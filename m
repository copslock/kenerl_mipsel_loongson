Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jul 2006 17:19:36 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:31929 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S8133505AbWGTQT0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Jul 2006 17:19:26 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 492A046A3A; Thu, 20 Jul 2006 18:19:26 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1G3bEW-00010n-07; Thu, 20 Jul 2006 17:18:40 +0100
Date:	Thu, 20 Jul 2006 17:18:39 +0100
To:	hemanth.venkatesh@wipro.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Bit operations work differently on MIPS and IA32
Message-ID: <20060720161839.GE4350@networkno.de>
References: <2156B1E923F1A147AABDF4D9FDEAB4CB09D3D8@blr-m2-msg.wipro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2156B1E923F1A147AABDF4D9FDEAB4CB09D3D8@blr-m2-msg.wipro.com>
User-Agent: Mutt/1.5.12-2006-07-14
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12045
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

hemanth.venkatesh@wipro.com wrote:
> Hi All,
> 
>  
> 
> I ran the below program on an IA32 and AU1100 machine, both being little
> endian machines and got different results. Does anyone know what could
> be the cause of this behaviour. This problem is blocking us from booting
> the cramfs rootfs.
> 
>  
> 
> #include <stdio.h>
> 
> typedef unsigned int u32;
> 
> main()
> 
> {
> 
> struct tmp{
> 
> u32 namelen:6,offset:26;
> 
> }tmp1;
> 
> (*(int *)(&tmp1))=0x4c0;

This makes non-portable assumptions about the bitfield layout. The
results are platform-dependent (or rather ABI-dependent). Portable
code needs to avoid acessing bitfields via typecasts.


Thiemo
