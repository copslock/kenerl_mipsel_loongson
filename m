Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA2812782 for <linux-archive@neteng.engr.sgi.com>; Sat, 4 Apr 1998 12:29:18 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id MAA7838072
	for linux-list;
	Sat, 4 Apr 1998 12:27:33 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA7815126
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 4 Apr 1998 12:27:27 -0800 (PST)
Received: from aec.at (web.aec.at [193.170.192.5]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id MAA17629
	for <linux@cthulhu.engr.sgi.com>; Sat, 4 Apr 1998 12:27:25 -0800 (PST)
	mail_from (oliver@web.aec.at)
Received: from localhost (oliver@localhost) by aec.at (8.8.3/8.7) with SMTP id WAA05571 for <linux@cthulhu.engr.sgi.com>; Sat, 4 Apr 1998 22:27:24 +0200
Date: Sat, 4 Apr 1998 22:27:24 +0200 (MET DST)
From: Oliver Frommel <oliver@aec.at>
Reply-To: Oliver Frommel <oliver@aec.at>
To: linux@cthulhu.engr.sgi.com
Subject: Re: serial console
In-Reply-To: <19980402233532.10932@uni-koblenz.de>
Message-ID: <Pine.LNX.3.96.980404212135.32556A-100000@web.aec.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

i think i fixed the serial console, at least it works here after linking
/dev/console to /dev/ttyS1 (i have no idea if this is the correct behaviour
however)
you can find the patch on ftp://zero.aec.at/pub/sgi-linux/serial-patch.gz

bye
-oliver
