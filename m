Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Mar 2006 11:14:59 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:57810 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133518AbWCELOv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 5 Mar 2006 11:14:51 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k25BN08m004871;
	Sun, 5 Mar 2006 11:23:00 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k25BMll2004869;
	Sun, 5 Mar 2006 11:22:47 GMT
Date:	Sun, 5 Mar 2006 11:22:47 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	zhuzhenhua <zzh.hust@gmail.com>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: does the linux support rootfs on vfat?
Message-ID: <20060305112247.GA4243@linux-mips.org>
References: <50c9a2250603042217l475e84pc9ab7ce87c40eb76@mail.gmail.com> <20060305080958.GX19232@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060305080958.GX19232@lug-owl.de>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Mar 05, 2006 at 09:09:58AM +0100, Jan-Benedict Glaw wrote:

> On Sun, 2006-03-05 14:17:56 +0800, zhuzhenhua <zzh.hust@gmail.com> wrote:
> > if in my product based ide disk, i want to it to support the
> > u-disk(with vfat fs), and can i set the root fs as vfat too?
> > if use vfat as rootfs, what's disadvantage of the selection?
> 
> Well, most notably you won't have device nodes. Maybe a ram-backed
> filesystem mounted to /dev/ could solve that, but you'd probably need
> an initrd for that to do.

It's anso case-insensitive which may cause some further troubles.  It's
doesn't have proper inodes, no UNIX file modes, no UID / GID support (These
two can be kludges in awfully insufficient way through mount options), not
only lacks device special files but also no FIFO, no UNIX domain sockets,
no hard or soft links.  It's simply a sorry excuse for a useful filesystem.

  Ralf
