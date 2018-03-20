Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2018 01:33:06 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43558 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992521AbeCTAc6rbx8m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Mar 2018 01:32:58 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1ey5Cy-0004Xs-DN; Tue, 20 Mar 2018 00:32:56 +0000
Received: from ben by deadeye with local (Exim 4.90_1)
        (envelope-from <ben@decadent.org.uk>)
        id 1ey5Ct-0004em-6g; Tue, 20 Mar 2018 00:32:51 +0000
Message-ID: <1521505970.2495.200.camel@decadent.org.uk>
Subject: Re: 3.16.55-stable breaks yeeloong
From:   Ben Hutchings <ben@decadent.org.uk>
To:     "Maciej W. Rozycki" <macro@mips.com>
Cc:     Alexandre Oliva <lxoliva@fsfla.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Date:   Tue, 20 Mar 2018 00:32:50 +0000
In-Reply-To: <alpine.DEB.2.00.1803192231480.2163@tp.orcam.me.uk>
References: <ortvtd4gxf.fsf@lxoliva.fsfla.org>
         <1521416975.2495.186.camel@decadent.org.uk>
         <alpine.DEB.2.00.1803190706520.2163@tp.orcam.me.uk>
         <alpine.DEB.2.00.1803192231480.2163@tp.orcam.me.uk>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-v71KHwec3WB5/5ifZ3jb"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63068
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


--=-v71KHwec3WB5/5ifZ3jb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-03-19 at 22:52 +0000, Maciej W. Rozycki wrote:
> On Mon, 19 Mar 2018, Maciej W. Rozycki wrote:
>=20
> > > > Commit 304acb717e5b67cf56f05bc5b21123758e1f7ea0 AKA
> > > > https://patchwork.linux-mips.org/patch/9705/ was backported to 3.16=
.55
> > > > stable as 8605aa2fea28c0485aeb60c114a9d52df1455915 and I'm afraid i=
t
> > > > causes yeeloongs to fail to boot up.  3.16.54 was fine; bisection t=
ook
> > > > me to this patch.
>=20
> [...]
> > > Guenter Roeck reported the same problem on QEMU Malta emulation.
> > > I haven't yet ivnestigated why this causes breakage.  I will aim to f=
ix
> > > this in the next update (will be 3.16.57 now), if necessary by
> > > reverting that and whatever depends on it.
> >=20
> >  I'll see if I can trigger it with my development setup and investigate=
.
>=20
>  OK, I have been able to reproduce the crash and I can see what is going=
=20
> on here: the backport didn't take into account a change from `break' to=
=20
> `goto out' required for code in `do_cpu' in that old version and=20
> consequently `force_sig(SIGILL, current)' is reached whenever the first=
=20
> FPU instruction is executed on hard-float hardware, with obvious=20
> consequences.
>=20
>  Rather than messing with commit 304acb717e5b ("MIPS: Set `si_code' for=
=20
> SIGFPE signals sent from emulation too") though, I suggest cherry-picking=
=20
> commit 27e28e8ec47a ("MIPS: Normalise code flow in the CpU exception=20
> handler"), which was in the original series and which I have verified to=
=20
> remove the crash.  I believe it is obvious enough to be considered safe t=
o=20
> backport.

I started looking at this today and also found that commit, but hadn't
tested it yet.  Thanks for confirming.

Ben.

>  Please let me know if you need anything else from me.
>=20
>   Maciej
--=20
Ben Hutchings
Time is nature's way of making sure that
everything doesn't happen at once.


--=-v71KHwec3WB5/5ifZ3jb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlqwVrIACgkQ57/I7JWG
EQnQjQ//Whtq6fhxxsOTEAisAl45Rk/n9VwQzJa4Xk5n+Ek4iFWvwQ4XztQFv4vv
kSzc4gk7Qi3svwkmDyVTxMxAI5kBq20VLPiuM1JLXu/8P2hwHjXIGEEL2Rwg9z1/
TgevfSmBdFoK8N4hGo/IuhxcTGROcUYXaIYF55Lj2bnZbUsuRHVICCIu7jkazFFu
1HkMnWAp2/LEqIq8ZrHgi0IotY+T+FqFirScZyWQMUxlARBwU811dgXUiMaQfc8k
dv09WodONIl9BZXkx7c7Ww3//FmFEtHYdsGvRQGphhk6P5Dh252HPK1EODJhZAW/
gFWXLp7kv9MkSNMmxtCXhaIqGMDVsCYUp5V1PaleUJq6/VZO4MSlEpSzKU+YNZKQ
5L8ZiDqulS0ROP2uXiJ75wCpJ4Ngknt/VK8AwHvkSAiEOkK9Lmd2KA79nw5O3HN5
FEONg3+1gp1Ib6s546FYQSsmg0JM4l4qB1cFxhSckC0fzEmMHXwJs5FgsFN9o90b
Fvmq6dePWxO5E0S3V468BOzAFXifXAaBNzQUbF6FDOR260N9ryPmJhP8a4yk9SFF
adqLhdQxvDOvQ8s32wvZrMW+z6auL5++Ul0Q5q4Zfe+n0vnZ5kRySbl+uRWps65m
hXtK2dHvfpBIFJSUnUETOI9ZoXIRr37hI/XXduOEzfhWi4ozLiY=
=N0/B
-----END PGP SIGNATURE-----

--=-v71KHwec3WB5/5ifZ3jb--
