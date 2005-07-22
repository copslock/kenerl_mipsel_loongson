Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2005 16:23:41 +0100 (BST)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:11656 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8225313AbVGVPXW>;
	Fri, 22 Jul 2005 16:23:22 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j6MFPPgo006043;
	Fri, 22 Jul 2005 11:25:25 -0400
Received: from pobox.hsv.redhat.com (pobox.hsv.redhat.com [172.16.16.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j6MFPPV16141;
	Fri, 22 Jul 2005 11:25:25 -0400
Received: from riff.hsv.redhat.com (riff.hsv.redhat.com [172.16.16.120])
	by pobox.hsv.redhat.com (8.12.8/8.12.8) with ESMTP id j6MFPOJG016756;
	Fri, 22 Jul 2005 11:25:24 -0400
Subject: Re: Battery status
From:	Clark Williams <williams@redhat.com>
To:	Rodolfo Giometti <giometti@linux.it>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20050722151402.GG21044@enneenne.com>
References: <20050722142205.GE21044@enneenne.com>
	 <1122044036.10743.5.camel@riff>  <20050722151402.GG21044@enneenne.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YOeFsgUgCDVl8hmub3O/"
Date:	Fri, 22 Jul 2005 10:25:24 -0500
Message-Id: <1122045924.10743.16.camel@riff>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Return-Path: <williams@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: williams@redhat.com
Precedence: bulk
X-list: linux-mips


--=-YOeFsgUgCDVl8hmub3O/
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-07-22 at 17:14 +0200, Rodolfo Giometti wrote:
> On Fri, Jul 22, 2005 at 09:53:56AM -0500, Clark Williams wrote:
> > You might want to look at how acpi is presented in the /proc interface.
> > You could hook your battery status routines into the acpi entries:
> >=20
> > 	/proc/acpi/battery/BAT0/{alarm,info,status}=20
>=20
> I see... but in =ABdrivers/acpi/Kconfig=BB I notice that this driver
> depends on =ABIA64 || X86=BB. Do you think I can activate it even for MIP=
S
> arch? :-o

/me goes and actually *looks* at the acpi driver(s)

I would recommend writing a completely separate driver that just
provides the hook(s) to get to battery and any other info you want to
provide. I did it on another platform (can't seem to find that code
though) mainly to use the /proc/acpi/event interface and receive button
presses and things like that. Something like a fake-acpi.c that various
platform folks could use to translate their events into the acpi
interface.=20

That's kinda hokey now that I actually wrote it down and looked at it.
Maybe what we need to do is put together a framework somewhat like the
way acpi presents state information, but not called acpi (wouldn't want
someone thinking that we'd ported the acpi interpreter to MIPS :). I'm
not even sure if it should go into /proc or /sys.=20

I just liked the fact that the event interface and the status interfaces
were presented in somewhat logical fashion to user space, such that a
shell script could be used to gather information or manipulate the state
(e.g. 'echo 3 >/proc/acpi/sleep' to suspend to RAM).=20

Gah. Sorry, you were asking for an answer and I turned this into a
design discussion. My opinion: if you're in a hurry, write a simple
driver that presents a /proc interface to get to battery information.=20

Clark

--=20
Clark Williams <williams@redhat.com>

--=-YOeFsgUgCDVl8hmub3O/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC4Q/kHyuj/+TTEp0RAiVQAJ9VkeJn4x4FBiqm2aGBiqqufC6emQCgk/z+
Bnz1OR3KvM5pb82qTFW6/hg=
=W3Vr
-----END PGP SIGNATURE-----

--=-YOeFsgUgCDVl8hmub3O/--
