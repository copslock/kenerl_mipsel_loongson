Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2006 08:44:21 +0100 (BST)
Received: from mo01.po.2iij.net ([210.130.202.205]:58336 "EHLO
	mo01.po.2iij.net") by ftp.linux-mips.org with ESMTP
	id S8133462AbWDFHoL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Apr 2006 08:44:11 +0100
Received: NPO MO01 id k367tRhN004609; Thu, 6 Apr 2006 16:55:27 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (NPO-MR/mbox02) id k367tQOw024524
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Thu, 6 Apr 2006 16:55:26 +0900 (JST)
Message-Id: <200604060755.k367tQOw024524@mbox02.po.2iij.net>
Date:	Thu, 6 Apr 2006 16:55:26 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: Re: [MIPS] MT: Improved multithreading support.
In-Reply-To: <4955666b0604060047x42cdc3e3kefb1d95737cc08e7@mail.gmail.com>
References: <S8133460AbWDEPzw/20060405155552Z+40@ftp.linux-mips.org>
	<4955666b0604060047x42cdc3e3kefb1d95737cc08e7@mail.gmail.com>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Envid: tripeaks.co.jp
Envelope-Id: tripeaks.co.jp
X-archive-position: 11044
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

> Subject: [MIPS] MT: Improved multithreading support.
> To: git-commits@linux-mips.org
> 
> 
> Author: Ralf Baechle <ralf@linux-mips.org> Wed Apr 5 09:45:47 2006 +0100
> Commit: 79cc8007b93838a670b164b8a55ab3e735a12a8b
> Gitweb: http://www.linux-mips.org/g/linux/79cc8007
> Branch: master
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

I think it's maybe typo.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/Kconfig mips/arch/mips/Kconfig
--- mips-orig/arch/mips/Kconfig	2006-04-06 11:26:26.460425500 +0900
+++ mips/arch/mips/Kconfig	2006-04-06 16:44:56.935829750 +0900
@@ -1617,7 +1617,7 @@ source "mm/Kconfig"
 
 config SMP
 	bool "Multi-Processing support"
-	depends on CPU_RM9000 || ((SIBYTE_BCM1x80 || SIBYTE_BCM1x55 || SIBYTE_SB1250 || QEMU) && !SIBYTE_STANDALONE) || SGI_IP27 || MIPS_MT_SMP || MIPS_MT_SMP
+	depends on CPU_RM9000 || ((SIBYTE_BCM1x80 || SIBYTE_BCM1x55 || SIBYTE_SB1250 || QEMU) && !SIBYTE_STANDALONE) || SGI_IP27 || MIPS_MT_SMP || MIPS_MT_SMTC
 	---help---
 	  This enables support for systems with more than one CPU. If you have
 	  a system with only one CPU, like most personal computers, say N. If
