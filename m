Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA87417 for <linux-archive@neteng.engr.sgi.com>; Mon, 22 Feb 1999 17:31:40 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA45468
	for linux-list;
	Mon, 22 Feb 1999 17:30:46 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from otg.dallas.sgi.com (roctane.dallas.sgi.com [169.238.83.62])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA69326
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 22 Feb 1999 17:30:43 -0800 (PST)
	mail_from (chad@dallas.sgi.com)
Received: from dallas.sgi.com (localhost [127.0.0.1]) by otg.dallas.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id RAA18214; Mon, 22 Feb 1999 17:28:04 -0800 (PST)
Message-ID: <36D20423.1B7513D1@dallas.sgi.com>
Date: Mon, 22 Feb 1999 19:28:04 -0600
From: Chad Carlin <chad@dallas.sgi.com>
Reply-To: chad@sgi.com
Organization: Silicon Graphics Inc.
X-Mailer: Mozilla 4.5C-SGI [en] (X11; I; IRIX64 6.5 IP30)
X-Accept-Language: en
MIME-Version: 1.0
To: ralf@uni-koblenz.de, linux <linux@cthulhu.engr.sgi.com>
Subject: Re: able to bootp/NFS-install/reboot R4400SC Indy
References: <Pine.LNX.3.96.990217020751.6350A-100000@lager.engsoc.carleton.ca> <36D19E7E.955F66EC@dallas.sgi.com> <19990223000909.B502@uni-koblenz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ralf,

On closer observation......

The message in the syslog is as follows:
kernel: kmod: failed to exec /sbin/modprobe -s -k net-pf-N, errno = 2

ls -l /sbin/modprobe
.....No such file or directory

Obviously, I need modprobe. I wonder how I didn't get modprobe?

Other info:
uname -r  = 2.1.131

cat /proc/cpuinfo

cpu: MIPS
cpu model: R4000SC V6.0
system type: SGI Indy
BogoMIPS: 99.94
........

Let me know if you want to see more.




ralf@uni-koblenz.de wrote:

> On Mon, Feb 22, 1999 at 12:14:22PM -0600, Chad Carlin wrote:
>
> > I got my 200MHz R4400 working too. Yes it actually boots. I guess you guys
> > weren't making all this stuff up after all.
> >
> > I have one problem though. Something is broken in modules. The networking
> > stuff is working incorrectly because of this. When I try to telnet in from
> > another host, the linux-indy panics. I can hand copy more verbose
> > information when I get home if this is not a common problem that everyone
> > else knows the answer to.
>
> I'd appreciate a more detailed bug report with all the messages you got.
> Which kernel binary exactly were you using?
>
>   Ralf

--
           -----------------------------------------------------
            Chad Carlin                          Special Systems
            Silicon Graphics Inc.                   972.205.5911
            Pager 888.754.1597          VMail 800.414.7994 X5344
            chad@sgi.com             http://reality.sgi.com/chad
           -----------------------------------------------------
        "flying through hyper space ain't like dusting crops, boy"
