Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Apr 2003 22:44:10 +0100 (BST)
Received: from mx2.mips.com ([IPv6:::ffff:206.31.31.227]:13218 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225208AbTDXVoF>;
	Thu, 24 Apr 2003 22:44:05 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h3OLhpUe019581;
	Thu, 24 Apr 2003 14:43:52 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id OAA03757;
	Thu, 24 Apr 2003 14:43:52 -0700 (PDT)
Message-ID: <011a01c30aab$b7748ce0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Chip Coldwell" <coldwell@frank.harvard.edu>,
	<linux-mips@linux-mips.org>
References: <Pine.LNX.4.44.0304241613190.18155-100000@frank.harvard.edu>
Subject: Re: NCD900 port?
Date: Thu, 24 Apr 2003 23:51:41 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2181
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> I'm facing a ~$1K site license charge for NCD's NCBridge software for
> their NC948 X Terminals, and since my site consists of exactly three
> of these things that I bought for less than $250 each I'm balking a
> bit.
> 
> The NC948 consists of a 165 MHz QED RM5231, S3 Savage4 graphics
> controller, and an AMD PCnet NIC of some sort.  It doesn't seem like
> there's anything in that set that Linux or XFree86 wouldn't be happy
> to run.

What PCI bridge is being used?  Galileo?

> To be completely explicit what I'm proposing is to run Linux on the X
> Terminal (as opposed to the server that provides boot image, xdm,
> etc.).  My question is: has anybody done it or does anybody know a
> reason why it can't be done?

I think it's probably doable, but if you want two reasons 
why it might not be, I'd say they would be:
1) Undocumented/unsupported PCI or other interface
2) Not enough RAM
