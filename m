Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jan 2006 21:00:55 +0000 (GMT)
Received: from [62.38.115.213] ([62.38.115.213]:62415 "EHLO pfn3.pefnos")
	by ftp.linux-mips.org with ESMTP id S3950320AbWATVAL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 20 Jan 2006 21:00:11 +0000
Received: from xorhgos2.pefnos (xorhgos2.pefnos [192.168.0.3])
	by pfn3.pefnos (Postfix) with ESMTP id A19AD1F742
	for <linux-mips@linux-mips.org>; Fri, 20 Jan 2006 23:03:56 +0200 (EET)
Resent-From: P. Christeas <p_christ@hol.gr>
Resent-To: linux-mips@linux-mips.org
Resent-Date: Fri, 20 Jan 2006 23:03:43 +0200
Resent-Message-ID: <200601202303.43365.p_christ@hol.gr>
From:	"P. Christeas" <p_christ@hol.gr>
To:	Marc Karasek <marckarasek@ivivity.com>
Subject: Re: how to emdedded ramdisk.gz in vmlinux for linux-2.6.14?
Date:	Fri, 20 Jan 2006 23:02:28 +0200
User-Agent: KMail/1.9
References: <0F31272A2BCBBE4FA01344C6E69DBF501EAB1B@thoth.ivivity.com> <200601202203.14325.p_christ@hol.gr> <1137790053.22994.58.camel@localhost.localdomain>
In-Reply-To: <1137790053.22994.58.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601202302.29928.p_christ@hol.gr>
Return-Path: <p_christ@hol.gr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10030
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p_christ@hol.gr
Precedence: bulk
X-list: linux-mips

On Friday 20 January 2006 10:47 pm, you wrote:
> Basically due to design issues and cost issues having a flash based
> system is not possible.  Currently we have only 16MB total of flash and
> the biggest contiguous block avail in this is only 12MB.  Our current
> ramdisk (uncompressed) is running at 30MB.  Basically, memory is cheaper
> than flash.  When you have designs that are very cost sensitive (to put
> it lightly), for example adding a 50 cent part is a major event.  You
> cannot just say we need more flash...  If we are to continue to support
> the embedded market for Linux,  every decision we make as too what
> feature gets put in, which ones get dropped have to be made with
> everyone in mind.  What is good for the desktop market, may not be the
> best solution for the embedded market.  BTW: When I mean embedded I do
> not mean Ipaq or Palm.  These are small computers with a completely
> different set of requirements than a 1U pizza box headless storage
> controller/switch/etc.
>

Our discussion is quite general, I don't mean to interfere with your hardware 
design anyway. My point was just that the filesystem you mention would be 
stored in some kind of ROM anyway (either inside the kernel ELF or outside 
it). So, you wouldn't need to copy it to your RAM. That's the main feature of 
squashfs/cromfs. You can still have tmpfs for some kind of read/write 
storage.
One drawback, however, would be that the access to the ROM (in the form of 
mtd) could cost you some extra code that need to go into the kernel.
