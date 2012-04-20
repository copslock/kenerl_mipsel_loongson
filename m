Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Apr 2012 05:18:23 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:34241 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901162Ab2DTDSF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Apr 2012 05:18:05 +0200
Received: by pbcun4 with SMTP id un4so595749pbc.36
        for <multiple recipients>; Thu, 19 Apr 2012 20:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=zd4iKqIri2kgtMfhGyFOawBehDdsrP+jLvjSHM80EG0=;
        b=SCwxSjxgBN4dj1J+eToVFgavIBDbg3jjEc3G1PmloF6q1jMWvwRzA/szHi7TNdGxPr
         LH/gW5UdXu6qd2rbPxoJnC2+t5wQGCh5rp7NbqsGJfjrJvHx5rE5DiUIxJ0p+cw0Jyo2
         OWFDvIz1pmvzAeyVUHk4zp3+T/eK6TGBf7UHWae0YIrbgPjytWWzqb8fXezq3XjwedG2
         BEHZjbHVR1kSynwcbmAIqVhi5GfX9LKxTXYuq5dgL6JktVAOSJqRGstjhdTqxRSbnFcm
         /0M2m0v/RHLoYOc53TYCzcfPS2gOXQxlidNrXSrhYDoD5kZWD1nbldCwR2Ba2kXev8nd
         rWrg==
Received: by 10.68.190.40 with SMTP id gn8mr9508756pbc.12.1334891878830;
        Thu, 19 Apr 2012 20:17:58 -0700 (PDT)
Received: from dd_xps.caveonetworks.com (adsl-68-122-34-125.dsl.pltn13.pacbell.net. [68.122.34.125])
        by mx.google.com with ESMTPS id my1sm2397326pbc.53.2012.04.19.20.17.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Apr 2012 20:17:57 -0700 (PDT)
Message-ID: <4F90D564.3090508@gmail.com>
Date:   Thu, 19 Apr 2012 20:17:56 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
MIME-Version: 1.0
To:     "H. Peter Anvin" <hpa@zytor.com>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Marek <mmarek@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v1 1/5] scripts: Add sortextable to sort the kernel's
 exception table.
References: <1334872799-14589-1-git-send-email-ddaney.cavm@gmail.com> <1334872799-14589-2-git-send-email-ddaney.cavm@gmail.com> <4F90BF8D.7030209@zytor.com>
In-Reply-To: <4F90BF8D.7030209@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32987
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 04/19/2012 06:44 PM, H. Peter Anvin wrote:
> I committed this into the tip tree, but I realized something scary on
> the way home... this program is broken: it doesn't handle the
> relocations that go with the entries.  Specifically, it needs to not
> just handle __ex_table, it also needs to handle the corresponding
> entries in .rel__ex_table.
>
> On x86-32, in particular, *most*, but not *all*, extable relocations
> will have an R_386_32 relocation on it, so the resulting binary will
> "mostly work"... but the ELF metadata will be wrong, and pretty much any
> user of the try/catch mechanism will be broken, unless your kernel
> happens to be located at its preferred address.
>
> This needs to be addressed, either by adjusting the exception table to
> be relative (which would be good for code size on 64-bit platforms)
> *and* zero out the .rel__ex_table section or by making the program
> actually sort the relocations correctly.

Crap.

I hadn't considered that the image was relocatable.  Our MIPS kernels 
never have relocations.

I am working on a version of this that handles the relocations.  It 
shouldn't be too difficult.


> 	-hpa
>
> On 04/19/2012 02:59 PM, David Daney wrote:
>> +
>> +/* w8rev, w8nat, ...: Handle endianness. */
>> +
>> +static uint64_t w8rev(uint64_t const x)
>> +{
>> +	return   ((0xff&  (x>>  (0 * 8)))<<  (7 * 8))
>> +	       | ((0xff&  (x>>  (1 * 8)))<<  (6 * 8))
>> +	       | ((0xff&  (x>>  (2 * 8)))<<  (5 * 8))
>> +	       | ((0xff&  (x>>  (3 * 8)))<<  (4 * 8))
>> +	       | ((0xff&  (x>>  (4 * 8)))<<  (3 * 8))
>> +	       | ((0xff&  (x>>  (5 * 8)))<<  (2 * 8))
>> +	       | ((0xff&  (x>>  (6 * 8)))<<  (1 * 8))
>> +	       | ((0xff&  (x>>  (7 * 8)))<<  (0 * 8));
>> +}
>> +
>> +static uint32_t w4rev(uint32_t const x)
>> +{
>> +	return   ((0xff&  (x>>  (0 * 8)))<<  (3 * 8))
>> +	       | ((0xff&  (x>>  (1 * 8)))<<  (2 * 8))
>> +	       | ((0xff&  (x>>  (2 * 8)))<<  (1 * 8))
>> +	       | ((0xff&  (x>>  (3 * 8)))<<  (0 * 8));
>> +}
>> +
>> +static uint32_t w2rev(uint16_t const x)
>> +{
>> +	return   ((0xff&  (x>>  (0 * 8)))<<  (1 * 8))
>> +	       | ((0xff&  (x>>  (1 * 8)))<<  (0 * 8));
>> +}
>> +
>> +static uint64_t w8nat(uint64_t const x)
>> +{
>> +	return x;
>> +}
>> +
>> +static uint32_t w4nat(uint32_t const x)
>> +{
>> +	return x;
>> +}
>> +
>> +static uint32_t w2nat(uint16_t const x)
>> +{
>> +	return x;
>> +}
>> +
>> +static uint64_t (*w8)(uint64_t);
>> +static uint32_t (*w)(uint32_t);
>> +static uint32_t (*w2)(uint16_t);
> Stylistic note: these should use the<tools/*_byteshift.h>  headers now.

I will try to use those.

Thanks,
David Daney
