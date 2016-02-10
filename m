Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 01:05:48 +0100 (CET)
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36596 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011376AbcBJAFqoRaoO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Feb 2016 01:05:46 +0100
Received: by mail-pf0-f175.google.com with SMTP id e127so2028992pfe.3;
        Tue, 09 Feb 2016 16:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=aCZBMy8Zt2yfnz2itZ3bBfXlzt/psNayTp4UCpfHs5I=;
        b=WuQhOFaFiyZFVMDY+jFX0gzm0x95nRG+0nh3Z+Q1ipeEpcasJ0BdH2a8AH1ktClhMM
         tdF9rZpVps5KZ20u2VvGTbniSRQ6WaNACN1RJAR6bd0a/N+AzAtW1CIuPyX2Y46hyciU
         vYTU4KgPVKQ8DTGib8Eh0xxdAkFshL1OM/usZZIAZzu/p5uHdDPkmlpAQ8pkrK+mHotg
         vLBvCqKx4MbXdNO5SLZk0H5/MCm/27BULHYg32wVItvWCbc6E+J2DJgkFV5C1d5wlDq0
         ov0MADq27+x50ZFl8CePgTC4I8fooiNCu5XynTVdtnvn8n0gAqRcI7L/wHwt/eP6vniS
         oXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=aCZBMy8Zt2yfnz2itZ3bBfXlzt/psNayTp4UCpfHs5I=;
        b=CpFQ9c+gjxzH+AvDKypcn+4SYp7bCKqE4AwiavmHfzhsJIH5pAeQDFWT5fKXsyov3x
         49QWEOzy7/i5sxkIPx6gmk45sgNwNA9XEUYk9m+Ij6MpMi0ki3PrMwfr0fIL2uH3vUw9
         4XWevwqDiMr4sy9r1u9iceZRFIoxx0DQEl9jKEZ8FA5Pzfd6+GVWp3YWmbTz6SR+mHI1
         pmRoagKOfKnSBQWi3AseeuE0IKOoWlWnwOi9PcSTDQvobPBLaZkrUZrq5rPji6qIWu/X
         7o0TGrjSwijgZCLaCbme4GlwWYkPudlLdxMcsacYZDG3ZRosovZffaQUfM+HnqefCxdP
         OE9A==
X-Gm-Message-State: AG10YOSYJ0/txKBSJii04VYLT/519hRcWD+58C19YMA854xtVjPbQQuhtXmVpu/v39OCqg==
X-Received: by 10.98.42.207 with SMTP id q198mr28750695pfq.103.1455062740835;
        Tue, 09 Feb 2016 16:05:40 -0800 (PST)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id fl9sm356120pab.30.2016.02.09.16.05.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2016 16:05:40 -0800 (PST)
Subject: Re: [PATCH 1/6] MIPS: BMIPS: Disable pref 30 for buggy CPUs
To:     "Maciej W. Rozycki" <macro@imgtec.com>
References: <1455051354-6225-1-git-send-email-f.fainelli@gmail.com>
 <1455051354-6225-2-git-send-email-f.fainelli@gmail.com>
 <alpine.DEB.2.00.1602092101240.15885@tp.orcam.me.uk>
 <56BA6AD3.9050308@gmail.com>
 <alpine.DEB.2.00.1602092245180.15885@tp.orcam.me.uk>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        blogic@openwrt.org, cernekee@gmail.com, jon.fraser@broadcom.com,
        pgynther@google.com, paul.burton@imgtec.com, ddaney.cavm@gmail.com
From:   Florian Fainelli <f.fainelli@gmail.com>
X-Enigmail-Draft-Status: N1110
Message-ID: <56BA7E94.6080302@gmail.com>
Date:   Tue, 9 Feb 2016 16:04:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:44.0) Gecko/20100101
 Thunderbird/44.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1602092245180.15885@tp.orcam.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 09/02/16 15:52, Maciej W. Rozycki wrote:
> On Tue, 9 Feb 2016, Florian Fainelli wrote:
> 
>>>> +static void bmips5000_pref30_quirk(void)
>>>> +{
>>>> +	__asm__ __volatile__(
>>>> +	"	.word	0x4008b008\n"	/* mfc0 $8, $22, 8 */
>>>> +	"	lui	$9, 0x0100\n"
>>>> +	"	or	$8, $9\n"
>>>> +	/* disable "pref 30" on buggy CPUs */
>>>> +	"	lui	$9, 0x0800\n"
>>>> +	"	or	$8, $9\n"
>>>> +	"	.word	0x4088b008\n"	/* mtc0 $8, $22, 8 */
>>>> +	: : : "$8", "$9");
>>>> +}
>>>
>>>  Ouch, why not using our standard accessors and avoid magic numbers, e.g.:
>>
>> Are you positive the assembler will not barf on these custom cp0 reg 22
>> selectors?
> 
>  Indeed, I missed that this is beyond the usual select range of 0-7.  
> Sorry about that.
> 
>  That does not mean it shouldn't be done in a cleaner way, stashing the 
> obscurity in one place only.  I did notice a similar piece in one of your 
> other patches, which is a strong argument for abstracting it.
> 
>  So first, are you aware of support for these Broadcom instruction 
> encoding extensions being considered for inclusion in binutils?  I'll be 
> happy to accept a patch and AFAICT it's a simple extension of the `sel' 
> field within the existing MFC0/MTC0 instruction definitions.

