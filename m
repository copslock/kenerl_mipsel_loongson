Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Aug 2008 03:29:35 +0100 (BST)
Received: from verein.lst.de ([213.95.11.210]:18088 "EHLO verein.lst.de")
	by ftp.linux-mips.org with ESMTP id S28577921AbYHQC3Z (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 17 Aug 2008 03:29:25 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by verein.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id m7H2TPIF023738
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 17 Aug 2008 04:29:25 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id m7H2TOl2023736;
	Sun, 17 Aug 2008 04:29:24 +0200
Date:	Sun, 17 Aug 2008 04:29:24 +0200
From:	Christoph Hellwig <hch@lst.de>
To:	linux-mips@linux-mips.org, linux-parisc@vger.kernel.org
Subject: missing compat_sys_ptrace conversions for mips and parisc
Message-ID: <20080817022924.GA23625@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

Currently mips and parisc are the only architectures not yet converted
to the generic compat_sys_ptrace.  The conversion is rather trivial and
only involves splitting the current compat_ptrace handler into a
compat_arch_ptrace with all the meat and the existing compat_sys_ptrace
that does all the boilerplate code, just like the generic sys_ptrace.
To get the generic compat_sys_ptrace you have to add a

	#define __ARCH_WANT_COMPAT_SYS_PTRACE

to ptrace.h for now, but once mips and parisc are converted this will of
course be removed.  Take a look at the powerpc conversion as an example:

	http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git&a=commitdiff&h=81e695c026eeda9a97e412fa4f458e5cab2f6c85
	
