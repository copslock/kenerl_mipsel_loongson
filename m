Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id TAA323939 for <linux-archive@neteng.engr.sgi.com>; Fri, 23 Jan 1998 19:30:32 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA03312 for linux-list; Fri, 23 Jan 1998 19:27:43 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA03296 for <linux@cthulhu.engr.sgi.com>; Fri, 23 Jan 1998 19:27:37 -0800
Received: from mdhill.interlog.com (mdhill.interlog.com [199.212.154.112]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id TAA07922
	for <linux@cthulhu.engr.sgi.com>; Fri, 23 Jan 1998 19:27:18 -0800
	env-from (mike@mdhill.interlog.com)
Received: (from mike@localhost) by mdhill.interlog.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id WAA01949; Fri, 23 Jan 1998 22:24:20 -0500
Date: Fri, 23 Jan 1998 22:24:20 -0500
Message-Id: <199801240324.WAA01949@mdhill.interlog.com>
From: Michael Hill <mdhill@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Linux-installer 0.1c
In-Reply-To: <Pine.LNX.3.95.980123001923.16039C-100000@lager.engsoc.carleton.ca>
References: <Pine.LNX.3.95.980123001923.16039C-100000@lager.engsoc.carleton.ca>
X-Mailer: VM 6.34 under 20.3 "Vatican City" XEmacs  Lucid
Reply-To: mdhill@interlog.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi Alex,

Running the installer with root-be-0.03 gives me the following:

cjwsh>cpio root-be-0.03.cpio
error -2 reading header: Error 0

and kicks me back to the root prompt.  When I did it with
root-be-0.01.cpio, it seemed to execute without a hitch.

Alex deVries writes:
 > 
 > I've merged the root-be-0.03 with Linux-installer 0.1 to make 0.1c.
 > 
 > I know the filesystem works, I don't know about the installer and I can't
 > do that until I have another disk to install on. 
 > 

Thanks,

Mike
-- 
Michael Hill
Toronto, Canada
mdhill@interlog.com
