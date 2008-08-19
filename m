Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2008 15:10:15 +0100 (BST)
Received: from verein.lst.de ([213.95.11.210]:64709 "EHLO verein.lst.de")
	by ftp.linux-mips.org with ESMTP id S28573884AbYHSOKH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Aug 2008 15:10:07 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by verein.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id m7JEA3IF027548
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 19 Aug 2008 16:10:03 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id m7JEA3Zc027546;
	Tue, 19 Aug 2008 16:10:03 +0200
Date:	Tue, 19 Aug 2008 16:10:03 +0200
From:	Christoph Hellwig <hch@lst.de>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Use compat_sys_ptrace
Message-ID: <20080819141003.GA26694@lst.de>
References: <20080817144926.0425BC3F17@solo.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080817144926.0425BC3F17@solo.franken.de>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20274
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Sun, Aug 17, 2008 at 04:49:25PM +0200, Thomas Bogendoerfer wrote:
> This replaces mips's sys_ptrace32 with a compat_arch_ptrace and
> enables the new generic definition of compat_sys_ptrace instead.

If you're looking for another compat related bit of work try converting
misp to the generic binfmt_elf emulation, although that will be some
more fun thanks to o32 vs n32.  Here's the sparc64 diff:

	http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=48c946a482661d8466cd24bae5df749147ff1b1d
