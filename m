Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2015 20:39:23 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:34444 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011901AbbASTjUcsHSM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Jan 2015 20:39:20 +0100
Received: from p4fe24a52.dip0.t-ipconnect.de ([79.226.74.82]:60498 helo=localhost)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1YDIAO-0002NU-7J; Mon, 19 Jan 2015 20:39:16 +0100
Date:   Mon, 19 Jan 2015 20:39:15 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: drop ancient protection against sysfs refcounting
 issues
Message-ID: <20150119193915.GA9969@katana>
References: <1421693756-12917-1-git-send-email-wsa@the-dreams.de>
 <20150119191210.GE26493@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <20150119191210.GE26493@n2100.arm.linux.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wsa@the-dreams.de
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


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2015 at 07:12:10PM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 19, 2015 at 07:55:56PM +0100, Wolfram Sang wrote:
> > Back in the days, sysfs seemed to have refcounting issues and subsystems
> > needed a completion to be safe. This is not the case anymore, so I2C can
> > get rid of this code. There is noone else besides I2C doing something
> > like this currently (checked with the attached coccinelle script which
> > checks if a release function exists and if it contains a completion).
>=20
> Have you validated this with DEBUG_KOBJECT_RELEASE enabled?

You saved me, thank you a lot for this pointer! Patch discarded.

I assume other subsystems also moved away from 'struct device_type' for
the release function as well; but this is just a guess for now and I'll
call it a day for today.


--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUvV1iAAoJEBQN5MwUoCm27koP/jPOmSfj8D5Vt7pOnePBcVts
w0FiFCQ7XSQufLhPQ3CXTjWRGriI5YNnxBfwCZygwglKQybEinzTW7H+unFlJmrd
ZRRDJ1gOKjGcU2SktuwIW5Ljs695M52oTDTP1IwXnPFndv27ZhkN0gRCh04v2yJl
rKuC7aGZEdvZLqHR8FIbvmNrkk5kALwav2tVKRG8jw1GK+3me2qsblnAOHhfbaUx
1wiuQJ98pIZV0EqESLkn0M/99r5iGO51Yt8GPNkR0HoTP8uEWQi5yLPIhPWstZz6
jCF9d9jGBy5FIBvii+b0etdxqforhls3YdK0W0DupkYtcaDqXTkwt1KrWjCerEYC
CWBsfgAnN5oNAqvG9inleH5TK/gHba8+WLFIpDJ17Ok0137++Qsi3TdgMuuXUQni
Y1XD9Srt3vvmEi4zQJi6WaJoxYII1QACKIZBtv3ak+gRVw+TgCpMVLaufYiDP49b
jmH1I/jZA39wQOd+8fx63pkxwTQEAx1DsBhiTGqRKSAMYMA/zZ6hTeEMbzTDVFm3
jf0NKx2nwjzwlb4cH17y/CfDxgRYEHwomwkqzgR0V0AYCONy+4xmCJNjQd4inV0n
/hRjiyqIyNRO2lFmtmByuK5xN2hI7UdpL6N1jrKbvaLBFyU84ZD8Kwvw5YAYNzvb
bIszLmjrWtbH4Rq4ARDz
=IGop
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
