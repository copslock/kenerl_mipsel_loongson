Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7DDgMU08193
	for linux-mips-outgoing; Mon, 13 Aug 2001 06:42:22 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7DDgGj08186
	for <linux-mips@oss.sgi.com>; Mon, 13 Aug 2001 06:42:16 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA21444;
	Mon, 13 Aug 2001 15:43:56 +0200 (MET DST)
Date: Mon, 13 Aug 2001 15:43:56 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Keith Owens <kaos@ocs.com.au>, Ralf Baechle <ralf@uni-koblenz.de>,
   Harald Koerfgen <hkoerfg@web.de>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: [patch] modutils 2.4.6: Make __dbe_table available to modules
Message-ID: <Pine.GSO.3.96.1010813153841.18279H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

 The following patch is needed for modutils to initialize __dbe_table
table pointers appropriately for modules that want to handle bus error
exceptions on MIPS.  A separate patch is needed for the kernel.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

modutils-2.4.6-mips-dbe.patch
diff -up --recursive --new-file modutils-2.4.6.macro/include/module.h modutils-2.4.6/include/module.h
--- modutils-2.4.6.macro/include/module.h	Fri Jan  5 01:45:19 2001
+++ modutils-2.4.6/include/module.h	Sun Aug 12 13:16:13 2001
@@ -153,6 +153,10 @@ struct module
   unsigned tgt_long cleanup;
   unsigned tgt_long ex_table_start;
   unsigned tgt_long ex_table_end;
+#ifdef __mips__
+  unsigned tgt_long dbe_table_start;
+  unsigned tgt_long dbe_table_end;
+#endif
 #ifdef __alpha__
   unsigned tgt_long gp;
 #endif
diff -up --recursive --new-file modutils-2.4.6.macro/man/init_module.2 modutils-2.4.6/man/init_module.2
--- modutils-2.4.6.macro/man/init_module.2	Fri Jan  5 01:45:19 2001
+++ modutils-2.4.6/man/init_module.2	Sun Aug 12 13:17:14 2001
@@ -39,6 +39,10 @@ struct module
   void (*cleanup)(void);
   const struct exception_table_entry *ex_table_start;
   const struct exception_table_entry *ex_table_end;
+#ifdef __mips__
+  const struct exception_table_entry *dbe_table_start;
+  const struct exception_table_entry *dbe_table_end;
+#endif
 #ifdef __alpha__
   unsigned long gp;
 #endif
diff -up --recursive --new-file modutils-2.4.6.macro/obj/obj_mips.c modutils-2.4.6/obj/obj_mips.c
--- modutils-2.4.6.macro/obj/obj_mips.c	Fri Jan  5 01:45:19 2001
+++ modutils-2.4.6/obj/obj_mips.c	Sun Aug 12 16:16:26 2001
@@ -217,6 +217,15 @@ arch_create_got (struct obj_file *f)
 int
 arch_init_module (struct obj_file *f, struct module *mod)
 {
+  struct obj_section *sec;
+
+  sec = obj_find_section(f, "__dbe_table");
+  if (sec)
+    {
+      mod->dbe_table_start = sec->header.sh_addr;
+      mod->dbe_table_end = sec->header.sh_addr + sec->header.sh_size;
+    }
+
   return 1;
 }
 
