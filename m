Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2007 21:53:26 +0100 (BST)
Received: from unassigned-81-90-243-194.ujezd.net ([81.90.243.194]:30167 "EHLO
	skerikoff.satca.net") by ftp.linux-mips.org with ESMTP
	id S20030184AbXJJUxS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Oct 2007 21:53:18 +0100
Received: from localhost (unknown [127.0.0.1])
	by skerikoff.satca.net (Postfix) with ESMTP id 1488CE410B8;
	Wed, 10 Oct 2007 20:29:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at satca.net
Received: from skerikoff.satca.net ([127.0.0.1])
	by localhost (skerikoff.satca.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kQaBHKriK5MX; Wed, 10 Oct 2007 22:29:56 +0200 (CEST)
Received: from [10.1.1.70] (unknown [192.168.51.95])
	by skerikoff.satca.net (Postfix) with ESMTP id 5BCB3E41090;
	Wed, 10 Oct 2007 20:29:56 +0000 (UTC)
Message-ID: <470D3A94.9090401@satca.net>
Date:	Wed, 10 Oct 2007 22:48:20 +0200
From:	Marian Jancar <m.jancar@satca.net>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	juhosg@openwrt.org
Subject: Linux 2.6.22 on ADM5120
X-Enigmail-Version: 0.95.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <m.jancar@satca.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m.jancar@satca.net
Precedence: bulk
X-list: linux-mips

Hi,

I'm trying to boot current Linux kernel with patches from OpenWRT on
an Infineon Easy5120-RT but without the LZMA loader. Hence I
mimic what patches from
http://nano.gmxhome.de/linux-2.6.17.11-adm5120-patch.diff.gz
and
http://www.student.tue.nl/Q/t.f.a.wilms/adm5120/files/linux-2.6.12-rc1-adm.diff

(I have verified myself that the later boots, as also the 2.6.22 with
the LZMA does) do - use 0x80002000 as LOADDADD instead of 0x80001000, and
fill to 0x6d8 + jump to kernel_entry in head.S, but the resulting vmlinuz
doesn't boot. There is some info at
http://www.linux-mips.org/wiki/Adm5120#Linux_Support

diff -urNdp linux-2.6.22.9-vanilla/arch/mips/Makefile linux-2.6.22.9/arch/mips/Makefile
--- linux-2.6.22.9-vanilla/arch/mips/Makefile   2007-09-26 20:03:01.000000000 +0200
+++ linux-2.6.22.9/arch/mips/Makefile   2007-10-10 20:44:24.000000000 +0200
@@ -165,6 +165,13 @@ cflags-$(CONFIG_MACH_JAZZ) += -Iinclude/
 load-$(CONFIG_MACH_JAZZ)       += 0xffffffff80080000

 #
+# ADMtek 5120
+#
+
+core-$(CONFIG_MIPS_ADM5120)    += arch/mips/adm5120/
+load-$(CONFIG_MIPS_ADM5120)    += 0xffffffff80002000
+
+#
 # Common Alchemy Au1x00 stuff
 #
 core-$(CONFIG_SOC_AU1X00)      += arch/mips/au1000/common/


diff -urNdp linux-2.6.22.9-vanilla/arch/mips/kernel/head.S linux-2.6.22.9/arch/mips/kernel/head.S
--- linux-2.6.22.9-vanilla/arch/mips/kernel/head.S      2007-09-26 20:03:01.000000000 +0200
+++ linux-2.6.22.9/arch/mips/kernel/head.S      2007-10-10 20:44:24.000000000 +0200
@@ -134,6 +134,11 @@
         * Necessary for machines which link their kernels at KSEG0.
         */
        .fill   0x400
+#ifdef CONFIG_MIPS_ADM5120
+       /* ADM5120 bootloader jumps to 0x6d8 */
+       .fill   0x2d8
+       j kernel_entry
+#endif

 EXPORT(stext)                                  # used for profiling
 EXPORT(_stext)


Any clues what I am missing or what I do wrong?

Marian
