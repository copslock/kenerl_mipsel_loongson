Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Dec 2007 19:55:22 +0000 (GMT)
Received: from hydra.gt.owl.de ([195.71.99.218]:7577 "EHLO hydra.gt.owl.de")
	by ftp.linux-mips.org with ESMTP id S20033703AbXLWTzO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 23 Dec 2007 19:55:14 +0000
Received: by hydra.gt.owl.de (Postfix, from userid 1000)
	id 93E1793701; Sun, 23 Dec 2007 20:54:42 +0100 (CET)
Date:	Sun, 23 Dec 2007 20:54:42 +0100
From:	Florian Lohoff <flo@rfc822.org>
To:	linux-mips@linux-mips.org
Subject: IP28 Installation Success report Was: [UPDATED PATCH] IP28 support
Message-ID: <20071223195442.GA17311@paradigm.rfc822.org>
References: <20071202120032.2A477C2EB6@solo.franken.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <20071202120032.2A477C2EB6@solo.franken.de>
Organization: rfc822 - pure communication
X-SpiderMe: mh-200712232045@listme.rfc822.org
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 02, 2007 at 01:00:32PM +0100, Thomas Bogendoerfer wrote:
> Add support for SGI IP28 machines (Indigo 2 with R10k CPUs)
> This work is mainly based on Peter Fuersts work.

I thought an installation success report is sometimes nice to have:

flo@ip28:~$ cat /proc/cpuinfo=20
system type             : SGI Indigo2
processor               : 0
cpu model               : R10000 V2.5  FPU V0.0
BogoMIPS                : 194.04
wait instruction        : no
microsecond timers      : yes
tlb_entries             : 64
extra interrupt vector  : no
hardware watchpoint     : yes
ASEs implemented        :
shadow register sets    : 1
VCED exceptions         : not available
VCEI exceptions         : not available

flo@ip28:~$ uptime
 19:49:15 up 4 days,  9:09,  2 users,  load average: 0.00, 0.00, 0.00
flo@ip28:~$ uname -a
Linux ip28 2.6.24-rc5-g8b3ba06b-dirty #21 Tue Dec 18 12:48:29 CET 2007 mips=
64 GNU/Linux
flo@ip28:~$ cat /proc/interrupts=20
           CPU0      =20
  0:          1          XT-PIC  timer
  2:          0          XT-PIC  cascade
 18:          0            MIPS  local0 cascade
 19:          0            MIPS  local1 cascade
 22:          1            MIPS  Bus Error
 23:   94680570            MIPS  timer
 25:    3863916    IP22 local 0  SGI WD93
 26:          7    IP22 local 0  SGI WD93
 27:     677582    IP22 local 0  SGI Seeq8003
 31:          0    IP22 local 0  mapable0 cascade
 33:          0    IP22 local 1  Front Panel
 43:          1    IP22 local 2  EISA
 44:          5    IP22 local 2  i8042, i8042
 45:    6462546    IP22 local 2  IP22-Zilog

ERR:          0

The maschine successfully compiled multiple gcc version and had no hickups
so far ...

Peter and Thomas did great work ....

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
          security shall soon have neither - Benjamin Franklin

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHbr0CUaz2rXW+gJcRAop2AKCuNMfz+1N8CeFPui/169qNTg5ZdgCfVyoo
xCwssQKevt24/Oj3ehEK1ic=
=Or13
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
