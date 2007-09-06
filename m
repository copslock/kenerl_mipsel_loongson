Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2007 13:00:41 +0100 (BST)
Received: from host210-152-dynamic.56-82-r.retail.telecomitalia.it ([82.56.152.210]:21511
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20025646AbXIFMAc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Sep 2007 13:00:32 +0100
Received: from localhost ([127.0.0.1] helo=sgi)
	by eppesuigoccas.homedns.org with smtp (Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1ITFz1-0007ou-1R; Thu, 06 Sep 2007 13:57:17 +0200
Date:	Thu, 6 Sep 2007 13:57:08 +0200
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	debian-mips@lists.debian.org, linux-mips@linux-mips.org
Subject: Re: Exception while loading kernel
Message-Id: <20070906135708.dc49a3bc.giuseppe@eppesuigoccas.homedns.org>
In-Reply-To: <Pine.LNX.4.64.0709060646120.23362@pixie.tetracon-eng.net>
References: <1188030215.13999.14.camel@scarafaggio>
	<20070825152536.GA4499@networkno.de>
	<Pine.SGI.4.60.0708252047260.4891@zeus.tetracon-eng.net>
	<20070826065054.84c97aef.giuseppe@eppesuigoccas.homedns.org>
	<Pine.LNX.4.64.0708300931100.14430@pixie.tetracon-eng.net>
	<1188481891.6770.22.camel@scarafaggio>
	<Pine.LNX.4.64.0709060646120.23362@pixie.tetracon-eng.net>
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; mips-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16397
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Hi -S-,

On Thu, 6 Sep 2007 06:58:15 -0400 (EDT) "J. Scott Kasten" <jscottkasten@yahoo.com> wrote:
[...] 
> The System.map was OVER 50 MEGS, and the kernel weighed in at a HEFTY 87 
> MEGS.

My kernel and System.map looks very normal. I had the same file sizes you reported, but only when compiling with all debug symbols. Once stripped the kernel became at the normal size, about 8Mb.

When I got the large kernel, I stripped it before copying it in /boot. Arcboot never used the large file.

Bye,
Giuseppe
