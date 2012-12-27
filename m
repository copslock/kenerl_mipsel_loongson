Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Dec 2012 10:39:19 +0100 (CET)
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:59232
        "EHLO qmta03.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817419Ab2L0JjOZx00Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Dec 2012 10:39:14 +0100
Received: from omta10.westchester.pa.mail.comcast.net ([76.96.62.28])
        by qmta03.westchester.pa.mail.comcast.net with comcast
        id gZYa1k0030cZkys53Zf8cT; Thu, 27 Dec 2012 09:39:08 +0000
Received: from [192.168.1.13] ([76.106.69.86])
        by omta10.westchester.pa.mail.comcast.net with comcast
        id gZf61k00C1rgsis3WZf7RQ; Thu, 27 Dec 2012 09:39:08 +0000
Message-ID: <50DC174D.6090302@gentoo.org>
Date:   Thu, 27 Dec 2012 04:39:25 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Linux MIPS List <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH]: Fix 3.7 mips build if !CONFIG_MODULES
X-Enigmail-Version: 1.4.6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20121106; t=1356601148;
        bh=DmgMMcr/bfX8VsdR7GEXbg49vDxG8APY8RjgYPdrJK0=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=MW098NwwzQqdGeJaVRJzx1IMZ5EbQwON7ls6zULCXXmucXTjbalFaXUXGJlc6HkTh
         Jjg/jwrYtnj7X1XVAkhQO8fjgrFvbn9o8m12bxHwaVLdrSQexSS9HLPrkNsYsEfeXh
         sanqe+Aq1+qoNhfKpExG7IUA1/obQjVEMSVPso9d2KIX03RWsaWdU4AC2tPykIT9T0
         Tkh03hmZ8Ti24ZYwtWp+a1qGsRCijekJq94KDnppZU7CPZ7EpCZmiBuVEJQqp8k680
         77zpiikvvDw8ZYmB4wkzVCbgbOjT5lE8rPEDxp9cpttw59pYK6Fm4OzXn77yp/k0fF
         zGlLVSlpOYt5w==
X-archive-position: 35335
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
Return-Path: <linux-mips-bounce@linux-mips.org>

The attached patch fixes a build failure if building a monolithic kernel due
to arch/mips/kernel/Kconfig selecting MODULES_USE_ELF_REL[A] without
checking to see if MODULES is set or not.  This leads to 'struct module' not
existing, which triggers a compile failure in arch/mips/kernel/module-rela.c
when the compiler attempts to dereference me->name on lines 36, 48, and 133.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---

 Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


diff -Naurp a/arch/mips/Kconfig b/arch/mips/Kconfig
--- a/arch/mips/Kconfig	2012-12-22 22:52:28.264461836 -0500
+++ b/arch/mips/Kconfig	2012-12-26 23:00:46.202996691 -0500
@@ -39,8 +39,8 @@ config MIPS
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CMOS_UPDATE
 	select HAVE_MOD_ARCH_SPECIFIC
-	select MODULES_USE_ELF_REL
-	select MODULES_USE_ELF_RELA if 64BIT
+	select MODULES_USE_ELF_REL && MODULES
+	select MODULES_USE_ELF_RELA if MODULES && 64BIT

 menu "Machine selection"
