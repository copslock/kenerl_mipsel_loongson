Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Nov 2009 14:12:53 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:42344 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492734AbZKFNMH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Nov 2009 14:12:07 +0100
Received: by pwi15 with SMTP id 15so646646pwi.24
        for <multiple recipients>; Fri, 06 Nov 2009 05:12:01 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=dPUS8WnhsQugPgviv9O3ELH6TD0t5cbmEn29wS0xZ3M=;
        b=ks5w+hNoJq9eBJcWUQNLsZwPB34afCwObmNwgSdV3ATRrO3OTWColho98+5sryZMGt
         LSv3chbNKdS3DGu6Ms0OLwIIwU1nMuMfYW3dH5NzV4azTr1ISXQ+CerqKEd002iXOw1f
         znVFew5GzcANAz5TGjLX07ruL9xBiMI09omFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=agbWVhmc25BPuEKQsBkQyZ22+EGa+USk95DO0NEhKgErs791TcdbiG2GULNeHJmqsT
         tDZ1hpwr3oEWUeq9KQJT+zBgib3ywxuvVUaH8+d8WaakmdHRZKV35wrsmtlVYAfrPgv9
         //LPkfwtYSZU3/jZ8YRAd7ERd13U5y/50rLD4=
Received: by 10.114.187.37 with SMTP id k37mr6704124waf.49.1257513120997;
        Fri, 06 Nov 2009 05:12:00 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm26431pxi.7.2009.11.06.05.11.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Nov 2009 05:12:00 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Arnaud Patard <apatard@mandriva.com>, zhangfx@lemote.com,
	yanh@lemote.com, huhb@lemote.com,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org
Subject: [PATCH -queue v1 2/7] [loongson] lemote-2f: rtc: enable legacy RTC driver
Date:	Fri,  6 Nov 2009 21:11:27 +0800
Message-Id: <588574ed5910292f2728072ca147add2ae342778.1257510612.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <17e5d58a0cd7273b81c7151b7f7f2096c9694b59.1257510612.git.wuzhangjin@gmail.com>
References: <cover.1257510612.git.wuzhangjin@gmail.com>
 <17e5d58a0cd7273b81c7151b7f7f2096c9694b59.1257510612.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1257510612.git.wuzhangjin@gmail.com>
References: <cover.1257510612.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24724
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
