Received:  by oss.sgi.com id <S553996AbRAaQsV>;
	Wed, 31 Jan 2001 08:48:21 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:30992 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553991AbRAaQsD>;
	Wed, 31 Jan 2001 08:48:03 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id E04857FD; Wed, 31 Jan 2001 17:47:51 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 7C2CEEE9C; Wed, 31 Jan 2001 17:48:23 +0100 (CET)
Date:   Wed, 31 Jan 2001 17:48:23 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Carsten Langgaard <carstenl@mips.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Filesystem corruption
Message-ID: <20010131174823.E32399@paradigm.rfc822.org>
References: <3A781F33.6B28D19C@mips.com> <20010131165246.B32399@paradigm.rfc822.org> <3A783C59.FC3D3F98@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A783C59.FC3D3F98@mips.com>; from carstenl@mips.com on Wed, Jan 31, 2001 at 05:24:58PM +0100
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jan 31, 2001 at 05:24:58PM +0100, Carsten Langgaard wrote:
> 
> Try use fsck.
> 

*Urgs* Trouble ...



resume:~# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sda1              2074328   1360061    607040  70% /
/dev/sde1              3839092    217476   3426600   6% /chroot
/dev/sdb1              4003992   3708044     89260  98% /home2
/dev/sdc1              4003992    449472   3347832  12% /home3
/dev/sdd1              4003992   1134620   2662684  30% /ftp.rfc822.org
resume:~# umount /ftp.rfc822.org/
resume:~# fsck -f /dev/sdd1
Parallelizing fsck version 1.18 (11-Nov-1999)
e2fsck 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09
Pass 1: Checking inodes, blocks, and sizes
Inode 64654, i_blocks is 42696, should be 44744.  Fix<y>? yes

Duplicate blocks found... invoking duplicate block passes.
Pass 1B: Rescan for duplicate/bad blocks
Duplicate/bad block(s) in inode 64654: 265881 ... ... ...
Duplicate/bad block(s) in inode 193927: 265881 ... ... ...
Pass 1C: Scan directories for inodes with dup blocks.
Pass 1D: Reconciling duplicate blocks
(There are 2 inodes containing duplicate/bad blocks.)

File /kernel/kernel-image-2.4.0-ip22-r4k.tgz (inode #193927, mod time Thu Jan 25 11:17:00 2001) 
  has 251 duplicate block(s), shared with 1 file(s):
	/devel/gcc-20000822-mips.tar.gz (inode #64654, mod time Mon Aug 28 17:14:56 2000)
Clone duplicate/bad blocks<y>? yes

File /devel/gcc-20000822-mips.tar.gz (inode #64654, mod time Mon Aug 28 17:14:56 2000) 
  has 251 duplicate block(s), shared with 1 file(s):
	/kernel/kernel-image-2.4.0-ip22-r4k.tgz (inode #193927, mod time Thu Jan 25 11:17:00 2001)
Duplicated blocks already reassigned or cloned.

Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Block bitmap differences:  +265876 +265877 +265878 +265879 +265880
Fix<y>? yes

Free blocks count wrong for group #0 (29960, counted=29709).
Fix<y>? yes

Free blocks count wrong for group #8 (5, counted=0).
Fix<y>? yes

Free blocks count wrong (717343, counted=717087).
Fix<y>? yes


/dev/sdd1: ***** FILE SYSTEM WAS MODIFIED *****
/dev/sdd1: 6277/1034240 files (21.0% non-contiguous), 316359/1033446 blocks



I ran -test6 and -test9 before.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
