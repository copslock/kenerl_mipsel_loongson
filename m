Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4BAgdt01391
	for linux-mips-outgoing; Fri, 11 May 2001 03:42:39 -0700
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4BAgbF01388
	for <linux-mips@oss.sgi.com>; Fri, 11 May 2001 03:42:37 -0700
Received: from ginger.sonytel.be (ginger.sonytel.be [10.34.16.6])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id MAA13216;
	Fri, 11 May 2001 12:42:36 +0200 (MET DST)
Received: (from tea@localhost)
	by ginger.sonytel.be (8.9.0/8.8.6) id MAA13864;
	Fri, 11 May 2001 12:42:35 +0200 (MET DST)
Date: Fri, 11 May 2001 12:42:35 +0200
From: Tom Appermont <tea@sonycom.com>
To: Keith M Wesolowski <wesolows@foobazco.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: Binary compatibility break understood ?
Message-ID: <20010511124235.E8495@sonycom.com>
References: <20010507163210.B2381@bacchus.dhis.org> <20010508202518.A13476@paradigm.rfc822.org> <20010508214313.A12528@bacchus.dhis.org> <20010509095955.A8392@sonycom.com> <20010509104635.D12267@paradigm.rfc822.org> <3AF934AE.38AB0089@cotw.com> <20010510110847.A2799@cyberhqz.com> <20010510162221.A1736@bacchus.dhis.org> <20010511095628.D8495@sonycom.com> <20010511022627.A17202@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20010511022627.A17202@foobazco.org>; from wesolows@foobazco.org on Fri, May 11, 2001 at 02:26:27AM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> > To avoid any further confusion, which then are the versions 
> > ( & patches ) of binutils / gcc / libc needed to get a
> > linux mips toolchain we can use until the end of time? 
> 
> I routinely publish just such a thing at
> oss.sgi.com:/pub/linux/mips/mips-linux/simple/crossdev.  Many others

Thanks for the pointer. Any reason why the tar files are not compressed?

> publish similar toolchains regularly - see the list archives for
> pointers.  

Sorry for asking for a bit of clarity on this. There are indeed many
others publishing their own cross-dev toolchains on their ftp site.
So far it has not been easy for me to find the version that I need,
i.e. a version that compiles the latest linux/mips cvs tree on solaris.
Too many versions, too many patches, and no central repository for
tools have caused me too many headaches. How naive I was when I started
from the webpage "How to build a cross compiler for Linux/MIPS"
(I use the mirror at http://www.village.org/villagers/imp/build.html),
looking desperately for the files that are referenced there ....

> None of them have expiration dates; you are free to use
> them forever.  If you never change software you'll never lose binary
> compatibility.  Likewise, you'll never get any bug fixes or new
> features either.

I was not being serious, I know it is unthinkable to be using the same
version forever. I just hope there will come a time where I can spend 
more time on actually using the tools than trying to solve the problems 
I have with them.


Greetz,

Tom
