Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id XAA91055 for <linux-archive@neteng.engr.sgi.com>; Tue, 6 Apr 1999 23:01:16 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id WAA94380
	for linux-list;
	Tue, 6 Apr 1999 22:59:48 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id WAA23302
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 6 Apr 1999 22:59:46 -0700 (PDT)
	mail_from (matthias@fmc-container.mach.uni-karlsruhe.de)
Received: from mdaxp2.umassd.edu (MDAxp2.UMassD.Edu [134.88.120.67]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id WAA07553
	for <linux@cthulhu.engr.sgi.com>; Tue, 6 Apr 1999 22:59:45 -0700 (PDT)
	mail_from (matthias@fmc-container.mach.uni-karlsruhe.de)
Received: from us08-568b-1.res.umassd.edu by umassd.edu (PMDF V5.1-12 #22746)
 with ESMTP id <01J9QGOK49W88X03AF@umassd.edu> for linux@cthulhu.engr.sgi.com;
 Wed, 7 Apr 1999 01:59:42 EST
Received: from matthias by us08-568b-1.res.umassd.edu with local
 (Exim 2.05 #1 (Debian)) id 10UlNU-0000ib-00; Wed, 07 Apr 1999 01:59:56 -0400
Date: Wed, 07 Apr 1999 01:59:56 -0400
From: Matthias Kleinschmidt <mkleinschmidt@gmx.de>
Subject: Re: HAL2 driver 0.2
In-reply-to: <19990406221641.A6206@bun.falkenberg.se>; from Ulf Carlsson on
 Tue, Apr 06, 1999 at 10:16:41PM -0400
To: Linux SGI <linux@cthulhu.engr.sgi.com>
Message-id: <19990407015956.A2584@fmc-container.mach.uni-karlsruhe.de>
MIME-version: 1.0
X-Mailer: Mutt 0.93i
Content-type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-md5; boundary=82I3+IH0IqGh5yIs
Mail-Followup-To: Linux SGI <linux@cthulhu.engr.sgi.com>
References: <19990406221641.A6206@bun.falkenberg.se>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 06, 1999 at 10:16:41PM -0400, Ulf Carlsson wrote:
> Hello,
>=20
> I've uploaded new version of ALSA HAL2 sounddrivers now. Works much bette=
r.

I got a new kernel from cvs and compiled with soundcore.o.
When I try to install alsa-driver-0.3.0-pre5-1.mipseb.rpm I get many errors
about unresolved symbols. And when I try to load snd.o I get the following
output:

snd.o: unresolved symbol lookup_dentry_Rbf9ede0c
snd.o: unresolved symbol register_chrdev_R79319a7e
snd.o: unresolved symbol create_proc_entry_R4bfb68d0
snd.o: unresolved symbol __up_R224e7279
snd.o: unresolved symbol register_sound_dsp_Rb255d4ae
snd.o: unresolved symbol proc_unregister_R77de8be6
snd.o: unresolved symbol __down_R3d27099f
snd.o: unresolved symbol register_sound_special_Rdf061e7e
snd.o: unresolved symbol mem_map_R89246c1b
snd.o: unresolved symbol proc_root_R04ac0340


Does anyone have a solution for that?

Matthias

--=20
Matthias Kleinschmidt
Cedar Dell 568B, Box 5398
UMass Dartmouth
285 Old Westport Rd.
North Dartmouth, MA 02747
email: matthias@fmc-container.mach.uni-karlsruhe.de

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: 2.6.3ia

iQCVAwUBNwr0XMXMHXe35ITFAQGk4AP/Tfn6ciZEzMYPhXf6gnXmZ8YCzv5IqpWM
LM2qhaZ1KqarMY+j8vQJTV8ImpLpagTf+tkn+OdJR45Xq/6FxOJr5+unC+lwzRWe
xuPGOAi+YCthRLKEOee1QhdEo4oWZF/cktDK5hFLekvRqc/oFF62MYzkZ3AhnZec
bBwnyIATQkQ=
=3cRf
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
