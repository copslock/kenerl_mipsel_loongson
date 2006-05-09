Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 May 2006 02:21:26 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:45368 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S7619044AbWEIBVR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 9 May 2006 02:21:17 +0100
Received: by mo.po.2iij.net (mo31) id k491LCeF055034; Tue, 9 May 2006 10:21:12 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox32) id k491LBRO083770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 9 May 2006 10:21:11 +0900 (JST)
Date:	Tue, 9 May 2006 10:21:11 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	zhuzhenhua <zzh.hust@gmail.com>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: Re: how to reuse the initrd ram by busybox?
Message-Id: <20060509102111.01ccd1a8.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <50c9a2250605081803l3ac0465ase56bab689d1b34e8@mail.gmail.com>
References: <50c9a2250605081803l3ac0465ase56bab689d1b34e8@mail.gmail.com>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

On Tue, 9 May 2006 09:03:00 +0800
zhuzhenhua <zzh.hust@gmail.com> wrote:

> now i use a initrd to boot my system, then switch to the real root
> filesystem, and i want to reuse the initrd.
> i see in the redhat, it use the blockdev --flushbufs /dev/ram0 to
> flush the initrd ram.
>  and i can't find blockdev in busybox, so i use the freeramdisk
> /dev/ram0, but it seems has no effect.is there any other command to
> finish this job?

"blockdev --flushbufs" only do ioctl(fd, BLKFLSBUF, ...).
You can make simple program.

Yoichi
