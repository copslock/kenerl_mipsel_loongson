Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Nov 2007 14:13:45 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:45774 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026336AbXK0ONn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Nov 2007 14:13:43 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lAREDfCB019387;
	Tue, 27 Nov 2007 14:13:41 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lAREDfPk019386;
	Tue, 27 Nov 2007 14:13:41 GMT
Date:	Tue, 27 Nov 2007 14:13:41 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: SGI IP28 support
Message-ID: <20071127141341.GA19316@linux-mips.org>
References: <20071126223814.GA21339@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071126223814.GA21339@alpha.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 26, 2007 at 11:38:14PM +0100, Thomas Bogendoerfer wrote:

> I finally cleaned up Peter Fuerst's IP28 patches and solved some of
> the IP28 issues in an IMHO more eye-friendly way (no ip26ucmem).
> My IP28 boots with these patches from an Debian sarge NFS root and
> is able to dd data from the harddrive. I'm going to send this patches
> to this list and the subsystem maintainers.
> 
> There is one change missing to get a working SCSI driver, because
> a proper fix will be done in 2.6.25. The quick&dirty workaround is
> below. The workaround makes sure that the sense_buffer lives in
> its own cache line by aligning and extendin it.
> 
> The patch "Use real cache invalidate" still contains one problem.
> It will not flush the cache correctly, if the given size is bigger
> than the second level cache. The problem is, that there is no index
> invalidate cache operation available. I have two ideas to solve that.
> One is to always do a range invalidate (maybe just by using this only
> for R10k machines, which usually have quite big caches) or scan through
> the cache and use the tag informations to do hit invalidate. If anybody
> has a better idea please speak up :-)

A while ago I instrumented the cacheflushing functions to get a histogram
of cacheflush sizes.  I was surprised to find no flushes larger than 64K
even though I did that experiment on an Origin with a large RAID array
copying huge amounts of data with reads and writes of several MB.  So as
long as that finding holds your code will work.

  Ralf
