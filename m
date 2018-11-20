Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2018 18:52:11 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:46436 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991346AbeKTRwI1XXq0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Nov 2018 18:52:08 +0100
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gPABp-0006qy-9Q; Tue, 20 Nov 2018 17:51:57 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gPABp-0003q9-2G; Tue, 20 Nov 2018 17:51:57 +0000
Message-ID: <41d354185275e1043cb3cea1b68192b6733d9a9e.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 151/366] MIPS: BCM47XX: Enable 74K Core
 ExternalSync for PCIe erratum
From:   Ben Hutchings <ben@decadent.org.uk>
To:     =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Burton <paul.burton@mips.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        James Hogan <jhogan@kernel.org>,
        Tokunori Ikegami <ikegami@allied-telesis.co.jp>
Date:   Tue, 20 Nov 2018 17:51:52 +0000
In-Reply-To: <CACna6rx3LPxuYKtJOmZP-Pt-HMAhh99qHVsxVFv=XoPuJ1azbw@mail.gmail.com>
References: <lsq.1541965744.387173642@decadent.org.uk>
         <lsq.1541965745.189575243@decadent.org.uk>
         <CACna6rx3LPxuYKtJOmZP-Pt-HMAhh99qHVsxVFv=XoPuJ1azbw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-Yj6Ow3Ai7w20I1uGxoH1"
User-Agent: Evolution 3.30.1-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67405
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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


--=-Yj6Ow3Ai7w20I1uGxoH1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2018-11-11 at 21:17 +0100, Rafa=C5=82 Mi=C5=82ecki wrote:
> On Sun, 11 Nov 2018 at 21:05, Ben Hutchings <ben@decadent.org.uk> wrote:
> > 3.16.61-rc1 review patch.  If anyone has any objections, please let me =
know.
>=20
> Nack. This patch has caused a regression and had to be reverted.
> Please check upstream repository for a revert (search git log for
> 2a027b47dba6).

I've dropped this from the queue, thanks.

Ben.

--=20
Ben Hutchings
Time is nature's way of making sure that
everything doesn't happen at once.



--=-Yj6Ow3Ai7w20I1uGxoH1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlv0SbgACgkQ57/I7JWG
EQmqbxAAmsbCCoAcC55mud5vEZBf+MNx838Wp88wztHpkS9FTmFaA28MZvOiKxIF
e5+knPBk7mp5IovgpvM1v67+sUIrQzM6Sy4y3vCCjmAdNeI/BdqWlvXKfaolXRBT
4Dlp+x8uCJvCHzkWwRfetgb9U5rdT/LAw/END+Rn8UumieHCtStO6hjL2cAX/x56
xGrzbXoBDGELepudDZTqUwUg2lgEO5Sifktq4aeKmvXE/8KJPAlmIu5J4qY7/fcl
43LGez/+hZEevHhYzssEMxy/vJ+EOzYhin78NH37njIRRKYnIl7ZACKxPaRa2gpw
0lddh03MIEXs9wXo+M0EpGOXdG9aUX90iGceihC2IRb4PRnQTQxz2BGU81q6/T60
IMiybKIC58QZV6JGYkyNsla8b6yXZ8endu4/jRzOlWkRe6MbvipL2csKLALmFwdW
KLhtRtWfLaQrDnaC3pWNM+sGl9Q7/klljG+XgKgTCPWSOGYYZl3Fbq/5Rkji0d+r
CgdE5fLptlxhd7l8524oCIwNS9zgtLWRJ311wkXs94xFLLz3Ql3f50rOo6OhdQgB
Wqd4l0MByZRgTlxNrppg2JrlL3l6PpXRDg+ngDDBcA1eDdj9kNleXYVnwyuGpDHq
nuIYg7O9SiPxa5oXzKCoZaCYhvJCvG/dWayKD/cgHlEl+Y9RNgI=
=Fc2q
-----END PGP SIGNATURE-----

--=-Yj6Ow3Ai7w20I1uGxoH1--
