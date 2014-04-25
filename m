Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2014 22:42:27 +0200 (CEST)
Received: from mail-wi0-f171.google.com ([209.85.212.171]:44505 "EHLO
        mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6843083AbaDYUmYaFC4U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Apr 2014 22:42:24 +0200
Received: by mail-wi0-f171.google.com with SMTP id q5so3268689wiv.4
        for <linux-mips@linux-mips.org>; Fri, 25 Apr 2014 13:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :organization:user-agent:in-reply-to:references:mime-version
         :content-type;
        bh=EQyiD1oIu0e4nTqrIlmtwE0R6lcvry38tdLNN4onHLs=;
        b=Hna9x4UlTg+WlOUjHZ1/ohZTIoJVTAsIIyPaNLCvbNPF48EoVxxSBAXqVWjp6uKAmV
         EMjHgGrGm7chk+JlVqiEK6ZSON5wNRWiy17dncsPCJiuqN6aNAv5zCMsjw2Bb4Q3DvK1
         1xlEpU5JxA3tCEgjI+iz8I0DBJnkiqG6vgN0j7QJwiQi+5r9Pud2mcvCIv8mlM6PfxAr
         ZvI/11BH2iyYcpzNazLxiMi/IaIsI5zdenN1TGpi8dyhIAzFFt83l4c7sbsbmczORL0f
         nYR6/8er9Xilq4fc0oeVSaUcWQGO1GuPNuxjXEFEYmKdSL2E+HrsUXFWCxi+lzRoKuo2
         eoDA==
X-Gm-Message-State: ALoCoQmMr3xUAVuP5wqOPBazHACool6w5alvKNuiFaq96mOBPLZg0VjIUt1eRohkyYNgpvrwr+PX
X-Received: by 10.180.19.167 with SMTP id g7mr5268830wie.46.1398458539109;
        Fri, 25 Apr 2014 13:42:19 -0700 (PDT)
Received: from radagast.localnet (jahogan.plus.com. [212.159.75.221])
        by mx.google.com with ESMTPSA id fi2sm8121262wib.2.2014.04.25.13.42.17
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 25 Apr 2014 13:42:18 -0700 (PDT)
From:   James Hogan <james.hogan@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     David Daney <ddaney.cavm@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: Re: [PATCH 09/21] MIPS: KVM: Fix timer race modifying guest CP0_Cause
Date:   Fri, 25 Apr 2014 21:42:08 +0100
Message-ID: <3027239.6lcM6FV8mj@radagast>
Organization: Imagination Technologies
User-Agent: KMail/4.11.5 (Linux/3.14.0+; KDE/4.11.5; x86_64; ; )
In-Reply-To: <535A9393.9010907@gmail.com>
References: <1398439204-26171-1-git-send-email-james.hogan@imgtec.com> <1398439204-26171-10-git-send-email-james.hogan@imgtec.com> <535A9393.9010907@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1679865.gt23WWEXNi"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39955
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


--nextPart1679865.gt23WWEXNi
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi David,

On Friday 25 April 2014 09:55:47 David Daney wrote:
> On 04/25/2014 08:19 AM, James Hogan wrote:
> > The hrtimer callback for guest timer timeouts sets the guest's
> > CP0_Cause.TI bit to indicate to the guest that a timer interrupt is
> > pending, however there is no mutual exclusion implemented to prevent
> > this occurring while the guest's CP0_Cause register is being
> > read-modify-written elsewhere.
> > 
> > When this occurs the setting of the CP0_Cause.TI bit is undone and the
> > guest misses the timer interrupt and doesn't reprogram the CP0_Compare
> > register for the next timeout. Currently another timer interrupt will be
> > triggered again in another 10ms anyway due to the way timers are
> > emulated, but after the MIPS timer emulation is fixed this would result
> > in Linux guest time standing still and the guest scheduler not being
> > invoked until the guest CP0_Count has looped around again, which at
> > 100MHz takes just under 43 seconds.
> > 
> > Currently this is the only asynchronous modification of guest registers,
> > therefore it is fixed by adjusting the implementations of the
> > kvm_set_c0_guest_cause(), kvm_clear_c0_guest_cause(), and
> > kvm_change_c0_guest_cause() macros which are used for modifying the
> > guest CP0_Cause register to use ll/sc to ensure atomic modification.
> > This should work in both UP and SMP cases without requiring interrupts
> > to be disabled.
> > 
> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Gleb Natapov <gleb@kernel.org>
> > Cc: kvm@vger.kernel.org
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: linux-mips@linux-mips.org
> > Cc: Sanjay Lal <sanjayl@kymasys.com>
> 
> NACK, I don't like the names of these functions.  They initially
> confused me too much...

It's just being consistent with all the other *set*, *clear*, and *change* 
macros in kvm_host.h, asm/mipsregs.h, and the 229 users of those macros across 
the arch. I see no reason to confuse things further by being inconsistent.

Cheers
James

> 
> > ---
> > 
> >   arch/mips/include/asm/kvm_host.h | 71
> >   ++++++++++++++++++++++++++++++++++++---- 1 file changed, 65
> >   insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/mips/include/asm/kvm_host.h
> > b/arch/mips/include/asm/kvm_host.h index 3eedcb3015e5..90e1c0005ff4
> > 100644
> > --- a/arch/mips/include/asm/kvm_host.h
> > +++ b/arch/mips/include/asm/kvm_host.h
> > @@ -481,15 +481,74 @@ struct kvm_vcpu_arch {
> > 
> >   #define
> >   kvm_read_c0_guest_errorepc(cop0)	(cop0->reg[MIPS_CP0_ERROR_PC][0])
> >   #define kvm_write_c0_guest_errorepc(cop0,
> >   val)	(cop0->reg[MIPS_CP0_ERROR_PC][0] = (val))> 
> > +/*
> > + * Some of the guest registers may be modified asynchronously (e.g. from
> > a
> > + * hrtimer callback in hard irq context) and therefore need stronger
> > atomicity + * guarantees than other registers.
> > + */
> > +
> > +static inline void _kvm_atomic_set_c0_guest_reg(unsigned long *reg,
> > +						unsigned long val)
> 
> The name of this function is too unclear.
> 
> It should be _kvm_atomic_or_c0_guest_reg, or
> _kvm_atomic_setbits_c0_guest_reg(unsigned long *reg, unsigned long mask)
> 
> > +{
> > +	unsigned long temp;
> > +	do {
> > +		__asm__ __volatile__(
> > +		"	.set	mips3				\n"
> > +		"	" __LL "%0, %1				\n"
> > +		"	or	%0, %2				\n"
> > +		"	" __SC	"%0, %1				\n"
> > +		"	.set	mips0				\n"
> > +		: "=&r" (temp), "+m" (*reg)
> > +		: "r" (val));
> > +	} while (unlikely(!temp));
> > +}
> > +
> > +static inline void _kvm_atomic_clear_c0_guest_reg(unsigned long *reg,
> > +						  unsigned long val)
> 
> Same here.
> 
> Perhaps _kvm_atomic_clearbits_c0_guest_reg(unsigned long *reg, unsigned
> long mask)
> 
> > +{
> > +	unsigned long temp;
> > +	do {
> > +		__asm__ __volatile__(
> > +		"	.set	mips3				\n"
> > +		"	" __LL "%0, %1				\n"
> > +		"	and	%0, %2				\n"
> > +		"	" __SC	"%0, %1				\n"
> > +		"	.set	mips0				\n"
> > +		: "=&r" (temp), "+m" (*reg)
> > +		: "r" (~val));
> > +	} while (unlikely(!temp));
> > +}
> > +
> > +static inline void _kvm_atomic_change_c0_guest_reg(unsigned long *reg,
> > +						   unsigned long change,
> > +						   unsigned long val)
> 
> Same here.
> 
> Perhaps
> 
> _kvm_atomic_setbits_c0_guest_reg(unsigned long *reg,
> 				unsigned long mask,
> 				unsigned long bits)
> 
> > +{
> > +	unsigned long temp;
> > +	do {
> > +		__asm__ __volatile__(
> > +		"	.set	mips3				\n"
> > +		"	" __LL "%0, %1				\n"
> > +		"	and	%0, %2				\n"
> > +		"	or	%0, %3				\n"
> > +		"	" __SC	"%0, %1				\n"
> > +		"	.set	mips0				\n"
> > +		: "=&r" (temp), "+m" (*reg)
> > +		: "r" (~change), "r" (val & change));
> > +	} while (unlikely(!temp));
> > +}
> > +
> > 
> >   #define kvm_set_c0_guest_status(cop0,
> >   val)	(cop0->reg[MIPS_CP0_STATUS][0] |= (val)) #define
> >   kvm_clear_c0_guest_status(cop0, val)	(cop0->reg[MIPS_CP0_STATUS][0] &=
> >   ~(val))> 
> > -#define kvm_set_c0_guest_cause(cop0, val)	(cop0->reg[MIPS_CP0_CAUSE][0]
> > |= (val)) -#define kvm_clear_c0_guest_cause(cop0,
> > val)	(cop0->reg[MIPS_CP0_CAUSE][0] &= ~(val)) +
> > +/* Cause can be modified asynchronously from hardirq hrtimer callback */
> > +#define kvm_set_c0_guest_cause(cop0, val)				\
> > +	_kvm_atomic_set_c0_guest_reg(&cop0->reg[MIPS_CP0_CAUSE][0], val)
> > +#define kvm_clear_c0_guest_cause(cop0, val)				\
> > +	_kvm_atomic_clear_c0_guest_reg(&cop0->reg[MIPS_CP0_CAUSE][0], val)
> > 
> >   #define kvm_change_c0_guest_cause(cop0, change, val)			\
> > 
> > -{									\
> > -	kvm_clear_c0_guest_cause(cop0, change);				\
> > -	kvm_set_c0_guest_cause(cop0, ((val) & (change)));		\
> > -}
> > +	_kvm_atomic_change_c0_guest_reg(&cop0->reg[MIPS_CP0_CAUSE][0],	\
> > +					change, val)
> > +
> > 
> >   #define kvm_set_c0_guest_ebase(cop0, val)	(cop0->reg[MIPS_CP0_PRID][1]
> >   |= (val)) #define kvm_clear_c0_guest_ebase(cop0,
> >   val)	(cop0->reg[MIPS_CP0_PRID][1] &= ~(val)) #define
> >   kvm_change_c0_guest_ebase(cop0, change, val)			\

