Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Aug 2004 18:37:09 +0100 (BST)
Received: from gw02.mail.saunalahti.fi ([IPv6:::ffff:195.197.172.116]:9667
	"EHLO gw02.mail.saunalahti.fi") by linux-mips.org with ESMTP
	id <S8224919AbUHPRhE>; Mon, 16 Aug 2004 18:37:04 +0100
Received: from fairytale.tal.org (cruel.tal.org [195.16.220.85])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id A1BF4177E1
	for <linux-mips@linux-mips.org>; Mon, 16 Aug 2004 20:37:01 +0300 (EEST)
Received: from amos (unknown [195.16.220.84])
	by fairytale.tal.org (Postfix) with SMTP id 2C30B8DB0
	for <linux-mips@linux-mips.org>; Mon, 16 Aug 2004 20:45:33 +0300 (EEST)
Message-ID: <001401c483b8$51d289f0$54dc10c3@amos>
From: "Kaj-Michael Lang" <milang@tal.org>
To: <linux-mips@linux-mips.org>
Subject: O2 arcboot 32-bit kernel boot fix
Date: Mon, 16 Aug 2004 20:41:40 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Return-Path: <milang@tal.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5645
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: milang@tal.org
Precedence: bulk
X-list: linux-mips

Hi

Played with arcboot today and fixed (for me atleast) loading of 32-bit
kernels.
I've also added a very simple progress thing so you know something is
happening when
the kernel is loaded.
Anyway, the patch can be found here:
http://fairytale.tal.org/pub/talinux/patches/arcboot-O2boot-and-progress.patch

The fix was quite simple, arcboot was loading the kernel over itself, the
 -	.base     = 0x80004000,
+	.base     = 0x80002000,

change is the actual fix. 64-bit kernels loads fine after the fix.

There is some extra stuff (a patch from gentoo, removal debuging from e2fs
lib, etc) too..

-- 
Kaj-Michael Lang , milang@tal.org
