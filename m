Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Feb 2004 22:57:45 +0000 (GMT)
Received: from mail.convergence.de ([IPv6:::ffff:212.84.236.4]:21223 "EHLO
	mail.convergence.de") by linux-mips.org with ESMTP
	id <S8225268AbUBCW5p>; Tue, 3 Feb 2004 22:57:45 +0000
Received: from pd9e71b79.dip.t-dialin.net ([217.231.27.121] helo=abc.local)
	by mail.convergence.de with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Ao9SW-0003v4-JV
	for linux-mips@linux-mips.org; Tue, 03 Feb 2004 23:55:56 +0100
Received: from js by abc.local with local (Exim 3.35 #1 (Debian))
	id 1Ao9WT-00013d-00
	for <linux-mips@linux-mips.org>; Wed, 04 Feb 2004 00:00:01 +0100
Date: Wed, 4 Feb 2004 00:00:01 +0100
From: Johannes Stezenbach <js@convergence.de>
To: linux-mips@linux-mips.org
Subject: Re: dietlibc nash  pic/non-pic errors
Message-ID: <20040203230001.GB1667@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	linux-mips@linux-mips.org
References: <4020137E.9020005@savages.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4020137E.9020005@savages.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <js@convergence.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@convergence.de
Precedence: bulk
X-list: linux-mips

Shaun Savage wrote:
> I am want to cross compile dietlibc and nash(mkinitrd).
> 
> I can cross compile static mipsel dietlibc libs
> but when I try to link it with nash I get
>   the pic and non-pic error,  can't merge
> 
> I have gotten QPDF, SD on linux, busybox and ulibc cross compiled and 
> working, so I sort of know what I am doing.
> 
> I am using Maciej toolchain

- check that everything is compiled with '-fno-pic -mno-abicalls -G 0'
- you must have either a non-pic libgcc or make sure your programs
  don't need libgcc

The standard configuration of gcc for mipsel-linux creates a
PIC libgcc only, so if you need a non-pic libgcc you must hack
the gcc configuration and rebuild your toolchain.

Or alternatively you can compile dietlibc as PIC
(remove '-fno-pic -mno-abicalls' from mips/Makefile.add
and diet.c).

HTH,
Johannes
