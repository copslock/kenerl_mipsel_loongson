Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2009 10:06:59 +0100 (CET)
Received: from mail-pz0-f194.google.com ([209.85.222.194]:45687 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492635AbZKDJG0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Nov 2009 10:06:26 +0100
Received: by pzk32 with SMTP id 32so4707427pzk.21
        for <multiple recipients>; Wed, 04 Nov 2009 01:06:20 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=VlbIkpAFSNzmIC7cIiqhqnxhrkxOf1q9N2cTY1gu5wU=;
        b=LAJEPou1JABakGomxSwuf11xQAcVJn5u8+bgWBKR4oZUkWOKW/i4OFkyjuat16fjFR
         ERbpLf5ODliZK+sXR2GrYiE6BaIwpnP0D8Dli6wFRVwM8pfMwl/5bf23+2rUE5oPFmMy
         G9xVirdGApYThfI6dJzskacGXeHxD2TnIRSaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=G1JZ2U3GTEbXD0jykF8admYWCm9q4wgYugbeMG+MwLa7ibPmwxSFYTg65LkRFHLXs6
         9wRYpqpBkZ20Um64J3/fByhZjkLborMbPOz4ZIeXfrQKI9i1tm2bQ27j9RWv2kWNkmIN
         5bwmp/a0w1Pf3xAkTHT8w2EdF4szxW2Agiwqc=
Received: by 10.115.65.11 with SMTP id s11mr1616355wak.170.1257325580156;
        Wed, 04 Nov 2009 01:06:20 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm528567pxi.15.2009.11.04.01.06.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 01:06:19 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
	LKML <linux-kernel@vger.kernel.org>, huhb@lemote.com,
	yanh@lemote.com, Zhang Le <r0bertz@gentoo.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>, zhangfx@lemote.com,
	liujl@lemote.com
Subject: [PATCH -queue v0 5/6] [loongson] rtc: enable legacy RTC driver on fuloong2f
Date:	Wed,  4 Nov 2009 17:06:07 +0800
Message-Id: <e13ed33a99dbf14f223360d414aa2b2c5caa9b1f.1257325319.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1257325319.git.wuzhangjin@gmail.com>
References: <cover.1257325319.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24663
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

RTC_LIB is selected by MIPS by default, and therefore, the legacy RTC driver is
disabled. but fortunately, RTC_LIB not works on fulong, so, enabling the legcy
RTC driver is needed, otherwise, the tools like hwclock will not work.

because loongson family machines, including fuloong2e, fuloong2f and
yeeloong2f need to enable legacy RTC driver, so we use MACH_LOONGSON
here.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8417357..6a9bdda 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -7,7 +7,7 @@ config MIPS
 	select HAVE_ARCH_KGDB
 	# Horrible source of confusion.  Die, die, die ...
 	select EMBEDDED
-	select RTC_LIB if !LEMOTE_FULOONG2E
+	select RTC_LIB if !MACH_LOONGSON
 
 mainmenu "Linux/MIPS Kernel Configuration"
 
-- 
1.6.2.1
