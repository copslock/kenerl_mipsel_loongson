Received:  by oss.sgi.com id <S305180AbQC0VJH>;
	Mon, 27 Mar 2000 13:09:07 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:14858 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305163AbQC0VIu>; Mon, 27 Mar 2000 13:08:50 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id NAA05756; Mon, 27 Mar 2000 13:12:27 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA07118
	for linux-list;
	Mon, 27 Mar 2000 13:00:31 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA15880
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 27 Mar 2000 13:00:19 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA00341
	for <linux@cthulhu.engr.sgi.com>; Mon, 27 Mar 2000 13:00:18 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id NAA26511;
	Mon, 27 Mar 2000 13:00:17 -0800 (PST)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id NAA11449;
	Mon, 27 Mar 2000 13:00:12 -0800 (PST)
Message-ID: <013201bf982f$fdf092f0$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Linux/MIPS fnet" <linux-mips@fnet.fr>,
        "Linux/MIPS algor" <linux-porters@algor.co.uk>,
        "Linux SGI" <linux@cthulhu.engr.sgi.com>
Subject: Linux now availabile on MIPS Technologies FTP Server
Date:   Mon, 27 Mar 2000 23:03:59 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

The semi-induistrialized 2.2.12 MIPS kernel from
MIPS Technologies and a set of userland installation
facilities are at long last available by anonymous FTP
from the MIPS Technologies server at ftp://ftp.mips.com
under /pub/linux/mips.  The www.paralogos.com/mipslinux 
site has been updated with some explanations and
links to specific subdirectories.

As with the earlier snapshot I made available on the
Paralogos server, one can download the full set
of sources, or a patch file relative to the kernel.org
2.2.12 release.  I also generated a patch file between
the previous snapshot ("01.01") and the current 
code ("01.04").  The major changes between the
two are in the kernel interfaces to the Algorithmics
FPU emulator, which are now potentially SMP-safe
(untested), more R3000-friendly, and if configured,
the full emulator is used instead of the old softfp
asm hack to handle unimplemented FP operations.
There are also minor changes to fix a few bugs 
found in the course of torture-testing, etc.

The other thing that may be of interest on the site
is the genericised NFS install root archives for both
big and little-endian platforms.  These were set up
for the MIPS Atlas development board, but should
work equally well on Algorithmics or other MIPS
development boards with serial ports, ethernet
interfaces, and a hard disk controller.   They were
derived from the Indy install kit on the SGI site, but
with the SGI dependencies removed.  Well, almost
removed - the big-endian fdisk program will only work
if the kernel has EFS configured. :-(.  Even compressed,
these are huge files (250MB or so), but at least they
are available.  Instructions can be found in the FTP
directory or on the www.paralogos.com site.
__

Kevin D. Kissell
MIPS Technologies European Architecture Lab
kevink@mips.com
Tel. +33.4.78.38.70.67
FAX. +33.4.78.38.70.68
