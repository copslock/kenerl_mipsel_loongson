Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Feb 2007 10:43:43 +0000 (GMT)
Received: from ns.suse.de ([195.135.220.2]:30375 "EHLO mx1.suse.de")
	by ftp.linux-mips.org with ESMTP id S20038912AbXBKKnh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 11 Feb 2007 10:43:37 +0000
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 59C7412082;
	Sun, 11 Feb 2007 11:42:17 +0100 (CET)
From:	Andi Kleen <ak@suse.de>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: -mm merge plans for 2.6.21
Date:	Sun, 11 Feb 2007 11:37:45 +0100
User-Agent: KMail/1.9.5
Cc:	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Davide Libenzi <davidel@xmailserver.org>,
	linux-mips@linux-mips.org, David Woodhouse <dwmw2@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Dobriyan <adobriyan@openvz.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ulrich Drepper <drepper@redhat.com>
References: <20070208150710.1324f6b4.akpm@linux-foundation.org> <20070210102205.GB8145@osiris.boeblingen.de.ibm.com> <20070210210557.GA9116@linux-mips.org>
In-Reply-To: <20070210210557.GA9116@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200702111137.46344.ak@suse.de>
Return-Path: <ak@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ak@suse.de
Precedence: bulk
X-list: linux-mips

On Saturday 10 February 2007 22:05, Ralf Baechle wrote:
> On Sat, Feb 10, 2007 at 11:22:05AM +0100, Heiko Carstens wrote:
> 
> > Which remembers me that I think that MIPS is using the non-compat version
> > of sys_epoll_pwait for compat syscalls. But maybe MIPS doesn't need a compat
> > syscall for some reason. Dunno.
> 
> Which reminds me that x86_64 i386 compat doesn't wire up sys_epoll_pwait ;-)

Added thanks.

-Andi
