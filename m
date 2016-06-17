Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jun 2016 16:47:54 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62810 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27042813AbcFQOrwzav3n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Jun 2016 16:47:52 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 5D44141F8DE5;
        Fri, 17 Jun 2016 15:47:47 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 17 Jun 2016 15:47:47 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 17 Jun 2016 15:47:47 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 0A2CD94AA5F1A;
        Fri, 17 Jun 2016 15:47:43 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 17 Jun
 2016 15:47:46 +0100
Date:   Fri, 17 Jun 2016 15:47:46 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@redhat.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH 3/8] MIPS: KVM: Clean up kvm_exit trace event
Message-ID: <20160617144746.GM30921@jhogan-linux.le.imgtec.org>
References: <1465893617-5774-1-git-send-email-james.hogan@imgtec.com>
 <1465893617-5774-4-git-send-email-james.hogan@imgtec.com>
 <20160617101025.3ae9e691@gandalf.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Z1Z8UV8BNhgCynIS"
Content-Disposition: inline
In-Reply-To: <20160617101025.3ae9e691@gandalf.local.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 5de3adfe
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54098
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

--Z1Z8UV8BNhgCynIS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Steven,

On Fri, Jun 17, 2016 at 10:10:25AM -0400, Steven Rostedt wrote:
> On Tue, 14 Jun 2016 09:40:12 +0100
> James Hogan <james.hogan@imgtec.com> wrote:
>=20
>=20
> >  TRACE_EVENT(kvm_exit,
> >  	    TP_PROTO(struct kvm_vcpu *vcpu, unsigned int reason),
> > @@ -34,7 +71,8 @@ TRACE_EVENT(kvm_exit,
> >  	    ),
> > =20
> >  	    TP_printk("[%s]PC: 0x%08lx",
> > -		      kvm_mips_exit_types_str[__entry->reason],
> > +		      __print_symbolic(__entry->reason,
> > +				       kvm_trace_symbol_exit_types),
> >  		      __entry->pc)
> >  );
> > =20
>=20
> BTW, I'm curious. Can you show me what you see in:
>=20
>  /sys/kernel/debug/tracing/events/kvm/kvm_exit/format

Sure:

name: kvm_exit
ID: 472
format:
	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
	field:int common_pid;	offset:4;	size:4;	signed:1;

	field:unsigned long pc;	offset:8;	size:4;	signed:0;
	field:unsigned int reason;	offset:12;	size:4;	signed:0;

print fmt: "[%s]PC: 0x%08lx", __print_symbolic(REC->reason, { 0, "Interrupt=
" }, { 1, "TLB Mod" }, { 2, "TLB Miss (LD)" }, { 3, "TLB Miss (ST)" }, { 4,=
 "Address Error (LD)" }, { 5, "Address Err (ST)" }, { 8, "System Call" }, {=
 9, "Break Inst" }, { 10, "Reserved Inst" }, { 11, "COP0/1 Unusable" }, { 1=
3, "Trap Inst" }, { 14, "MSA FPE" }, { 15, "FPE" }, { 21, "MSA Disabled" },=
 { 32, "WAIT" }, { 33, "CACHE" }, { 34, "Signal" }), REC->pc

Cheers
James

--Z1Z8UV8BNhgCynIS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXZA2SAAoJEGwLaZPeOHZ62egP/iv3dacTDHpR6HUsdl1k4eYY
YHPixFuo9P1DnK6lSbHia7opscVr9p/IA2VhbSvJSzkZAQsq+aQitcv1knUxR0pq
81wq5pSRbz1h7ZdgqQ/qfYIceeJKMbTboEmaMVb3i7HPmbs4iBngyl1QpflviEWc
+Rmm++aiW/P8oNjILePRhzn8FGaiUOCbXVDE3M/5z7k7Ac2Qseyj+TT2RMV/MM1p
cB3WkKMl5dn5UTTkeKs1B5znJDklBLMxtfJ7+1JQlAOGwqA3qR3sg3k8GasziojK
8hI9UO0uPJGlzPS/KsNq7eY1Vx1AT+G9fEfpv65xcBpYatjj9CHZOHzQNCZ95TZm
S/nC/pO5qCP/t7i4/9dItyc+XOJkHX52DCy26vSH3DnmyX7KZZoqXq0e5C34WvDa
yqx8ib8kOqhw0o5evxF0byIXBOhLUxavMNsFDy4Bx7EjijkXCkPb31zEY5tQY+Ft
EXZwyd2qeAs+GVrZTMR2YdBwuAIoUCq5A7WOM6f7oHYMWVIJlCkn8GmnQHFW0p3o
GfncwlywLMjN4NVLHFZxzc8PjmxZCIECsKJl7E6G7Lg/UWhQaymC/FAZX0Ta8a1H
doAwGKo5TtMAuYshuzNfO8nVjAZ/BVXJE+07ZsysoDhjAp38PPDAMZTZRqyZyvkc
SaS0RZkpVAmuLd7HUYBE
=fjq1
-----END PGP SIGNATURE-----

--Z1Z8UV8BNhgCynIS--
