Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Nov 2016 19:37:14 +0100 (CET)
Received: from www.zeus03.de ([194.117.254.33]:55414 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992836AbcK2ShIHzsRq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Nov 2016 19:37:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=e2KG2gWtFTXNbQ9S/lXBbboVue9v
        b2H8IVexz+MpRLM=; b=yw0xa4MkBnl3ZpP85U918IzRhEdyj0cV5F/VVlvo3Mfn
        Zvyg6cXBYHt6aysumTXuqQlbzZsPmnczEhgoS8TqdJOgPdliWovIpeanxppE7kSu
        oW4vUybjjOWx7cbiZrNFxW3HqFTl+gZql8+wJpK69x+jnmNjeSSkI3s7/FiIIz8=
Received: (qmail 30983 invoked from network); 29 Nov 2016 19:37:07 +0100
Received: from p5b385032.dip0.t-ipconnect.de (HELO localhost) (l3s3148p1@91.56.80.50)
  by mail.zeus03.de with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted, authenticated); 29 Nov 2016 19:37:07 +0100
Date:   Tue, 29 Nov 2016 19:37:07 +0100
From:   Wolfram Sang <wsa-dev@sang-engineering.com>
To:     "Steven J. Hill" <Steven.Hill@cavium.com>
Cc:     Jan Glauber <jan.glauber@caviumnetworks.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-mips@linux-mips.org, Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v2 0/3] i2c: octeon: thunder: Fix i2c not working on
 Octeon
Message-ID: <20161129183707.GA3378@katana>
References: <1479149445-4663-1-git-send-email-jglauber@cavium.com>
 <99500824-4c63-b769-ad66-c136529b14b2@cavium.com>
 <20161122120106.GB3993@katana>
 <20161122145539.GA7716@hardcore>
 <20161128142208.GA3916@katana>
 <20161129091928.GB29487@hardcore>
 <52c6e31e-9351-fa26-aefe-4f1415324adf@cavium.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <52c6e31e-9351-fa26-aefe-4f1415324adf@cavium.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <wsa-dev@sang-engineering.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55909
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wsa-dev@sang-engineering.com
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


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 29, 2016 at 12:22:34PM -0600, Steven J. Hill wrote:
> On 11/29/2016 03:19 AM, Jan Glauber wrote:
> >=20
> > if possible we should at least revert commit 70121f7f3725. I should get
> > access to an Octeon 71xx board tomorrow, but I'm afraid we'll miss the
> > deadline for a well tested fix that works across all machines.
> >=20
> I second Jan's advice. Please revert the commit and we'll have the
> fix for the next release.

Okay, I will pick up patch 1/3 from Jan (the revert) and read your
comment above as an ack. Paul, is your tested-by still valid?

Thanks,

   Wolfram


--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYPcrTAAoJEBQN5MwUoCm2ctsP/iIjGn6MWF0c380QWx8moelM
nNH5QcAmWc9jCLTZmOjis6GrjJurDh2H3OyzUbNqhbmDOjiR4olK8PAY+W+nSP1N
J7wULS2Nxzh/ntqfbb6C+hwMAKY9Pnmads5WDwXE/8dvg9dDvK5KJ3sJbWLsuKcL
c1GUrYjv17HoYXA6BA/cGISQlRz1M12qGhAN4a/uYmh26reBKtJ9RvuZ4ArmXDE2
WwWLHWbFnStbZfd7Yj+7TWVF1YiW7ihyOsZ+0vICqF2HAdwnSEvOyU3nSRPwKjJk
pqsvC5+xW5YJG6V2q1FODF3pulOA0HuguNlHx6u2f6NUyC03LN7mUAkj5MJI6leY
h1hrZUcyWIDRcNS/r8ZzqRTioALm06rAZ2T6vH10ni7CiFOn7uttjR/wIZi2ewjl
NvrPTWaLHEayGHQRRGYiEmryfwhMyAHrc3RwMYdIXn1d1KkAITbtOXv3YWH1SpRt
LHFNS/ZrJKREZUs/RVL2SCZDJUvHVtKrSfpcwDxg+RJ0rNbRx+U8LGdrScpI9noE
WOPmQrZA90VRPPhcqnSq4QQ+ow+M3peww4XaFbN14qE0ixLw6nV4AwDR7n+qyEZI
gKaA5sMv6tA7YHOUT1++wXu8USOkj4uf4lw9CLb7+y+dSjQ10FTIQN6D+GtC50WZ
RHIHRpOT3bH2n2Hf9d+Q
=lhs7
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
