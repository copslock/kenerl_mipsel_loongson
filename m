Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA05245 for <linux-archive@neteng.engr.sgi.com>; Sun, 21 Mar 1999 18:35:21 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA66162
	for linux-list;
	Sun, 21 Mar 1999 18:34:35 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA57801
	for <linux@engr.sgi.com>;
	Sun, 21 Mar 1999 18:34:32 -0800 (PST)
	mail_from (imp@harmony.village.org)
Received: from rover.village.org (rover.village.org [204.144.255.49]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id VAA00104
	for <linux@engr.sgi.com>; Sun, 21 Mar 1999 21:34:30 -0500 (EST)
	mail_from (imp@harmony.village.org)
Received: from harmony.village.org (harmony [10.0.0.6]) by rover.village.org (8.9.3/8.6.6) with ESMTP id CAA98028; Mon, 22 Mar 1999 02:33:54 GMT
Received: from harmony.village.org (localhost.village.org [127.0.0.1]) by harmony.village.org (8.9.3/8.8.3) with ESMTP id TAA00474; Sun, 21 Mar 1999 19:33:23 -0700 (MST)
Message-Id: <199903220233.TAA00474@harmony.village.org>
To: linux-mips@fnet.fr
Subject: Re: Little Endian - Debian/Linux/MIPS Port 
Cc: Karel van Houten <K.H.C.vanHouten@research.kpn.com>,
        linux@cthulhu.engr.sgi.com, linux-mips@vger.rutgers.edu,
        joey@infodrom.north.de, debian-mips@lists.debian.org
In-reply-to: Your message of "Sun, 21 Mar 1999 19:48:22 CST."
		<Pine.SOL.3.95.990321194101.27295A-100000@ecom5> 
References: <Pine.SOL.3.95.990321194101.27295A-100000@ecom5>  
Date: Sun, 21 Mar 1999 19:33:23 -0700
From: Warner Losh <imp@harmony.village.org>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

In message <Pine.SOL.3.95.990321194101.27295A-100000@ecom5> Russell E Glaue writes:
: Is the DECstation port compatible with the Deskstation bios and related
: system chipset and hardware? I didn't think it was.

Deskstation and DECstation are two different beasties.

The Deskstation Tyne (and rPC44, which is my machine) are both R4xxx
based machines that use the ARC BIOS interface.

All ARC BIOS machines are little endian (well, sgi calls its bios ARC
too, so that is confusing).  The JAZZ is supported as a ARC BIOS
machine and it is little endian.  Ralf also has several other little
endian mips machines that he's supporting.  The Tyne isn't one of them
due to hardware problems with the one he had and some bone-headedness,
at the time, on the part of Deskstation.

Warner
