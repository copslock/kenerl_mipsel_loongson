Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id HAA40063 for <linux-archive@neteng.engr.sgi.com>; Tue, 23 Feb 1999 07:56:16 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA64861
	for linux-list;
	Tue, 23 Feb 1999 07:55:29 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from otg.dallas.sgi.com (roctane.dallas.sgi.com [169.238.83.62])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA87269
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 23 Feb 1999 07:55:26 -0800 (PST)
	mail_from (chad@dallas.sgi.com)
Received: from dallas.sgi.com (localhost [127.0.0.1]) by otg.dallas.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id HAA19032; Tue, 23 Feb 1999 07:51:24 -0800 (PST)
Message-ID: <36D2CE7C.A863C235@dallas.sgi.com>
Date: Tue, 23 Feb 1999 09:51:24 -0600
From: Chad Carlin <chad@dallas.sgi.com>
Reply-To: chad@sgi.com
Organization: Silicon Graphics Inc.
X-Mailer: Mozilla 4.5C-SGI [en] (X11; I; IRIX64 6.5 IP30)
X-Accept-Language: en
MIME-Version: 1.0
To: Alex deVries <adevries@engsoc.carleton.ca>
CC: linux <linux@cthulhu.engr.sgi.com>
Subject: Re: able to bootp/NFS-install/reboot R4400SC Indy
References: <Pine.LNX.3.96.990223011941.1617A-100000@lager.engsoc.carleton.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex,

I get this error message in my syslog.
kernel: kmod: failed to exec /sbin/modprobe -s -k net-pf-N, errno = 2

/sbin/modprobe is not on my system. Why is it trying to execute? According to
rpm -qf /sbin/modprobe on my intel-Linux system, this executable gets installed
with modutils. I am jumping to a conclusion that this error message is telling
me why networking is not running properly. More specifically, I have tried
rlogin, telnet, ftp and nfs. All of these panic the system.

I grabbed
ftp://linus.linux.sgi.com/pub/linux/mips/hardhat/5.2/RPMS/mipseb/modutils-2.1.121-4.mipseb.rpm
and put that in with the other rpms in my installation nfs filesystem. It didn't
get picked up during my nfsroot install. I guess I need to look at  some sort of
installation script to find where it get's it's list of packages to install.

Heck, I might be barking up the wrong tree after all.

Thanks,
Chad



Alex deVries wrote:

> On Mon, 22 Feb 1999, Chad Carlin wrote:
> > Ok. Somebody shoot me. I went through and reinstalled linux on my Indy. I
> > thought that I screwed up and somehow did not get modutils-x.x.x-x because
> > I chose to install the wrong package set. I think I was wrong there too.
> >
> > Problem:
> > - modutils-x.x.x-x does not get installed by the base installer. (or I
> > don't know which one it goes with)
>
> Yup. modutils was broken at the time when Rough Cuts was put together.
> Theres a newer package that does work on the ftp site.
>
> > - Can't get this package over the network because if I try to use my
> > network interface, the system panics. It panics because I don't have
> > modutils.
>
> Why do you need modules to get your network going?
>
> > - BTW howto-french-5.1.1 seems to be corrupted in the distribution. My indy
> > always hangs when trying to install it. Hence, I have to deselect
> > optional-documentation during install.
>
> We know that. :)
>
> - Alex

--
           -----------------------------------------------------
            Chad Carlin                          Special Systems
            Silicon Graphics Inc.                   972.205.5911
            Pager 888.754.1597          VMail 800.414.7994 X5344
            chad@sgi.com             http://reality.sgi.com/chad
           -----------------------------------------------------
        "flying through hyper space ain't like dusting crops, boy"
