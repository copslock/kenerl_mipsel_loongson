Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Mar 2017 13:42:15 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:50960 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993418AbdCCMmJK9hqM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 3 Mar 2017 13:42:09 +0100
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E849080494;
        Fri,  3 Mar 2017 12:42:02 +0000 (UTC)
Received: from [10.36.117.102] (ovpn-117-102.ams2.redhat.com [10.36.117.102])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v23CfxD9027203
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 3 Mar 2017 07:42:00 -0500
Subject: Re: [PATCH 11/32] KVM: MIPS: Add VZ capability
To:     James Hogan <james.hogan@imgtec.com>
References: <cover.5cfb5298ebc2f5308f4f56aaac7fa31c39a8ab58.1488447004.git-series.james.hogan@imgtec.com>
 <17827db14f848b69e8184ae80b5d63ba01b4b106.1488447004.git-series.james.hogan@imgtec.com>
 <bb40a6bb-e6b3-a37b-a08e-daccbf52bbef@redhat.com>
 <20170302113923.GC2878@jhogan-linux.le.imgtec.org>
 <1a071956-a897-a2f9-4523-e6da074568b6@redhat.com>
 <20170302223407.GQ996@jhogan-linux.le.imgtec.org>
 <20170303123724.GD2878@jhogan-linux.le.imgtec.org>
Cc:     linux-mips@linux-mips.org, kvm@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6163bc41-b5a1-0b71-be57-3e6b71b7db06@redhat.com>
Date:   Fri, 3 Mar 2017 13:41:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170303123724.GD2878@jhogan-linux.le.imgtec.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iFgiwHrXxsHnIG252GxUURfGANOQacWG0"
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 03 Mar 2017 12:42:03 +0000 (UTC)
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57016
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
--iFgiwHrXxsHnIG252GxUURfGANOQacWG0
Content-Type: multipart/mixed; boundary="Xvs45SpCTrJroEuVpnuO3MhSeWkxkM5C8";
 protected-headers="v1"
From: Paolo Bonzini <pbonzini@redhat.com>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org, kvm@vger.kernel.org,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 Ralf Baechle <ralf@linux-mips.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
Message-ID: <6163bc41-b5a1-0b71-be57-3e6b71b7db06@redhat.com>
Subject: Re: [PATCH 11/32] KVM: MIPS: Add VZ capability
References: <cover.5cfb5298ebc2f5308f4f56aaac7fa31c39a8ab58.1488447004.git-series.james.hogan@imgtec.com>
 <17827db14f848b69e8184ae80b5d63ba01b4b106.1488447004.git-series.james.hogan@imgtec.com>
 <bb40a6bb-e6b3-a37b-a08e-daccbf52bbef@redhat.com>
 <20170302113923.GC2878@jhogan-linux.le.imgtec.org>
 <1a071956-a897-a2f9-4523-e6da074568b6@redhat.com>
 <20170302223407.GQ996@jhogan-linux.le.imgtec.org>
 <20170303123724.GD2878@jhogan-linux.le.imgtec.org>
In-Reply-To: <20170303123724.GD2878@jhogan-linux.le.imgtec.org>

--Xvs45SpCTrJroEuVpnuO3MhSeWkxkM5C8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 03/03/2017 13:37, James Hogan wrote:
> Actually I think the way I had designed KVM_CAP_MIPS_VZ is fine. I had
> defined it as an enumeration rather than a mask because it isn't
> expected you'd have more than one hardware virtualisation type able to
> run on a particular core.
>=20
> Whether T&E is still supported is I think better exposed by a new
> KVM_CAP_MIPS_TE capability, indicating whether T&E is exposed when
> KVM_CAP_MIPS_VZ is also set.
>=20
> It would be set to 1 on new kernels whenever T&E is supported.
>=20
> For compatibility with older kernels, userland would be expected to
> determine whether T&E is present by:
> check(KVM_CAP_MIPS_VZ) =3D=3D 0 || check(KVM_CAP_MIPS_TE) !=3D 0
>=20
> Old userland that doesn't check KVM_CAP_MIPS_TE would just hit an EINVA=
L
> from KVM_CREATE_VM if T&E isn't supported.

That's okay.

Paolo


--Xvs45SpCTrJroEuVpnuO3MhSeWkxkM5C8--

--iFgiwHrXxsHnIG252GxUURfGANOQacWG0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYuWSUAAoJEL/70l94x66DEoIH+wbIf9macI+lgE+eiJ2ZzxO9
S6nUlc1AW4hmSNSQRVp/yj/1uZfJttL77TPVUVN8ZotGqSiL3Z00sgNJyCaQ8Llo
i85lh+jtF269GMoRp48P7OCzKbmJC4gD61Ob152SZSQrl/7euSB7079xC4WKlt1W
r2gZf6r315Sw1JOC/uem8kZR+On6DG1HtrizUGTZqS3VEZJ22z3JQX76di4pIASQ
dw/4iOaXIeLMUE+AP63EZGoD1qGnAlke3OF8/tkvapUp9M4ixNXCguk0a5pGQQoQ
WizXlKh05kj1AwihClShl+17hJqlnHg+W7+PGqTQlwYUKCTGioanLIjPz2lLJ3k=
=M9N6
-----END PGP SIGNATURE-----

--iFgiwHrXxsHnIG252GxUURfGANOQacWG0--
