Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2016 12:13:11 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16601 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27041234AbcFNKNJK5sVn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jun 2016 12:13:09 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 682D641F8D18;
        Tue, 14 Jun 2016 10:17:49 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 14 Jun 2016 10:17:49 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 14 Jun 2016 10:17:49 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 0F90EAEDF1DDF;
        Tue, 14 Jun 2016 10:17:46 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 14 Jun
 2016 10:17:48 +0100
Date:   Tue, 14 Jun 2016 10:17:48 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>
Subject: Re: [PATCH 2/8] MIPS: KVM: Add kvm_aux trace event
Message-ID: <20160614091748.GH30921@jhogan-linux.le.imgtec.org>
References: <1465893617-5774-1-git-send-email-james.hogan@imgtec.com>
 <1465893617-5774-3-git-send-email-james.hogan@imgtec.com>
 <20160614085541.GA17625@jhogan-linux.le.imgtec.org>
 <cb4fef4f-c66f-42b8-18bc-89985e21a6d7@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J/zg8ciPNcraoWb6"
Content-Disposition: inline
In-Reply-To: <cb4fef4f-c66f-42b8-18bc-89985e21a6d7@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 5de3adfe
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54034
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

--J/zg8ciPNcraoWb6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 14, 2016 at 11:15:40AM +0200, Paolo Bonzini wrote:
>=20
>=20
> On 14/06/2016 10:55, James Hogan wrote:
> > hmm, sorry, I don't know how i didn't spot when I checked these over
> > that fpu_msa is still referred to here instead of aux. I'll post a V2 of
> > this patch with s/fpu_msa/aux/.
>=20
> I can fix it up to kvm_trace_symbol_aux_op and kvm_trace_symbol_aux_state.

Great, thanks Paolo. Looks good.

Cheers
James

>=20
> diff --git a/arch/mips/kvm/trace.h b/arch/mips/kvm/trace.h
> index 32ac7cc82e13..f3ada591ca25 100644
> --- a/arch/mips/kvm/trace.h
> +++ b/arch/mips/kvm/trace.h
> @@ -48,14 +48,14 @@ TRACE_EVENT(kvm_exit,
>  #define KVM_TRACE_AUX_MSA		2
>  #define KVM_TRACE_AUX_FPU_MSA		3
> =20
> -#define kvm_trace_symbol_fpu_msa_op		\
> +#define kvm_trace_symbol_aux_op		\
>  	{ KVM_TRACE_AUX_RESTORE, "restore" },	\
>  	{ KVM_TRACE_AUX_SAVE,    "save" },	\
>  	{ KVM_TRACE_AUX_ENABLE,  "enable" },	\
>  	{ KVM_TRACE_AUX_DISABLE, "disable" },	\
>  	{ KVM_TRACE_AUX_DISCARD, "discard" }
> =20
> -#define kvm_trace_symbol_fpu_msa_state		\
> +#define kvm_trace_symbol_aux_state		\
>  	{ KVM_TRACE_AUX_FPU,     "FPU" },	\
>  	{ KVM_TRACE_AUX_MSA,     "MSA" },	\
>  	{ KVM_TRACE_AUX_FPU_MSA, "FPU & MSA" }
> @@ -78,9 +78,9 @@ TRACE_EVENT(kvm_aux,
> =20
>  	    TP_printk("%s %s PC: 0x%08lx",
>  		      __print_symbolic(__entry->op,
> -				       kvm_trace_symbol_fpu_msa_op),
> +				       kvm_trace_symbol_aux_op),
>  		      __print_symbolic(__entry->state,
> -				       kvm_trace_symbol_fpu_msa_state),
> +				       kvm_trace_symbol_aux_state),
>  		      __entry->pc)
>  );
> =20
>=20
> Paolo

--J/zg8ciPNcraoWb6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXX8u8AAoJEGwLaZPeOHZ6v2EP/2dKfxU6tucDKbvZYC02UCfU
e3GoAMrt+d7hjqVlyrFyzoy9U9dTp7bD2moTS4ASxqueUK4WvLx3C0Qksp4WZPZU
Xv32vlrBRyGRGbwk8xBd9NLg7xJa39qcVP95xxrN3jJVNsYiLYdR455E7FLqmCcX
Ck/x3yZB0DszyQu0VMOxiDtFVFcmGIe2Dzjy42Lc/BhLunTGExmJ5FTSpiGoW4Ta
efSpxz0pjElPAzXuU+fgwHhbNklvgGU//zoiDgduGM+rhHJo38BFHQbEyPaXrBzr
KRuVjNukiTRaF52edvIV/QmjGJ8znyZ6RuOHBhZO2PhnjjoeFxJkVy3bJyEeywbZ
BEDu0Ryf/74O0uHrrRXkAlnj2jca5npg+r4x1Z0GfjA6p/CnUS3vd07l/pVzXMb3
NE9RsCp+g8MBoDokpnGzq055U3TbCwPP1K6K93kXJXqjoz6d/YdBpY5OSVQhvNyx
KXsxz8MYWfDmmR69TSBUvdgAXUMrymsW5WWNrrXLLQQxEJxevEPf802kaO8NbNwM
jUOO63HwKDIDr97NezuWKx7OtGIzNlCXW5KJ+wGyaFnHwrwn4y1QaH7la9z53Lkq
vYtIrhwujzaPX0pH41AaItJ3cRvDhH+AA7/qwwOtqr8JLpYU7SdsF8Ifc6J58IWd
u5yCuLXZzj4QoIlmHQIp
=g1/u
-----END PGP SIGNATURE-----

--J/zg8ciPNcraoWb6--
