Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2007 08:44:44 +0000 (GMT)
Received: from host87-170-dynamic.9-87-r.retail.telecomitalia.it ([87.9.170.87]:26844
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20023687AbXJ3Iof (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 30 Oct 2007 08:44:35 +0000
Received: from eppesuig3 ([192.168.2.50])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1Immf1-00032t-Py; Tue, 30 Oct 2007 09:41:21 +0100
Subject: Re: 2.4.24-rc1 does not boot on SGI
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20071030083106.GA16763@deprecation.cyrius.com>
References: <1193468825.7474.6.camel@scarafaggio>
	 <20071030083106.GA16763@deprecation.cyrius.com>
Content-Type: text/plain
Date:	Tue, 30 Oct 2007 09:41:46 +0100
Message-Id: <1193733706.7731.15.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17304
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Il giorno mar, 30/10/2007 alle 09.31 +0100, Martin Michlmayr ha scritto:
> * Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org> [2007-10-27 09:07]:
> > The new kernel once again does not boot on SGI O2. What happens is that
> > arcboot write its messages and nothing more is displayed on the screen.
> > The last message is "Starting ELF64 kernel". The previous running kernel
> > were 2.6.23 from linux-mips.org and 2.6.23.1 from kernel.org.
> 
> I can confirm that currnt git doesn't boot (no message on the serial
> console at all).  However, I'm curious to know whether 2.6.23 is
> working properly for you (and, if so, can you send me your .config).
[...]

my config file for 2.6.23.1 from kernel.org is
http://eppesuigoccas.homedns.org/~giuseppe/debian/sgi-mips-config-2.6.23.1-gs2.bz2

currently open points:

1. serial line does not work
2. cat /proc/self/cmdline ends in kernel oops
3. writing on USB block devices through a PCI-to-PCI does not work
4. XFS kernel module is missing 32bit ioctl and cannot talk with xfsdump
nor xfsrestore

I am currently investigating on 1. and 3.
