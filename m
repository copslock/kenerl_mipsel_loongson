Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6DIARo23506
	for linux-mips-outgoing; Fri, 13 Jul 2001 11:10:27 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6DIAGV23495;
	Fri, 13 Jul 2001 11:10:17 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id CE2C5125BA; Fri, 13 Jul 2001 11:10:10 -0700 (PDT)
Date: Fri, 13 Jul 2001 11:10:10 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Ulrich Drepper <drepper@cygnus.com>
Cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com,
   GNU C Library <libc-alpha@sourceware.cygnus.com>
Subject: Re: Clean up the mips dynamic linker
Message-ID: <20010713111010.A25902@lucon.org>
References: <20010712182402.A10768@lucon.org> <20010713112635.A32010@bacchus.dhis.org> <m3lmlsu82u.fsf@otr.mynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m3lmlsu82u.fsf@otr.mynet>; from drepper@redhat.com on Fri, Jul 13, 2001 at 09:06:49AM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jul 13, 2001 at 09:06:49AM -0700, Ulrich Drepper wrote:
> Ralf Baechle <ralf@oss.sgi.com> writes:
> 
> > So please, go ahead.
> 
> So you say the patch is OK from your POV?
> 

My last patch was not ok :-(. Somehow, make didn't rebuild. In this
patch, I rewrote RESOLVE_GOTSYM with RESOLVE to help prelink.


H.J.
-----
2001-07-13  H.J. Lu <hjl@gnu.org>

	* sysdeps/mips/dl-machine.h (MAP_BASE_ADDR): Removed.
	(elf_machine_got_rel): Defined only if RTLD_BOOTSTRAP is not
	defined.
	(RESOLVE_GOTSYM): Rewrite to use RESOLVE.

	* sysdeps/mips/rtld-ldscript.in: Removed.
	* sysdeps/mips/rtld-parms: Likewise.
	* sysdeps/mips/mips64/rtld-parms: Likewise.
	* sysdeps/mips/mipsel/rtld-parms: Likewise.

--- libc/sysdeps/mips/dl-machine.h.mips	Sat Jul  7 16:46:05 2001
+++ libc/sysdeps/mips/dl-machine.h	Fri Jul 13 10:53:42 2001
@@ -61,23 +61,6 @@
    in l_info array.  */
 #define DT_MIPS(x) (DT_MIPS_##x - DT_LOPROC + DT_NUM)
 
-/*
- * MIPS libraries are usually linked to a non-zero base address.  We
- * subtract the base address from the address where we map the object
- * to.  This results in more efficient address space usage.
- *
- * FIXME: By the time when MAP_BASE_ADDR is called we don't have the
- * DYNAMIC section read.  Until this is fixed make the assumption that
- * libraries have their base address at 0x5ffe0000.  This needs to be
- * fixed before we can safely get rid of this MIPSism.
- */
-#if 0
-#define MAP_BASE_ADDR(l) ((l)->l_info[DT_MIPS(BASE_ADDRESS)] ? \
-			  (l)->l_info[DT_MIPS(BASE_ADDRESS)]->d_un.d_ptr : 0)
-#else
-#define MAP_BASE_ADDR(l) 0x5ffe0000
-#endif
-
 /* If there is a DT_MIPS_RLD_MAP entry in the dynamic section, fill it in
    with the run-time address of the r_debug structure  */
 #define ELF_MACHINE_DEBUG_SETUP(l,r) \
@@ -557,51 +540,30 @@ elf_machine_lazy_rel (struct link_map *m
   /* Do nothing.  */
 }
 
