Received:  by oss.sgi.com id <S553919AbRBMOwq>;
	Tue, 13 Feb 2001 06:52:46 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:64400 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553916AbRBMOwZ>;
	Tue, 13 Feb 2001 06:52:25 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA22077;
	Tue, 13 Feb 2001 15:42:35 +0100 (MET)
Date:   Tue, 13 Feb 2001 15:42:34 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Karsten Merker <karsten@excalibur.cologne.de>,
        Ralf Baechle <ralf@uni-koblenz.de>
cc:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        linux-mips@oss.sgi.com
Subject: Re: DECstation crashes
In-Reply-To: <20010209000419.A17609@excalibur.cologne.de>
Message-ID: <Pine.GSO.3.96.1010213152936.20214A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 9 Feb 2001, Karsten Merker wrote:

> Do other Linux/MIPS-targets besides the DECstations show similar problems
> (kernel crash due to NULL-pointer dereference in __free_pages_ok just
> after mounting the rootfs) or is this a decstation-specific effect? The
> problems happens both on R3k and R4k (tested on 5000/20 and 5000/150).

 The following patch should fix it.  Hmm, I wonder how it worked before at
all...  There is a related small fix for ARC included.  Ralf, please apply
these changes.

 Still 2.4.1 is rather unstable here -- it crashes silently under moderate
system activity after boot.  If nothing gets executed the system survives
for long.  A single `ls -la' is able to kill it if unfortunate enough,
though.  I'm still using 2.4.0-test12 taken on Jan 10, which is rock solid
apart from a single libtool script which kills it repeatedly always at the
same point (currently investigating it).

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.1-20010208-mem_map-43
diff -up --recursive --new-file linux-mips-2.4.1-20010208.macro/arch/mips/arc/memory.c linux-mips-2.4.1-20010208/arch/mips/arc/memory.c
--- linux-mips-2.4.1-20010208.macro/arch/mips/arc/memory.c	Wed Jan 17 05:25:58 2001
+++ linux-mips-2.4.1-20010208/arch/mips/arc/memory.c	Sun Feb 11 11:19:37 2001
@@ -145,7 +145,7 @@ prom_free_prom_memory (void)
 			      + boot_mem_map.map[i].size) {
 			ClearPageReserved(virt_to_page(__va(addr)));
 			set_page_count(virt_to_page(__va(addr)), 1);
-			free_page(__va(addr));
+			free_page((unsigned long)__va(addr));
 			addr += PAGE_SIZE;
 			freed += PAGE_SIZE;
 		}
diff -up --recursive --new-file linux-mips-2.4.1-20010208.macro/arch/mips/dec/prom/memory.c linux-mips-2.4.1-20010208/arch/mips/dec/prom/memory.c
--- linux-mips-2.4.1-20010208.macro/arch/mips/dec/prom/memory.c	Tue Dec 12 05:26:20 2000
+++ linux-mips-2.4.1-20010208/arch/mips/dec/prom/memory.c	Sun Feb 11 11:41:12 2001
@@ -108,10 +108,10 @@ void __init prom_meminit(unsigned int ma
 		rex_setup_memory_region();
 }
 
-void prom_free_prom_memory (void)
+void __init prom_free_prom_memory (void)
 {
 	unsigned long addr, end;
-	extern	char _ftext;
+	extern char _ftext;
 
 	/*
 	 * Free everything below the kernel itself but leave
@@ -126,16 +126,16 @@ void prom_free_prom_memory (void)
 	 * XXX: save this address for use in dec_lance.c?
 	 */
 	if (IOASIC)
-		end = PHYSADDR(&_ftext) - 0x00020000;
+		end = __pa(&_ftext) - 0x00020000;
 	else
 #endif
-		end = PHYSADDR(&_ftext);
+		end = __pa(&_ftext);
 
 	addr = PAGE_SIZE;
 	while (addr < end) {
-		ClearPageReserved(virt_to_page(addr));
-		set_page_count(virt_to_page(addr), 1);
-		free_page(addr);
+		ClearPageReserved(virt_to_page(__va(addr)));
+		set_page_count(virt_to_page(__va(addr)), 1);
+		free_page((unsigned long)__va(addr));
 		addr += PAGE_SIZE;
 	}
 
