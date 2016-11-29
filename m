Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Nov 2016 20:14:50 +0100 (CET)
Received: from www.zeus03.de ([194.117.254.33]:46992 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993211AbcK2TOoTBGgq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Nov 2016 20:14:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=MR6fmW8iBV+LxM63rHSf7teHyUXg
        DE2VabBtrY05/n8=; b=iyjjY4aqF8FcsXUnkPo66fj9fkSztaGsKC9xUnUL7MsS
        96rM11MU8aEPh/8dUkfwUerIkC9Rjak0nBAstQhpnLYat+EZEBe/8AM1QFhvpQQc
        yIa8RsMsRr9dkcawxwDNaU3VWLi0g7++uMYvYwQUL4ALkJaJqP39gtdds2+SKHE=
Received: (qmail 6795 invoked from network); 29 Nov 2016 20:14:43 +0100
Received: from p5b385032.dip0.t-ipconnect.de (HELO localhost) (l3s3148p1@91.56.80.50)
  by mail.zeus03.de with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted, authenticated); 29 Nov 2016 20:14:43 +0100
Date:   Tue, 29 Nov 2016 20:14:43 +0100
From:   Wolfram Sang <wsa-dev@sang-engineering.com>
To:     "Steven J. Hill" <Steven.Hill@cavium.com>
Cc:     Jan Glauber <jan.glauber@caviumnetworks.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-mips@linux-mips.org, Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v2 0/3] i2c: octeon: thunder: Fix i2c not working on
 Octeon
Message-ID: <20161129191443.GA10865@katana>
References: <1479149445-4663-1-git-send-email-jglauber@cavium.com>
 <99500824-4c63-b769-ad66-c136529b14b2@cavium.com>
 <20161122120106.GB3993@katana>
 <20161122145539.GA7716@hardcore>
 <20161128142208.GA3916@katana>
 <20161129091928.GB29487@hardcore>
 <52c6e31e-9351-fa26-aefe-4f1415324adf@cavium.com>
 <20161129183707.GA3378@katana>
 <6237fab7-fc5f-90fd-a652-b304f2a21a43@cavium.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <6237fab7-fc5f-90fd-a652-b304f2a21a43@cavium.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <wsa-dev@sang-engineering.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55911
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


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 29, 2016 at 01:10:30PM -0600, Steven J. Hill wrote:
> On 11/29/2016 12:37 PM, Wolfram Sang wrote:
> >=20
> > Okay, I will pick up patch 1/3 from Jan (the revert) and read your
> > comment above as an ack. Paul, is your tested-by still valid?
> >=20
> Just to be explicitly clear, the patch revert allows I2C on OCTEON
> to work again. I apologize if that was not clear.

Partly. It was not clear to me if only patch 1 was enough to get Paul's
system to boot again or if it needed all 3 patches to do that.

Anyway, the revert will be in v4.9 for sure.


--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYPdOjAAoJEBQN5MwUoCm23ecP/1va52BJ4rP+72Z7Z9T6iyuf
imp66pUfLwWAlAE++WHGOJHKqrLgLC11CblAdHmfkZx9FQkuR4cBpWqfE578C5AN
44fUgILfytIS8LzVup4ZvHIitEWWXo7XJVyvRBmhANEuAGGT+AnVDyVuzvmjh9pw
g80BLLcLQs+8Ev6hZpx81W/ld8kUy9Nfr91YA1N3fvc1OzcNj0kihdFy3Irk+ZhJ
dvlD/vS2KeBzpeYYZUNjrExK3oWlgFLOIbiXVhtgw5s/nobIj+Qe7BWL+LB86b8i
PyAheQKH6ZqIdZolrM3a6mYVqlzjuI9XGGN+A8E4GBgY3wBUAxxwN14/ouYipR76
kXatNIvl+1Fj5aE+/tnRa5mPHzodudkNMlQQTC6LBaZBjlwUlQnEm/iP6/4VdpvD
lY9M1dktDHQnrqFrgAxucWYNznZsLR2X940CfxdX1e8S3AvApIrVlWlx+ONmYFKc
lNHDIRv1xtspgNt5wZxNwyYKqexfSOc6uaSzmXZF68FP4WBnfChCyl5kImR1RHLC
LdFg6nWHvPARUcBB6+dsACsZSCI6eW5pybbTVIFj+AthTpcN8RkvP1Z+WT7TJC7h
kkutl2p+uU/f2SoAyW5ih6qDr7ao1KmlA9phO+Xay9g8aZq6vRtyeEW4oCzt+iQk
T6BK5pW+3Tl0TZRASj00
=aGC6
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
