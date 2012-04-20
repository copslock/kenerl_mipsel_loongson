Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Apr 2012 06:49:34 +0200 (CEST)
Received: from terminus.zytor.com ([198.137.202.10]:34175 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1901162Ab2DTEtX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Apr 2012 06:49:23 +0200
Received: from hanvin-mobl6.amr.corp.intel.com (jfdmzpr05-ext.jf.intel.com [134.134.139.74])
        (authenticated bits=0)
        by mail.zytor.com (8.14.5/8.14.5) with ESMTP id q3K4nAum025372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
        Thu, 19 Apr 2012 21:49:11 -0700
Message-ID: <4F90EAC1.6070508@zytor.com>
Date:   Thu, 19 Apr 2012 21:49:05 -0700
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
References: <1334872799-14589-1-git-send-email-ddaney.cavm@gmail.com> <1334872799-14589-2-git-send-email-ddaney.cavm@gmail.com> <4F90BF8D.7030209@zytor.com> <4F90D564.3090508@gmail.com> <CA+55aFyijf43qSu3N9nWHEBwaGbb7T2Oq9A=9EyR=Jtyqfq_cQ@mail.gmail.com> <4F90DB37.9080702@zytor.com>
In-Reply-To: <4F90DB37.9080702@zytor.com>
X-Enigmail-Version: 1.4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 32990
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 04/19/2012 08:42 PM, H. Peter Anvin wrote:
> 
> I don't think we can get _ASM_EXTABLE() to do that work for us, because
> we'd need to subtract symbols from two different sections.  We would
> need the postprocessing tool to take care this, but guess what, we can
> do exactly that (and then, as I mentioned, just zero out the relocation
> section.)
> 

Ah, apparently it is possible to generate relocations relative to the
start of the current section:

# define _ASM_EXTABLE(from,to)      			\
        __ASM_EX_SEC ;              			\
        _ASM_ALIGN ;                			\
        .long (from)-__ex_table,(to)-__ex_table ;       \
        .previous

Then all the postprocessor would have to do is to zero out the
relocation section, and we would always just add the base of the
particular __ex_table section.

We need to make sure the module loader works, too, and not to break the
__{get,put}_user_ex macros (which would need to use a new variant of
_ASM_EXTABLE()).

There is still a disturbing number of open-coded __ex_table instances
too; those all need to be converted.

Looks like a worthwhile project but not for tonight.

All of this is for x86... other architectures would need to be converted
in whatever way is appropriate.

	-hpa
