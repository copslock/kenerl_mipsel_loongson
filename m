Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Aug 2004 09:41:43 +0100 (BST)
Received: from gw01.mail.saunalahti.fi ([IPv6:::ffff:195.197.172.115]:47034
	"EHLO gw01.mail.saunalahti.fi") by linux-mips.org with ESMTP
	id <S8224916AbUHQIlj>; Tue, 17 Aug 2004 09:41:39 +0100
Received: from fairytale.tal.org (cruel.tal.org [195.16.220.85])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id 4931D4C959;
	Tue, 17 Aug 2004 11:41:38 +0300 (EEST)
Received: from amos (unknown [195.16.220.84])
	by fairytale.tal.org (Postfix) with SMTP
	id 9CCAF8DB0; Tue, 17 Aug 2004 11:50:13 +0300 (EEST)
Message-ID: <001301c48436$b06c6250$54dc10c3@amos>
From: "Kaj-Michael Lang" <milang@tal.org>
To: "Ralf Baechle" <ralf@linux-mips.org>
Cc: "linux-mips" <linux-mips@linux-mips.org>
References: <001901c48427$6272acd0$54dc10c3@amos> <20040817074307.GA21407@linux-mips.org>
Subject: Re: cpu_has_llsc cleanup broke compilation.
Date: Tue, 17 Aug 2004 11:46:28 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Return-Path: <milang@tal.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: milang@tal.org
Precedence: bulk
X-list: linux-mips

> Clearly a kernel bug - but one that also shows poor maintenance of your
> target.  It should define cpu_has_llsc which it doesn't, so the kernel

It's IP32

> will use generic code and deciede at runtime it should use ll/sc.  I'm
> fixing this problem but you really should fix your target also.

If I knew what to do.. but I don't.. but trying to learn..

-- 
Kaj-Michael Lang , milang@tal.org
