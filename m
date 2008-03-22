Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Mar 2008 23:40:19 +0000 (GMT)
Received: from host194-211-dynamic.20-79-r.retail.telecomitalia.it ([79.20.211.194]:28651
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S28642771AbYCVXkR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 22 Mar 2008 23:40:17 +0000
Received: from casa ([192.168.2.34])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1JdDJn-0001YG-6X
	for linux-mips@linux-mips.org; Sun, 23 Mar 2008 00:40:09 +0100
Subject: Re: Compiler error? [was: Re: new kernel oops in recent kernels]
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
In-Reply-To: <20080321230010.GA31135@alpha.franken.de>
References: <1205664563.3050.4.camel@localhost>
	 <1205699257.4159.14.camel@casa> <20080316233619.GA29511@alpha.franken.de>
	 <1205741142.3515.2.camel@localhost> <20080317141828.GA25798@linux-mips.org>
	 <20080317143215.GA11497@alpha.franken.de>
	 <20080321230010.GA31135@alpha.franken.de>
Content-Type: text/plain
Date:	Sun, 23 Mar 2008 00:39:58 +0100
Message-Id: <1206229198.4075.12.camel@casa>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Hi Thomas,

Il giorno sab, 22/03/2008 alle 00.00 +0100, Thomas Bogendoerfer ha
scritto:
[...]
> below is a patch, which replaces all buffers on the stack, which are
> passed to the scsi layer with kmalloced ones.
> 
> Giuseppe, could you please check if this fixes your problem, and
> doesn't cause new regressions ? 

I rebuilt a kernel (pulling latest code from git) with your patch. Now I
do not get anymore the Oops at boot time, moreover I may mount a CDROM
and copying data from that CDROM to local SCSI disk.

Bye,
Giuseppe
