Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Oct 2014 03:43:52 +0200 (CEST)
Received: from resqmta-po-03v.sys.comcast.net ([96.114.154.162]:57327 "EHLO
        resqmta-po-03v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010799AbaJHBnugTzF2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Oct 2014 03:43:50 +0200
Received: from resomta-po-17v.sys.comcast.net ([96.114.154.241])
        by resqmta-po-03v.sys.comcast.net with comcast
        id 0Rhf1p0035Clt1L01RjjzM; Wed, 08 Oct 2014 01:43:43 +0000
Received: from [192.168.1.13] ([69.251.152.165])
        by resomta-po-17v.sys.comcast.net with comcast
        id 0Rji1p00H3aNLgd01RjjmQ; Wed, 08 Oct 2014 01:43:43 +0000
Message-ID: <543496C6.7000005@gentoo.org>
Date:   Tue, 07 Oct 2014 21:43:34 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: IP22/IP32: Add missing ifdefs to Platform files
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1412732623;
        bh=+VBRODf7FW8vKjyXuwRNA/N5/qvc97yGz8cu0so629Y=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=MKBo0IQfiBtSp3H2ugJjImAtBjg42k8TTKqEiCdFxcpA9zpPNBrTp44Xw/KTNnkzR
         Kr7Hbt0GWEMWsvAQ/ipaYP2fneJwNwrqN4IWqSosnyCsHPWDOHqP20h7eK55Wh6tWx
         EdRq88B9spW9T1iuAlowECiZV17gohNlSab6F3NeTDYGcgMbF+PZhdVi0us/YW8P8y
         83vVVJoglxzWwMVDomG0jjpi+C8Cl43vCiLNa6zyjmQHYJ0iffkaHfF6+oK8gKRsM5
         I9lBUmGQhoMLvXttkMJx+yrzTpXAPSTvkui0nmVrYpUabMEO72psqc0saiKv0m94mJ
         zEkHr2WzBw2aw==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43104
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

In arch/mips/sgi-ip22/Platform and arch/mips/sgi-ip32/Platform, ifdefs for
CONFIG_SGI_IP22 and CONFIG_SGI_IP32 are missing, which can cause the
definitions for these platforms to get included in builds for other platforms.
 This patch adds these missing ifdefs, which matches IP27's Platform file.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/sgi-ip22/Platform |    8 +++++---
 arch/mips/sgi-ip32/Platform |    9 ++++++---
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/mips/sgi-ip22/Platform b/arch/mips/sgi-ip22/Platform
index b7a4b7e..5fa3c7a 100644
--- a/arch/mips/sgi-ip22/Platform
+++ b/arch/mips/sgi-ip22/Platform
@@ -7,7 +7,8 @@
 # current variable will break so for 64-bit kernels we have to raise the start
 # address by 8kb.
 #
-platform-$(CONFIG_SGI_IP22)		+= sgi-ip22/
+ifdef CONFIG_SGI_IP22
+platform-$(CONFIG_SGI_IP22)	+= sgi-ip22/
 cflags-$(CONFIG_SGI_IP22)	+= -I$(srctree)/arch/mips/include/asm/mach-ip22
 ifdef CONFIG_32BIT
 load-$(CONFIG_SGI_IP22)		+= 0xffffffff88002000
@@ -15,6 +16,7 @@ endif
 ifdef CONFIG_64BIT
 load-$(CONFIG_SGI_IP22)		+= 0xffffffff88004000
 endif
+endif
 
 #
 # SGI IP28 (Indigo2 R10k)
@@ -28,7 +30,7 @@ ifdef CONFIG_SGI_IP28
   ifeq ($(call cc-option-yn,-mr10k-cache-barrier=store), n)
       $(error gcc doesn't support needed option -mr10k-cache-barrier=store)
   endif
-endif
-platform-$(CONFIG_SGI_IP28)		+= sgi-ip22/
+platform-$(CONFIG_SGI_IP28)	+= sgi-ip22/
 cflags-$(CONFIG_SGI_IP28)	+= -mr10k-cache-barrier=store -I$(srctree)/arch/mips/include/asm/mach-ip28
 load-$(CONFIG_SGI_IP28)		+= 0xa800000020004000
+endif
diff --git a/arch/mips/sgi-ip32/Platform b/arch/mips/sgi-ip32/Platform
index 0fea556..ab95705 100644
--- a/arch/mips/sgi-ip32/Platform
+++ b/arch/mips/sgi-ip32/Platform
@@ -6,6 +6,9 @@
 # a multiple of the kernel stack size or the handling of the current variable
 # will break.
 #
-platform-$(CONFIG_SGI_IP32)	+= sgi-ip32/
-cflags-$(CONFIG_SGI_IP32)	+= -I$(srctree)/arch/mips/include/asm/mach-ip32
-load-$(CONFIG_SGI_IP32)		+= 0xffffffff80004000
+ifdef CONFIG_SGI_IP32
+platform-$(CONFIG_SGI_IP32)		+= sgi-ip32/
+cflags-$(CONFIG_SGI_IP32)		+= -I$(srctree)/arch/mips/include/asm/mach-ip32
+load-$(CONFIG_SGI_IP32)			+= 0xffffffff80004000
+endif
+
