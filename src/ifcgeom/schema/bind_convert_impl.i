﻿#ifdef BIND
#undef BIND
#endif

#define BIND(T) \
	if (l->declaration().is(IfcSchema::T::Class())) { \
		try { \
			taxonomy::item* item = map((IfcSchema::T*)l); \
			item->instance = l; \
			try { \
				if (l->as<IfcSchema::IfcRepresentationItem>()) { \
					auto style = find_style(l->as<IfcSchema::IfcRepresentationItem>()); \
					if (style) { \
						((taxonomy::geom_item*)item)->surface_style = as<taxonomy::style>(map(style)); \
					} \
				} \
			} catch (const std::exception& e) { \
				Logger::Message(Logger::LOG_ERROR, std::string(e.what()) + "\nFailed to convert:", l); \
			} \
			return item; \
		} catch (const std::exception& e) { \
			Logger::Message(Logger::LOG_ERROR, std::string(e.what()) + "\nFailed to convert:", l); \
		} \
		return false; \
	}

#include "mapping.i"
