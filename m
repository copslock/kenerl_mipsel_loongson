Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA29337 for <linux-archive@neteng.engr.sgi.com>; Wed, 21 Oct 1998 17:56:50 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA98275
	for linux-list;
	Wed, 21 Oct 1998 17:56:29 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA82251
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 21 Oct 1998 17:56:27 -0700 (PDT)
	mail_from (jcoffin@lil.sv.usweb.com)
Received: from lil.sv.usweb.com ([207.44.155.155]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id RAA03538
	for <linux@cthulhu.engr.sgi.com>; Wed, 21 Oct 1998 17:56:26 -0700 (PDT)
	mail_from (jcoffin@lil.sv.usweb.com)
Received: (qmail 16169 invoked by uid 500); 22 Oct 1998 00:56:11 -0000
To: linux@cthulhu.engr.sgi.com
Subject: Re: Partial Success Report
From: Jeff Coffin <jcoffin@sv.usweb.com>
Date: 21 Oct 1998 17:56:11 -0700
Message-ID: <m3vhldwh1w.fsf@lil.sv.usweb.com>
X-Mailer: Gnus v5.5/Emacs 20.2
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Fogot to CC the list on this....

Thomas Bogendoerfer <tsbogend@alpha.franken.de> writes:

> Could you please lookup major and minor number of /dev/console on
> your root filesystem ? It should be major 5 and minor 2 to work
> properly with the serial console.

I fixed it, do I need to change systty too perhps?:

[root@lil dev]# ls -l
total 0
crw-------   1 root     disk       5,   2 Oct 21 13:25 console
crw-------   1 root     disk       4,   0 May 11 08:48 console.dist
crw-rw-r--   1 root     root       1,   3 May 11 08:48 null
brw-r-----   1 root     disk       1,   1 May 11 08:48 ram
crw-------   1 root     disk       4,   0 May 11 08:48 systty
crw-------   1 root     root       4,   1 May 11 08:48 tty1
crw-------   1 root     root       4,   2 May 11 08:48 tty2
crw-------   1 root     root       4,   3 May 11 08:48 tty3
crw-------   1 root     root       4,   4 May 11 08:48 tty4
crw-------   1 root     root       4,   5 May 11 08:48 tty5

> please try to boot these kernels with bootp()/vmlinux console=ttyS0 (also
> try ttyS1) and a terminal hooked up to one of the serial ports (in .116
> ttyS0 is port 2 and ttyS1 is port 1; I've changed that in .121, but I'm not
> sure if this fix is already in the precompiled kernel). It's possible, 
> that I've messed up the card detection so, that it panics, when there is 
> no newport installed.

Nope, didn't work.  The 116 kernel makes the power light blink red to
green ad infinitum and the 121 version appears to load, but the
console is elsewhere.  I'm using port 1 for the serial connection
(it's setup thusly in the PROM)

The default kernel still boots OK and appears to mount the nfsroot:

Looking up port of RPC 100003/2 on 192.168.0.20
Looking up port of RPC 100005/1 on 192.168.0.20
VFS: Mounted root (nfs filesystem).
Adv: done running setup() 

but then nothing....                                                     

BTW, I'm doing the whole thing from a serial console (minicom).  The
gfx card doesn't work from IRIX either.  One of these days I'll
replace it, but it's not real high on my list of things to buy for
$200+.


--jeff
