Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Mar 2011 00:20:13 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:61250 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491930Ab1B1XUK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Mar 2011 00:20:10 +0100
Received: by eyh6 with SMTP id 6so1427099eyh.36
        for <multiple recipients>; Mon, 28 Feb 2011 15:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:to:cc:from:subject;
        bh=wcOcApCsYHqet0aED2yEfDQQeEdaTtfnRNBHe2279T0=;
        b=Qs41YrDZ4HGQzvGwvtsQhUd4nuRui9e2Cezu3xM/xmE+2WyMRqL8nm0E9KHEZnNTYy
         LDfZsNftqaqReolw3ButfQrUzlSBk8Js0Ko6EPSDETpBNqyn1XfZwWLzF55PfeJeJQtC
         7txJPguj2rFTPF1A0geOqKwjB1GhQBoVI6M4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:to:cc:from:subject;
        b=BYeDtvyEsL/XKLsKHWenkeKOhHq/0HhidpmOwAmvgNkLF+Fl6EnDtWTZEJ1fW7pxol
         EWp7S0bTF7YJWwViL+n0n6kqzdOZi1cM4yexolDYAv+BGLZO51psyOIaQGsB0dvNVyhR
         2WZ8SMoVMPjaE2ehDQhqj4UxNyNORd3ofwm3Y=
Received: by 10.14.45.75 with SMTP id o51mr4258163eeb.49.1298935203892;
        Mon, 28 Feb 2011 15:20:03 -0800 (PST)
Received: from maurus-desktop (78-22-96-2.access.telenet.be [78.22.96.2])
        by mx.google.com with ESMTPS id b52sm3612265eei.13.2011.02.28.15.20.02
        (version=SSLv3 cipher=OTHER);
        Mon, 28 Feb 2011 15:20:03 -0800 (PST)
Message-ID: <4d6c2da3.cc7e0e0a.2116.ffffde18@mx.google.com>
Received: by maurus-desktop (sSMTP sendmail emulation); Tue,  1 Mar 2011 00:20:01 +0100
Date:   Tue,  1 Mar 2011 00:20:01 +0100
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
From:   Maurus Cuelenaere <mcuelenaere@gmail.com>
Subject: [PATCH] MIPS: Jz4740: Add HAVE_CLK
Return-Path: <mcuelenaere@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29299
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcuelenaere@gmail.com
Precedence: bulk
X-list: linux-mips

Jz4740 supports the clock framework but doesn't have HAVE_CLK defined, so define
it!

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/mips/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f5ecc05..6199128 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -208,6 +208,7 @@ config MACH_JZ4740
 	select ARCH_REQUIRE_GPIOLIB
 	select SYS_HAS_EARLY_PRINTK
 	select HAVE_PWM
+	select HAVE_CLK
 
 config LASAT
 	bool "LASAT Networks platforms"
-- 
1.7.4
