Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jun 2004 11:39:05 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:41940 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225717AbUFOKjA>; Tue, 15 Jun 2004 11:39:00 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 4AC564B770; Tue, 15 Jun 2004 12:38:59 +0200 (CEST)
Date: Tue, 15 Jun 2004 12:38:59 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: "No such device" with PCI card
Message-ID: <20040615103859.GC20632@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <40CEBB36.1030707@kilimandjaro.dyndns.org> <20040615102708.42219.qmail@web16604.mail.tpe.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bSFom/N6fjApd2mh"
Content-Disposition: inline
In-Reply-To: <20040615102708.42219.qmail@web16604.mail.tpe.yahoo.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--bSFom/N6fjApd2mh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-06-15 18:27:08 +0800, jospehchan <jospehchan@yahoo.com.tw>
wrote in message <20040615102708.42219.qmail@web16604.mail.tpe.yahoo.com>:
> Hi Dominique,
> Thanks for your suggestion and help.
> I've tried my VIA VT6212L USB2.0 PCI card on other
> Linux system(x86 based) (RedHat 7.2 + kernel 2.4.16).=20
> And it works fine under kernel 2.4.16 with an USB
> patch from kernel 2.4.26.
> So I migrated the system to MIPS, but I was stuck by
> this problem.
> Altough I'm not familiar with device driver, but I
> will try Jan-Benedict's suggestion.

Before I get mixed up by pure confusion, let's put all the facts on the
table:

- What kind of MIPS system do you use *exactly*? What board? Which
  kernel version? From where did you get your sources.

  Some hint right here:
  	- If this isn't a very current 2.6.x CVS checkout from
	  linux-mips.org, you'd consider getting that. I won't recommend
	  anything else (possibly MVista has better ported kernels for
	  some specific boards?).

- A USB2.0 card is IMHO driven by the ehci driver, but I may be wrong.
  I'm not exactly a regular USB user...

- Do you have output of "lspci", "lspci -v", "lspci -n", "lspci -vn" and
  "lspci -nxxx" at your hand, once from your i386 test machine, once
  from the MIPS board? Right, those commands mostly give the same
  output, but each style eases reading for specific values:)

- Does your MOPS board have working on-board PCI devices? These don't
  neccessarily have a PCI plug as you know them from add-on cards,
  because they're directly built into the chipset. For instance, does
  your board have onboard IDE interfaces?

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--bSFom/N6fjApd2mh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAztHDHb1edYOZ4bsRAkMoAKCRxdfj831z8SQLRzPCtl4np0H64ACfZHhR
GmgNbgLmZqfMOCDb0fIcbdA=
=zuj2
-----END PGP SIGNATURE-----

--bSFom/N6fjApd2mh--
