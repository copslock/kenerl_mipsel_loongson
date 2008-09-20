Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Sep 2008 08:07:30 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:45697 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S30616235AbYITHHZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 20 Sep 2008 08:07:25 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id AAA6B3212C3;
	Sat, 20 Sep 2008 07:07:16 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [173.8.135.205])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Sat, 20 Sep 2008 07:07:16 +0000 (UTC)
Received: from silver64.hq2.avtrex.com ([192.168.7.224]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 20 Sep 2008 00:07:11 -0700
Message-ID: <48D4A11E.6030402@avtrex.com>
Date:	Sat, 20 Sep 2008 00:07:10 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	linux-mips@reliableembeddedsystems.com
Cc:	linux-mips@linux-mips.org, linux-mips@reliabeembeddedsystems.com
Subject: Re: SMP8634 DRAM memory issue
References: <4e9ae533d87732773b7ad0f1a33b54f9@reliableembeddedsystems.com>
In-Reply-To: <4e9ae533d87732773b7ad0f1a33b54f9@reliableembeddedsystems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Sep 2008 07:07:11.0290 (UTC) FILETIME=[808B79A0:01C91AEF]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20571
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

linux-mips@reliableembeddedsystems.com wrote:
> Hi,
> 
> We've got an SMP8634 based set-top box from a 3rd party and are trying to
> port some middleware to it.
> Everything seems to work out fine, except for one thing ... the amount of
> memory for kernel space.
> 
> The box physically has two 64MB chips and two 32MB chips.  
> The kernel is only seeing the two 32MB chips, apparently attached to DRAM0.
> 
> The problem is the following:
> 
> 1) The middleware requires more memory in kernel space to allocalte big
> graphical surfaces.
> 2) Whatever runs before the kernel is also from a 3rd party and we don't
> have access to it.
> 3) We can't change anything on the box hardware.
> 
> This means, we would only be able to patch starting from the Linux kernel.
> 
> Do you see any way to swap what the kernel sees to be 128MB instead of 64MB
> and the user space 64MB minus whatever is allocated for the initial RAM
> disc?
> The 64MB for user space are sufficient, we just need more then 64 MB on
> kernel space.
> 

It depends if the 128MB is on DRAM0 or DRAM1.  Typically DRAM1 is not
usable by the kernel, although others have tried to access it as high-mem.

If DRAM0 is 128MB, *and* you have access to the kernel command line, you
 might try to append something like 'mem=96M'.  You may need to leave
some space in DRAM0 for the media components.  If not try jacking it up
to mem=128M.  Said media components do need memory too, so it may not be
possible to get more for the kernel and have it all work together.

David Daney
