Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA42492 for <linux-archive@neteng.engr.sgi.com>; Mon, 18 Jan 1999 12:12:17 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA91907
	for linux-list;
	Mon, 18 Jan 1999 12:11:36 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA70697
	for <linux@engr.sgi.com>;
	Mon, 18 Jan 1999 12:11:33 -0800 (PST)
	mail_from (shaver@netscape.com)
Received: from netscape.com (h-205-217-237-46.netscape.com [205.217.237.46]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA01045
	for <linux@engr.sgi.com>; Mon, 18 Jan 1999 15:11:33 -0500 (EST)
	mail_from (shaver@netscape.com)
Received: from tintin.mcom.com (tintin.mcom.com [205.217.233.42])
	by netscape.com (8.8.5/8.8.5) with ESMTP id MAA26585
	for <linux@engr.sgi.com>; Mon, 18 Jan 1999 12:11:32 -0800 (PST)
Received: from netscape.com ([205.217.243.67]) by
          tintin.mcom.com (Netscape Messaging Server 4.01) with ESMTP id
          F5RUR700.14I; Mon, 18 Jan 1999 12:11:31 -0800 
Message-ID: <36A395C4.1EE6A62E@netscape.com>
Date: Mon, 18 Jan 1999 15:12:52 -0500
From: Mike Shaver <shaver@netscape.com>
Organization: Just Another Snake Cult
X-Mailer: Mozilla 4.51 [en] (X11; I; Linux 2.2.0-pre7-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alex deVries <adevries@engsoc.carleton.ca>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: compiling kernel
References: <Pine.LNX.3.96.990118145622.30635J-100000@lager.engsoc.carleton.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex deVries wrote:
> This is usually because you didn't remove the "-N" in arch/mips/Makefile
> or similiar. It's in the FAQ, but I keep forgetting that myself.

So can we detect the bad versions of binutils and automatically set the
LDFLAGS correctly?  I'm tired of forgetting. =)

Mike

-- 
89428.19 72624.98
