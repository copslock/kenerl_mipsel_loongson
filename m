Received:  by oss.sgi.com id <S42285AbQEaLAJ>;
	Wed, 31 May 2000 04:00:09 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:21115 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42286AbQEaK7y>; Wed, 31 May 2000 03:59:54 -0700
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id DAA00992; Wed, 31 May 2000 03:44:06 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id DAA16101; Wed, 31 May 2000 03:38:48 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA95300
	for linux-list;
	Wed, 31 May 2000 03:30:53 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA88718
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 31 May 2000 03:30:52 -0700 (PDT)
	mail_from (jbglaw@ev-stift-gymn.guetersloh.de)
Received: from belgarath.esg-guetersloh.mediapoint.de ([193.189.251.50]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA02325
	for <linux@cthulhu.engr.sgi.com>; Wed, 31 May 2000 03:26:16 -0700 (PDT)
	mail_from (jbglaw@ev-stift-gymn.guetersloh.de)
Received: by belgarath.esg-guetersloh.mediapoint.de (Postfix, from userid 1000)
	id 8210C51315; Wed, 31 May 2000 12:25:27 +0200 (CEST)
Date:   Wed, 31 May 2000 12:25:27 +0200
From:   Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:     Chris Ruvolo <csr6702@grace.rit.edu>
Cc:     fisher@sgi.com, linux@cthulhu.engr.sgi.com
Subject: Re: Problems booting Indigo...
Message-ID: <20000531122527.A26328@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: Chris Ruvolo <csr6702@grace.rit.edu>, fisher@sgi.com,
	linux@cthulhu.engr.sgi.com
References: <200005310410.VAA00290@hollywood.engr.sgi.com> <Pine.LNX.4.21.0005310417570.274-100000@hork>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.21.0005310417570.274-100000@hork>; from csr6702@grace.rit.edu on Wed, May 31, 2000 at 04:23:59AM -0400
X-Operating-System: Linux belgarath.esg-guetersloh.mediapoint.de 2.0.35 
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, May 31, 2000 at 04:23:59AM -0400, Chris Ruvolo wrote:
> On Tue, 30 May 2000, William Fisher wrote:
> >	Ok, I looked at the ARCS prom code for the Indy series machine
> >aka an IP22
> >	in SGI hardware speak.
> Bill,
> 	Thanks for looking this up for us.  The port 69 issue was
> speculation on our part.  I've been talking with someone that has the boot
> PROM working with tftp, and it doesn't use port 69 exclusively.  Unless
> the tftp code changed with different PROM versions, I think we can rule
> that out.

I hacked the BSD tftpd last night (-> standalone and send from #69) but
you're right. It makes no difference at all. This morning, I played with
the transceiver again -- 2 switches, 4 possibilities. Tested all, but
no success. Some two month ago I booted that Indigo over net (okay, it
crashed immediately;) but the only difference is that we used a switched
port there... It's brain-dead, but I'll fetch a switch from my old school
and test it...

MfG, JBG
PS: Is there a way to boot the linux kernel off DAT tape or from local
    HDD? If so, HowTo?

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEAREBAAYFAjk06JYACgkQHb1edYOZ4btktgCfe0MBLjRISv6mopYNGMBnB2MQ
8bcAnilGchVqUy5rdGmG59EFXvTREEaL
=QKiR
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
