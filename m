Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Oct 2017 20:12:31 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40746 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992297AbdJHSMZPs7GU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 Oct 2017 20:12:25 +0200
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1e1G3m-0000pt-QJ; Sun, 08 Oct 2017 19:12:18 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1e1G3h-0002A3-Fg; Sun, 08 Oct 2017 19:12:13 +0100
Message-ID: <1507486329.2677.81.camel@decadent.org.uk>
Subject: Re: Building older mips kernels with different versions of
 binutils; possible patch for 3.2 and 3.4
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Guenter Roeck <linux@roeck-us.net>,
        stable <stable@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Li Zefan <lizefan@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Sun, 08 Oct 2017 19:12:09 +0100
In-Reply-To: <573936E3.3050003@roeck-us.net>
References: <573936E3.3050003@roeck-us.net>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-H9IjW9ISzbg7+2/mgQnr"
X-Mailer: Evolution 3.26.0-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60321
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


--=-H9IjW9ISzbg7+2/mgQnr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2016-05-15 at 19:56 -0700, Guenter Roeck wrote:
[...]
> For 3.4 and 3.2 kernels to build with binutils v2.24, it would be necessa=
ry to
> apply patch c02263063362 ("MIPS: Refactor 'clear_page' and 'copy_page' fu=
nctions").
> It applies cleanly to 3.4, but has a Makefile conflict in 3.2. It might
> make sense to apply this patch to both releases. Would this be possible ?
> This way, we would have at least one toolchain which can build all 3.2+ k=
ernels.

I'm finally queueing this up for 3.2.

Ben.

--=20
Ben Hutchings
compatible: Gracefully accepts erroneous data from any source


--=-H9IjW9ISzbg7+2/mgQnr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlnaankACgkQ57/I7JWG
EQkrgw//QsAb46hDvO6uu8EtWEYNt+KgxKph8lQx7jbCxrqJcmlHJwYm5a+cAXY2
xa33lljJ0Wk5OpBz90WUxsZlzDW1p3t2KRLUKgDJ3BWSwReEYLSWPIFiVj2OUZZ8
HQIi2fPL1bn9qzJC1GUkb1MFn05pns3KksOndhz8XHaQT40cvfgIPMBr/9V5asic
hzeSWOiWXENRlLfwuJFesgA6a4FLWtKo5CMXmu+2kccUd+gQt7XnpJdBIjDX85wj
vt/BrzcQLSLrrEeDYKdy/BNILzZrfefAZBw25uQ+MkyhIylGzKf5GcZrxzecJLPh
2ykZ5khr2QT9GszYtCJd+AKYVqya34ubPqbmWA5LjOzyHn5f3WPOVLkVaIZg592H
MkCUIc7BQZ5MXt+sgoB/TOA5sqtLmQ9rp0g1bZHCESPvz4k46EhW66tRGVkeGLkE
U7wh7cf3PooqJkTXinaquOk5U1M6oF4yOiH2pAdj1gMI9rCA7uBdwMf3QjOfPdS9
o3U/E9RUNMd4FeX2chyjwwd3AxgrqylsLPs3J5YGjKH+vwFaTOdXfMvULep1oBfb
c6bwA8t428vHhUSzHAfQGWrZ4Ik7LhD+5OHccMbu6YA+7HcH19fTi2hx0/10Wt5G
O2ljIYIcf2XwLhoQXjJOHIx6kureRFPNdwXr/4hKFSN7URjExwY=
=xE39
-----END PGP SIGNATURE-----

--=-H9IjW9ISzbg7+2/mgQnr--
