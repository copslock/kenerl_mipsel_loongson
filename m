Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2007 14:11:49 +0000 (GMT)
Received: from alnrmhc16.comcast.net ([206.18.177.56]:17028 "EHLO
	alnrmhc16.comcast.net") by ftp.linux-mips.org with ESMTP
	id S20022184AbXCTOLX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Mar 2007 14:11:23 +0000
Received: from [192.168.1.4] (c-68-34-70-207.hsd1.md.comcast.net[68.34.70.207])
          by comcast.net (alnrmhc16) with ESMTP
          id <20070320141039b160076jp3e>; Tue, 20 Mar 2007 14:10:39 +0000
Message-ID: <45FFEB5A.707@gentoo.org>
Date:	Tue, 20 Mar 2007 10:10:34 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0b2 (Windows/20070116)
MIME-Version: 1.0
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
CC:	Linux MIPS List <linux-mips@linux-mips.org>,
	Arnaud Giersch <arnaud.giersch@free.fr>
Subject: Re: IP32 prom crashes due to __pa() funkiness
References: <45D8B070.7070405@gentoo.org>	 <cda58cb80703010139y3e5bbb8eqa4d25b75ba658a22@mail.gmail.com>	 <45FC46F0.3070300@gentoo.org> <87irczzglc.fsf@groumpf.homeip.net>	 <45FC9E39.7010506@gentoo.org> <45FE95EE.5030108@innova-card.com>	 <45FE9D22.1030407@gentoo.org> <cda58cb80703191435u37ba4ed2se4cc150fcdb734a2@mail.gmail.com>
In-Reply-To: <cda58cb80703191435u37ba4ed2se4cc150fcdb734a2@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------080307090500070406020106"
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------080307090500070406020106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Franck Bui-Huu wrote:
> 
> I'm really not confident with all your tricks you described. Maybe a
> config that I believed to be uninsteresting and useless should be
> supported still.
> 
> Can you try the attached patch with a plain linux-mips kernel ? This
> patch restore CPHYSADDR() for 64 bits kernels _only_. I guess it's ok
> because we won't need to support mapped kernels on 64 bits machines...
> 
> Could others give their opinions ?

After going through all the fun to get rid of CPHYSADDR, I see no point really 
to bring it back.  Plus that patch unnecessarily complicates those defines.  As 
I highlighted in my original mail, O2 doesn't need CPHYSADDR added to __pa(), it 
just needs the conditional define for __pa_page_offset to be a little bit more 
flexible.

Since only three machines, O2 R5xx, Indy/Indigo2 R4xx, and Cobalt will exhibit 
similar issues (the latter two when booting 64bit kernels), a saner method in my 
opinion is to introduce a flag of sorts into the conditional for 
__pa_page_offset to determine whether to define it strictly to PAGE_OFFSET or to 
the other value listed in the code.  The only thing is, I'm not sure which 
method of the two I've thought up is cleaner.

The first introduces a hidden Kconfig value, CONFIG_SYS_LOADS_IN_CKSEG0, that 
only turns on when BUILD_ELF64 && (SGI_IP22 || (SGI_IP32 && (CPU_R5000 || 
CPU_NEVADA || CPU_RM7000)) || MIPS_COBALT), and then we test for this flag in 
include/asm-mips/page.h when setting the value of __pa_page_offset.

The other way is to define a similar flag in a new header file, memmap.h, in 
include/asm-mips/mach-{ip22,ip32,cobalt}/* called MIPS_USES_CKSEG0, and 
similarly, test for that flag in the same spot as above.  With this method, 
though, I'm not sure where exactly to pull in the memmap.h header, so the patch 
for it is incomplete (but included for reference).

I've tested the first patch (kconfig one), and it works fine.  The second one 
will also work, provided I find a nice spot to pull in memmap.h, but from a 
semantics perspective, which one do you guys like better?



--Kumba

-- 
Gentoo/MIPS Team Lead

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond

--------------080307090500070406020106
Content-Type: text/plain;
 name="mips-kconfig-ckseg0-idea.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mips-kconfig-ckseg0-idea.patch"

diff -Naurp mipslinux/arch/mips/Kconfig mipslinux.ckseg0-a/arch/mips/Kconfig
--- mipslinux/arch/mips/Kconfig	2007-03-17 21:12:06.000000000 -0400
+++ mipslinux.ckseg0-a/arch/mips/Kconfig	2007-03-20 01:38:42.000000000 -0400
@@ -1659,6 +1659,11 @@ config SB1_PASS_2_1_WORKAROUNDS
 	depends on CPU_SB1 && CPU_SB1_PASS_2
 	default y
 
+config SYS_LOADS_IN_CKSEG0
+	bool
+	depends on BUILD_ELF64 && (SGI_IP22 || (SGI_IP32 && (CPU_R5000 || CPU_NEVADA || CPU_RM7000)) || MIPS_COBALT)
+	default y
+
 config 64BIT_PHYS_ADDR
 	bool "Support for 64-bit physical address space"
 	depends on (CPU_R4X00 || CPU_R5000 || CPU_RM7000 || CPU_RM9000 || CPU_R10000 || CPU_SB1 || CPU_MIPS32 || CPU_MIPS64) && 32BIT
diff -Naurp mipslinux/include/asm-mips/page.h mipslinux.ckseg0-a/include/asm-mips/page.h
--- mipslinux/include/asm-mips/page.h	2007-03-17 21:12:31.000000000 -0400
+++ mipslinux.ckseg0-a/include/asm-mips/page.h	2007-03-20 01:37:31.000000000 -0400
@@ -149,7 +149,7 @@ typedef struct { unsigned long pgprot; }
 /*
  * __pa()/__va() should be used only during mem init.
  */
-#if defined(CONFIG_64BIT) && !defined(CONFIG_BUILD_ELF64)
+#if defined(CONFIG_64BIT) && (!defined(CONFIG_BUILD_ELF64) || defined(CONFIG_SYS_LOADS_IN_CKSEG0))
 #define __pa_page_offset(x)	((unsigned long)(x) < CKSEG0 ? PAGE_OFFSET : CKSEG0)
 #else
 #define __pa_page_offset(x)	PAGE_OFFSET

--------------080307090500070406020106
Content-Type: text/plain;
 name="mips-asm-mach-ckseg0-idea.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mips-asm-mach-ckseg0-idea.patch"

diff -Naurp mipslinux/include/asm-mips/mach-cobalt/memmap.h mipslinux.ckseg0-b/include/asm-mips/mach-cobalt/memmap.h
--- mipslinux/include/asm-mips/mach-cobalt/memmap.h	1969-12-31 19:00:00.000000000 -0500
+++ mipslinux.ckseg0-b/include/asm-mips/mach-cobalt/memmap.h	2007-03-20 01:19:59.000000000 -0400
@@ -0,0 +1,9 @@
+#ifndef __ASM_MACH_IP32_MEMMAP_H
+#define __ASM_MACH_IP32_MEMMAP_H
+
+
+#ifdef CONFIG_64BIT
+#define MIPS_USES_CKSEG0	1
+#endif
+
+#endif /* __ASM_MACH_IP32_MEMMAP_H */
diff -Naurp mipslinux/include/asm-mips/mach-ip22/memmap.h mipslinux.ckseg0-b/include/asm-mips/mach-ip22/memmap.h
--- mipslinux/include/asm-mips/mach-ip22/memmap.h	1969-12-31 19:00:00.000000000 -0500
+++ mipslinux.ckseg0-b/include/asm-mips/mach-ip22/memmap.h	2007-03-20 01:20:14.000000000 -0400
@@ -0,0 +1,9 @@
+#ifndef __ASM_MACH_IP32_MEMMAP_H
+#define __ASM_MACH_IP32_MEMMAP_H
+
+
+#ifdef CONFIG_64BIT
+#define MIPS_USES_CKSEG0	1
+#endif
+
+#endif /* __ASM_MACH_IP32_MEMMAP_H */
diff -Naurp mipslinux/include/asm-mips/mach-ip32/memmap.h mipslinux.ckseg0-b/include/asm-mips/mach-ip32/memmap.h
--- mipslinux/include/asm-mips/mach-ip32/memmap.h	1969-12-31 19:00:00.000000000 -0500
+++ mipslinux.ckseg0-b/include/asm-mips/mach-ip32/memmap.h	2007-03-20 01:12:24.000000000 -0400
@@ -0,0 +1,9 @@
+#ifndef __ASM_MACH_IP32_MEMMAP_H
+#define __ASM_MACH_IP32_MEMMAP_H
+
+
+#if defined(CONFIG_CPU_R5000) || defined(CONFIG_CPU_NEVADA) || defined (CONFIG_CPU_RM7000)
+#define MIPS_USES_CKSEG0	1
+#endif
+
+#endif /* __ASM_MACH_IP32_MEMMAP_H */
diff -Naurp mipslinux/include/asm-mips/page.h mipslinux.ckseg0-b/include/asm-mips/page.h
--- mipslinux/include/asm-mips/page.h	2007-03-17 21:12:31.000000000 -0400
+++ mipslinux.ckseg0-b/include/asm-mips/page.h	2007-03-20 01:15:35.000000000 -0400
@@ -149,7 +149,7 @@ typedef struct { unsigned long pgprot; }
 /*
  * __pa()/__va() should be used only during mem init.
  */
-#if defined(CONFIG_64BIT) && !defined(CONFIG_BUILD_ELF64)
+#if defined(CONFIG_64BIT) && (!defined(CONFIG_BUILD_ELF64) || defined(MIPS_USES_CKSEG0))
 #define __pa_page_offset(x)	((unsigned long)(x) < CKSEG0 ? PAGE_OFFSET : CKSEG0)
 #else
 #define __pa_page_offset(x)	PAGE_OFFSET

--------------080307090500070406020106--
