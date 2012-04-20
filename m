Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Apr 2012 05:43:15 +0200 (CEST)
Received: from terminus.zytor.com ([198.137.202.10]:33837 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1901162Ab2DTDnH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Apr 2012 05:43:07 +0200
Received: from hanvin-mobl6.amr.corp.intel.com (jfdmzpr02-ext.jf.intel.com [134.134.137.71])
        (authenticated bits=0)
        by mail.zytor.com (8.14.5/8.14.5) with ESMTP id q3K3grha010678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
        Thu, 19 Apr 2012 20:42:54 -0700
Message-ID: <4F90DB37.9080702@zytor.com>
Date:   Thu, 19 Apr 2012 20:42:47 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
MIME-Version: 1.0
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     David Daney <david.s.daney@gmail.com>,
        David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Michal Marek <mmarek@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v1 1/5] scripts: Add sortextable to sort the kernel's
 exception table.
References: <1334872799-14589-1-git-send-email-ddaney.cavm@gmail.com> <1334872799-14589-2-git-send-email-ddaney.cavm@gmail.com> <4F90BF8D.7030209@zytor.com> <4F90D564.3090508@gmail.com> <CA+55aFyijf43qSu3N9nWHEBwaGbb7T2Oq9A=9EyR=Jtyqfq_cQ@mail.gmail.com>
In-Reply-To: <CA+55aFyijf43qSu3N9nWHEBwaGbb7T2Oq9A=9EyR=Jtyqfq_cQ@mail.gmail.com>
X-Enigmail-Version: 1.4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 32989
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 04/19/2012 08:31 PM, Linus Torvalds wrote:
> On Thu, Apr 19, 2012 at 8:17 PM, David Daney <david.s.daney@gmail.com> wrote:
>>
>> I hadn't considered that the image was relocatable.  Our MIPS kernels never
>> have relocations.
>>
>> I am working on a version of this that handles the relocations.  It
>> shouldn't be too difficult.
> 
> It might be better to just make the rule be that we don't have
> relocations there - make everything relative to the start of the code
> segment or something.
> 
> On x86, we already use that _ASM_EXTABLE() macro to hide the
> differences between x86-64 and x86-32. So it should be be somewhat
> easy to make that same macro make it relative to the code start, and
> at the same time also make the exception table perhaps be two 32-bit
> words rather than two pointers.
> 
> So it would shrink the exception table and avoid relocations at the
> same time. Win-win. No?
> 

I don't think we can get _ASM_EXTABLE() to do that work for us, because
we'd need to subtract symbols from two different sections.  We would
need the postprocessing tool to take care this, but guess what, we can
do exactly that (and then, as I mentioned, just zero out the relocation
section.)

	-hpa
