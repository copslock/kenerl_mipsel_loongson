Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 May 2008 07:31:59 +0100 (BST)
Received: from verein.lst.de ([213.95.11.210]:44713 "EHLO verein.lst.de")
	by ftp.linux-mips.org with ESMTP id S20023592AbYEKGb5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 11 May 2008 07:31:57 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by verein.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id m4B6VXF3013586
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 11 May 2008 08:31:33 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id m4B6VThI013582;
	Sun, 11 May 2008 08:31:29 +0200
Date:	Sun, 11 May 2008 08:31:29 +0200
From:	Christoph Hellwig <hch@lst.de>
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
Cc:	Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org
Subject: Re: undefined reference to `copy_siginfo_from_user32'
Message-ID: <20080511063129.GA13451@lst.de>
References: <20080428212327.47c703b6.giuseppe@eppesuigoccas.homedns.org> <20080429090039.GA16616@lst.de> <1209665512.5605.0.camel@casa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1209665512.5605.0.camel@casa>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19196
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Thu, May 01, 2008 at 08:11:52PM +0200, Giuseppe Sacco wrote:
> I cannot apply this patch to the latest kernel from git. Could you
> provide a new one?

It still applies against the latest Linus tree, I don't currently
have a mips tree at hand.  But Ralf promised to look into the
compat_sys_ptrace conversion.
