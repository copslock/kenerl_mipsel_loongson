Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Aug 2004 18:43:32 +0100 (BST)
Received: from gw02.mail.saunalahti.fi ([IPv6:::ffff:195.197.172.116]:48580
	"EHLO gw02.mail.saunalahti.fi") by linux-mips.org with ESMTP
	id <S8224938AbUHPRn1>; Mon, 16 Aug 2004 18:43:27 +0100
Received: from fairytale.tal.org (cruel.tal.org [195.16.220.85])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id 5CE29177E8
	for <linux-mips@linux-mips.org>; Mon, 16 Aug 2004 20:43:26 +0300 (EEST)
Received: from amos (unknown [195.16.220.84])
	by fairytale.tal.org (Postfix) with SMTP id 6AF428DB0
	for <linux-mips@linux-mips.org>; Mon, 16 Aug 2004 20:51:57 +0300 (EEST)
Message-ID: <001501c483b9$36dc6b60$54dc10c3@amos>
From: "Kaj-Michael Lang" <milang@tal.org>
To: <linux-mips@linux-mips.org>
Subject: O2 framebuffer and mmap..
Date: Mon, 16 Aug 2004 20:48:16 +0300
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
X-archive-position: 5646
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: milang@tal.org
Precedence: bulk
X-list: linux-mips

Hi

The O2 fb driver (or something else) has broken mmap interface, you probably
know that. Anyway, I've tried to find the cause for it but I've haven't been
that succesfull.

I've patched a current cvs kernel with the old O2-fb
driver (from: http://www.linux-mips.org/~glaurung/)(before gbefb
merge/rename)
and mmap does not work with the old driver, so something else seem to
have changed so that the mmap things don't work. The 2.6.1 kernel on the
above page
does have a functional mmap (my test app and X works with it) but it's very
old..

Does anyone have any hints or ideas ?

Oh, and I've added some sysfs stuff to the gbefb driver, should I post the
changes here ?

-- 
Kaj-Michael Lang , milang@tal.org
