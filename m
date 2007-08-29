Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Aug 2007 04:00:09 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:26407 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20022009AbXH2DAB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Aug 2007 04:00:01 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Wed, 29 Aug 2007 11:59:59 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 17B0C42B84;
	Wed, 29 Aug 2007 11:59:50 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 0C78E42B82;
	Wed, 29 Aug 2007 11:59:50 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l7T2xnAF025967;
	Wed, 29 Aug 2007 11:59:49 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 29 Aug 2007 11:59:49 +0900 (JST)
Message-Id: <20070829.115949.75427319.nemoto@toshiba-tops.co.jp>
To:	ddaney@avtrex.com
Cc:	linux-mips@linux-mips.org, jschmidt@avtrex.com, sfrancis@avtrex.com
Subject: Re: O_DIRECT file access and cache aliasing...
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <46D4C61C.6010008@avtrex.com>
References: <46D4C61C.6010008@avtrex.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16306
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 28 Aug 2007 18:04:28 -0700, David Daney <ddaney@avtrex.com> wrote:
> When we write files that were opened with O_DIRECT set, we observe that 
> there are many 16 byte chunks of data in the files that contain all 
> zeros instead of the correct data.
> 
> My understanding is that the cache is virtually indexed.  So I think 
> what is happening is that when data is written to memory by a user 
> application that does an O_DIRECT write, the IDE driver is given a list 
> of pages to transfer to the disk.  The driver then does a 
> dma_cache_wback() on the KSEG0 address of the pages before initiating 
> the DMA operation.  Since the KSEG0 address and the USEG address of the 
> physical memory are different, the data is never flushed to memory 
> resulting in incorrect data being written to disk.

I think get_user_pages() should flush user data for O_DIRECT.

The get_user_pages() uses flush_anon_page() to do it, and MIPS
flush_anon_page() was added on Mar 2007.  Does your kernel have this
fix?

---
Atsushi Nemoto
