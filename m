Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 15:45:26 +0000 (GMT)
Received: from verein.lst.de ([213.95.11.210]:6807 "EHLO mail.lst.de")
	by ftp.linux-mips.org with ESMTP id S8133436AbWBTPpP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Feb 2006 15:45:15 +0000
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id k1KFq0RT006084
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 20 Feb 2006 16:52:01 +0100
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id k1KFq00l006082;
	Mon, 20 Feb 2006 16:52:00 +0100
Date:	Mon, 20 Feb 2006 16:52:00 +0100
From:	Christoph Hellwig <hch@lst.de>
To:	Jordan Crouse <jordan.crouse@amd.com>
Cc:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: Diff between Linus' and linux-mips git: drivers!
Message-ID: <20060220155200.GA5999@lst.de>
References: <20060219234318.GA16311@deprecation.cyrius.com> <20060220152734.GM30429@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220152734.GM30429@cosmic.amd.com>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10571
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Mon, Feb 20, 2006 at 08:27:34AM -0700, Jordan Crouse wrote:
> On 19/02/06 23:43 +0000, Martin Michlmayr wrote:
> > We should find out whether these drivers are still needed, and if so,
> > send them to the appropriate sub-system maintainer.  If they're no
> > longer useful, they should be removed from the linux-mips tree.
> 
> Meh - I think there's something to be said for platform specific trees.

There's shouldn't be any platform-specific trees at all.  just staging
trees for subsystem maintainers.  For linux-mips that would be just
arch/mips/ and include/asm-mips/.  Having the common tree not compile
is a complete pain in the ass for distributors, and that includes
embedded SDK vendors.
