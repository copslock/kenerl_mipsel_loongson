Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 13:20:29 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:37230 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992213AbdCBMUTxiNnG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Mar 2017 13:20:19 +0100
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4DF333A7698;
        Thu,  2 Mar 2017 12:20:14 +0000 (UTC)
Received: from [10.36.116.174] (ovpn-116-174.ams2.redhat.com [10.36.116.174])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v22CKBZn005692
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 2 Mar 2017 07:20:12 -0500
Subject: Re: [PATCH 11/32] KVM: MIPS: Add VZ capability
To:     James Hogan <james.hogan@imgtec.com>
References: <cover.5cfb5298ebc2f5308f4f56aaac7fa31c39a8ab58.1488447004.git-series.james.hogan@imgtec.com>
 <17827db14f848b69e8184ae80b5d63ba01b4b106.1488447004.git-series.james.hogan@imgtec.com>
 <bb40a6bb-e6b3-a37b-a08e-daccbf52bbef@redhat.com>
 <20170302113923.GC2878@jhogan-linux.le.imgtec.org>
Cc:     linux-mips@linux-mips.org, kvm@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1a071956-a897-a2f9-4523-e6da074568b6@redhat.com>
Date:   Thu, 2 Mar 2017 13:20:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170302113923.GC2878@jhogan-linux.le.imgtec.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="06Gh7a8OILQhg5HkRNwjo8eNQON0ga4g3"
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 02 Mar 2017 12:20:14 +0000 (UTC)
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56997
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
--06Gh7a8OILQhg5HkRNwjo8eNQON0ga4g3
Content-Type: multipart/mixed; boundary="pmV4VIo2HTjmEO4XLR0BrtjpPiMOuv0ml";
 protected-headers="v1"
From: Paolo Bonzini <pbonzini@redhat.com>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org, kvm@vger.kernel.org,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 Ralf Baechle <ralf@linux-mips.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
Message-ID: <1a071956-a897-a2f9-4523-e6da074568b6@redhat.com>
Subject: Re: [PATCH 11/32] KVM: MIPS: Add VZ capability
References: <cover.5cfb5298ebc2f5308f4f56aaac7fa31c39a8ab58.1488447004.git-series.james.hogan@imgtec.com>
 <17827db14f848b69e8184ae80b5d63ba01b4b106.1488447004.git-series.james.hogan@imgtec.com>
 <bb40a6bb-e6b3-a37b-a08e-daccbf52bbef@redhat.com>
 <20170302113923.GC2878@jhogan-linux.le.imgtec.org>
In-Reply-To: <20170302113923.GC2878@jhogan-linux.le.imgtec.org>

--pmV4VIo2HTjmEO4XLR0BrtjpPiMOuv0ml
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 02/03/2017 12:39, James Hogan wrote:
> It can't right now, though with relocation of the kernel now implemente=
d
> in MIPS Linux for KASLR, and hopes for a more generic EVA implementatio=
n
> (which can require the kernel to be linked in a completely different
> segment) it isn't completely infeasible.

What about the other way round, sticking a minimal T&E stub in kernel
space and running the kernel in userspace?  Would it be feasible or
would it be as complex as KVM itself?

> 1) QEMU, which I've implemented using the kvm_type machine callback.
> This allows the KVM type to be specified with e.g.
>   "-machine malta,accel=3Dkvm,kvm-type=3DTE"
> Otherwise it defaults to using KVM_VM_MIPS_DEFAULT.
>=20
> When you try and load a kernel (which happens after kvm_init() has
> already passed the kvm type into KVM_CREATE_VM) it will check that it
> supports the current kernel type.
>
> 2) My kvm test application, which uses KVM_VM_MIPS_DEFAULT by default
> and hackily maps itself into the guest physical address space to run C
> code test cases.

So this one would work for both TE and VZ because the guest is not a
Linux kernel.

I don't know...  Instinctively I would think that it's easy to get
KVM_VM_MIPS_DEFAULT wrong and place the VZ-and-fall-back-to-TE policy in
userspace, but I can be convinced otherwise if the failure mode is good
enough.  For example, what happens if you use KVM_SET_USER_MEMORY_REGION
for a kernel address in TE mode?

Paolo


--pmV4VIo2HTjmEO4XLR0BrtjpPiMOuv0ml--

--06Gh7a8OILQhg5HkRNwjo8eNQON0ga4g3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYuA33AAoJEL/70l94x66DGK0H/2Nm/wYcZA01x4vSQ6oOUr/O
Zw7ftHIJ1RmD96/+t06JmBQUuAwOj9JC+OaVB3A5oWG+XXvJP3inVRehLxqxHycs
2rTj5/N9864Pc5ankQdNluWP77fNxYbedjCExfqqoFCr+Fh81E0OWfIJpVoRC6Bm
j0IJJR4+d5cER/4eColhOgQGp/oczaKfMh++MdVK1r0f6vYsM9h4wAvblTHpnEzl
s6na7DAU+qj8xdSNqy8yvxJTBCDH/cH7c+AWTqdv0ZmvJb6Isxeec6KCBYtdbnGJ
hHuYwiNdWa4Feycobr99kD2D0u7rWIoFWym3309JVYwNsENOSYwMaPbfmyeSsqc=
=rldd
-----END PGP SIGNATURE-----

--06Gh7a8OILQhg5HkRNwjo8eNQON0ga4g3--
