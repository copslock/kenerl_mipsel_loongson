Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Apr 2012 01:18:13 +0200 (CEST)
Received: from terminus.zytor.com ([198.137.202.10]:42426 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903731Ab2DTXSG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 21 Apr 2012 01:18:06 +0200
Received: from hanvin-mobl6.amr.corp.intel.com (fmdmzpr01-ext.fm.intel.com [192.55.54.36])
        (authenticated bits=0)
        by mail.zytor.com (8.14.5/8.14.5) with ESMTP id q3KNHx0S011301
        (version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
        Fri, 20 Apr 2012 16:17:59 -0700
Message-ID: <4F91EEA2.8020502@zytor.com>
Date:   Fri, 20 Apr 2012 16:17:54 -0700
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
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] scripts: Make sortextable handle relocations.
References: <1334961679-14562-1-git-send-email-ddaney.cavm@gmail.com> <4F91EA5B.4000803@zytor.com> <4F91EDBD.4030700@gmail.com>
In-Reply-To: <4F91EDBD.4030700@gmail.com>
X-Enigmail-Version: 1.4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 32998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 04/20/2012 04:14 PM, David Daney wrote:
>>
>> I think Linus is right and the right thing to do is to switch to using
>> relative entries in the exception table; I am currently testing a
>> patchset to do exactly that (on x86).  It also has the benefit of making
>> the table half the size on x86-64.  Then we can just zero out the
>> .rel[a]__ex_table section and be done with it.
> 
> That's fine.
> 
> In any event we want to do build time sorting, this patch improves the
> original sortextable, so may be worthwhile as purely a cleanup.  I
> wanted to fix the relocation breakage, even if the eventual solution
> needs to be somewhat different.
> 

Yes... let me finish the patchset and then you can look at what is needed.

	-hpa
