Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5PIKEw03845
	for linux-mips-outgoing; Mon, 25 Jun 2001 11:20:14 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5PIKCV03839
	for <linux-mips@oss.sgi.com>; Mon, 25 Jun 2001 11:20:13 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id CA76A7F5; Mon, 25 Jun 2001 20:20:11 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 2659943AA; Mon, 25 Jun 2001 20:20:30 +0200 (CEST)
Date: Mon, 25 Jun 2001 20:20:30 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Barry Wu <wqb123@yahoo.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: about linux mips ext2fs
Message-ID: <20010625202030.B701@paradigm.rfc822.org>
References: <20010625155138.78161.qmail@web13904.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010625155138.78161.qmail@web13904.mail.yahoo.com>; from wqb123@yahoo.com on Mon, Jun 25, 2001 at 08:51:38AM -0700
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jun 25, 2001 at 08:51:38AM -0700, Barry Wu wrote:
> Hi, all,
> 
> I am new to this maillist. I want to mount root 
> file system under mipsel linux. I got root file
> system from MIPS company. But I have no ready mips
> linux system. Therefore I have to copy this root
> file system to hard disk under intel linux. Using
> its fdisk and ext2fs. I do not know if it can work
> under mipsel linux. That mean mipsel linux can
> support same ext2fs and partition? If someone knows,
> please help me.

Linux/mips uses ext2 - Ext2 is per definition little endian and all
big endian targets use byteswap mechanisms (All but very old Linux/m68k
systems). So - yes - you can read i386 written ext2 on mips machines.

With the partition type - I guess all architectures are able to read
dos partition tables allthough they might not be the default (On SGI
we mostly use IRIX style partition tables)

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
