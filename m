Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id RAA146881 for <linux-archive@neteng.engr.sgi.com>; Fri, 6 Feb 1998 17:44:40 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA14833 for linux-list; Fri, 6 Feb 1998 17:42:07 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA14818 for <linux@cthulhu.engr.sgi.com>; Fri, 6 Feb 1998 17:42:01 -0800
Received: from godzilla.taec.com (godzilla.taec.com [204.162.152.130]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via SMTP id RAA13677
	for <linux@cthulhu.engr.sgi.com>; Fri, 6 Feb 1998 17:42:00 -0800
	env-from (sasahm@taec.toshiba.com)
Received: from mailint.taec.com by godzilla.taec.com
          via smtpd (for SGI.COM [192.48.153.1]) with SMTP; 7 Feb 1998 01:42:00 UT
Received: from oita (oita.taec.com [198.232.207.41])
	by sol-x86-1.taec.com (8.8.8/8.8.8) with ESMTP id RAA03417
	for <linux@cthulhu.engr.sgi.com>; Fri, 6 Feb 1998 17:41:59 -0800 (PST)
Message-Id: <199802070141.RAA03417@sol-x86-1.taec.com>
To: linux@cthulhu.engr.sgi.com
Subject: Re: Trouble in making swap area
In-Reply-To: Your message of "Fri, 6 Feb 1998 19:40:00 -0500 (EST)"
References: <Pine.LNX.3.95.980206193645.7374B-100000@lager.engsoc.carleton.ca>
X-Mailer: Mew version 1.68 on Emacs 19.28.1 / Mule 2.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Fri, 06 Feb 1998 17:41:59 -0800
From: Masashi Sasahara/=?ISO-2022-JP?B?GyRCOns4NkA1O0obKEI=?=  <sasahm@taec.toshiba.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi, Alex,

> >   I'm trying to install linux onto indy using vmlinux-970916-efs
> > and Linux-installer-0.1d which is on ftp.linux.sgi.com.
> >   Actually I failed to start "installer" so I extracted
> > root-be-0.03 by hand. So I managed to install everything in
> > root-be-0.01.cpio. but I'm having a problem on creating swap
> > area.
> 
> Uh, are you using root-be 0.01, or 0.03?  I believe 0.03 has mkswap in it,
> but 0.01 does not.

  Oh, I'm sorry. 0.01 way typo. I used 0.03.


> What happened when you tried to run the installer?

  It simply says "Command not found" though I could execute
other binaries like ls or whatever came with root-be-0.03.tar.gz.


> You probably don't need mkswap at this point anyway, since there really
> aren't that many applications in root-be that will chew up that much

 Oh, I should write more about where I am now.
 I booted linux kernel via tftp, made ext2 filesystem on indy's
drive, and I extracted root-be-0.03 by hand (because of
installer's problem), and installed RPM stuffs.

> space.  The goal should be to put root-be on your filesystem, and from
> there install all the RPMS (which contain mkswap in util-linux).
                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 Great! that's what I want to know!!
Maybe I haven't extracted that (or forgot to get).

 Thank you very much. I'll try that.

-Masashi Sasahara
