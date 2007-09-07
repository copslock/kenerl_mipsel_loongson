Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Sep 2007 15:59:11 +0100 (BST)
Received: from kuber.nabble.com ([216.139.236.158]:4749 "EHLO kuber.nabble.com")
	by ftp.linux-mips.org with ESMTP id S20025553AbXIGO7D (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Sep 2007 15:59:03 +0100
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1ITfIT-0007mB-1E
	for linux-mips@linux-mips.org; Fri, 07 Sep 2007 07:59:01 -0700
Message-ID: <12556934.post@talk.nabble.com>
Date:	Fri, 7 Sep 2007 07:59:01 -0700 (PDT)
From:	dschaeffer <daniel.schaeffer@timesys.com>
To:	linux-mips@linux-mips.org
Subject: Re: Revert "[MIPS] BUG_ON() on dirty pages in kmap_coherent()."
In-Reply-To: <S20024450AbXHDOz0/20070804145526Z+167@ftp.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: daniel.schaeffer@timesys.com
References: <S20024450AbXHDOz0/20070804145526Z+167@ftp.linux-mips.org>
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.schaeffer@timesys.com
Precedence: bulk
X-list: linux-mips


Any update on the root cause of this issue?


linux-mips main mailing list wrote:
> 
> Author: Ralf Baechle <ralf@linux-mips.org> Sat Aug 4 15:53:09 2007 +0100
> Commit: c4ccdaecc7f61d04a71d30a839e0d0a61aded4e4
> Gitweb: http://www.linux-mips.org/g/linux/c4ccdaec
> Branch: master
> 
> This reverts commit 982e2ba521287370ee3a6f489400be985b0f9556.
> 
> Turns out the BUG_ON() is trivial to trigger.  Still enquiring the root
> cause.
> 
> 

-- 
View this message in context: http://www.nabble.com/Revert-%22-MIPS--BUG_ON%28%29-on-dirty-pages-in-kmap_coherent%28%29.%22-tf4217047.html#a12556934
Sent from the linux-mips main mailing list archive at Nabble.com.
