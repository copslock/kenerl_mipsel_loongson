Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Dec 2004 04:27:18 +0000 (GMT)
Received: from nssinet2.co-nss.co.jp ([IPv6:::ffff:150.96.0.5]:2270 "EHLO
	nssinet2.co-nss.co.jp") by linux-mips.org with ESMTP
	id <S8224909AbULNE1N>; Tue, 14 Dec 2004 04:27:13 +0000
Received: from nssinet2.co-nss.co.jp (localhost [127.0.0.1])
	by nssinet2.co-nss.co.jp (8.9.3/3.7W) with ESMTP id NAA14964;
	Tue, 14 Dec 2004 13:22:40 +0900 (JST)
Received: from nssnet.co-nss.co.jp (nssnet.co-nss.co.jp [150.96.64.250])
	by nssinet2.co-nss.co.jp (8.9.3/3.7W) with ESMTP id NAA14960;
	Tue, 14 Dec 2004 13:22:39 +0900 (JST)
Received: from NUNOE ([150.96.160.64])
	by nssnet.co-nss.co.jp (8.9.3+Sun/3.7W) with SMTP id NAA27719;
	Tue, 14 Dec 2004 13:13:40 +0900 (JST)
Message-ID: <001701c4e195$24d48260$3ca06096@NUNOE>
From: "Hdei Nunoe" <nunoe@co-nss.co.jp>
To: "Ralf Baechle" <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
References: <001101c4dbf9$1da02270$3ca06096@NUNOE> <20041207095837.GA13264@linux-mips.org>
Subject: Re: HIGHMEM
Date: Tue, 14 Dec 2004 13:26:55 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Return-Path: <nunoe@co-nss.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6660
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nunoe@co-nss.co.jp
Precedence: bulk
X-list: linux-mips

Ralf,

Thanks for the info!  I still have a ocuple of question, hope you do not 
mind.

> In 2.4 the support for CONFIG_DISCONTIG and CONFIG_NUMA are a bit tangled
> with each other because IP27 is the only platform to uses these features
> and it needs both.

Is it named "sgi-ip27"?

> Other than that you can also just setup your system
> as 0x0 - 0x10000000 being RAM, 0x10000000 - 0x20000000 being reserved
> memory and 0x20000000 - 0x30000000 being highmem.  Which works but is a
> bit wasteful.

The gap in physical memory is 0x10000000 - 0x20000000, but it is 
0x90000000 -
0xC0000000 in virtual memory because there is K1 segment.  So the macros 
such
as __pa() or __va() does not work, I think.  Started to wonder it might not 
be easy
as just changing the PAGE_OFFSET value.  Do you see?

cheers,
-hdei