That's a bit of a stretch for something that a) nobody is likely to
benefit from except these two patches, b) introducing a 3 way dependency
with: getting these current patches accepted, wait for the new binutils
to be widely spread we can count on the assembler to know about these
additional selectors, update the kernel again...

> 
>  Second, regardless we need to abstract this in a reusable way while we 
> don't have such support in the assembler.  So here:
> 
>>> #define read_c0_brcm_whateverthisiscalled() \
>>> 	__read_32bit_c0_register($22, 8)
>>> #define write_c0_brcm_whateverthisiscalled(val) \
>>> 	__write_32bit_c0_register($22, 8, val)
> 
> rather than using `__read_32bit_c0_register' and 
> `__write_32bit_c0_register' we can define special 
> `__read_32bit_c0_brcm_register' and `__write_32bit_c0_brcm_register' 
> helpers like:
> 
> #define __read_32bit_c0_brcm_register(reg, sel)				\
> ({									\
> 	register unsigned int __res asm("t0");				\
> 									\
> 	__asm__ __volatile__(						\
> 		/* mfc0 t0, $reg, sel */				\
> 		".word	0x40080000 | ((%1 & 0x1f) << 11) | (%2 & 0xf)"	\
> 		: "=r" (__res) : "i" (reg), "i" (sel));			\
> 	__res;								\
> })
> 
> #define __write_32bit_c0_brcm_register(reg, sel, value)			\
> do {									\
> 	register unsigned int __val asm("t0") = value;			\
> 									\
> 	__asm__ __volatile__(						\
> 		/* mtc0 t0, $reg, sel */				\
> 		".word  0x40880000 | ((%1 & 0x1f) << 11) | (%2 & 0xf)"	\
> 		: : "r" (__val), "i" (reg), "i" (sel));			\
> } while (0)
> 
> (if 0xf is indeed the mask for `sel').  This is untested, but should work, 
> perhaps with a minor fix somewhere if I made a typo.  It should also 
> produce a little bit better code, although I realise this is a corner case 
> hardly worth optimising for.  What is important is maintainability.

Maintainability works if these things are going to dramatically change
in the future, as the code stands right now, I grant it to you it is
doing some funky voodoo, but it is documented enough you could
understand what that does.

> 
>>> #define BMIPS5000_WHATEVERTHISISCALLED_BIT_X 0x0100
>>> #define BMIPS5000_WHATEVERTHISISCALLED_BIT_Y 0x0800
>>>
>>> static void bmips5000_pref30_quirk(void)
>>> {
>>> 	unsigned int whateverthisiscalled;
>>>
>>> 	whateverthisiscalled = read_c0_brcm_whateverthisiscalled();
>>> 	whateverthisiscalled |= BMIPS_WHATEVERTHISISCALLED_BIT_X;
>>> 	/* disable "pref 30" on buggy CPUs */
>>> 	whateverthisiscalled |= BMIPS_WHATEVERTHISISCALLED_BIT_Y;
>>> 	write_c0_brcm_whateverthisiscalled(whateverthisiscalled);
>>> }
>>>
>>> ?  I'm leaving it up to you to select the right names here -- just about 
>>> anything will be better than the halfway-binary piece you have proposed.
>>
>> These are not standardized registers in any form, which is why these are
>> in a halfway-binary form, they are not meant to be re-used outside of
>> two known places: disabling pref30 and enabling "rotr".
> 
>  Well, if Broadcom didn't give this register any name, then `reg22_sel8' 
> will be as good as any.  We don't need to invent things here, just to keep 
> them maintainable.  If you call something `8', then you can't easily 
> search through the tree to find references.  If you use something uniquely 
> identifiable, then you can.  So:
> 
> #define read_c0_brcm_reg22_sel8()					\
> 	__read_32bit_c0_brcm_register(22, 8)
> #define write_c0_brcm_reg22_sel8(val)					\
> 	__write_32bit_c0_brcm_register(22, 8, val)
> 
> (note the dropped `$' because we can't pass it along in this form).
> 
>  As to the bit names -- you already gave them: NO_PREF30 (since this is 
> negated) and ROTR will be just fine, with a BMIPS5000_REG22_SEL8_ prefix.  
> So:
> 
> #define BMIPS5000_REG22_SEL8_ROTR	0x0100
> #define BMIPS5000_REG22_SEL8_NO_PREF30	0x0800

I like your suggestion.

> 
> (why is ROTR set along NO_PREF30 BTW? -- it does not seem related).

They are not, Petri is quoting the downstream kernel which does thing
completely differently because it has separate build options per SoC.
The upstream kernel does not, it can run the sam binary on multiple SoCs
and perform run-time detection, hence the two patches which changes
things at two different spots because, unrelated.
> 
>  I hope you agree this all is reasonable from a maintainer's point of 
> view.  I'll leave it up to you to make a patch out of it.  You'll then be 
> able to use this stuff in 2/6 too.

It seems reasonable to adopt your suggestion, but I will certainly drop
the binutils suggestion, that's just way out of the scope of this patch,
and creates a dependency issue that I do not want to deal with, as
history showed recently, testing correctly for a proper ld version
turned out to be interesting, so pardon my skepticism here.

> 
>  Please try to give meaningful names to the other magic numbers you 
> introduce too.

These are actually *magic* register values, I swear to you, I had to dig
in the RTL to understand what this does, there is zero documentation
besides the code.
-- 
Florian