--nextPart1679865.gt23WWEXNi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJTWsinAAoJEGwLaZPeOHZ6ahQP/3JPJdE7rbrRCqT2zX+SLbD7
XkyGsgfFzntjk4cx23bAJaxdt1wQ09z2rYOJ6r7J7dCD9uWg3mXD2tsc3mx3P3VC
c4X2L5+UH+WKKWJTKWRmQ3PzemWPkFsHsBVFSPyAFb9JELFw8qGQdx0gGNl6zu/3
051Pa63E0oYF2Mi7kVeeJQPQk3ZZX0T3YFG6/qmnhkeMlDiC+40jfVwa4Wpwe/9G
zpMyzAb7ZuNroQIv2Jz1sYctLgmz0mHcrjLDmVWaXnHFaQb8QE4LCJwqotcrWX4w
Ak/5Hzqf2ww6/9qpzJIGSoofNjtE+W9J3O6zxt2uyd+Q7bJdDpqdayJqwJAJM3Zr
Sx0/4VsnvincrtVfVx5JDjluTFqUa+Qf1VdRcDGLgor43qVo2pFWhSqRvfjkevBd
LKqPU7reAqWwbXzTZIIOJn8Pdt8l7iOf69BTcdn4AH6woV81ohu7PGnmLwD6EQ7A
CjegLYw9fzj3gIjjpcMvfCP6QczwSLUWZ8pNBaBJO7Tj9N6Nc3kqPAsXzn/chnyv
Tp4RPIhqPq7U2gtLQUF8uiGivmM/S12B8cY4+vsUFvskHRlpeAsABaRx/Fo7bVR0
9E8gEgkSEjOKqqH9pV6o75/ULV5/yLMzthKgmJyo4xH9Qoj6c1Kskbl99ti808QH
rn25g4tTMSb7UcASpo+O
=H6Ws
-----END PGP SIGNATURE-----

--nextPart1679865.gt23WWEXNi--