+#ifndef RTLD_BOOTSTRAP
 /* Relocate GOT. */
 static inline void
 elf_machine_got_rel (struct link_map *map, int lazy)
 {
   ElfW(Addr) *got;
   ElfW(Sym) *sym;
+  const ElfW(Half) *vernum;
   int i, n, symidx;
-  /*  This function is loaded in dl-reloc as a nested function and can
-      therefore access the variables scope and strtab from
-      _dl_relocate_object.  */
-#ifdef RTLD_BOOTSTRAP
-# define RESOLVE_GOTSYM(sym,sym_index) 0
-#else
-# define RESOLVE_GOTSYM(sym,sym_index)					  \
+
+#define RESOLVE_GOTSYM(sym,vernum,sym_index)				  \
     ({									  \
       const ElfW(Sym) *ref = sym;					  \
+      const struct r_found_version *version				  \
+        = vernum ? &map->l_versions [vernum [sym_index]] : NULL;	  \
       ElfW(Addr) value;							  \
-									  \
-      switch (map->l_info[VERSYMIDX (DT_VERSYM)] != NULL)		  \
-	{								  \
-	default:							  \
-	  {								  \
-	    const ElfW(Half) *vernum =					  \
-	      (const void *) D_PTR (map, l_info[VERSYMIDX (DT_VERSYM)]);  \
-	    ElfW(Half) ndx = vernum[sym_index];				  \
-	    const struct r_found_version *version = &l->l_versions[ndx];  \
-									  \
-	    if (version->hash != 0)					  \
-	      {								  \
-		value = _dl_lookup_versioned_symbol(strtab + sym->st_name,\
-						    map,		  \
-						    &ref, scope, version, \
-						    R_MIPS_REL32, 0);	  \
-		break;							  \
-	      }								  \
-	    /* Fall through.  */					  \
-	  }								  \
-	case 0:								  \
-	  value = _dl_lookup_symbol (strtab + sym->st_name, map, &ref,	  \
-				     scope, R_MIPS_REL32, 0);		  \
-	}								  \
-									  \
+      value = RESOLVE (&ref, version, R_MIPS_REL32);			  \
       (ref)? value + ref->st_value: 0;					  \
     })
-#endif /* RTLD_BOOTSTRAP */
+
+  if (map->l_info[VERSYMIDX (DT_VERSYM)] != NULL)
+    vernum = (const void *) D_PTR (map, l_info[VERSYMIDX (DT_VERSYM)]);
+  else
+    vernum = NULL;
 
   got = (ElfW(Addr) *) D_PTR (map, l_info[DT_PLTGOT]);
 
@@ -639,10 +601,10 @@ elf_machine_got_rel (struct link_map *ma
 	      && sym->st_value && lazy)
 	    *got = sym->st_value + map->l_addr;
 	  else
-	    *got = RESOLVE_GOTSYM (sym, symidx);
+	    *got = RESOLVE_GOTSYM (sym, vernum, symidx);
 	}
       else if (sym->st_shndx == SHN_COMMON)
-	*got = RESOLVE_GOTSYM (sym, symidx);
+	*got = RESOLVE_GOTSYM (sym, vernum, symidx);
       else if (ELFW(ST_TYPE) (sym->st_info) == STT_FUNC
 	       && *got != sym->st_value
 	       && lazy)
@@ -653,7 +615,7 @@ elf_machine_got_rel (struct link_map *ma
 	    *got += map->l_addr;
 	}
       else
-	*got = RESOLVE_GOTSYM (sym, symidx);
+	*got = RESOLVE_GOTSYM (sym, vernum, symidx);
 
       ++got;
       ++sym;
@@ -661,9 +623,8 @@ elf_machine_got_rel (struct link_map *ma
     }
 
 #undef RESOLVE_GOTSYM
-
-  return;
 }
+#endif
 
 /* Set up the loaded object described by L so its stub function
    will jump to the on-demand fixup code __dl_runtime_resolve.  */
