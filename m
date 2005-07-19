Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jul 2005 20:19:43 +0100 (BST)
Received: from mx02.qsc.de ([IPv6:::ffff:213.148.130.14]:33676 "EHLO
	mx02.qsc.de") by linux-mips.org with ESMTP id <S8226729AbVGSTTZ>;
	Tue, 19 Jul 2005 20:19:25 +0100
Received: from port-195-158-170-19.dynamic.qsc.de ([195.158.170.19] helo=hattusa.textio)
	by mx02.qsc.de with esmtp (Exim 3.35 #1)
	id 1DuxeL-0005um-00
	for linux-mips@linux-mips.org; Tue, 19 Jul 2005 21:21:05 +0200
Received: from ths by hattusa.textio with local (Exim 4.52)
	id 1DuxeL-0002SB-H8
	for linux-mips@linux-mips.org; Tue, 19 Jul 2005 21:21:05 +0200
Date:	Tue, 19 Jul 2005 21:21:05 +0200
To:	linux-mips@linux-mips.org
Subject: Re: module loading on 64-bit kernel
Message-ID: <20050719192105.GF2071@hattusa.textio>
References: <20050719183546.GA3923@gaspode.automagically.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050719183546.GA3923@gaspode.automagically.de>
User-Agent: Mutt/1.5.9i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8564
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Markus Dahms wrote:
> Hello together,
> 
> do I need other module-init-tools for a 64-bit kernel than I need for
> 32-bit?
> When trying to load a module I get the following output:
> | insmod: error inserting \
> | '/lib/modules/2.6.13-rc3-mad-mips-1-64/kernel/fs/isofs/isofs.ko': -1 \
> | Cannot allocate memory
> 
> in dmesg:
> | allocation failed: out of vmalloc space - use vmalloc=<size> to increase \
> | size.

This seems to be a bug which crept in for (at least) 64bit Indy kernels
in IIRC 2.6.12-rc3.

> It happens with every module. If I'd need other tools these messages are
> confusing. I didn't try "vmalloc=..." as I think module loading wouldn't
> be "disabled" in such a way by default...

It happens also for any significant memory pressure.


Thiemo
