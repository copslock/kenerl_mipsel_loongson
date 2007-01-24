Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2007 14:02:54 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:46000 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20048327AbXAXOCx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 Jan 2007 14:02:53 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l0OE2rSt022047;
	Wed, 24 Jan 2007 14:02:53 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l0OE2qI5022046;
	Wed, 24 Jan 2007 14:02:52 GMT
Date:	Wed, 24 Jan 2007 14:02:52 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	zhuzhenhua <zzh.hust@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: how to choose journal filesystem for embedded linux?
Message-ID: <20070124140252.GA14574@linux-mips.org>
References: <50c9a2250701231805y62ec67f0v83d2fcf3ae2c55da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50c9a2250701231805y62ec67f0v83d2fcf3ae2c55da@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 24, 2007 at 10:05:10AM +0800, zhuzhenhua wrote:

>          i now work on a mips board, and want to store my system code
> on NAND Flash.
> our Flash driver can handle the Flash features(bad block,  phy  to
> logic addr, spare,etc.),
> so i just want to select a journal filesystem to handle sudden poweroff.
> Our system code(writeable) is about 10M~50M. i am not sure what
> journal filesystem will be suitable, ext3,xfs,jfs,or reiserFS?
> i have try ext3, it runs well, but seems to waste too much space
> while mkfs.ext3.

Classic journaling filesystems are not suitable for flash as they tend to
have write hot spots so will wear out certain parts of the flash fairly
quickly.  Don't forget atime updates, even those do matter!  Of course if
your filesystem is read-only these constraints matter much less.

  Ralf
