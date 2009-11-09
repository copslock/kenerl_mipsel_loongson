Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2009 17:07:01 +0100 (CET)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:61196 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493231AbZKIQGj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Nov 2009 17:06:39 +0100
Received: by ewy12 with SMTP id 12so3402282ewy.0
        for <multiple recipients>; Mon, 09 Nov 2009 08:06:34 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=dPUS8WnhsQugPgviv9O3ELH6TD0t5cbmEn29wS0xZ3M=;
        b=L7IiA1Dc0vGczHXXYok/fJ+q2PNb+xBgf3gc6Tu476SJkePV6IP/HMe0cvd8rv+UxK
         pKvVJ1j/NAIN6GFQ9uXWPUivKzYldioyqskDiYYE1NiAl6C3rxgE6tlegbs1PuNE/n19
         OguYYQ2VRzJuoiB+wTaFruXHXJGv8jEyRkRWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=eNl5qM7ORd7v0smIQnmGHUOdVljAvVv/tZpkEAsFkStIFIhBPM3WC5keHzkgLA45jh
         /PxzesywxPtBKUbWUUeocmhRmwAqhoYwGVAxLwXVZaqEIjvua29IwVBkmyq9d2p2kV6U
         CtH0n+uQ/BHc2QPbuW555Td/p+dTASrBTN1l0=
Received: by 10.216.87.69 with SMTP id x47mr2660021wee.97.1257782793969;
        Mon, 09 Nov 2009 08:06:33 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id p37sm9150866gvf.24.2009.11.09.08.06.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 08:06:32 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	zhangfx@lemote.com, yanh@lemote.com, huhb@lemote.com,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, Wu Zhangjin <wuzhangjin@gmail.com>,
	linux-mips@linux-mips.org
Subject: [PATCH v2 2/7] [loongson] lemote-2f: rtc: enable legacy RTC driver
Date:	Tue, 10 Nov 2009 00:06:11 +0800
Message-Id: <4c3b69663760b00d39e09c3682a55ee7cf4b84c7.1257781987.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <3154ef478a3a08f808e3a4b9c9cab9f4e263a8a2.1257781987.git.wuzhangjin@gmail.com>
References: <3154ef478a3a08f808e3a4b9c9cab9f4e263a8a2.1257781987.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1257781987.git.wuzhangjin@gmail.com>
References: <cover.1257781987.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Currently, RTC_LIB is not available on loongson family machines(need
extra patches to enable it), but the legacy RTC driver works well on
them. Herein, We just deselect RTC_LIB and make the legacy RTC driver as
a choice to not break the hwclock relative tools on these machines.

After the relative patches for RTC_LIB upstream
(http://www.linux-mips.org/archives/linux-mips/2009-11/msg00093.html),
we will be safe to Remove this patch at that time, but currently, this
is need.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d00c953..240a3ca 100644
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
