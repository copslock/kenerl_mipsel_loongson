Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2007 17:35:14 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:23503 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023542AbXILQfM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Sep 2007 17:35:12 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8CGZCLu009652;
	Wed, 12 Sep 2007 17:35:12 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8CGZCXj009651;
	Wed, 12 Sep 2007 17:35:12 +0100
Date:	Wed, 12 Sep 2007 17:35:12 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Johannes Dickgreber <tanzy@gmx.de>
Cc:	linux-mips@linux-mips.org, kumba@gentoo.org
Subject: Re: MIPS N32 tar could not change time on unpacked file
Message-ID: <20070912163511.GA11507@linux-mips.org>
References: <46E8122C.4000505@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46E8122C.4000505@gmx.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 12, 2007 at 06:22:04PM +0200, Johannes Dickgreber wrote:

> After I installed a new glibc-2.5 with linux-headers-2.6.21 on
> my SGI Octane, tar could not change time on unpacked file.
> 
> For each file there was "utime invalid argument".
> 
> System Gentoo MIPS N32
> Kernel 2.6.22 with mips-git20070902 plus modified skylark patches

Yep, makes perfect sense.  Patch applied.  Please include a Signed-off-by:
line when submitting patches, see Documentation/SubmittingPatches.

Thanks,

  Ralf
