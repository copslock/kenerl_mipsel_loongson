Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Sep 2013 19:44:53 +0200 (CEST)
Received: from mail-bk0-f51.google.com ([209.85.214.51]:45887 "EHLO
        mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816233Ab3IYRorS37r6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Sep 2013 19:44:47 +0200
Received: by mail-bk0-f51.google.com with SMTP id mx10so2374072bkb.24
        for <multiple recipients>; Wed, 25 Sep 2013 10:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=hbA9GP+zgR0e+o9LIr0jlfpUvN0pdtY+EHjqI0S8zzY=;
        b=Ntv+8fl1l4t5x7aLSIbpo1ZFXCQ9RG757rjAFXPwMyvP57D0cn/9bFuzsk7yAbzQA0
         BhnHAThfwq0YWRAA2srFtRIn/8SSSUjFGRV8m2Y1LQjh8XTRu6MuiH4Wz06InIhzR9aU
         DZafmmyHaVEWyjQYnDpvqtqfufigAL6FumM2FwDRup89srhsHn8RxL/HijgBBUNlEgBs
         aRw8ZIHWsurjzph8S0h/tHaqk5H/A9WlOxrc7jZG9MCPpRfNKvqRn5QwPtdj9ubrmhu4
         2MDn89oWZi8bSM2uVG5RlvI3W5kfejBpIpQmjKs8IqiQkQhbe/PqPPCfgvBIuxHXxpvA
         isLw==
X-Received: by 10.205.35.15 with SMTP id su15mr28728498bkb.21.1380131081871;
        Wed, 25 Sep 2013 10:44:41 -0700 (PDT)
Received: from gmail.com (BC24D856.catv.pool.telekom.hu. [188.36.216.86])
        by mx.google.com with ESMTPSA id kk2sm14928985bkb.10.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 25 Sep 2013 10:44:39 -0700 (PDT)
Date:   Wed, 25 Sep 2013 19:44:36 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Timothy Pepper <timothy.c.pepper@linux.intel.com>
Cc:     linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Paul Mundt <lethal@linux-sh.org>,
        linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <james.l.morris@oracle.com>,
        Michel Lespinasse <walken@google.com>,
        Rik van Riel <riel@redhat.com>
Subject: Re: mm: insure topdown mmap chooses addresses above security minimum
Message-ID: <20130925174436.GA14037@gmail.com>
References: <1380057811-5352-1-git-send-email-timothy.c.pepper@linux.intel.com>
 <20130925073048.GB27960@gmail.com>
 <20130925171243.GA7428@tcpepper-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130925171243.GA7428@tcpepper-desk.jf.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <mingo.kernel.org@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37975
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@kernel.org
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


* Timothy Pepper <timothy.c.pepper@linux.intel.com> wrote:

> On Wed 25 Sep at 09:30:49 +0200 mingo@kernel.org said:
> > >  	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
> > >  	info.length = len;
> > > -	info.low_limit = PAGE_SIZE;
> > > +	info.low_limit = max(PAGE_SIZE, PAGE_ALIGN(mmap_min_addr));
> > >  	info.high_limit = mm->mmap_base;
> > >  	info.align_mask = filp ? get_align_mask() : 0;
> > >  	info.align_offset = pgoff << PAGE_SHIFT;
> > 
> > There appears to be a lot of repetition in these methods - instead of 
> > changing 6 places it would be more future-proof to first factor out the 
> > common bits and then to apply the fix to the shared implementation.
> 
> Besides that existing redundancy in the multiple somewhat similar
> arch_get_unmapped_area_topdown() functions, I was expecting people might
> question the added redundancy of the six instances of:
> 
> 	max(PAGE_SIZE, PAGE_ALIGN(mmap_min_addr));

That redundancy would be automatically addressed by my suggestion.

Thanks,

	Ingo
