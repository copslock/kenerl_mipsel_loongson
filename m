Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA67979 for <linux-archive@neteng.engr.sgi.com>; Mon, 29 Jun 1998 11:35:03 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA58635
	for linux-list;
	Mon, 29 Jun 1998 11:33:50 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA26566
	for <linux@engr.sgi.com>;
	Mon, 29 Jun 1998 11:33:43 -0700 (PDT)
	mail_from (shaver@netscape.com)
Received: from netscape.com (h-205-217-237-47.netscape.com [205.217.237.47]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA08287
	for <linux@engr.sgi.com>; Mon, 29 Jun 1998 11:33:41 -0700 (PDT)
	mail_from (shaver@netscape.com)
Received: from dredd.mcom.com (dredd.mcom.com [205.217.237.54])
	by netscape.com (8.8.5/8.8.5) with ESMTP id LAA20590
	for <linux@engr.sgi.com>; Mon, 29 Jun 1998 11:33:39 -0700 (PDT)
Received: from netscape.com ([205.217.243.67]) by dredd.mcom.com
          (Netscape Messaging Server 3.52)  with ESMTP id AAA3DBE;
          Mon, 29 Jun 1998 11:33:39 -0700
Message-ID: <3597DE03.3D596A03@netscape.com>
Date: Mon, 29 Jun 1998 14:33:39 -0400
From: Mike Shaver <shaver@netscape.com>
Organization: Mozilla Dot Weenies
X-Mailer: Mozilla 4.06 [en] (X11; I; Linux 2.0.34 i686)
MIME-Version: 1.0
To: Oliver Frommel <oliver@aec.at>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: EFS compile problem
References: <Pine.LNX.3.96.980629172421.4439D-100000@web.aec.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Oliver Frommel wrote:
> 
> mips-linux-gcc -D__KERNEL__ -I/mnt/dsk1/src/sgi/linux/include -Wall -Wstrict-pro
> totypes -O2 -fomit-frame-pointer -G 0 -mno-abicalls -fno-pic -mcpu=r4600 -mips2
> -pipe   -c -o dir.o dir.c
> dir.c: In function `efs_readdir':
> dir.c:86: structure has no member named `efs_total'
> make[3]: *** [dir.o] Error 1
> make[3]: Leaving directory `/mnt/dsk1/src/sgi/linux/fs/efs'
> make[2]: *** [first_rule] Error 2
> make[2]: Leaving directory `/mnt/dsk1/src/sgi/linux/fs/efs'
> make[1]: *** [sub_dirs] Error 2
> make[1]: Leaving directory `/mnt/dsk1/src/sgi/linux/fs'
> make: *** [linuxsubdirs] Error 2

My bad.
Forgot to commit the EFS header changes I made when I was cleaning up
the EFS code a few weeks back.  Should be all better now.

Mike

-- 
220746.60 219516.06
