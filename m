Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 00:52:51 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57977 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012371AbcBIXwuUIdrO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Feb 2016 00:52:50 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 1373149335A71;
        Tue,  9 Feb 2016 23:52:40 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Tue, 9 Feb 2016
 23:52:43 +0000
Date:   Tue, 9 Feb 2016 23:52:42 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        <blogic@openwrt.org>, <cernekee@gmail.com>,
        <jon.fraser@broadcom.com>, <pgynther@google.com>,
        <paul.burton@imgtec.com>, <ddaney.cavm@gmail.com>
Subject: Re: [PATCH 1/6] MIPS: BMIPS: Disable pref 30 for buggy CPUs
In-Reply-To: <56BA6AD3.9050308@gmail.com>
Message-ID: <alpine.DEB.2.00.1602092245180.15885@tp.orcam.me.uk>
References: <1455051354-6225-1-git-send-email-f.fainelli@gmail.com> <1455051354-6225-2-git-send-email-f.fainelli@gmail.com> <alpine.DEB.2.00.1602092101240.15885@tp.orcam.me.uk> <56BA6AD3.9050308@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Tue, 9 Feb 2016, Florian Fainelli wrote:

> >> +static void bmips5000_pref30_quirk(void)
> >> +{
> >> +	__asm__ __volatile__(
> >> +	"	.word	0x4008b008\n"	/* mfc0 $8, $22, 8 */
> >> +	"	lui	$9, 0x0100\n"
> >> +	"	or	$8, $9\n"
> >> +	/* disable "pref 30" on buggy CPUs */
> >> +	"	lui	$9, 0x0800\n"
> >> +	"	or	$8, $9\n"
> >> +	"	.word	0x4088b008\n"	/* mtc0 $8, $22, 8 */
> >> +	: : : "$8", "$9");
> >> +}
> > 
> >  Ouch, why not using our standard accessors and avoid magic numbers, e.g.:
> 
> Are you positive the assembler will not barf on these custom cp0 reg 22
> selectors?

 Indeed, I missed that this is beyond the usual select range of 0-7.  
Sorry about that.

 That does not mean it shouldn't be done in a cleaner way, stashing the 
obscurity in one place only.  I did notice a similar piece in one of your 
other patches, which is a strong argument for abstracting it.

 So first, are you aware of support for these Broadcom instruction 
encoding extensions being considered for inclusion in binutils?  I'll be 
happy to accept a patch and AFAICT it's a simple extension of the `sel' 
field within the existing MFC0/MTC0 instruction definitions.

 Second, regardless we need to abstract this in a reusable way while we 
don't have such support in the assembler.  So here:

> > #define read_c0_brcm_whateverthisiscalled() \
> > 	__read_32bit_c0_register($22, 8)
> > #define write_c0_brcm_whateverthisiscalled(val) \
> > 	__write_32bit_c0_register($22, 8, val)

rather than using `__read_32bit_c0_register' and 
`__write_32bit_c0_register' we can define special 
`__read_32bit_c0_brcm_register' and `__write_32bit_c0_brcm_register' 
helpers like:

#define __read_32bit_c0_brcm_register(reg, sel)				\
({									\
	register unsigned int __res asm("t0");				\
									\
	__asm__ __volatile__(						\
		/* mfc0 t0, $reg, sel */				\
		".word	0x40080000 | ((%1 & 0x1f) << 11) | (%2 & 0xf)"	\
		: "=r" (__res) : "i" (reg), "i" (sel));			\
	__res;								\
})

#define __write_32bit_c0_brcm_register(reg, sel, value)			\
do {									\
	register unsigned int __val asm("t0") = value;			\
									\
	__asm__ __volatile__(						\
		/* mtc0 t0, $reg, sel */				\
		".word  0x40880000 | ((%1 & 0x1f) << 11) | (%2 & 0xf)"	\
		: : "r" (__val), "i" (reg), "i" (sel));			\
} while (0)

(if 0xf is indeed the mask for `sel').  This is untested, but should work, 
perhaps with a minor fix somewhere if I made a typo.  It should also 
produce a little bit better code, although I realise this is a corner case 
hardly worth optimising for.  What is important is maintainability.

> > #define BMIPS5000_WHATEVERTHISISCALLED_BIT_X 0x0100
> > #define BMIPS5000_WHATEVERTHISISCALLED_BIT_Y 0x0800
> > 
> > static void bmips5000_pref30_quirk(void)
> > {
> > 	unsigned int whateverthisiscalled;
> > 
> > 	whateverthisiscalled = read_c0_brcm_whateverthisiscalled();
> > 	whateverthisiscalled |= BMIPS_WHATEVERTHISISCALLED_BIT_X;
> > 	/* disable "pref 30" on buggy CPUs */
> > 	whateverthisiscalled |= BMIPS_WHATEVERTHISISCALLED_BIT_Y;
> > 	write_c0_brcm_whateverthisiscalled(whateverthisiscalled);
> > }
> > 
> > ?  I'm leaving it up to you to select the right names here -- just about 
> > anything will be better than the halfway-binary piece you have proposed.
> 
> These are not standardized registers in any form, which is why these are
> in a halfway-binary form, they are not meant to be re-used outside of
> two known places: disabling pref30 and enabling "rotr".

 Well, if Broadcom didn't give this register any name, then `reg22_sel8' 
will be as good as any.  We don't need to invent things here, just to keep 
them maintainable.  If you call something `8', then you can't easily 
search through the tree to find references.  If you use something uniquely 
identifiable, then you can.  So:

#define read_c0_brcm_reg22_sel8()					\
	__read_32bit_c0_brcm_register(22, 8)
#define write_c0_brcm_reg22_sel8(val)					\
	__write_32bit_c0_brcm_register(22, 8, val)

(note the dropped `$' because we can't pass it along in this form).

 As to the bit names -- you already gave them: NO_PREF30 (since this is 
negated) and ROTR will be just fine, with a BMIPS5000_REG22_SEL8_ prefix.  
So:

#define BMIPS5000_REG22_SEL8_ROTR	0x0100
#define BMIPS5000_REG22_SEL8_NO_PREF30	0x0800

(why is ROTR set along NO_PREF30 BTW? -- it does not seem related).

 I hope you agree this all is reasonable from a maintainer's point of 
view.  I'll leave it up to you to make a patch out of it.  You'll then be 
able to use this stuff in 2/6 too.

 Please try to give meaningful names to the other magic numbers you 
introduce too.

  Maciej
