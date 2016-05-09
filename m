Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 May 2016 21:42:29 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17144 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27028458AbcEITm2fCvry (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 May 2016 21:42:28 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 2E4E341F8E84;
        Mon,  9 May 2016 20:42:23 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 09 May 2016 20:42:23 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 09 May 2016 20:42:23 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id ABB6C38DA970C;
        Mon,  9 May 2016 20:42:18 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 9 May 2016 20:42:22 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Mon, 9 May
 2016 20:42:22 +0100
Date:   Mon, 9 May 2016 20:42:22 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH 1/7] MIPS: KVM/locore.S: Don't preserve host ASID around
 vcpu_run
Message-ID: <20160509194222.GD23699@jhogan-linux.le.imgtec.org>
References: <1462541784-22128-1-git-send-email-james.hogan@imgtec.com>
 <1462541784-22128-2-git-send-email-james.hogan@imgtec.com>
 <57309D29.6010903@redhat.com>
 <20160509153044.GD28818@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GyRA7555PLgSTuth"
Content-Disposition: inline
In-Reply-To: <20160509153044.GD28818@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 6e37d52
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53322
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

--GyRA7555PLgSTuth
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 09, 2016 at 05:30:44PM +0200, Ralf Baechle wrote:
> On Mon, May 09, 2016 at 04:22:33PM +0200, Paolo Bonzini wrote:
>=20
> > On 06/05/2016 15:36, James Hogan wrote:
> > > - It is actually redundant, since the host ASID will be restored
> > >   correctly by kvm_arch_vcpu_put(), which is called almost immediately
> > >   after kvm_arch_vcpu_ioctl_run() returns.
> >=20
> > What happens if the guest does a rogue access to the area where the host
> > kernel resides?  Would that cause a wrong entry in the TLB?
>=20
> The kernel and lowmem reside in KSEG0/XKPYS which are "unmapped segments".
> Unmapped means, the TLB isn't accessed at all nor does the ASID matter
> in the address translation process in one of these unmapped segments.

Yes, although kernel modules (KVM can be built as module) do run from
tlb mapped memory, but trap & emulate KVM as found in mainline should
work as accessing kernel segments from user mode (which is where guest
runs) causes address error exception, triggering emulation of MMIO
accesses rather than TLB fills.

Hmm, perhaps locore.S should be restoring correct root ASID properly
however before returning to the caller or calling the exit handler,
either of which could be tlb mapped module code.

Cheers
James

--GyRA7555PLgSTuth
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMOgeAAoJEGwLaZPeOHZ6iU0P/3QWjMr8QWu8Qt2TBY+7F1AI
ws/JWmVvObZEG/S7cuXSKokFQ2hjyw/ah8el6aaokkjDdoFoKYNT6NTsG0HLYkq5
dOehpf4+08csr8qDvK4BJ9ABgk+O7NACr4JJsnCCp/O2gP66WS4qpQbU5G3OIxEX
IHfyzG2PMDbNUaxtIuaP91k5H285JKLnuG9eIxF3rpW53AH6SSZBTT8BdeZH+1DU
nHAhOl9wmGUi+zZwfvCvE3Xqcfm7LPy18upUTj4SqCJZ+gAdWCNR3eaAO/5syu3t
NLZ8idpKB+Bj5uFrF0rV0E1tlD0Ypuzj0azyVfh+pM5K6iELUqNmV45QG18ciYcy
SE5G58MewdPefec3tLqwfRTxrieuyKmFGnnW5J8QNc+nZtONmnHU1MU7WRVpeJx1
Bupew7W08idD8tFEhZSJts9cpvf7hfFT2AqvSPiuxZGL4KbiW3eyYQpB2hj132YS
ncvwUzRup6RZUw3oRCMbfXxDLKikRXm3ganVKtWUH8VjAZy1Rt8RebVOuKqhfh9Q
EftSnsC0gDcOTO9f5kMD4iSfj+wEkqs02p6NkurtdG44FOt4QhdXQUvWyUof8TC/
6+H243ZgRmE9PWkgyiGbWVdg+nGJsaQzA85R7GEViZs15p+L+uBoRC1Z/7x4BWNr
7ya+TisfAktOIHzqsS3G
=I0pu
-----END PGP SIGNATURE-----

--GyRA7555PLgSTuth--
