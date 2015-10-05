Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Oct 2015 13:31:15 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41158 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008795AbbJELbOB825V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Oct 2015 13:31:14 +0200
Received: from deadeye.wl.decadent.org.uk ([192.168.4.247] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84)
        (envelope-from <ben@decadent.org.uk>)
        id 1Zj3z6-0002z7-L2; Mon, 05 Oct 2015 12:31:12 +0100
Received: from ben by deadeye with local (Exim 4.86)
        (envelope-from <ben@decadent.org.uk>)
        id 1Zj3z0-0000yr-R5; Mon, 05 Oct 2015 12:31:06 +0100
Message-ID: <1444044661.2730.286.camel@decadent.org.uk>
Subject: Re: [PATCH] MIPS: BPF: Disable JIT on R3000 (MIPS-I)
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Date:   Mon, 05 Oct 2015 12:31:01 +0100
In-Reply-To: <20151005092440.GA1389@linux-mips.org>
References: <1441481368.15927.0.camel@decadent.org.uk>
         <20151005092440.GA1389@linux-mips.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-Nw51Tpi/5x6VF1ON00Ci"
X-Mailer: Evolution 3.16.5-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.247
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49435
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


--=-Nw51Tpi/5x6VF1ON00Ci
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2015-10-05 at 11:24 +0200, Ralf Baechle wrote:
> On Sat, Sep 05, 2015 at 08:29:28PM +0100, Ben Hutchings wrote:
>=20
> > The JIT does not include the load delay slots required by MIPS-I
> > processors.
>=20
> See 0c5d187828588dd1b36cb93b4481a8db467ef3e8 (MIPS: BPF: Fix load delay
> slots.) for a proper fix.

How about all the inlined loads (emit_load, emit_load_byte,
emit_half_load)?

> I'm wondering, how did you find this issue, are you scanning the code
> for broken instruction sequences?

No, I was already looking at the BPF JIT implementation for some other
reason.

Ben.

--=20
Ben Hutchings
compatible: Gracefully accepts erroneous data from any source
--=-Nw51Tpi/5x6VF1ON00Ci
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUAVhJfdee/yOyVhhEJAQpW4hAAnS8WCtTHy5iUEn9OFPG8jK6BbUQ1xRkY
mun5I1IFUJcxq0FPbpcMbc2C8X7lpjziIYZB4z9A5qrdqbu7rUBJSsCGW2/9uE7G
ueVt8UalMcJt2MobidK+mcOROytJDQQa3BZauiZTjtX9hZWFjlonjNCe7Cn3fRju
I36tVt4mR/VvaVXwT3KODQ6MN7xa6D8fN4JBBIzHa0qAKVNffegJrHDGJkTdp12Y
gkaeNEwp7CqV5DY962agooG6pN3G77piX9fkfwAb6QhL9Cexn82IKMlA8POHAtiR
HlKpXNwW1vVe8F1WgumP3PSKkRC8desh1SqmFNObgUyVgNPlD2XKjvYb/mua51Zm
KqpeYd494niN7Z7waVfo3j03jt/amW17qmj8BfK+nVV0jShT9YLBYqdCUhdHxlsM
20ARZdhwQ4t2xdqAx/JBZc+5nThj8aybQ85pIq6lb1+Dn28sRr5Zpsr+JJEN247S
zGCfyTCBPsgeUEzmaIVP4OWe7BIUKlZo8dkxD2vL/g7K8VsUP9VrQv8pyfqxrCGl
2r7REktD0kDQkamAEv0qIkpEkj+XZn8CrLlesJUFNDJ5rYQ0itLPADPsAbRdJQRL
wC6xZf3z2M1e16NbPsDTAkL+9i2QAR+o2QBIAFMae/iVQ0PlNEbol9/G2CuGt7cE
Tykcz0njfJY=
=0Kpy
-----END PGP SIGNATURE-----

--=-Nw51Tpi/5x6VF1ON00Ci--
