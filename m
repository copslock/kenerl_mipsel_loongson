Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g65FP8Rw004445
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 5 Jul 2002 08:25:08 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g65FP8b2004444
	for linux-mips-outgoing; Fri, 5 Jul 2002 08:25:08 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g65FOjRw004432
	for <linux-mips@oss.sgi.com>; Fri, 5 Jul 2002 08:24:45 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA06267
	for <linux-mips@oss.sgi.com>; Fri, 5 Jul 2002 08:29:14 -0700 (PDT)
	mail_from (macro@ds2.pg.gda.pl)
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA12700;
	Fri, 5 Jul 2002 17:21:35 +0200 (MET DST)
Date: Fri, 5 Jul 2002 17:21:34 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: [patch] linux: Cache coherency fixes
Message-ID: <Pine.GSO.3.96.1020705170554.11897A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf,

 Following is a fix for the currently broken TLB cache coherency
attributes setup.  Of R4[04]00 processors only the MC versions support
cache coherency.  Looking at the current setup I infer SB1 is another CPU
that supports it -- for any other CPU, the patch will have to be updated.
Then it's only relevant for SMP setups. 

 My R4400SC locks up solid (and I mean it, even NMI doesn't work) when a
write back of a line marked as CACHABLE_COW is to happen.  Somebody's
laziness costed me a week of debugging, sigh... :-(

 OK to apply?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.19-rc1-20020705-cache-coherency-2
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020705.macro/arch/mips/config.in linux-mips-2.4.19-rc1-20020705/arch/mips/config.in
--- linux-mips-2.4.19-rc1-20020705.macro/arch/mips/config.in	2002-06-27 02:57:13.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020705/arch/mips/config.in	2002-07-05 14:58:52.000000000 +0000
@@ -393,6 +393,19 @@ else
       fi
    fi
 fi
+
+if [ "$CONFIG_CPU_R4X00" = "y" -o "$CONFIG_CPU_SB1" = "y" ]; then
+   define_bool CONFIG_CPU_CACHE_COHERENCY $CONFIG_SMP
+else
+   define_bool CONFIG_CPU_CACHE_COHERENCY n
+fi
+
+if [ "$CONFIG_VTAG_ICACHE" != "y" ]; then
+   define_bool CONFIG_VTAG_ICACHE n
+fi
+if [ "$CONFIG_CPU_HAS_PREFETCH" != "y" ]; then
+   define_bool CONFIG_CPU_HAS_PREFETCH n
+fi
 endmenu
 
 mainmenu_option next_comment
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020705.macro/arch/mips64/config.in linux-mips-2.4.19-rc1-20020705/arch/mips64/config.in
--- linux-mips-2.4.19-rc1-20020705.macro/arch/mips64/config.in	2002-06-27 02:57:26.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020705/arch/mips64/config.in	2002-07-05 14:59:16.000000000 +0000
@@ -126,7 +126,6 @@ choice 'CPU type' \
 	 R8000	CONFIG_CPU_R8000 \
 	 R10000	CONFIG_CPU_R10000 \
 	 SB1	CONFIG_CPU_SB1" R4x00
-endmenu
 
 if [ "$CONFIG_CPU_SB1" = "y" ]; then
    bool '  Workarounds for pass 1 sb1 bugs' CONFIG_SB1_PASS_1_WORKAROUNDS
@@ -137,6 +136,20 @@ fi
 define_bool CONFIG_CPU_HAS_LLSC y
 define_bool CONFIG_CPU_HAS_LLDSCD y
 
+if [ "$CONFIG_CPU_R4X00" = "y" -o "$CONFIG_CPU_SB1" = "y" ]; then
+   define_bool CONFIG_CPU_CACHE_COHERENCY $CONFIG_SMP
+else
+   define_bool CONFIG_CPU_CACHE_COHERENCY n
+fi
+
+if [ "$CONFIG_VTAG_ICACHE" != "y" ]; then
+   define_bool CONFIG_VTAG_ICACHE n
+fi
+if [ "$CONFIG_CPU_HAS_PREFETCH" != "y" ]; then
+   define_bool CONFIG_CPU_HAS_PREFETCH n
+fi
+endmenu
+
 mainmenu_option next_comment
 comment 'General setup'
 
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020705.macro/include/asm-mips/pgtable-bits.h linux-mips-2.4.19-rc1-20020705/include/asm-mips/pgtable-bits.h
--- linux-mips-2.4.19-rc1-20020705.macro/include/asm-mips/pgtable-bits.h	2002-04-15 07:50:23.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020705/include/asm-mips/pgtable-bits.h	2002-07-05 14:52:59.000000000 +0000
@@ -74,9 +74,9 @@
 #define _CACHE_CACHABLE_WA          (1<<9)  /* R4600 only              */
 #define _CACHE_UNCACHED             (2<<9)  /* R4[0246]00              */
 #define _CACHE_CACHABLE_NONCOHERENT (3<<9)  /* R4[0246]00              */
-#define _CACHE_CACHABLE_CE          (4<<9)  /* R4[04]00 only           */
-#define _CACHE_CACHABLE_COW         (5<<9)  /* R4[04]00 only           */
-#define _CACHE_CACHABLE_CUW         (6<<9)  /* R4[04]00 only           */
+#define _CACHE_CACHABLE_CE          (4<<9)  /* R4[04]00MC only         */
+#define _CACHE_CACHABLE_COW         (5<<9)  /* R4[04]00MC only         */
+#define _CACHE_CACHABLE_CUW         (6<<9)  /* R4[04]00MC only         */
 #define _CACHE_UNCACHED_ACCELERATED (7<<9)  /* R10000 only             */
 
 #endif
@@ -87,12 +87,20 @@
 
 #define _PAGE_CHG_MASK  (PAGE_MASK | _PAGE_ACCESSED | _PAGE_MODIFIED | _CACHE_MASK)
 
-#ifdef CONFIG_MIPS_UNCACHED
+
+#if defined(CONFIG_MIPS_UNCACHED)
+
 #define PAGE_CACHABLE_DEFAULT	_CACHE_UNCACHED
-#elif CONFIG_CPU_SB1
+
+#elif defined(CONFIG_CPU_CACHE_COHERENCY)
+
 #define PAGE_CACHABLE_DEFAULT	_CACHE_CACHABLE_COW
+
 #else
+
 #define PAGE_CACHABLE_DEFAULT	_CACHE_CACHABLE_NONCOHERENT
+
 #endif
 
+
 #endif /* _ASM_CACHINGMODES_H */
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020705.macro/include/asm-mips64/pgtable.h linux-mips-2.4.19-rc1-20020705/include/asm-mips64/pgtable.h
--- linux-mips-2.4.19-rc1-20020705.macro/include/asm-mips64/pgtable.h	2002-07-03 02:58:29.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020705/include/asm-mips64/pgtable.h	2002-07-05 14:52:59.000000000 +0000
@@ -191,9 +191,9 @@ extern void (*_flush_icache_page)(struct
 #define _CACHE_CACHABLE_WA          (1<<9)  /* R4600 only              */
 #define _CACHE_UNCACHED             (2<<9)  /* R4[0246]00              */
 #define _CACHE_CACHABLE_NONCOHERENT (3<<9)  /* R4[0246]00              */
-#define _CACHE_CACHABLE_CE          (4<<9)  /* R4[04]00 only           */
-#define _CACHE_CACHABLE_COW         (5<<9)  /* R4[04]00 only           */
-#define _CACHE_CACHABLE_CUW         (6<<9)  /* R4[04]00 only           */
+#define _CACHE_CACHABLE_CE          (4<<9)  /* R4[04]00MC only         */
+#define _CACHE_CACHABLE_COW         (5<<9)  /* R4[04]00MC only         */
+#define _CACHE_CACHABLE_CUW         (6<<9)  /* R4[04]00MC only         */
 #define _CACHE_UNCACHED_ACCELERATED (7<<9)  /* R10000 only             */
 #define _CACHE_MASK                 (7<<9)
 
@@ -202,15 +202,21 @@ extern void (*_flush_icache_page)(struct
 
 #define _PAGE_CHG_MASK  (PAGE_MASK | _PAGE_ACCESSED | _PAGE_MODIFIED | _CACHE_MASK)
 
-#ifdef CONFIG_MIPS_UNCACHED
-#define PAGE_CACHABLE_DEFAULT _CACHE_UNCACHED
-#else /* ! UNCACHED */
-#ifdef CONFIG_SGI_IP22
-#define PAGE_CACHABLE_DEFAULT _CACHE_CACHABLE_NONCOHERENT
-#else /* ! IP22 */
-#define PAGE_CACHABLE_DEFAULT _CACHE_CACHABLE_COW
-#endif /* IP22 */
-#endif /* UNCACHED */
+
+#if defined(CONFIG_MIPS_UNCACHED)
+
+#define PAGE_CACHABLE_DEFAULT	_CACHE_UNCACHED
+
+#elif defined(CONFIG_CPU_CACHE_COHERENCY)
+
+#define PAGE_CACHABLE_DEFAULT	_CACHE_CACHABLE_COW
+
+#else
+
+#define PAGE_CACHABLE_DEFAULT	_CACHE_CACHABLE_NONCOHERENT
+
+#endif
+
 
 #define PAGE_NONE	__pgprot(_PAGE_PRESENT | PAGE_CACHABLE_DEFAULT)
 #define PAGE_SHARED     __pgprot(_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