--- libc/sysdeps/mips/mips64/rtld-parms.mips	Sat Jul 12 16:26:11 1997
+++ libc/sysdeps/mips/mips64/rtld-parms	Fri Jul 13 10:54:55 2001
@@ -1,3 +0,0 @@
-ifndef rtld-wordsize
-rtld-wordsize = 64
-endif
--- libc/sysdeps/mips/mipsel/rtld-parms.mips	Sat Jul 12 16:26:15 1997
+++ libc/sysdeps/mips/mipsel/rtld-parms	Fri Jul 13 10:54:55 2001
@@ -1,3 +0,0 @@
-ifndef rtld-oformat
-rtld-oformat = elf32-littlemips
-endif
--- libc/sysdeps/mips/rtld-ldscript.in.mips	Sun May 13 20:39:31 2001
+++ libc/sysdeps/mips/rtld-ldscript.in	Fri Jul 13 10:54:55 2001
@@ -1,105 +0,0 @@
-OUTPUT_ARCH(@@rtld-arch@@)
-ENTRY(@@rtld-entry@@)
-SECTIONS
-{
-  /* Read-only sections, merged into text segment: */
-  . = @@rtld-base@@;
-  .reginfo       : { *(.reginfo) }
-  .dynamic       : { *(.dynamic) }
-  .dynstr        : { *(.dynstr)		}
-  .dynsym        : { *(.dynsym)		}
-  .hash          : { *(.hash)		}
-  .rel.text      : { *(.rel.text)		}
-  .rela.text     : { *(.rela.text) 	}
-  .rel.data      : { *(.rel.data)		}
-  .rela.data     : { *(.rela.data) 	}
-  .rel.rodata    : { *(.rel.rodata) 	}
-  .rela.rodata   : { *(.rela.rodata) 	}
-  .rel.got       : { *(.rel.got)		}
-  .rela.got      : { *(.rela.got)		}
-  .rel.ctors     : { *(.rel.ctors)	}
-  .rela.ctors    : { *(.rela.ctors)	}
-  .rel.dtors     : { *(.rel.dtors)	}
-  .rela.dtors    : { *(.rela.dtors)	}
-  .rel.init      : { *(.rel.init)	}
-  .rela.init     : { *(.rela.init)	}
-  .rel.fini      : { *(.rel.fini)	}
-  .rela.fini     : { *(.rela.fini)	}
-  .rel.bss       : { *(.rel.bss)		}
-  .rela.bss      : { *(.rela.bss)		}
-  .rel.plt       : { *(.rel.plt)		}
-  .rela.plt      : { *(.rela.plt)		}
-  .rodata    : { *(.rodata)  }
-  .rodata1   : { *(.rodata1) }
-  .init          : { *(.init)	} =0
-  .text      :
-  {
-    *(.text)
-    *(.stub)
-    /* .gnu.warning sections are handled specially by elf32.em.  */
-    *(.gnu.warning)
-  } =0
-  .fini      : { *(.fini)    } =0
-  /* Adjust the address for the data segment.  We want to adjust up to
-     the same address within the page on the next page up.  It would
-     be more correct to do this:
-       . = 0x10000000;
-     The current expression does not correctly handle the case of a
-     text segment ending precisely at the end of a page; it causes the
-     data segment to skip a page.  The above expression does not have
-     this problem, but it will currently (2/95) cause BFD to allocate
-     a single segment, combining both text and data, for this case.
-     This will prevent the text segment from being shared among
-     multiple executions of the program; I think that is more
-     important than losing a page of the virtual address space (note
-     that no actual memory is lost; the page which is skipped can not
-     be referenced).  */
-  . += 0x10000;
-  .data    :
-  {
-    *(.data)
-    CONSTRUCTORS
-  }
-  .data1   : { *(.data1) }
-  .ctors         : { *(.ctors)   }
-  .dtors         : { *(.dtors)   }
-  _gp = ALIGN(16) + 0x7ff0;
-  .got           :
-  {
-    *(.got.plt) *(.got)
-   }
-  /* We want the small data sections together, so single-instruction offsets
-     can access them all, and initialized data all before uninitialized, so
-     we can shorten the on-disk segment size.  */
-  .sdata     : { *(.sdata) }
-  .lit8 : { *(.lit8) }
-  .lit4 : { *(.lit4) }
-  .sbss      : { *(.sbss) *(.scommon) }
-  .bss       :
-  {
-   *(.dynbss)
-   *(.bss)
-   *(COMMON)
-  }
-  /* The normal linker scripts created by the binutils doesn't have the
-     symbols end and _end which breaks ld.so's dl-minimal.c.  */
-  _end = . ;
-  PROVIDE (end = .);
-  /* These are needed for ELF backends which have not yet been
-     converted to the new style linker.  */
-  .stab 0 : { *(.stab) }
-  .stabstr 0 : { *(.stabstr) }
-  /* DWARF debug sections.
-     Symbols in the .debug DWARF section are relative to the beginning of the
-     section so we begin .debug at 0.  It's not clear yet what needs to happen
-     for the others.   */
-  .debug          0 : { *(.debug) }
-  .debug_srcinfo  0 : { *(.debug_srcinfo) }
-  .debug_aranges  0 : { *(.debug_aranges) }
-  .debug_pubnames 0 : { *(.debug_pubnames) }
-  .debug_sfnames  0 : { *(.debug_sfnames) }
-  .line           0 : { *(.line) }
-  /* These must appear regardless of  .  */
-  .gptab.sdata : { *(.gptab.data) *(.gptab.sdata) }
-  .gptab.sbss : { *(.gptab.bss) *(.gptab.sbss) }
-}
--- libc/sysdeps/mips/rtld-parms.mips	Mon Jul 21 17:04:07 1997
+++ libc/sysdeps/mips/rtld-parms	Fri Jul 13 10:54:55 2001
@@ -1,15 +0,0 @@
-ifndef rtld-wordsize
-rtld-wordsize = 32
-endif
-ifndef rtld-oformat
-rtld-oformat = elf$(rtld-wordsize)-bigmips
-endif
-ifndef rtld-arch
-rtld-arch = mips
-endif
-ifndef rtld-entry
-rtld-entry = __start
-endif
-ifndef rtld-base
-rtld-base = 0x0fb60000 + SIZEOF_HEADERS
-endif
