Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3INRX8d014592
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 18 Apr 2002 16:27:33 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3INRXSv014591
	for linux-mips-outgoing; Thu, 18 Apr 2002 16:27:33 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from rwcrmhc54.attbi.com (rwcrmhc54.attbi.com [216.148.227.87])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3INRQ8d014585
	for <linux-mips@oss.sgi.com>; Thu, 18 Apr 2002 16:27:26 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by rwcrmhc54.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020418171600.SOHB15826.rwcrmhc54.attbi.com@ocean.lucon.org>;
          Thu, 18 Apr 2002 17:16:00 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 3E5A7125C2; Thu, 18 Apr 2002 10:16:00 -0700 (PDT)
Date: Thu, 18 Apr 2002 10:16:00 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Jay Carlson <nop@nop.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Update of RedHat 7.1/mips
Message-ID: <20020418101600.C21240@lucon.org>
References: <20020417210843.A10182@lucon.org> <001501c1e6fc$34acc710$41745381@mitre.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <001501c1e6fc$34acc710$41745381@mitre.org>; from nop@nop.com on Thu, Apr 18, 2002 at 01:12:22PM -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Apr 18, 2002 at 01:12:22PM -0400, Jay Carlson wrote:
> "H . J . Lu" <hjl@lucon.org> writes:
> 
> > FYI, I updated a few packages in RedHat 7.1/mips. It has new gcc,
> > glibc, binutils and gdb.
> 
> Is there a quick summary of those changes?  Aside from binutils, which you
> already describe, of course---and thank you for that.
> 

I merged all the recent RedHat 7.1 updates. I also took sh-utils from
RedHat 7.2 to fix the date bug. Here is the list.


H.J.
----
-rw-r--r--    1 hjl      hjl        175660 Apr  8 19:14 zlib-1.1.3-25.7.1.src.rpm
-rw-r--r--    1 hjl      hjl        953640 Apr  8 19:17 pam-0.75-18.7.1.src.rpm
-rw-r--r--    1 hjl      hjl       1454824 Apr  8 19:22 ncurses-5.2-8.2.src.rpm
-rw-r--r--    1 hjl      hjl       6851075 Apr  8 19:27 tcltk-8.3.1-53.7.src.rpm
-rw-r--r--    1 hjl      hjl       5865232 Apr  8 19:47 rpm-4.0.4-7x.1.src.rpm
-rw-r--r--    1 hjl      hjl       1503718 Apr  8 19:56 freetype-2.0.5-3.1.src.rpm
-rw-r--r--    1 hjl      hjl        264946 Apr  8 19:56 gd-1.8.4-4.1.src.rpm
-rw-r--r--    1 hjl      hjl      10724600 Apr  8 20:07 binutils-2.12.90.0.4-1.src.rpm
-rw-r--r--    1 hjl      hjl       4369377 Apr  8 20:14 mpatrol-1.4.7-1.src.rpm
-rw-r--r--    1 hjl      hjl         36351 Apr  8 20:16 lockdev-1.0.0-5.1.src.rpm
-rw-r--r--    1 hjl      hjl        146033 Apr  8 20:18 at-3.1.8-23.1.src.rpm
-rw-r--r--    1 hjl      hjl         68948 Apr  8 20:18 authconfig-4.1.6-1.2.src.rpm
-rw-r--r--    1 hjl      hjl        370575 Apr  8 20:19 automake-1.4-8.3.src.rpm
-rw-r--r--    1 hjl      hjl         43152 Apr  8 20:21 devfsd-1.3.18-1.1.src.rpm
-rw-r--r--    1 hjl      hjl       1367227 Apr  8 20:23 e2fsprogs-1.26-1.71.1.src.rpm
-rw-r--r--    1 hjl      hjl      13356931 Apr  8 20:41 gcc-2.96-109.1.src.rpm
-rw-r--r--    1 hjl      hjl      11701958 Apr  8 20:49 gdb-5.2-0.2.src.rpm
-rw-r--r--    1 hjl      hjl       1283837 Apr  8 20:50 gettext-0.10.38-7.1.src.rpm
-rw-r--r--    1 hjl      hjl       1774533 Apr  8 20:53 groff-1.17.2-7.0.2.1.src.rpm
-rw-r--r--    1 hjl      hjl         29215 Apr  8 20:53 hdparm-4.1-3.1.src.rpm
-rw-r--r--    1 hjl      hjl        234396 Apr  8 20:54 iptables-1.2.4-0.71.2.1.src.rpm
-rw-r--r--    1 hjl      hjl         54885 Apr  8 20:55 ksymoops-2.4.0-3.2.src.rpm
-rw-r--r--    1 hjl      hjl         22341 Apr  8 20:57 mingetty-0.9.4-16.2.src.rpm
-rw-r--r--    1 hjl      hjl        966053 Apr  8 20:58 mount-2.11g-5.2.src.rpm
-rw-r--r--    1 hjl      hjl        237448 Apr  8 20:58 modutils-2.4.13-0.7.1.1.src.rpm
-rw-r--r--    1 hjl      hjl       2039668 Apr  8 21:00 mutt-1.2.5.1-0.7.1.src.rpm
-rw-r--r--    1 hjl      hjl        395818 Apr  8 21:01 ncftp-3.0.2-1.1.src.rpm
-rw-r--r--    1 hjl      hjl        247576 Apr  8 21:02 nfs-utils-1.0.1-1.src.rpm
-rw-r--r--    1 hjl      hjl        911685 Apr  8 21:05 openssh-3.1p1-1.1.src.rpm
-rw-r--r--    1 hjl      hjl         14645 Apr  8 21:09 rdate-1.0-7.1.src.rpm
-rw-r--r--    1 hjl      hjl        130453 Apr  8 21:14 SysVinit-2.78-17.2.src.rpm
-rw-r--r--    1 hjl      hjl        267754 Apr  8 21:15 telnet-0.17-18.1.1.src.rpm
-rw-r--r--    1 hjl      hjl        995402 Apr  8 21:19 util-linux-2.11f-17.1.src.rpm
-rw-r--r--    1 hjl      hjl         60015 Apr  8 21:21 wireless-tools-21-1.1.src.rpm
-rw-r--r--    1 hjl      hjl        114943 Apr  8 21:21 wvdial-1.41-12.1.src.rpm
-rw-r--r--    1 hjl      hjl      11921088 Apr 10 14:13 glibc-2.2.5-30.2.src.rpm
-rw-r--r--    1 hjl      hjl      36746146 Apr 10 15:26 toolchain-20020408-1.src.rpm
-rw-r--r--    1 hjl      hjl      50844326 Apr 11 11:43 XFree86-4.1.0-15.1.src.rpm
-rw-r--r--    1 hjl      hjl       1159621 Apr 17 19:51 sh-utils-2.0.11-5.1.src.rpm
