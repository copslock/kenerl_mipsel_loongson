Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jul 2004 15:36:56 +0100 (BST)
Received: from [IPv6:::ffff:195.197.172.115] ([IPv6:::ffff:195.197.172.115]:43740
	"EHLO gw01.mail.saunalahti.fi") by linux-mips.org with ESMTP
	id <S8225463AbUGGOgq>; Wed, 7 Jul 2004 15:36:46 +0100
Received: from fairytale.tal.org (cruel.tal.org [195.16.220.85])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id 67B7036364
	for <linux-mips@linux-mips.org>; Wed,  7 Jul 2004 17:36:35 +0300 (EEST)
Received: from amos (unknown [195.16.220.84])
	by fairytale.tal.org (Postfix) with SMTP id 0CF4F8D77
	for <linux-mips@linux-mips.org>; Wed,  7 Jul 2004 17:38:14 +0300 (EEST)
Message-ID: <00e201c46430$5cc18250$54dc10c3@amos>
From: "Kaj-Michael Lang" <milang@tal.org>
To: <linux-mips@linux-mips.org>
References: <000d01c463d1$994e59a0$6030a8c0@eng32>
Subject: Re: querries on cross compiler
Date: Wed, 7 Jul 2004 17:40:32 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Return-Path: <milang@tal.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: milang@tal.org
Precedence: bulk
X-list: linux-mips

> Iam trying to build a cross compiler for MIPS processor on
> "i686-pc-linux-gcc" host. Iam getting some errors during the installation
of
> BINUTILS(binutils-2.9.1) i.e, after configure, when I type "make" Iam
> getting errors. Can u please suggest how to remove these errors.

That binutils is extremly old, try using something a little more uptodate...
I'd recommend using crosstool to build you cross compiler.

-- 
Kaj-Michael Lang , milang@tal.org
