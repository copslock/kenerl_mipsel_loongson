Received:  by oss.sgi.com id <S553711AbQJYUqd>;
	Wed, 25 Oct 2000 13:46:33 -0700
Received: from natmail2.webmailer.de ([192.67.198.65]:49300 "EHLO
        post.webmailer.de") by oss.sgi.com with ESMTP id <S553675AbQJYUqQ>;
	Wed, 25 Oct 2000 13:46:16 -0700
Received: from scotty.mgnet.de (p3E9ECD26.dip.t-dialin.net [62.158.205.38])
	by post.webmailer.de (8.9.3/8.8.7) with SMTP id WAA21780
	for <linux-mips@oss.sgi.com>; Wed, 25 Oct 2000 22:46:13 +0200 (MET DST)
Received: (qmail 554 invoked from network); 25 Oct 2000 20:45:27 -0000
Received: from spock.mgnet.de (192.168.1.4)
  by scotty.mgnet.de with SMTP; 25 Oct 2000 20:45:27 -0000
Date:   Wed, 25 Oct 2000 22:46:12 +0200 (CEST)
From:   Klaus Naumann <spock@mgnet.de>
To:     Guido Guenther <guido.guenther@gmx.net>
cc:     Keith M Wesolowski <wesolows@chem.unr.edu>, linux-mips@oss.sgi.com
Subject: Re: fdisk/kernel oddity
In-Reply-To: <20001025194348.A1164@gandalf.physik.uni-konstanz.de>
Message-ID: <Pine.LNX.4.21.0010252242560.726-100000@spock.mgnet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 25 Oct 2000, Guido Guenther wrote:

> On Wed, Oct 25, 2000 at 10:14:53AM -0700, Keith M Wesolowski wrote:
> > On Wed, Oct 25, 2000 at 07:01:29PM +0200, Guido Guenther wrote:
> > Not to sound defensive, but I'm fairly sure this isn't an
> > fdisk-related problem. The partitions that fdisk creates follow the
> > spec as far as I can see.
> I didn't want to blame fdisk for that(how could I, I want you to send
> the patches upstream ASAP :)
> > 
> > > What puzzles me even more is that I get illegal instructions for almost 
> > > all commands I execute afterwards. Any comments on this one?
> > 
> > I rather suspect that this is the same problem that causes the request
> > for the out-of-bounds block in the first place: kernel memory
> > corruption. Unfortunately I have few ideas as to what the specific
> > problem is. I would start bug-hunting in the sgi disklabel kernel
> > parts. Make sure that it's compatible with what fdisk is doing.
> That's a starting point - thanks. Ian pointed out that it might be
> related to the fact that I use two harddisks which is interesting since
> I see the problems only when writing on sda, sdb seems to be o.k.
> Regards,
>  -- Guido

This is a problem which I'm seeing for a loooooong time now.
I've been geeting this correuption a while back too - look at the mailing
list archives. The problem seems to be cache corruption as far as I can
see. Since Ralf checked in some small fixes for the cache handling it's a
bit better - but not completely fixed.
The Problem is also tracked on the buc tracker btw (#5) .

I have seen this only when copying from one harddisk to another.
Especialy if one wants to copy the kernel sources it will messup.

	CU, Klaus

-- 
Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
Nickname    : Spock             | Org.: Mad Guys Network
Phone / FAX : ++49/177/7862964  | E-Mail: (spock@mgnet.de)
PGP Key     : www.mgnet.de/keys/key_spock.txt
