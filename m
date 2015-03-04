Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Mar 2015 01:26:04 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53236 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007914AbbCDA0DIAEF0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Mar 2015 01:26:03 +0100
Received: from deadeye.wl.decadent.org.uk ([192.168.4.249] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <ben@decadent.org.uk>)
        id 1YSx8P-0004Vk-Ik; Wed, 04 Mar 2015 00:25:57 +0000
Received: from ben by deadeye with local (Exim 4.84)
        (envelope-from <ben@decadent.org.uk>)
        id 1YSx8K-0008Vo-AL; Wed, 04 Mar 2015 00:25:52 +0000
Message-ID: <1425428747.4190.48.camel@decadent.org.uk>
Subject: Re: [PATCH 3.2 12/24] MIPS: Fix C0_Pagegrain[IEC] support.
From:   Ben Hutchings <ben@decadent.org.uk>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, linux-mips@linux-mips.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        Ralf Baechle <ralf@linux-mips.org>
Date:   Wed, 04 Mar 2015 00:25:47 +0000
In-Reply-To: <54F642AE.1020802@gmail.com>
References: <lsq.1425420688.25339415@decadent.org.uk>
         <54F642AE.1020802@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-S3jPPtm7mpRQuQA0yRaD"
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.249
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46112
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


--=-S3jPPtm7mpRQuQA0yRaD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2015-03-03 at 15:24 -0800, David Daney wrote:
> On 03/03/2015 02:11 PM, Ben Hutchings wrote:
> > 3.2.68-rc1 review patch.  If anyone has any objections, please let me k=
now.
> >
>=20
> I object!
>=20
> Because ...
>=20
> > ------------------
> >
> > From: David Daney <david.daney@cavium.com>
> >
> > commit 9ead8632bbf454cfc709b6205dc9cd8582fb0d64 upstream.
> >
> > The following commits:
> >
> >    5890f70f15c52d (MIPS: Use dedicated exception handler if CPU support=
s RI/XI exceptions)
> >    6575b1d4173eae (MIPS: kernel: cpu-probe: Detect unique RI/XI excepti=
ons)
> >
> > break the kernel for *all* existing MIPS CPUs that implement the
> > CP0_PageGrain[IEC] bit.  They cause the TLB exception handlers to be
> > generated without the legacy execute-inhibit handling, but never set
> > the CP0_PageGrain[IEC] bit to activate the use of dedicated exception
> > vectors for execute-inhibit exceptions.  The result is that upon
> > detection of an execute-inhibit violation, we loop forever in the TLB
> > exception handlers instead of sending SIGSEGV to the task.
> >
> > If we are generating TLB exception handlers expecting separate
> > vectors, we must also enable the CP0_PageGrain[IEC] feature.
> >
> > The bug was introduced in kernel version 3.17.
>=20
> ... I don't think the patch should be applied to versions prior to 3.17
[...]

Sorry about that - I dropped this one just before sending, but didn't
regenerate the mailbox.

Ben.

--=20
Ben Hutchings
Horngren's Observation:
                   Among economists, the real world is often a special case=
.

--=-S3jPPtm7mpRQuQA0yRaD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVPZREOe/yOyVhhEJAQpzrxAAuAiDBDhCtDFHu57mSJ0Zh8yPGGNxVd/P
hxGiInDIbKUtqlkvn0bEXtsoXNUMUV3GSq186v70wy99bCUgvXswtzhAv9jBbMrX
HrgiiEPc2dDqk5Jt879buUAp6HHxQF+hPY1++h9nVgeavzrxiRnTKP7nTyJoiyeu
jgASBOWNhQiJOAcBClycDwbTnyw3nhJY+X+UBBmb8g5UbEDpITtKKwOoJw2AJlJg
m1rXMtgEMH2NLnujyN+J6SGdobAsLbLL6blJsyermImyEE8mA/eTcGvtinmRiwis
ciZOYx9fVnXRwZnttYmD30qNHbcZ/9I+AP2q7GD98yadDloyYouUS4HiaZDPc2lj
dJ4ijIDR84GuE3TjJhNpKH+j7PHJ89SmePKK3NrviNYKwmTqotLcD+8jqnu03PX1
Cinxoxn0tCZEdrnntSkMTgP1bE/Bhi21k6NTa1Ybu34dYCEXAP4Zs3W6ZiYMEvyW
xFM6z8iaPRJYCTc2aa/PCA1hxXuj+I/ZSzb26XK3TIxzwT7crOE2jJiRQ5rLy72L
7hMQqRrePA/j2cwbJnXTN/WpZ/flifUOK8tPSfpPq9uIvKDKCqLAJwp3LA8gH1j5
5VnhxmQJt+LrrgqtbHMmuFY+tWfhC2BDO7cdiy5GWx8/AH0MmcVgxGAZSCKQd+eX
qVdJxuhJczA=
=mSMM
-----END PGP SIGNATURE-----

--=-S3jPPtm7mpRQuQA0yRaD--
