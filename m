Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA12737 for <linux-archive@neteng.engr.sgi.com>; Thu, 4 Mar 1999 12:19:21 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA10087
	for linux-list;
	Thu, 4 Mar 1999 12:17:01 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA79490
	for <linux@engr.sgi.com>;
	Thu, 4 Mar 1999 12:16:59 -0800 (PST)
	mail_from (nico@ramapo.edu)
Received: from orion.ramapo.edu (orion.ramapo.edu [192.107.108.5]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA07431
	for <linux@engr.sgi.com>; Thu, 4 Mar 1999 12:16:56 -0800 (PST)
	mail_from (nico@ramapo.edu)
Received: from localhost by orion.ramapo.edu (PMDF V5.2-31 #32713)
 with ESMTP id <0F83009016ZDC5@orion.ramapo.edu> for linux@engr.sgi.com; Thu,
 4 Mar 1999 15:16:25 -0500 (EST)
Date: Thu, 04 Mar 1999 15:16:20 -0500 (EST)
From: Nico Halpern <nico@ramapo.edu>
Subject: booting linux on a Challenge S
To: linux@cthulhu.engr.sgi.com
Message-id: <Pine.OSF.4.10.9903041455290.22579-100000@orion.ramapo.edu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

-----BEGIN PGP SIGNED MESSAGE-----


hello all, and pardon me if this is a FAQ.

Scenario:
	I managed to install the rh-5.1 tarball on a Challenge S. Since I have
a single disk drive on the machine, I installed linux on a '/' filesystem that
takes up most of the disk (sda1). I no longer have IRIX on the machine, and I
would like to boot linux. I have tried the following:
boot -f vmlinux (error message: file not found... how can I tell the prom to
boot linux??)

boot bootp():/vmlinux root=/dev/sda1 init=/bin/sh .. Machine loads kernel, and
stops after the 'Warning: cannot open an initial console'. Theoretically I
_could_ fix this problem by creating the correct entry with mknod. The catch
22 is that I cannot access the hard drive because I have no console.. any
suggestions?

oh-- I almost forget. This machine is completely headless, if that makes a
diference. Also, what it the status of the sound drivers? I have not seen any
docs on this... maybe I am just looking in all the wrong places.

TIA,
	-Nico.

- -- 
                    Nico Halpern, Your Favorite daemon.
                         UNIX System Administrator
                       Ramapo College  of New Jersey
                              +1.201.684.6821
- --
On ne voit bien qu'avec le coeur. L'essentiel est invisible pour les yeux. 
                                                  Antoine de Saint-Exupery



-----BEGIN PGP SIGNATURE-----
Version: 2.6.2

iQCVAwUBNt7qGFRPq2j8zDBJAQE4pAP6AjC+PWrTFpxrgFjeSZVjzSw9W7V5A7Wh
C+qq+p5M9SN45DCricwMWvm1JOlAjN8caNh9xx0LLlhfhgSqs2cKlWASc9gL1hjY
YqAniyRYQ20b+i2t1FtdLMrhVC5k0QyeC9yceothUISqpA0z8sKjA5jC1ZrShWGI
Q8lBU4s8PDw=
=N0Fq
-----END PGP SIGNATURE-----
