Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jul 2006 09:28:48 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.187]:18631 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S8133396AbWGKI2h (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 11 Jul 2006 09:28:37 +0100
Received: by nf-out-0910.google.com with SMTP id k27so141131nfc
        for <linux-mips@linux-mips.org>; Tue, 11 Jul 2006 01:28:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=oWante4wEqW7XS6sFVOCCWpcwEDO6peQLed5/y20uk9+qZ2u9KEvSQgZlU7IrX2KNez10uwmE2+fSpWff4DTb+eoBotyDmAowAQuXNC0jOk5ixAL64gH+VgF/a+cM7N7yIdKnO6PjHyUBX2dCh1FjG84Vrzo0G2N4SIKDP26kc0=
Received: by 10.48.1.4 with SMTP id 4mr280349nfa;
        Tue, 11 Jul 2006 01:28:34 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id k24sm13420090nfc.2006.07.11.01.28.33;
        Tue, 11 Jul 2006 01:28:34 -0700 (PDT)
Message-ID: <44B3625B.7000700@innova-card.com>
Date:	Tue, 11 Jul 2006 10:33:31 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] do not count pages in holes with sparsemem
References: <cda58cb80607060805yc656114p53516b904188c20f@mail.gmail.com>	<20060707.002602.75184460.anemo@mba.ocn.ne.jp>	<cda58cb80607100434h13831eb7rc6eda13a0d9e373f@mail.gmail.com> <20060710.233454.39153668.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060710.233454.39153668.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Mon, 10 Jul 2006 13:34:06 +0200, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> 
>> can we use pfn_valid() instead of page_is_ram() ? bootmem_init() and
>> sparse_init() have already been called so pfn_valid() should be safe
>> here....
> 
> We can, but we can get more precise value using page_is_ram().  The
> pfn_valid() returns true for _all_ pages on present section, and
> currently the section size is 256MB.

so your total pages of RAM in show_mem() is incorrect...

               if (!pfn_valid(pfn))
                        continue;
                page = pfn_to_page(pfn);
                total++;


I don't know SPARSEMEM a lot but is it allowed to have holes inside
a section ? Shouldn't we tune the section size to avoid holes inside
section ?

> 
>>> -       max_mapnr = num_physpages = highend_pfn;
>>> +       max_mapnr = highend_pfn;
>>>  #else
>>> -       max_mapnr = num_physpages = max_low_pfn;
>>> +       max_mapnr = max_low_pfn;
>> this is not always true, specially if FLATMEM set and your physical mem
>> do not start at 0.
> 
> Yes, and I think you are preparing a patch for these systems ;-)
> 

good point :)

		Franck
