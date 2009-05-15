Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 23:34:24 +0100 (BST)
Received: from mail-px0-f119.google.com ([209.85.216.119]:35813 "EHLO
	mail-px0-f119.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023417AbZEOWeS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2009 23:34:18 +0100
Received: by pxi17 with SMTP id 17so1374288pxi.22
        for <multiple recipients>; Fri, 15 May 2009 15:34:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=D2X+uNj/7bRa+s6WgFy55XcmkfdjUQr9xCC/jYIJHmg=;
        b=GPkpVtMxVLwX/vZNDCY0FtFUYf7SqKiG+bEPfE1cp9W4ZTEmLbzuEVyy4bxuOhBEUj
         h4yZHd/choeCqd/VXLZbM1V7mErEYEUoP1p931rKZnGDnoI66D+z5yK+Hz6l7EvXGa+R
         f3qGzvix6g+00fy3G/0+defkAV94b9dKKWPfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Fe9P6CqVIOm+meoqeoizbirw9kK31UqMvx64P94VYKqP4CWsem8YA3+KbNC6S1rQzB
         j7nhATtDo1ZmaxbKkHSS5VpcCPUx5A6eK2zK19MsHSrtE/tReKnPFXDQJ5TQbTTEEX9L
         F/P88vThdoPbrKrGlB7vXRUudj23KYTz8M7AQ=
Received: by 10.114.145.17 with SMTP id s17mr5696277wad.120.1242426851491;
        Fri, 15 May 2009 15:34:11 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id n33sm1998883wag.21.2009.05.15.15.34.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 15:34:10 -0700 (PDT)
Subject: [PATCH 29/30] loongson: fixup undefined CONFIG_UCA_SIZE
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>, Erwan Lerale <erwan@thiscow.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sat, 16 May 2009 06:34:04 +0800
Message-Id: <1242426844.10164.180.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22766
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

>From 3e72233003feab86575032851dd374111d0eeaef Mon Sep 17 00:00:00 2001
From: Wu Zhangjin <wuzhangjin@gmail.com>
Date: Sat, 16 May 2009 05:04:19 +0800
Subject: [PATCH 29/30] loongson: fixup undefined CONFIG_UCA_SIZE

---
 arch/mips/loongson/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index 572054c..cef68a0 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -109,7 +109,7 @@ config CS5536_MFGPT
 
 config UCA_SIZE
  	hex "Uncache Accelerated Region size"
- 	depends on LOONGSON2F 
+	depends on CPU_LOONGSON2F
  	default 0x400000 if LEMOTE_YEELOONG2F
  	default 0x2000000 if LEMOTE_FULOONG2F
  	help
-- 
1.6.2.1
