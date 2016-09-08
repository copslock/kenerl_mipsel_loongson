Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Sep 2016 17:52:35 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:57442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991346AbcIHPw1cewuA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Sep 2016 17:52:27 +0200
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3518F61E5B;
        Thu,  8 Sep 2016 15:35:30 +0000 (UTC)
Received: from [10.36.112.47] (ovpn-112-47.ams2.redhat.com [10.36.112.47])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u88FZQad009262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 8 Sep 2016 11:35:28 -0400
Subject: Re: [PATCH 0/2] MIPS: KVM: Partial EVA support
To:     James Hogan <james.hogan@imgtec.com>
References: <cover.4afb9d6281172d5a66d490da41c5ea418050dcea.1473335231.git-series.james.hogan@imgtec.com>
 <5d95c50f-b9bd-49e0-9bca-71242d9d5efd@redhat.com>
 <20160908152633.GA26885@jhogan-linux.le.imgtec.org>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6783eca2-5587-3dcc-dc34-126a37594293@redhat.com>
Date:   Thu, 8 Sep 2016 17:35:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160908152633.GA26885@jhogan-linux.le.imgtec.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="h0ctV6FtoVDvEUxqCq8m3vBRlAvha1Obc"
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 08 Sep 2016 15:35:30 +0000 (UTC)
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pbonzini@redhat.com
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h0ctV6FtoVDvEUxqCq8m3vBRlAvha1Obc
Content-Type: multipart/mixed; boundary="tpeIFqc94s4JP06Lg7lMGpECmNllPpdTt";
 protected-headers="v1"
From: Paolo Bonzini <pbonzini@redhat.com>
To: James Hogan <james.hogan@imgtec.com>
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
 kvm@vger.kernel.org
Message-ID: <6783eca2-5587-3dcc-dc34-126a37594293@redhat.com>
Subject: Re: [PATCH 0/2] MIPS: KVM: Partial EVA support
References: <cover.4afb9d6281172d5a66d490da41c5ea418050dcea.1473335231.git-series.james.hogan@imgtec.com>
 <5d95c50f-b9bd-49e0-9bca-71242d9d5efd@redhat.com>
 <20160908152633.GA26885@jhogan-linux.le.imgtec.org>
In-Reply-To: <20160908152633.GA26885@jhogan-linux.le.imgtec.org>

--tpeIFqc94s4JP06Lg7lMGpECmNllPpdTt
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/09/2016 17:26, James Hogan wrote:
>> > Since there aren't any overlaps with 4.8 patches, feel free to send =
a
>> > pull request for these and any other patches you might have in the r=
est
>> > of this cycle.
> Yeh, I'd like to start working with pull requests (and topic branches
> where applicable) from now on. I'd normally still post patches to the
> lists even if I immediately apply them (I should perhaps move you from
> To to Cc), is that okay?
>=20
> Any particular times in the cycle you want pull requests, or deadlines
> for new features for the next release?

Whenever you want.  If I haven't gotten anything, at some point I'll
ping you like I do with ARM and PPC folks.

Please do get the branch added to linux-next please.  That lets me know
in advance of conflicts.

Paolo


--tpeIFqc94s4JP06Lg7lMGpECmNllPpdTt--

--h0ctV6FtoVDvEUxqCq8m3vBRlAvha1Obc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJX0YU7AAoJEL/70l94x66Dd40H+wRDBi+YE27SDSRmNWwYZF4m
fDqoPOVd6HBeM9+NRqL9J93tLSlB3tZugpTyeE6mObMthCRgyV2MGIrfde3b+DMj
9+hQezf1w9n+sKf9zWa8ONRgDW/cy9qWPkLwyt3B4NRGhsV4RKIZ2eL45kthI7AR
EwdkBbw0PyPTMUvrJgeFE17/bDkfUUzj9+apOkfuGjM2YC+aFdOsHT5+GJQCWKbv
FIwiwkaCP0tHwHOIy/0f6bt42oBZ2MLRJ5iOb4pjZplYTDawM9DOmqg9hT0Xs9s6
EPFJn/ca0u/V308sEH5ln6aCV4rGTwHtZGuVXuI76hNZBejckThhTScr88utgwY=
=jKUv
-----END PGP SIGNATURE-----

--h0ctV6FtoVDvEUxqCq8m3vBRlAvha1Obc--
