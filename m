Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 18:10:54 +0100 (BST)
Received: from crux.i-cable.com ([203.83.115.104]:53289 "HELO crux.i-cable.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S20022876AbZEORKs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 15 May 2009 18:10:48 +0100
Received: (qmail 2409 invoked by uid 107); 15 May 2009 17:10:37 -0000
Received: from 203.83.114.121 by crux (envelope-from <robert.zhangle@gmail.com>, uid 104) with qmail-scanner-2.01 
 (clamdscan: 0.94.2/9149. spamassassin: 2.63.   
 Clear:RC:1(203.83.114.121):SA:0(2.6/5.0):. 
 Processed in 8.511292 secs); 15 May 2009 17:10:37 -0000
Received: from ip114121.hkicable.com (HELO silicon.i-cable.com) (203.83.114.121)
  by 0 with SMTP; 15 May 2009 17:10:28 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by silicon.i-cable.com (8.13.5/8.13.5) with ESMTP id n4FHA4TP023544;
	Sat, 16 May 2009 01:10:04 +0800 (HKT)
Date:	Sat, 16 May 2009 01:09:27 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Arnaud Patard <apatard@mandriva.com>, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Erwan Lerale <erwan@thiscow.com>
Subject: Re: [GIT repo] loongson: Merge and Clean up fuloong(2e),
	fuloong(2f) and yeeloong(2f) support
Message-ID: <20090515170926.GE28012@adriano.hkcable.com.hk>
Mail-Followup-To: Wu Zhangjin <wuzhangjin@gmail.com>,
	Arnaud Patard <apatard@mandriva.com>, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>, loongson-dev@googlegroups.com,
	zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Erwan Lerale <erwan@thiscow.com>
References: <1242357553.30339.66.camel@falcon> <m3iqk2rcwd.fsf@anduin.mandriva.com> <1242383903.10164.118.camel@falcon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ni93GHxFvA+th69W"
Content-Disposition: inline
In-Reply-To: <1242383903.10164.118.camel@falcon>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips


--ni93GHxFvA+th69W
Content-Type: multipart/mixed; boundary="DqhR8hV3EnoxUkKN"
Content-Disposition: inline


--DqhR8hV3EnoxUkKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18:38 Fri 15 May     , Wu Zhangjin wrote:
> On Fri, 2009-05-15 at 10:25 +0200, Arnaud Patard wrote:
> > - even if it should not affect the kernel, compiling with
> >   -march=3Dloongson2f even for 2e (you're matching on loongson2 so 2e a=
nd
> >   2f) looks weird.
>=20
> sorry, this is really a very obvious error, in 2e, -march=3Dloongson2e
> should be used.
>=20
> to fix this problem, perhaps we can add two new kernel options:
>=20
> config CPU_LOONGSON2E
> 	bool
>=20
> config CPU_LOONGSON2F
> 	bool
>=20
> and then use this solution:
>=20
> config FULOONG2E
> 	...
> 	select CPU_LOONGSON2E
> 	...
>=20
> config YEELOONG2F
> 	...
> 	select CPU_LOONGSON2F
> 	...
>=20
> cflags-$(CONFIG_CPU_LOONGSON2E)  +=3D -march=3Dloongson2e -Wa,--trap
> cflags-$(CONFIG_CPU_LOONGSON2F)  +=3D -march=3Dloongson2f -Wa,--trap
>=20
> is this solution okay?

I have tried to solve this problem once. At that time, there is no loongson=
-dev
list. So I send my patch to yanhua and zhang fuxin directly. It seems that =
they
didn't forward that patch to you.

For the whole patch, please check attachment. It does not applicable on top=
 of
your work any more.

But here is how I deal with the CPU types:

@@ -951,14 +929,20 @@ choice
       prompt "CPU type"
       default CPU_R4X00

-config CPU_LOONGSON2
-       bool "Loongson 2"
-       depends on SYS_HAS_CPU_LOONGSON2
-       select CPU_SUPPORTS_32BIT_KERNEL
-       select CPU_SUPPORTS_64BIT_KERNEL
-       select CPU_SUPPORTS_HIGHMEM
+config CPU_LOONGSON2E
+       bool "Loongson 2E"
+       depends on SYS_HAS_CPU_LOONGSON2E
+       select CPU_LOONGSON2
+       help
+         The Loongson 2E processor implements the MIPS III instruction set
+         with many extensions.
+
+config CPU_LOONGSON2F
+       bool "Loongson 2F"
+       depends on SYS_HAS_CPU_LOONGSON2F
+       select CPU_LOONGSON2
        help
-         The Loongson 2E/2F processor implements the MIPS III instruction =
set
+         The Loongson 2F processor implements the MIPS III instruction set
         with many extensions.

 config CPU_MIPS32_R1
@@ -1171,7 +1155,16 @@ config CPU_SB1

 endchoice

-config SYS_HAS_CPU_LOONGSON2
+config CPU_LOONGSON2
+       bool
+       select CPU_SUPPORTS_32BIT_KERNEL
+       select CPU_SUPPORTS_64BIT_KERNEL
+       select CPU_SUPPORTS_HIGHMEM
+
+config SYS_HAS_CPU_LOONGSON2E
+       bool
+
+config SYS_HAS_CPU_LOONGSON2F
        bool

 config SYS_HAS_CPU_MIPS32_R1

--=20
Zhang, Le
Gentoo/Loongson Developer
http://zhangle.is-a-geek.org
0260 C902 B8F8 6506 6586 2B90 BC51 C808 1E4E 2973

--DqhR8hV3EnoxUkKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-Resent-RFC-lemote-products-naming-convention-chan.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 7f87a641bdc960d6e38a03197701df8b1c750d15 Mon Sep 17 00:00:00 2001
=46rom: Zhang Le <r0bertz@gentoo.org>
Date: Wed, 25 Mar 2009 05:44:05 +0800
Subject: [PATCH] Resent: [RFC] lemote products naming convention change

There is a little flaw in my previous patch, just fixed.

Previously, the naming convention lacks consistency.
Like:
1. FULONG is actually FULOONG
2. 2E box is just called FULONG, while 2F box is called FULONG2F
3. 2F box is called FULONG2F, while 2F notebook is call 2FNOTEBOOK
4. 2F has a machine type LM2F, while 2E box has no machine type

So I tried to make it look better.

This patch applies to master branch of lemote's git.
I have already tested it on my 2e/2f box and yeelong.

There are several changes in this patch:
1. added CPU type CPU_LOONGSON2E and CPU_LOONGSON2F in addition to
   CPU_LOONGSON2, so that we can minimize the change while make it possible=
 to
   set different cflags for different CPUs.
2. added machine type MACH_LM2E, move fuloong 2e's Kconfig to its own direc=
tory
3. change all occurences of fulong to fuloong
4. change LEMOTE_FULONG to LEMOTE_FULOONG2E, make it clear that it uses Loo=
ngson 2E
5. change LEMOTE_2FNOTEBOOK to LEMOTE_YEELOONG2F

Signed-off-by: Zhang Le <r0bertz@gentoo.org>
---
 arch/mips/Kconfig                               |   63 ++++++++++---------=
----
 arch/mips/Makefile                              |   24 ++++----
 arch/mips/configs/fulong_defconfig              |    6 +-
 arch/mips/configs/ls2f_fulong_defconfig         |    6 +-
 arch/mips/configs/ls2f_notebook_defconfig       |    6 +-
 arch/mips/configs/ls2f_notebook_fbsplash.config |    6 +-
 arch/mips/kernel/8250-platform.c                |    2 +-
 arch/mips/lemote/lm2e/Kconfig                   |   32 ++++++++++++
 arch/mips/lemote/lm2e/Makefile                  |    2 +-
 arch/mips/lemote/lm2e/prom.c                    |    2 +-
 arch/mips/lemote/lm2f/Kconfig                   |   23 ++++----
 arch/mips/lemote/lm2f/lmbook/Makefile           |    2 +-
 arch/mips/pci/Makefile                          |    6 +-
 arch/mips/pci/ops-bonito64.c                    |    4 +-
 arch/mips/zboot/Makefile                        |    2 +-
 arch/mips/zboot/lm2f/ns16550.c                  |    4 +-
 drivers/ata/Kconfig                             |    2 +-
 include/asm-mips/mips-boards/bonito64.h         |    2 +-
 18 files changed, 109 insertions(+), 85 deletions(-)
 create mode 100644 arch/mips/lemote/lm2e/Kconfig

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5059abe..d0ea735 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -155,34 +155,11 @@ config LASAT
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select GENERIC_HARDIRQS_NO__DO_IRQ
=20
-config LEMOTE_FULONG
-	bool "Lemote Fulong mini-PC"
-	select ARCH_SPARSEMEM_ENABLE
-	select CEVT_R4K
-	select CSRC_R4K
-	select SYS_HAS_CPU_LOONGSON2
-	select DMA_NONCOHERENT
-	select BOOT_ELF32
-	select BOARD_SCACHE
-	select HAVE_STD_PC_SERIAL_PORT
-	select HW_HAS_PCI
-	select I8259
-	select ISA
-	select IRQ_CPU
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_64BIT_KERNEL
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_SUPPORTS_HIGHMEM
-	select SYS_HAS_EARLY_PRINTK
-	select GENERIC_HARDIRQS_NO__DO_IRQ
-	select GENERIC_ISA_DMA_SUPPORT_BROKEN
-	select CPU_HAS_WB
-	help
-	  Lemote Fulong mini-PC board based on the Chinese Loongson-2E CPU and
-	  an FPGA northbridge
+config MACH_LM2E
+	bool "Lemote Loongson 2E based machines"
=20
 config MACH_LM2F
-	bool "Lemote LOONGSON2F based machines"
+	bool "Lemote Loongson 2F based machines"
=20
 config MIPS_MALTA
 	bool "MIPS Malta board"
@@ -610,6 +587,7 @@ source "arch/mips/sgi-ip27/Kconfig"
 source "arch/mips/sibyte/Kconfig"
 source "arch/mips/txx9/Kconfig"
 source "arch/mips/vr41xx/Kconfig"
+source "arch/mips/lemote/lm2e/Kconfig"
 source "arch/mips/lemote/lm2f/Kconfig"
=20
 endmenu
@@ -951,14 +929,20 @@ choice
 	prompt "CPU type"
 	default CPU_R4X00
=20
-config CPU_LOONGSON2
-	bool "Loongson 2"
-	depends on SYS_HAS_CPU_LOONGSON2
-	select CPU_SUPPORTS_32BIT_KERNEL
-	select CPU_SUPPORTS_64BIT_KERNEL
-	select CPU_SUPPORTS_HIGHMEM
+config CPU_LOONGSON2E
+	bool "Loongson 2E"
+	depends on SYS_HAS_CPU_LOONGSON2E
+	select CPU_LOONGSON2
+	help
+	  The Loongson 2E processor implements the MIPS III instruction set
+	  with many extensions.
+
+config CPU_LOONGSON2F
+	bool "Loongson 2F"
+	depends on SYS_HAS_CPU_LOONGSON2F
+	select CPU_LOONGSON2
 	help
-	  The Loongson 2E/2F processor implements the MIPS III instruction set
+	  The Loongson 2F processor implements the MIPS III instruction set
 	  with many extensions.
=20
 config CPU_MIPS32_R1
@@ -1171,7 +1155,16 @@ config CPU_SB1
=20
 endchoice
=20
-config SYS_HAS_CPU_LOONGSON2
+config CPU_LOONGSON2
+	bool
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select CPU_SUPPORTS_64BIT_KERNEL
+	select CPU_SUPPORTS_HIGHMEM
+
+config SYS_HAS_CPU_LOONGSON2E
+	bool
+
+config SYS_HAS_CPU_LOONGSON2F
 	bool
=20
 config SYS_HAS_CPU_MIPS32_R1
@@ -2036,7 +2029,7 @@ source "drivers/cpufreq/Kconfig"
=20
 config LS2F_CPU_FREQ
 	tristate "Loongson-2F CPU Frequency driver"
-	depends on CPU_LOONGSON2 && CPU_FREQ
+	depends on CPU_LOONGSON2F && CPU_FREQ
 	select CPU_FREQ_TABLE
 	help
 	  This adds the cpufreq driver for Loongson-2F.
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 95036fd..2a59e77 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -298,11 +298,11 @@ cflags-$(CONFIG_WR_PPMC)		+=3D -Iinclude/asm-mips/mac=
h-wrppmc
 load-$(CONFIG_WR_PPMC)		+=3D 0xffffffff80100000
=20
 #
-# lemote fulong mini-PC board
+# lemote loongson2e fuloong mini-PC board
 #
-core-$(CONFIG_LEMOTE_FULONG) +=3Darch/mips/lemote/lm2e/
-load-$(CONFIG_LEMOTE_FULONG) +=3D0xffffffff80100000
-cflags-$(CONFIG_LEMOTE_FULONG) +=3D -Iinclude/asm-mips/mach-lemote
+core-$(CONFIG_LEMOTE_FULOONG2E) +=3Darch/mips/lemote/lm2e/
+load-$(CONFIG_LEMOTE_FULOONG2E) +=3D0xffffffff80100000
+cflags-$(CONFIG_LEMOTE_FULOONG2E) +=3D -I$(srctree)/arch/mips/include/asm/=
mach-lemote
=20
 #
 # common lemote loongson2f stuffs
@@ -310,18 +310,18 @@ cflags-$(CONFIG_LEMOTE_FULONG) +=3D -Iinclude/asm-mip=
s/mach-lemote
 core-$(CONFIG_MACH_LM2F) +=3Darch/mips/lemote/lm2f/common/
=20
 #
-# lemote loongson2f fulong mini-PC board
+# lemote loongson2f fuloong mini-PC board
 #
-core-$(CONFIG_LEMOTE_FULONG2F) +=3Darch/mips/lemote/lm2f/lmbox/
-load-$(CONFIG_LEMOTE_FULONG2F) +=3D0xffffffff80200000
-cflags-$(CONFIG_LEMOTE_FULONG2F) +=3D -Iinclude/asm-mips/mach-lemote
+core-$(CONFIG_LEMOTE_FULOONG2F) +=3Darch/mips/lemote/lm2f/lmbox/
+load-$(CONFIG_LEMOTE_FULOONG2F) +=3D0xffffffff80200000
+cflags-$(CONFIG_LEMOTE_FULOONG2F) +=3D -I$(srctree)/arch/mips/include/asm/=
mach-lemote
=20
 #
-# lemote loongson2f notebook
+# lemote loongson2f yeeloong notebook
 #
-core-$(CONFIG_LEMOTE_2FNOTEBOOK) +=3Darch/mips/lemote/lm2f/lmbook/
-load-$(CONFIG_LEMOTE_2FNOTEBOOK) +=3D0xffffffff80200000
-cflags-$(CONFIG_LEMOTE_2FNOTEBOOK) +=3D -Iinclude/asm-mips/mach-lemote
+core-$(CONFIG_LEMOTE_YEELOONG2F) +=3Darch/mips/lemote/lm2f/lmbook/
+load-$(CONFIG_LEMOTE_YEELOONG2F) +=3D0xffffffff80200000
+cflags-$(CONFIG_LEMOTE_YEELOONG2F) +=3D -I$(srctree)/arch/mips/include/asm=
/mach-lemote
=20
 #
 # MIPS Malta board
diff --git a/arch/mips/configs/fulong_defconfig b/arch/mips/configs/fulong_=
defconfig
index 6209800..170b4e5 100644
--- a/arch/mips/configs/fulong_defconfig
+++ b/arch/mips/configs/fulong_defconfig
@@ -8,7 +8,7 @@ CONFIG_MIPS=3Dy
 #
 # Machine selection
 #
-CONFIG_LEMOTE_FULONG=3Dy
+CONFIG_LEMOTE_FULOONG2E=3Dy
 # CONFIG_MACH_ALCHEMY is not set
 # CONFIG_BASLER_EXCITE is not set
 # CONFIG_MIPS_COBALT is not set
@@ -62,7 +62,7 @@ CONFIG_MIPS_L1_CACHE_SHIFT=3D5
 #
 # CPU selection
 #
-CONFIG_CPU_LOONGSON2=3Dy
+CONFIG_CPU_LOONGSON2E=3Dy
 # CONFIG_CPU_MIPS32_R1 is not set
 # CONFIG_CPU_MIPS32_R2 is not set
 # CONFIG_CPU_MIPS64_R1 is not set
@@ -82,7 +82,7 @@ CONFIG_CPU_LOONGSON2=3Dy
 # CONFIG_CPU_RM7000 is not set
 # CONFIG_CPU_RM9000 is not set
 # CONFIG_CPU_SB1 is not set
-CONFIG_SYS_HAS_CPU_LOONGSON2=3Dy
+CONFIG_SYS_HAS_CPU_LOONGSON2E=3Dy
 CONFIG_SYS_SUPPORTS_32BIT_KERNEL=3Dy
 CONFIG_SYS_SUPPORTS_64BIT_KERNEL=3Dy
 CONFIG_CPU_SUPPORTS_32BIT_KERNEL=3Dy
diff --git a/arch/mips/configs/ls2f_fulong_defconfig b/arch/mips/configs/ls=
2f_fulong_defconfig
index 77c71bd..ea05368 100644
--- a/arch/mips/configs/ls2f_fulong_defconfig
+++ b/arch/mips/configs/ls2f_fulong_defconfig
@@ -44,7 +44,7 @@ CONFIG_MACH_LM2F=3Dy
 # CONFIG_TOSHIBA_RBTX4927 is not set
 # CONFIG_TOSHIBA_RBTX4938 is not set
 # CONFIG_WR_PPMC is not set
-CONFIG_LEMOTE_FULONG2F=3Dy
+CONFIG_LEMOTE_FULOONG2F=3Dy
 # CONFIG_LEMOTE_2FNOTEBOOK is not set
 CONFIG_CS5536_RTC_BUG=3Dy
 CONFIG_CS5536=3Dy
@@ -83,7 +83,7 @@ CONFIG_HAVE_STD_PC_SERIAL_PORT=3Dy
 #
 # CPU selection
 #
-CONFIG_CPU_LOONGSON2=3Dy
+CONFIG_CPU_LOONGSON2F=3Dy
 # CONFIG_CPU_MIPS32_R1 is not set
 # CONFIG_CPU_MIPS32_R2 is not set
 # CONFIG_CPU_MIPS64_R1 is not set
@@ -103,7 +103,7 @@ CONFIG_CPU_LOONGSON2=3Dy
 # CONFIG_CPU_RM7000 is not set
 # CONFIG_CPU_RM9000 is not set
 # CONFIG_CPU_SB1 is not set
-CONFIG_SYS_HAS_CPU_LOONGSON2=3Dy
+CONFIG_SYS_HAS_CPU_LOONGSON2F=3Dy
 CONFIG_SYS_SUPPORTS_32BIT_KERNEL=3Dy
 CONFIG_SYS_SUPPORTS_64BIT_KERNEL=3Dy
 CONFIG_CPU_SUPPORTS_32BIT_KERNEL=3Dy
diff --git a/arch/mips/configs/ls2f_notebook_defconfig b/arch/mips/configs/=
ls2f_notebook_defconfig
index 8251089..14516da 100644
--- a/arch/mips/configs/ls2f_notebook_defconfig
+++ b/arch/mips/configs/ls2f_notebook_defconfig
@@ -43,7 +43,7 @@ CONFIG_MACH_LM2F=3Dy
 # CONFIG_MIKROTIK_RB532 is not set
 # CONFIG_WR_PPMC is not set
 # CONFIG_LEMOTE_FULONG2F is not set
-CONFIG_LEMOTE_2FNOTEBOOK=3Dy
+CONFIG_LEMOTE_YEELOONG2F=3Dy
 CONFIG_CS5536_RTC_BUG=3Dy
 CONFIG_CS5536=3Dy
 CONFIG_RWSEM_GENERIC_SPINLOCK=3Dy
@@ -80,7 +80,7 @@ CONFIG_HAVE_STD_PC_SERIAL_PORT=3Dy
 #
 # CPU selection
 #
-CONFIG_CPU_LOONGSON2=3Dy
+CONFIG_CPU_LOONGSON2F=3Dy
 # CONFIG_CPU_MIPS32_R1 is not set
 # CONFIG_CPU_MIPS32_R2 is not set
 # CONFIG_CPU_MIPS64_R1 is not set
@@ -100,7 +100,7 @@ CONFIG_CPU_LOONGSON2=3Dy
 # CONFIG_CPU_RM7000 is not set
 # CONFIG_CPU_RM9000 is not set
 # CONFIG_CPU_SB1 is not set
-CONFIG_SYS_HAS_CPU_LOONGSON2=3Dy
+CONFIG_SYS_HAS_CPU_LOONGSON2F=3Dy
 CONFIG_SYS_SUPPORTS_32BIT_KERNEL=3Dy
 CONFIG_SYS_SUPPORTS_64BIT_KERNEL=3Dy
 CONFIG_CPU_SUPPORTS_32BIT_KERNEL=3Dy
diff --git a/arch/mips/configs/ls2f_notebook_fbsplash.config b/arch/mips/co=
nfigs/ls2f_notebook_fbsplash.config
index 43d45cf..82cce00 100644
--- a/arch/mips/configs/ls2f_notebook_fbsplash.config
+++ b/arch/mips/configs/ls2f_notebook_fbsplash.config
@@ -43,7 +43,7 @@ CONFIG_MACH_LM2F=3Dy
 # CONFIG_MIKROTIK_RB532 is not set
 # CONFIG_WR_PPMC is not set
 # CONFIG_LEMOTE_FULONG2F is not set
-CONFIG_LEMOTE_2FNOTEBOOK=3Dy
+CONFIG_LEMOTE_YEELOONG2F=3Dy
 CONFIG_CS5536_RTC_BUG=3Dy
 CONFIG_CS5536=3Dy
 CONFIG_RWSEM_GENERIC_SPINLOCK=3Dy
@@ -80,7 +80,7 @@ CONFIG_HAVE_STD_PC_SERIAL_PORT=3Dy
 #
 # CPU selection
 #
-CONFIG_CPU_LOONGSON2=3Dy
+CONFIG_CPU_LOONGSON2F=3Dy
 # CONFIG_CPU_MIPS32_R1 is not set
 # CONFIG_CPU_MIPS32_R2 is not set
 # CONFIG_CPU_MIPS64_R1 is not set
@@ -100,7 +100,7 @@ CONFIG_CPU_LOONGSON2=3Dy
 # CONFIG_CPU_RM7000 is not set
 # CONFIG_CPU_RM9000 is not set
 # CONFIG_CPU_SB1 is not set
-CONFIG_SYS_HAS_CPU_LOONGSON2=3Dy
+CONFIG_SYS_HAS_CPU_LOONGSON2F=3Dy
 CONFIG_SYS_SUPPORTS_32BIT_KERNEL=3Dy
 CONFIG_SYS_SUPPORTS_64BIT_KERNEL=3Dy
 CONFIG_CPU_SUPPORTS_32BIT_KERNEL=3Dy
diff --git a/arch/mips/kernel/8250-platform.c b/arch/mips/kernel/8250-platf=
orm.c
index 6bf8ab3..308b02d 100644
--- a/arch/mips/kernel/8250-platform.c
+++ b/arch/mips/kernel/8250-platform.c
@@ -27,7 +27,7 @@
=20
 static struct plat_serial8250_port uart8250_data[] =3D {
 #ifdef CONFIG_MACH_LM2F
-#if defined(CONFIG_LEMOTE_NAS) || defined(CONFIG_LEMOTE_2FNOTEBOOK)
+#if defined(CONFIG_LEMOTE_NAS) || defined(CONFIG_LEMOTE_YEELOONG2F)
 	{ .membase =3D UART_BASE,
 	  .irq =3D 19,
 	  .uartclk =3D 3686400,
diff --git a/arch/mips/lemote/lm2e/Kconfig b/arch/mips/lemote/lm2e/Kconfig
new file mode 100644
index 0000000..aa897c1
--- /dev/null
+++ b/arch/mips/lemote/lm2e/Kconfig
@@ -0,0 +1,32 @@
+choice
+	prompt "Machine type"
+	depends on MACH_LM2E
+	default LEMOTE_FULOONG2E
+
+config LEMOTE_FULOONG2E
+	bool "Lemote Fuloong 2E mini PC"
+	select ARCH_SPARSEMEM_ENABLE
+	select CEVT_R4K
+	select CSRC_R4K
+	select SYS_HAS_CPU_LOONGSON2E
+	select DMA_NONCOHERENT
+	select BOOT_ELF32
+	select BOARD_SCACHE
+	select HAVE_STD_PC_SERIAL_PORT
+	select HW_HAS_PCI
+	select I8259
+	select ISA
+	select IRQ_CPU
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_SUPPORTS_HIGHMEM
+	select SYS_HAS_EARLY_PRINTK
+	select GENERIC_HARDIRQS_NO__DO_IRQ
+	select GENERIC_ISA_DMA_SUPPORT_BROKEN
+	select CPU_HAS_WB
+	help
+	  Lemote Fuloong mini-PC board based on the Chinese Loongson-2E CPU and
+	  an FPGA northbridge
+
+endchoice
diff --git a/arch/mips/lemote/lm2e/Makefile b/arch/mips/lemote/lm2e/Makefile
index d34671d..a31cff2 100644
--- a/arch/mips/lemote/lm2e/Makefile
+++ b/arch/mips/lemote/lm2e/Makefile
@@ -1,5 +1,5 @@
 #
-# Makefile for Lemote Fulong mini-PC board.
+# Makefile for Lemote Fuloong mini-PC board.
 #
=20
 obj-y +=3D setup.o prom.o reset.o irq.o pci.o bonito-irq.o dbg_io.o mem.o
diff --git a/arch/mips/lemote/lm2e/prom.c b/arch/mips/lemote/lm2e/prom.c
index 7edc15d..1ea17b5 100644
--- a/arch/mips/lemote/lm2e/prom.c
+++ b/arch/mips/lemote/lm2e/prom.c
@@ -30,7 +30,7 @@ static int *env;
=20
 const char *get_system_type(void)
 {
-	return "lemote-fulong";
+	return "lemote-fuloong";
 }
=20
 void __init prom_init_cmdline(void)
diff --git a/arch/mips/lemote/lm2f/Kconfig b/arch/mips/lemote/lm2f/Kconfig
index 25c2b3d..f157f15 100644
--- a/arch/mips/lemote/lm2f/Kconfig
+++ b/arch/mips/lemote/lm2f/Kconfig
@@ -1,14 +1,14 @@
 choice
 	prompt "Machine type"
 	depends on MACH_LM2F
-	default LEMOTE_FULONG2F
+	default LEMOTE_FULOONG2F
=20
-config LEMOTE_FULONG2F
-	bool "Lemote Fulong mini-PC"
+config LEMOTE_FULOONG2F
+	bool "Lemote Fuloong 2F mini PC"
 	select ARCH_SPARSEMEM_ENABLE
 	select CEVT_R4K
 	select CSRC_R4K
-	select SYS_HAS_CPU_LOONGSON2
+	select SYS_HAS_CPU_LOONGSON2F
 	select DMA_NONCOHERENT
 	select BOOT_ELF32
 	select BOARD_SCACHE
@@ -27,14 +27,14 @@ config LEMOTE_FULONG2F
 	select CPU_HAS_WB
 	select CS5536
 	help
-	  Lemote Fulong mini-PC board based on the Chinese Loongson-2F CPU
+	  Lemote Fuloong mini-PC board based on the Chinese Loongson-2F CPU
=20
-config LEMOTE_2FNOTEBOOK
-	bool "Lemote mini Notebook"
+config LEMOTE_YEELOONG2F
+	bool "Lemote Yeeloong 2F mini Notebook"
 	select ARCH_SPARSEMEM_ENABLE
 	select CEVT_R4K
 	select CSRC_R4K
-	select SYS_HAS_CPU_LOONGSON2
+	select SYS_HAS_CPU_LOONGSON2F
 	select DMA_NONCOHERENT
 	select BOOT_ELF32
 	select BOARD_SCACHE
@@ -53,7 +53,7 @@ config LEMOTE_2FNOTEBOOK
 	select CPU_HAS_WB
 	select CS5536
 	help
-	  Lemote Notebook based on the Chinese Loongson-2F CPU
+	  Lemote Yeelong Notebook based on the Chinese Loongson-2F CPU
=20
 endchoice
=20
@@ -66,7 +66,6 @@ config CS5536
=20
 config LEMOTE_NAS
 	bool "Lemote NAS machine"
-	depends on LEMOTE_FULONG2F
-	help=20
+	depends on LEMOTE_FULOONG2F
+	help
 	  Lemote's Loongson-2F based network attached system
-
diff --git a/arch/mips/lemote/lm2f/lmbook/Makefile b/arch/mips/lemote/lm2f/=
lmbook/Makefile
index 92a19c3..cccb40d 100644
--- a/arch/mips/lemote/lm2f/lmbook/Makefile
+++ b/arch/mips/lemote/lm2f/lmbook/Makefile
@@ -1,5 +1,5 @@
 #
-# Makefile for Lemote Loongson-2F mini notebook
+# Makefile for Lemote Loongson-2F yeeloong mini notebook
 #
=20
 obj-y	+=3D setup.o prom.o reset.o irq.o bonito-irq.o dbg_io.o=20
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index b023e1c..97b2cc5 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -26,9 +26,9 @@ obj-$(CONFIG_MIPS_COBALT)	+=3D fixup-cobalt.o
 obj-$(CONFIG_SOC_AU1500)	+=3D fixup-au1000.o ops-au1000.o
 obj-$(CONFIG_SOC_AU1550)	+=3D fixup-au1000.o ops-au1000.o
 obj-$(CONFIG_SOC_PNX8550)	+=3D fixup-pnx8550.o ops-pnx8550.o
-obj-$(CONFIG_LEMOTE_FULONG)	+=3D fixup-lm2e.o ops-bonito64.o
-obj-$(CONFIG_LEMOTE_FULONG2F)	+=3D fixup-lm2f.o ops-loongson2f.o
-obj-$(CONFIG_LEMOTE_2FNOTEBOOK)	+=3D fixup-lmbook.o ops-loongson2f.o
+obj-$(CONFIG_LEMOTE_FULOONG2E)	+=3D fixup-lm2e.o ops-bonito64.o
+obj-$(CONFIG_LEMOTE_FULOONG2F)	+=3D fixup-lm2f.o ops-loongson2f.o
+obj-$(CONFIG_LEMOTE_YEELOONG2F)	+=3D fixup-lmbook.o ops-loongson2f.o
 obj-$(CONFIG_MIPS_MALTA)	+=3D fixup-malta.o
 obj-$(CONFIG_PMC_MSP7120_GW)	+=3D fixup-pmcmsp.o ops-pmcmsp.o
 obj-$(CONFIG_PMC_MSP7120_EVAL)	+=3D fixup-pmcmsp.o ops-pmcmsp.o
diff --git a/arch/mips/pci/ops-bonito64.c b/arch/mips/pci/ops-bonito64.c
index f742c51..54e55e7 100644
--- a/arch/mips/pci/ops-bonito64.c
+++ b/arch/mips/pci/ops-bonito64.c
@@ -29,7 +29,7 @@
 #define PCI_ACCESS_READ  0
 #define PCI_ACCESS_WRITE 1
=20
-#ifdef CONFIG_LEMOTE_FULONG
+#ifdef CONFIG_LEMOTE_FULOONG2E
 #define CFG_SPACE_REG(offset) (void *)CKSEG1ADDR(BONITO_PCICFG_BASE | (off=
set))
 #define ID_SEL_BEGIN 11
 #else
@@ -77,7 +77,7 @@ static int bonito64_pcibios_config_access(unsigned char a=
ccess_type,
 	addrp =3D CFG_SPACE_REG(addr & 0xffff);
 	if (access_type =3D=3D PCI_ACCESS_WRITE) {
 		writel(cpu_to_le32(*data), addrp);
-#ifndef CONFIG_LEMOTE_FULONG
+#ifndef CONFIG_LEMOTE_FULOONG2E
 		/* Wait till done */
 		while (BONITO_PCIMSTAT & 0xF);
 #endif
diff --git a/arch/mips/zboot/Makefile b/arch/mips/zboot/Makefile
index 9c3bc8a..7ca8aa8 100644
--- a/arch/mips/zboot/Makefile
+++ b/arch/mips/zboot/Makefile
@@ -43,7 +43,7 @@ images/vmlinux.gz: $(TOPDIR)/vmlinux
=20
 $(BOOT_TARGETS): lib/zlib.a images/vmlinux.gz
=20
-ifdef CONFIG_LEMOTE_FULONG
+ifdef CONFIG_LEMOTE_FULOONG2E
 SUBARCH :=3D $(obj)/lm2e
 KBUILD_IMAGE :=3D arch/mips/zboot/lm2e/bzImage
 endif
diff --git a/arch/mips/zboot/lm2f/ns16550.c b/arch/mips/zboot/lm2f/ns16550.c
index 8bfe8bb..9410665 100644
--- a/arch/mips/zboot/lm2f/ns16550.c
+++ b/arch/mips/zboot/lm2f/ns16550.c
@@ -8,7 +8,7 @@
=20
 typedef struct NS16550 *NS16550_t;
=20
-#ifdef CONFIG_LEMOTE_FULONG2F
+#ifdef CONFIG_LEMOTE_FULOONG2F
 #ifdef CONFIG_LEMOTE_NAS
 #define COM1 0xbff003f8
 #else=20
@@ -16,7 +16,7 @@ typedef struct NS16550 *NS16550_t;
 #endif
 #endif
=20
-#ifdef CONFIG_LEMOTE_2FNOTEBOOK=20
+#ifdef CONFIG_LEMOTE_YEELOONG2F
 #define COM1 0xbff003f8
 #endif
=20
diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 11c8c19..a69a1ab 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -311,7 +311,7 @@ config PATA_CS5535
=20
 config PATA_CS5536
 	tristate "CS5536 PATA support (Experimental)"
-	depends on PCI && X86 && !X86_64 && EXPERIMENTAL
+	depends on PCI && ( X86 || MACH_LM2F ) && !X86_64
 	help
 	  This option enables support for the AMD CS5536
 	  companion chip used with the Geode LX processor family.
diff --git a/include/asm-mips/mips-boards/bonito64.h b/include/asm-mips/mip=
s-boards/bonito64.h
index 9e70093..86f7a76 100644
--- a/include/asm-mips/mips-boards/bonito64.h
+++ b/include/asm-mips/mips-boards/bonito64.h
@@ -26,7 +26,7 @@
 /* offsets from base register */
 #define BONITO(x)	(x)
=20
-#elif defined(CONFIG_LEMOTE_FULONG) ||defined(CONFIG_LEMOTE_FULONG2F) ||de=
fined(CONFIG_LEMOTE_2FNOTEBOOK)
+#elif defined(CONFIG_MACH_LM2E) || defined(CONFIG_MACH_LM2F)
=20
 #define BONITO(x) (*(volatile u32 *)((char *)CKSEG1ADDR(BONITO_REG_BASE) +=
 (x)))
 #define BONITO_IRQ_BASE   32
--=20
1.6.2.3


--DqhR8hV3EnoxUkKN--

--ni93GHxFvA+th69W
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAkoNocYACgkQvFHICB5OKXNP8ACeLpzt/WnFyei5CsqulIXtCODH
1wQAniMJoCoDOZn6GTrk3RRfZI832IBm
=NWla
-----END PGP SIGNATURE-----

--ni93GHxFvA+th69W--
