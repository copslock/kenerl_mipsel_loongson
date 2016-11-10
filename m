Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2016 18:37:54 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35632 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993180AbcKJRh2PNuLO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Nov 2016 18:37:28 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 5BAF341F8E45;
        Thu, 10 Nov 2016 17:36:12 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 10 Nov 2016 17:36:12 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 10 Nov 2016 17:36:12 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B041C98707B62;
        Thu, 10 Nov 2016 17:37:18 +0000 (GMT)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 10 Nov
 2016 17:37:22 +0000
Date:   Thu, 10 Nov 2016 17:37:22 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <fengguang.wu@intel.com>
CC:     Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>,
        <stable@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>,
        Paul Burton <Paul.Burton@imgtec.com>
Subject: Re: [BACKPORT PATCH 3.10..3.16] KVM: MIPS: Drop other CPU ASIDs on
 guest MMU changes
Message-ID: <20161110173721.GD7075@jhogan-linux.le.imgtec.org>
References: <20161109144624.16683-1-james.hogan@imgtec.com>
 <6066667d-e62d-bfec-ca3e-f16f8bef912d@suse.cz>
 <20161109220043.GA7075@jhogan-linux.le.imgtec.org>
 <20161110060843.GA28639@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IDYEmSnFhs3mNXr+"
Content-Disposition: inline
In-Reply-To: <20161110060843.GA28639@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55777
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--IDYEmSnFhs3mNXr+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Fengguang,

On Thu, Nov 10, 2016 at 07:08:43AM +0100, Greg KH wrote:
> On Wed, Nov 09, 2016 at 10:00:43PM +0000, James Hogan wrote:
> > On Wed, Nov 09, 2016 at 10:22:01PM +0100, Jiri Slaby wrote:
> > > On 11/09/2016, 03:46 PM, James Hogan wrote:
> > > > Unfortunately the original commit went in to v3.12.65 as commit
> > > > 168e5ebbd63e, without fixing up the references to tlb_lo[0/1] to
> > > > tlb_lo0/1 which broke the MIPS KVM build, and I didn't twig that I
> > > > already had a correct backport outstanding (sorry!). That commit sh=
ould
> > > > be reverted before applying this backport to 3.12.
> > >=20
> > > Thanks, reverted and applied. I wonder the builders didn't break give=
n 4
> > > mips configurations are tested. I indeed could reproduce locally.
> >=20
> > I'm guessing malta_kvm_defconfig isn't one of those defconfigs (and the
> > imgtec buildbots don't yet test stable branches). Which builders do you
> > use?
>=20
> I use 0-day for these types of things, and it is not showing up any
> errors for the 4.4-stable kernel.  Can you get these configurations
> added to it so that we can ensure it doesn't regress?

Can we please get a few MIPS defconfigs added to the 0-day testing?

- malta_kvm_defconfig
  this probably doesn't need to be a high priority build, but other
  configs don't yet cover MIPS KVM so its worth having (that bit us
  recently with 3.12 and 4.4 stable branches).

- 64r6el_defconfig and 32r2_defconfig (4.9 and later)
  these are just a couple of the new generic/multiplatform kernel
  configurations added in 4.9 (Paul Burton Cc'd). There are others too,
  but these will probably give decent coverage. These are likely to be
  increasingly relevant as more/new platforms are converted to use it.
  (note, the r6 one may require a newish toolchain).

Thanks
James

--IDYEmSnFhs3mNXr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYJLBLAAoJEGwLaZPeOHZ6yNAQAIeiAQ3a6HE5x7ueirSDnPox
zPy5rHBU/3XPJ4svwVuTQWR6wHR+3aw6m20sUvUK04XV5K5Ffq3ElCSWD67gRFvE
XxW+j39WtSRjf+vdtddNktWvq1826Uy3gTrKf6N8UjOaFz8kK4RaCIUA0PpSNCWf
HKDTE/ODKOJiUQDCddpfH4ONxCH7r2XFS/NrZQDbFYr13tC3ydFio5OAkOkB8OoX
/NhV0kH8u0Eock0L4cr6BjDWfHQdEY0Tq+bf5K4xW6wPo6E9p8E9OzA+znQOT5dX
G8e/6xS748/bEYBbtzDsHmbwBCxGzmMojzPrxaR5tTdQq9qIrY4IBGElW0MlXjfz
gU7JDw91Tw7ombS7OgZoIUWOD+aEk2VvaUqk27Xx/bsSYWLOjCpQ0j3e4Jz0rQLb
Hm7G/Te+aukM5wJg2JV+w+DvxiZkfxo1BU8xStBCacfVzwRHdBFTZGXESjVsKHA6
4vV/9psY38M94/UO2U626QHYT8TfdIbeOYbM2f9ctpGp51mygsNX+CpvVfykZ5zc
hPm6/Fkp3Hz5+QjyEXDvNhAVaILZIdRqtD9jdRat7zB/6DSXelwQSAuMvkHgUp+V
hdrbqpVoj0Wi3eM48pchKSxD5zstMGRFbWiTwPlz/LpACpICYx3iW0KWg2G2vjWM
RtjFNgRL9cDDB0f6fctR
=GICU
-----END PGP SIGNATURE-----

--IDYEmSnFhs3mNXr+--
