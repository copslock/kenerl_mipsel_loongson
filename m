Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id RAA1133405 for <linux-archive@neteng.engr.sgi.com>; Thu, 11 Dec 1997 17:27:42 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA13066 for linux-list; Thu, 11 Dec 1997 17:24:31 -0800
Received: from meteor.nsg.sgi.com (meteor.nsg.sgi.com [134.14.162.53]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA12479 for <linux@cthulhu.engr.sgi.com>; Thu, 11 Dec 1997 17:22:02 -0800
Received: (from hakamada@localhost) by meteor.nsg.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id KAA05559; Fri, 12 Dec 1997 10:16:53 +0900
Message-Id: <199712120116.KAA05559@meteor.nsg.sgi.com>
To: alan@lxorguk.ukuu.org.uk
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Mount ext2 filesystem.
In-Reply-To: Your message of "Fri, 12 Dec 1997 01:11:51 +0000 (GMT)"
References: <m0xgJdw-0005FsC@lightning.swansea.linux.org.uk>
X-Mailer: Mew version 1.70 on XEmacs 20.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Fri, 12 Dec 1997 10:16:53 +0900
From: Takeshi Hakamada <hakamada@meteor.nsg.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> > Thank you. I've converted rpm to cpio and I could have installed rpm binary.
> > But, I can't boot from local disk yet. If I can boot from local disk, I'd
> > like to update faq on the www.linux.sgi.com. How do you think about it?
> 
> In irix, shutdown, restart hit the maintenance button to get to the arc
> menu, hit command line and do I think its
> 
> boot /whatever/efs/vmlinux root=/dev/sdb1
> 
> (first partition disk 2 as root)

I know this method, my want to boot from local disk is, I've not installed
all rpm packages on the second disk. I'll do this until tomorrow.
Do you think anyone wants my installation howto?

--
Takeshi Hakamada                  
Nihon Silicon Graphics Cray
E-mail: hakamada@nsg.sgi.com, URL: http://reality.sgi.com/hakamada_nsg/
Phone: +81-45-682-3712, Fax: +81-45-682-0856
Voice mail: (internal)822-1300, (external)+81-3-5488-1863-1300
