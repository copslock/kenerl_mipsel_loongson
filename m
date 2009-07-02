Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jul 2009 17:30:09 +0200 (CEST)
Received: from ey-out-1920.google.com ([74.125.78.148]:30431 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492211AbZGBPaB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Jul 2009 17:30:01 +0200
Received: by ey-out-1920.google.com with SMTP id 13so514585eye.60
        for <multiple recipients>; Thu, 02 Jul 2009 08:24:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4ZiNyqmByEwQyQEPN6TXIr0jo/9Tal2W4AVO8hGPkGE=;
        b=f5HW2VFlfSVJGMz5L272+vMPtSrqViiPDnKO/F/5d2YmicXHBavwygOZMxbCzV3dm2
         7qzPy41a0o/ClN5OSPUA3kACCJWkPKw5Ul4jW3eY6znEvBzWIxHWDIvpUpU3hZ3S+9KD
         LHlc3uUp4esPNOjRry/G16O9No+PQUJUeo8ss=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mg9CkSVZeZbk3A91MmHVYnKE+dKpwHv610CUUn7Ae5fJ91dfjCDINjWjzVrd//gVhI
         Ala8di2X4diqGQFnMoTNi+QulEMvtcs6tSTIi0D76WUZPDUOB+PQfs0Vbh1yKbirO3ky
         Z2XsCO/PKTiez7pb51Z7sIRqD8zSnZxDwk5G4=
Received: by 10.210.34.2 with SMTP id h2mr207280ebh.56.1246548255511;
        Thu, 02 Jul 2009 08:24:15 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 10sm2984694eyd.38.2009.07.02.08.24.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Jul 2009 08:24:14 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Cc:	Wu Zhangjin <wuzj@lemote.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Arnaud Patard <apatard@mandriva.com>
Subject: [PATCH v4 10/16] [loongson] rtc: enable legacy RTC driver on fulong
Date:	Thu,  2 Jul 2009 23:24:01 +0800
Message-Id: <a9d4b1b8e508b28b93ba03fbeef161bc3ac3ff86.1246546684.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1246546684.git.wuzhangjin@gmail.com>
References: <cover.1246546684.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23622
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

RTC_LIB is selected by MIPS by default, and therefore, the legacy RTC
driver is disabled. but fortunately, RTC_LIB not works on fulong, so,
enabling the legcy RTC driver is needed, otherwise, the tools like
hwclock will not work.

Signed-off-by: Wu Zhangjin <wuzj@lemote.com>
---
 arch/mips/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3ca0fe1..a383dac 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -6,7 +6,7 @@ config MIPS
 	select HAVE_ARCH_KGDB
 	# Horrible source of confusion.  Die, die, die ...
 	select EMBEDDED
-	select RTC_LIB
+	select RTC_LIB if !LEMOTE_FULONG
 
 mainmenu "Linux/MIPS Kernel Configuration"
 
-- 
1.6.2.1
