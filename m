Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Nov 2016 17:14:49 +0100 (CET)
Received: from mail.lysator.liu.se ([130.236.254.3]:50460 "EHLO
        mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993187AbcKAQOmUYZNY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Nov 2016 17:14:42 +0100
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
        by mail.lysator.liu.se (Postfix) with ESMTP id 960754003D;
        Tue,  1 Nov 2016 17:14:41 +0100 (CET)
Received: from zarathustra.unixrus.se (c83-250-85-64.bredband.comhem.se [83.250.85.64])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.lysator.liu.se (Postfix) with ESMTPSA id 3E3D54000A;
        Tue,  1 Nov 2016 17:14:40 +0100 (CET)
Subject: Re: System clock going slow/fast with ntpdate
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: multipart/signed; boundary="Apple-Mail=_99079E4C-67E1-47C0-B375-628F1A962178"; protocol="application/pgp-signature"; micalg=pgp-sha1
X-Pgp-Agent: GPGMail 2.5.2
From:   Markus Gothe <nietzsche@lysator.liu.se>
In-Reply-To: <20161026085306.M18729@cdot.in>
Date:   Tue, 1 Nov 2016 17:14:35 +0100
Sendlaterdate: Tue, 1 Nov 2016 17:14:35 +0100
Message-Id: <012925E3-E06F-413D-BBD4-9BF40F0F08A7@lysator.liu.se>
References: <20161026081208.M10605@cdot.in> <20161026085306.M18729@cdot.in>
To:     Deepak Gaur <dgaur@cdot.in>, linux-mips@linux-mips.org
X-Mailer: Apple Mail (2.1878.6)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <nietzsche@lysator.liu.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nietzsche@lysator.liu.se
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips


--Apple-Mail=_99079E4C-67E1-47C0-B375-628F1A962178
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

You should calculate your boards time drift and compensate for it.

//Markus - The panama-hat hacker

On 26 Oct 2016, at 10:55 , Deepak Gaur <dgaur@cdot.in> wrote:

> Hello,
>=20
> I have board with MIPS 34Kc processor and linux-2.6.29 with =
CONFIG_HZ_250=3Dy set in kernel configuration (i.e 250 timer
> interrupts per 1 real second in /proc/interrupts). When I try to =
synchronize time using ntpdate command, the time gets
> synchronized. This resync is being done every 5 min using cron. The =
clocksource is set to jiffies and is the only source
> available. After some time (1 hr and more) the system clock =
(kernel/software) sometimes starts slowing down and sometime
> goes fast. System time increments very slowly i.e 1 sec on system =
takes 8-9 real seconds (as per wrist watch) or fast 2
> sec in 1 real second.
>=20
> #date
> Tue Oct 25 15:14:05 IST 2016
> # date
> Tue Oct 25 15:14:05 IST 2016
> # date
> Tue Oct 25 15:14:05 IST 2016
> # date
> Tue Oct 25 15:14:05 IST 2016
> # date
> Tue Oct 25 15:14:05 IST 2016
> # date
> Tue Oct 25 15:14:05 IST 2016
> # date
> Tue Oct 25 15:14:05 IST 2016
> # date
> Tue Oct 25 15:14:05 IST 2016
> # date
> Tue Oct 25 15:14:05 IST 2016
> # date
> Tue Oct 25 15:14:06 IST 2016
> # date
> Tue Oct 25 15:14:06 IST 2016
>=20
> (It took 10 date commands to increment from 14:05 to 15:06)
>=20
> On further analysing the system we found the number of timer =
interrupts in /proc/interrupts has actually gone down from
> 250 to 40 every 1 real second
>=20
> (1) Normal Operation 10 real sec watch window
>=20
> cat /proc/interrupts
>=20
> Start of timer  MIPS timer intr count 3856633
> End of Timer   MIPS timer intr count 3859268
>=20
> Timing approximately 10-11 real sec, the interrupts are 263 per sec.
>=20
> (2) Clock Slow (Less Timer Interrupts)
> After ntpdate run for 1 hr once per 5 min
>=20
> cat /proc/interrupts
>=20
> Start of timer  MIPS timer intr count 985072
> End of Timer   MIPS timer intr count 985492
>=20
> 985492 - 985072 =3D 420 in 10 sec (real) =3D 42 in 1 sec
>=20
> (3) Fast Clock with ntpdate (More Timer interrupts)
>=20
> Start of timer  MIPS timer intr count 4068301
> End of Timer   MIPS timer intr count 4073411
> 985492 - 985072 =3D 5110 in 10 sec (real) =3D 511 in 1 real sec
>=20
> ntpdate uses ntp_adjtime()/adjtimex() GNU libc system call for =
changing system clock and can change it but by a very
> small amount.
>=20
> But the issue is it is changing system clock so much that other =
application have started behaving erratically, timers
> are not expiring in required time etc.. and once the system clock has =
slowed down/fast it remains in that state.
>=20
> # cat =
/sys/devices/system/clocksource/clocksource0/available_clocksource
> jiffies
>=20
> # cat /sys/devices/system/clocksource/clocksource0/current_clocksource
> jiffies
>=20
> We are using gcc version 4.5.2  and gnu libc
>=20
> Please help me in understanding this behaviour of NTP with MIPS Linux =
and possible fixes if any. Is it a kernel bug or a
> configuration issue?
>=20
> regards,
>=20
> Deepak Gaur
>=20
>=20


--Apple-Mail=_99079E4C-67E1-47C0-B375-628F1A962178
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.28

iD8DBQFYGL9v6I0XmJx2NrwRAkrqAKCvCD8dmfYKSpw3jeboUQ5FSecUDwCgpoBA
NU9yEcRGeyE9FbyAP2Z6b34=
=mY3p
-----END PGP SIGNATURE-----

--Apple-Mail=_99079E4C-67E1-47C0-B375-628F1A962178--
