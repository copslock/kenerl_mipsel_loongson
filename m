Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5FDVrj17198
	for linux-mips-outgoing; Fri, 15 Jun 2001 06:31:53 -0700
Received: from air.lug-owl.de (air.lug-owl.de [62.52.24.190])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5FDVpk17195
	for <linux-mips@oss.sgi.com>; Fri, 15 Jun 2001 06:31:51 -0700
Received: by air.lug-owl.de (Postfix, from userid 1000)
	id 348C37C14; Fri, 15 Jun 2001 15:31:49 +0200 (CEST)
Date: Fri, 15 Jun 2001 15:31:48 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@oss.sgi.com
Subject: Re: Newbie question...
Message-ID: <20010615153147.A7621@lug-owl.de>
Mail-Followup-To: linux-mips@oss.sgi.com
References: <20010613081435.A722@foobazco.org> <p05001901b74d8f7fb72c@[192.168.1.3]>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <p05001901b74d8f7fb72c@[192.168.1.3]>; from mjpento@mediaone.net on Wed, Jun 13, 2001 at 05:50:06PM -0400
X-Operating-System: Linux air 2.4.2 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2001 at 05:50:06PM -0400, mjpento wrote:
[Indigo R3000]

> 1. Is there someone out there working on a port to the R3000's=20
> Indigo's? If so, does someone know who it is or a link to a=20
> website??? etc ...

Rumor was that Michael Engel was working on the Indigo. I've got
such a beast as well (okay, it's an OEM version build by Siemens
Nixdorf), but there's no Linux running on this box these days.

=46rom what I've heared, the Indigo R3k is quite different to most
other supported machines (Indy, Indigo2) so a port will be
somewhat difficult. The machine isn't the fastest one (well,=20
mine is running wirh Irix 5.2 and the flight simulator is quite nice
to play with:-), but it *would* be more then fast enough to run
Linux.

> 2. Since I am rather new to porting, is there a resource that you=20
> folks would suggest out there on the internet that would be a good=20
> starting point for information or tips on the best porting methods?

Porting Linux to Indigo R3k is difficult. There seems to be no
hardware documentation available (except Irix header files). So
porting will be a means of reading header files, using an oscilloscope
and disassembline Irix' kernel.=20

> Any help would be greatly appreciated,

I'd really *love* to see Linux running on Indigo R3k, but I'm not
experienced enough to do the port. However, I'd like to help and
cooperate with more experienced programmers to make it running, but
they're more or less fixed to their bigger^Wfaster machines...

Michael, have you had any success with your Indigo R3k?

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-172-7608481 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjsqDkIACgkQHb1edYOZ4buQSACeMml7MtVmlNGAymlnsN7wpBB2
5m0An3eBrarbfwfSk3evQrBvJfWq/rk/
=fCKh
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
