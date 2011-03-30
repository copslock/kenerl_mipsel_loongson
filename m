Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2011 12:08:57 +0200 (CEST)
Received: from mail-qy0-f177.google.com ([209.85.216.177]:33736 "EHLO
        mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491079Ab1C3KIy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Mar 2011 12:08:54 +0200
Received: by qyl38 with SMTP id 38so818956qyl.15
        for <linux-mips@linux-mips.org>; Wed, 30 Mar 2011 03:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=DWHyYTbH1kpni2zr5KJHlD7IsK0108ursGkY5b4J5Xo=;
        b=uh4OxPOlTdaAVRMQM/K0yIuhkhpKlcqFItAWTswqWYjGK0i2bip092BHnQOabMgtua
         c3L8a+GuWnqFBnnnOpwoWR+qJoI1YbdIJLPtvpXT1k0sOvZRk54vm30WpOcfSpJ5IJj3
         7DuF7EttQg4QatySAblzilXfOgV1fTGlN/ygM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ME5/GtQR/XDnLfTKBmETJTLN6EcE2m4MeXCO5FWdlNRwMvycOFs6Ds/73jzi5N3c+v
         kUMLad1vTGLOkhdDi0DHMpwdt+kRM9b3yDUU8l8nh9u84ImUOLpnxyyPCP3ybnfD4XhX
         QjldMs4+GKZCmnwxWJBoq+6ufKWl6g6Y/Uy+o=
MIME-Version: 1.0
Received: by 10.224.127.131 with SMTP id g3mr846158qas.70.1301479728252; Wed,
 30 Mar 2011 03:08:48 -0700 (PDT)
Received: by 10.229.6.200 with HTTP; Wed, 30 Mar 2011 03:08:48 -0700 (PDT)
In-Reply-To: <1301476505.29074.47.camel@e102109-lin.cambridge.arm.com>
References: <9bde694e1003020554p7c8ff3c2o4ae7cb5d501d1ab9@mail.gmail.com>
        <AANLkTinnqtXf5DE+qxkTyZ9p9Mb8dXai6UxWP2HaHY3D@mail.gmail.com>
        <1300960540.32158.13.camel@e102109-lin.cambridge.arm.com>
        <AANLkTim139fpJsMJFLiyUYvFgGMz-Ljgd_yDrks-tqhE@mail.gmail.com>
        <1301395206.583.53.camel@e102109-lin.cambridge.arm.com>
        <AANLkTim-4v5Cbp6+wHoXjgKXoS0axk1cgQ5AHF_zot80@mail.gmail.com>
        <1301399454.583.66.camel@e102109-lin.cambridge.arm.com>
        <AANLkTin0_gT0E3=oGyfMwk+1quqonYBExeN9a3=v=Lob@mail.gmail.com>
        <AANLkTi=gMP6jQuQFovfsOX=7p-SSnwXoVLO_DVEpV63h@mail.gmail.com>
        <1301476505.29074.47.camel@e102109-lin.cambridge.arm.com>
Date:   Wed, 30 Mar 2011 11:08:48 +0100
Message-ID: <AANLkTim9+kQYSKXRbkOPArJ63jTxvjkFg=AEywr5meNN@mail.gmail.com>
Subject: Re: kmemleak for MIPS
From:   Maxin John <maxin.john@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Daniel Baluta <dbaluta@ixiacom.com>,
        naveen yadav <yad.naveen@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <maxin.john@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29638
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maxin.john@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

> If you for the kmemleak scan (via echo) a few times, do you get more
> leaks?

Yes. I am getting some leaks after the scan.

> The udp_table_init() function looks like it could leak some
> memory but I haven't seen it before. I'm not sure whether this is a
> false positive or a real leak.

As Daniel suggested, this could be a real leak . However, we need to
confirm this.

 udp_table_init() -> alloc_large_system_hash() ->  alloc_pages_exact()
followed by  kmemleak_alloc()

> I think the last line should be more like:

As per your suggestion, I have modified the patch.

Signed-off-by: Maxin B. John <maxin.john@gmail.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
diff --git a/arch/mips/include/asm/cache.h b/arch/mips/include/asm/cache.h
index 650ac9b..b4db69f 100644
--- a/arch/mips/include/asm/cache.h
+++ b/arch/mips/include/asm/cache.h
@@ -17,6 +17,6 @@
 #define SMP_CACHE_SHIFT                L1_CACHE_SHIFT
 #define SMP_CACHE_BYTES                L1_CACHE_BYTES

-#define __read_mostly __attribute__((__section__(".data.read_mostly")))
+#define __read_mostly __attribute__((__section__(".data..read_mostly")))

 #endif /* _ASM_CACHE_H */
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 832afbb..4f10141 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -68,12 +68,14 @@ SECTIONS
        RODATA

        /* writeable */
+       _sdata = .;                  /* Start of data section */
        .data : {       /* Data */
                . = . + DATAOFFSET;             /* for CONFIG_MAPPED_KERNEL */

                INIT_TASK_DATA(PAGE_SIZE)
                NOSAVE_DATA
                CACHELINE_ALIGNED_DATA(1 << CONFIG_MIPS_L1_CACHE_SHIFT)
+               READ_MOSTLY_DATA(1 << CONFIG_MIPS_L1_CACHE_SHIFT)
                DATA_DATA
                CONSTRUCTORS
        }
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index df9234c..5042421 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -398,7 +398,7 @@ config SLUB_STATS
 config DEBUG_KMEMLEAK
        bool "Kernel memory leak detector"
        depends on DEBUG_KERNEL && EXPERIMENTAL && !MEMORY_HOTPLUG && \
-               (X86 || ARM || PPC || S390 || SPARC64 || SUPERH ||
MICROBLAZE || TILE)
+               (X86 || ARM || PPC || MIPS || S390 || SPARC64 ||
SUPERH || MICROBLAZE || TILE)

        select DEBUG_FS if SYSFS
        select STACKTRACE if STACKTRACE_SUPPORT
