Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jun 2016 16:58:27 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22378 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27042813AbcFQO60EhDXn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Jun 2016 16:58:26 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id B949541F8DE5;
        Fri, 17 Jun 2016 15:58:20 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 17 Jun 2016 15:58:20 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 17 Jun 2016 15:58:20 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 6049FFB8A9600;
        Fri, 17 Jun 2016 15:58:16 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 17 Jun
 2016 15:58:19 +0100
Date:   Fri, 17 Jun 2016 15:58:19 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@redhat.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH 5/8] MIPS: KVM: Add guest mode switch trace events
Message-ID: <20160617145819.GN30921@jhogan-linux.le.imgtec.org>
References: <1465893617-5774-1-git-send-email-james.hogan@imgtec.com>
 <1465893617-5774-6-git-send-email-james.hogan@imgtec.com>
 <20160617100848.4a91b313@gandalf.local.home>
 <1b6e9e4e-3cbb-9c6e-bfa7-390f8a4f8d24@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xTKfHyrFnSV9DG3y"
Content-Disposition: inline
In-Reply-To: <1b6e9e4e-3cbb-9c6e-bfa7-390f8a4f8d24@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 5de3adfe
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54099
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

--xTKfHyrFnSV9DG3y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 17, 2016 at 04:29:37PM +0200, Paolo Bonzini wrote:
>=20
>=20
> On 17/06/2016 16:08, Steven Rostedt wrote:
> >> > +/*
> >> > + * Tracepoints for VM enters
> >> > + */
> >> > +TRACE_EVENT(kvm_enter,
> >> > +	    TP_PROTO(struct kvm_vcpu *vcpu),
> >> > +	    TP_ARGS(vcpu),
> >> > +	    TP_STRUCT__entry(
> >> > +			__field(unsigned long, pc)
> >> > +	    ),
> >> > +
> >> > +	    TP_fast_assign(
> >> > +			__entry->pc =3D vcpu->arch.pc;
> >> > +	    ),
> >> > +
> >> > +	    TP_printk("PC: 0x%08lx",
> >> > +		      __entry->pc)
> >> > +);
> >> > +
> >> > +TRACE_EVENT(kvm_reenter,
> >> > +	    TP_PROTO(struct kvm_vcpu *vcpu),
> >> > +	    TP_ARGS(vcpu),
> >> > +	    TP_STRUCT__entry(
> >> > +			__field(unsigned long, pc)
> >> > +	    ),
> >> > +
> >> > +	    TP_fast_assign(
> >> > +			__entry->pc =3D vcpu->arch.pc;
> >> > +	    ),
> >> > +
> >> > +	    TP_printk("PC: 0x%08lx",
> >> > +		      __entry->pc)
> >> > +);
> >> > +
> >> > +TRACE_EVENT(kvm_out,
> >> > +	    TP_PROTO(struct kvm_vcpu *vcpu),
> >> > +	    TP_ARGS(vcpu),
> >> > +	    TP_STRUCT__entry(
> >> > +			__field(unsigned long, pc)
> >> > +	    ),
> >> > +
> >> > +	    TP_fast_assign(
> >> > +			__entry->pc =3D vcpu->arch.pc;
> >> > +	    ),
> >> > +
> >> > +	    TP_printk("PC: 0x%08lx",
> >> > +		      __entry->pc)
> >> > +);
> >=20
> > Please combine the above TRACE_EVENT()s to use a single
> > DECLARE_EVENT_CLASS() and three DEFINE_EVENT()s.

Oh, neat. I did wonder if there was a nicer way to do that. Thanks!

>=20
> James,
>=20
> I've committed the patch already, so please send a follow up.

Will do,

Thanks
James

--xTKfHyrFnSV9DG3y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXZBALAAoJEGwLaZPeOHZ6WokP/iNdLioeP5Ui0gHzLoIubaLi
mt9XXOiiI96uecV0QsTfj+nflrLvoqp4vDUpFyCOTSGojF1bJss0Rj574DjNfjRv
BYOxuyWkc8/PR6SV3TieXBZuc0VkB5cjAxCIgqHQm2zH6ssZizUnZAf1Zkeo5QRN
OfpW2zwMH4582Mxg2Sie4HIf9QOfjLstI9DCpAFRt3rwESuVFGlu3Id099ZBP5TQ
teFJIMxRw7X+2BIV8R0kZL+2EzGZBujcRYMI6Wum3aCvV+tz3FWh6uDL9zoRYMUb
s4IJo0/igubaYB0QOJmO6xoIbtfgJabxSYdxLtDjV9+vANG//YS1K4YwuShPxpRE
snUjVKQHSQn9CN2IaM6KbGMfMbwfldwRyLl6fpihrJDgiTkP2hsNV9bhpcUe82bz
GfGOZdMQwfx0VKHi0NCpzf3JMufydmCdrA7kUP1uiGOK7i9Oe03DazrIpEJjXeuk
iaNS8X0i0C/m0j+BuvDoObb9yGD8ZvspbDOHJ3nMNZo4Il5wQJNVSayoOmZIr107
mUuT/8OephGK7itFk2nQwajkvlDO2bjMt9wbjoxJVLDbdIQU4Vu+b3MgyXR/oW50
lbLV3lnZ62h6N+i/dmLAmntUQCTOKBaqvk6iS028CZ9YXBJPXMuiXxNSuJ9nFSBN
d4GcGJvjs/d1dq4yG1NJ
=Ysfj
-----END PGP SIGNATURE-----

--xTKfHyrFnSV9DG3y--
