Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 May 2009 20:05:53 +0100 (BST)
Received: from mail.gmx.net ([213.165.64.20]:53200 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S20023068AbZEPTFk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 16 May 2009 20:05:40 +0100
Received: (qmail invoked by alias); 16 May 2009 19:05:33 -0000
Received: from p548B1ECF.dip0.t-ipconnect.de (EHLO [192.168.120.26]) [84.139.30.207]
  by mail.gmx.net (mp029) with SMTP; 16 May 2009 21:05:33 +0200
X-Authenticated: #16080105
X-Provags-ID: V01U2FsdGVkX19WaR8IQDJWpbK3mlC1tQ/mBL5kOUyy4WfLOQ1ZvW
	rHozoH4mZ5HdoN
Message-ID: <4A0F0E7B.1010602@gmx.de>
Date:	Sat, 16 May 2009 21:05:31 +0200
From:	Johannes Dickgreber <tanzy@gmx.de>
User-Agent: Thunderbird 2.0.0.21 (X11/20090310)
MIME-Version: 1.0
To:	Kumba <kumba@gentoo.org>
CC:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Help getting IP30/Octane fixed?
References: <4A06100F.7020105@gentoo.org> <4A0717AA.8060603@gmx.de> <4A072383.3010109@gentoo.org>
In-Reply-To: <4A072383.3010109@gentoo.org>
X-Enigmail-Version: 0.95.7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Return-Path: <tanzy@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22780
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tanzy@gmx.de
Precedence: bulk
X-list: linux-mips

Kumba schrieb:

> 
> Ricardo (ricmm on IRC) explained it as this:
> 
> <ricmm> the baseline problem is that the secondary CPU's ipi irq is not
> triggering, the first one works
> <ricmm> and smp_call_function() is calling an init function on both CPUs
> with a wait_for_completion flag set
> <ricmm> but the second CPU will never run the function as the irq is not
> happening, therefore the flag will remain set
> <ricmm> and smp_call_function() will spin waiting for the completion
> 
> 
i think i found the problem

try booting with a command line       cca=5

the system is setting _page_cachable_default with what is found in the
processor register at booting time which is 3 ( _CACHE_CACHABLE_NONCOHERENT )
i think this can not work on a SMP System.

with the above overriding i have a working SMP Octane system.

	cca = 5  means _CACHE_CACHABLE_COHERENT

if time permits i send patches 

bye 
 
