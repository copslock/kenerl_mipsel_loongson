Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id KAA198252 for <linux-archive@neteng.engr.sgi.com>; Thu, 12 Feb 1998 10:05:53 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA22806 for linux-list; Thu, 12 Feb 1998 10:01:57 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA22676 for <linux@cthulhu.engr.sgi.com>; Thu, 12 Feb 1998 10:01:35 -0800
Received: from chiara.csoma.elte.hu (chiara.csoma.elte.hu [157.181.71.18]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA02200
	for <linux@cthulhu.engr.sgi.com>; Thu, 12 Feb 1998 10:01:24 -0800
	env-from (mingo@chiara.csoma.elte.hu)
Received: from localhost (mingo@localhost)
	by chiara.csoma.elte.hu (8.8.5/8.8.5) with SMTP id TAA28155;
	Thu, 12 Feb 1998 19:00:41 +0100
Date: Thu, 12 Feb 1998 19:00:41 +0100 (CET)
From: MOLNAR Ingo <mingo@chiara.csoma.elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: ralf@uni-koblenz.de, linux-kernel@vger.rutgers.edu,
        linux@cthulhu.engr.sgi.com
Subject: Re: TLB entries > 4kb
In-Reply-To: <m0y2uMG-0005FsC@lightning.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.96.980212185923.27931A-100000@chiara.csoma.elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Thu, 12 Feb 1998, Alan Cox wrote:

> > Has anybody ever looked into implementing that?  What architectures besides
> > MIPS could take advantage of such a feature?
> 
> On the intel its a huge win to map PCI frame buffers using 4Mbyte pages, but
> the kernel mmap really can't hack the idea right now. A pity cos if you
> hack it in and make sure you never unmap it you get 2-3% better X performance

i tried to hack this half a year ago, but had to find out that 4MB pages
are only valid for kernel mappings, which means we'd have to make X a ring
0 process too ...

-- mingo
