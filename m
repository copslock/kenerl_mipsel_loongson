Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Apr 2012 06:55:08 +0200 (CEST)
Received: from terminus.zytor.com ([198.137.202.10]:34212 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1901162Ab2DTEzD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Apr 2012 06:55:03 +0200
Received: from hanvin-mobl6.amr.corp.intel.com (fmdmzpr03-ext.fm.intel.com [192.55.54.38])
        (authenticated bits=0)
        by mail.zytor.com (8.14.5/8.14.5) with ESMTP id q3K4ssKN026295
        (version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
        Thu, 19 Apr 2012 21:54:55 -0700
Message-ID: <4F90EC19.7070103@zytor.com>
Date:   Thu, 19 Apr 2012 21:54:49 -0700
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
References: <1334872799-14589-1-git-send-email-ddaney.cavm@gmail.com> <1334872799-14589-2-git-send-email-ddaney.cavm@gmail.com> <4F90BF8D.7030209@zytor.com> <4F90D564.3090508@gmail.com> <CA+55aFyijf43qSu3N9nWHEBwaGbb7T2Oq9A=9EyR=Jtyqfq_cQ@mail.gmail.com> <4F90DB37.9080702@zytor.com> <4F90EAC1.6070508@zytor.com>
In-Reply-To: <4F90EAC1.6070508@zytor.com>
X-Enigmail-Version: 1.4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 32991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 04/19/2012 09:49 PM, H. Peter Anvin wrote:
> 
> Ah, apparently it is possible to generate relocations relative to the
> start of the current section.
> 

Nevermind... I'm wrong.  The assembler will generate them but the linker
will produce garbage.

So I think using PC-relative relocations and have the postprocessor (or
the sort in the module loader) convert them to section-relative makes
sense...

	-hpa
