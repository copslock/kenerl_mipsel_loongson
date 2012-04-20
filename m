Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Apr 2012 03:45:09 +0200 (CEST)
Received: from terminus.zytor.com ([198.137.202.10]:33211 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903730Ab2DTBpB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Apr 2012 03:45:01 +0200
Received: from tazenda.hos.anvin.org ([IPv6:2001:470:861f::feed:face:f00d])
        (authenticated bits=0)
        by mail.zytor.com (8.14.5/8.14.5) with ESMTP id q3K1ioF4018493
        (version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=OK);
        Thu, 19 Apr 2012 18:44:50 -0700
Message-ID: <4F90BF8D.7030209@zytor.com>
Date:   Thu, 19 Apr 2012 18:44:45 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Marek <mmarek@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v1 1/5] scripts: Add sortextable to sort the kernel's
 exception table.
References: <1334872799-14589-1-git-send-email-ddaney.cavm@gmail.com> <1334872799-14589-2-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1334872799-14589-2-git-send-email-ddaney.cavm@gmail.com>
X-Enigmail-Version: 1.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-archive-position: 32986
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

I committed this into the tip tree, but I realized something scary on
the way home... this program is broken: it doesn't handle the
relocations that go with the entries.  Specifically, it needs to not
just handle __ex_table, it also needs to handle the corresponding
entries in .rel__ex_table.

On x86-32, in particular, *most*, but not *all*, extable relocations
will have an R_386_32 relocation on it, so the resulting binary will
"mostly work"... but the ELF metadata will be wrong, and pretty much any
user of the try/catch mechanism will be broken, unless your kernel
happens to be located at its preferred address.

This needs to be addressed, either by adjusting the exception table to
be relative (which would be good for code size on 64-bit platforms)
*and* zero out the .rel__ex_table section or by making the program
actually sort the relocations correctly.

	-hpa

On 04/19/2012 02:59 PM, David Daney wrote:
> +
> +/* w8rev, w8nat, ...: Handle endianness. */
> +
> +static uint64_t w8rev(uint64_t const x)
> +{
> +	return   ((0xff & (x >> (0 * 8))) << (7 * 8))
> +	       | ((0xff & (x >> (1 * 8))) << (6 * 8))
> +	       | ((0xff & (x >> (2 * 8))) << (5 * 8))
> +	       | ((0xff & (x >> (3 * 8))) << (4 * 8))
> +	       | ((0xff & (x >> (4 * 8))) << (3 * 8))
> +	       | ((0xff & (x >> (5 * 8))) << (2 * 8))
> +	       | ((0xff & (x >> (6 * 8))) << (1 * 8))
> +	       | ((0xff & (x >> (7 * 8))) << (0 * 8));
> +}
> +
> +static uint32_t w4rev(uint32_t const x)
> +{
> +	return   ((0xff & (x >> (0 * 8))) << (3 * 8))
> +	       | ((0xff & (x >> (1 * 8))) << (2 * 8))
> +	       | ((0xff & (x >> (2 * 8))) << (1 * 8))
> +	       | ((0xff & (x >> (3 * 8))) << (0 * 8));
> +}
> +
> +static uint32_t w2rev(uint16_t const x)
> +{
> +	return   ((0xff & (x >> (0 * 8))) << (1 * 8))
> +	       | ((0xff & (x >> (1 * 8))) << (0 * 8));
> +}
> +
> +static uint64_t w8nat(uint64_t const x)
> +{
> +	return x;
> +}
> +
> +static uint32_t w4nat(uint32_t const x)
> +{
> +	return x;
> +}
> +
> +static uint32_t w2nat(uint16_t const x)
> +{
> +	return x;
> +}
> +
> +static uint64_t (*w8)(uint64_t);
> +static uint32_t (*w)(uint32_t);
> +static uint32_t (*w2)(uint16_t);

Stylistic note: these should use the <tools/*_byteshift.h> headers now.

	-hpa


-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
