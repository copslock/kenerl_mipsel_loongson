Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5PJAJ004590
	for linux-mips-outgoing; Mon, 25 Jun 2001 12:10:19 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5PJAHV04587
	for <linux-mips@oss.sgi.com>; Mon, 25 Jun 2001 12:10:17 -0700
Received: by mail.foobazco.org (Postfix, from userid 1014)
	id 37A6C3E90; Mon, 25 Jun 2001 12:04:57 -0700 (PDT)
Date: Mon, 25 Jun 2001 12:04:57 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: Florian Lohoff <flo@rfc822.org>
Cc: Barry Wu <wqb123@yahoo.com>, linux-mips@oss.sgi.com
Subject: Re: about linux mips ext2fs
Message-ID: <20010625120457.A15950@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010625202030.B701@paradigm.rfc822.org>
User-Agent: Mutt/1.3.18i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jun 25, 2001 at 08:20:30PM +0200, Florian Lohoff wrote:

> Linux/mips uses ext2 - Ext2 is per definition little endian and all
> big endian targets use byteswap mechanisms (All but very old Linux/m68k
> systems). So - yes - you can read i386 written ext2 on mips machines.
> 
> With the partition type - I guess all architectures are able to read
> dos partition tables allthough they might not be the default (On SGI
> we mostly use IRIX style partition tables)

All true, though the more standard way to get software onto your
system is using network booting and nfsroot.  Then you can create
partition tables and filesystems locally, then copy or install
appropriate software from the nfsroot onto local disk.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"Nothing motivates a man more than to see his boss put
	 in an honest day's work." -- The fortune file
