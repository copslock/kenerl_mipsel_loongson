Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7KE2cu19922
	for linux-mips-outgoing; Mon, 20 Aug 2001 07:02:38 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7KE2Yj19919
	for <linux-mips@oss.sgi.com>; Mon, 20 Aug 2001 07:02:35 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA11482;
	Mon, 20 Aug 2001 16:04:18 +0200 (MET DST)
Date: Mon, 20 Aug 2001 16:04:18 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Keith Owens <kaos@ocs.com.au>, Ralf Baechle <ralf@uni-koblenz.de>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: [patch] modutils 2.4.6: __dbe_table iteration #2
In-Reply-To: <Pine.GSO.3.96.1010813153841.18279H-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.3.96.1010820155737.3562E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

 Following is a modutils patch that complements __dbe_table handling for
modules for mips.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

modutils-2.4.6-mips-dbe.patch
diff -up --recursive --new-file modutils-2.4.6.macro/obj/obj_mips.c modutils-2.4.6/obj/obj_mips.c
--- modutils-2.4.6.macro/obj/obj_mips.c	Fri Jan  5 01:45:19 2001
+++ modutils-2.4.6/obj/obj_mips.c	Mon Aug 20 03:47:36 2001
@@ -232,7 +232,26 @@ arch_finalize_section_address(struct obj
 }
 
 int
-arch_archdata (struct obj_file *fin, struct obj_section *sec)
+arch_archdata (struct obj_file *f, struct obj_section *archdata_sec)
 {
+  struct archdata {
+    unsigned tgt_long dbe_table_start;
+    unsigned tgt_long dbe_table_end;
+  } *ad;
+  struct obj_section *sec;
+
+  free(archdata_sec->contents);
+  archdata_sec->contents = xmalloc(sizeof(struct archdata));
+  memset(archdata_sec->contents, 0, sizeof(struct archdata));
+  archdata_sec->header.sh_size = sizeof(struct archdata);
+
+  ad = (struct archdata *)(archdata_sec->contents);
+
+  sec = obj_find_section(f, "__dbe_table");
+  if (sec) {
+    ad->dbe_table_start = sec->header.sh_addr;
+    ad->dbe_table_end = sec->header.sh_addr + sec->header.sh_size;
+  }
+
   return 0;
 }
