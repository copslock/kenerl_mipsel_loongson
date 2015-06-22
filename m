Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Jun 2015 14:38:35 +0200 (CEST)
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34518 "EHLO
        mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008814AbbFVMidoXVlq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Jun 2015 14:38:33 +0200
Received: by wicnd19 with SMTP id nd19so75285229wic.1
        for <linux-mips@linux-mips.org>; Mon, 22 Jun 2015 05:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=GsQGiILZ9bE1+xQjMR8Ln5+FIc9YUMBIhy0jV+7QYmI=;
        b=aVCVd9VYIAhPmq6I8qg7Z2UT8DRa4WsnST9GF8uUp0fBiCLPuTCmKoZ4M1NG4zmeSY
         p41AiEXfVudHKV9LsrnshxtD0pKyGiENX80YEmAmnzQQu9lv5WLeZMztXz17OrFqhxw7
         PlchbV8oVVdW/mfvXhkYwLkRU1ftLbS2ZbFwbcgGJKf+ZONDW0JgI4qCCyZJ+VDc/cCY
         JTPL/0jTLxgTi6Ly7QEB2XcWBcfZidlsDxHfsG2j0dpPNHQseRHyJYr6WEXP4OcGEoCL
         SE0+zgjWvpjTLli8WugUTX8vOGNiJkRgzAPCcHDRpvOA56c2ZqWZLugrzmQPjIuPDv6c
         ZCrQ==
X-Received: by 10.194.22.105 with SMTP id c9mr42855402wjf.120.1434976708489;
        Mon, 22 Jun 2015 05:38:28 -0700 (PDT)
Received: from localhost (ip-86-49-65-8.net.upcbroadband.cz. [86.49.65.8])
        by mx.google.com with ESMTPSA id pl1sm17092417wic.6.2015.06.22.05.38.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2015 05:38:27 -0700 (PDT)
Date:   Mon, 22 Jun 2015 14:38:26 +0200
From:   Michal Hocko <mhocko@suse.cz>
To:     Eric B Munson <emunson@akamai.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [RESEND PATCH V2 1/3] Add mmap flag to request pages are locked
 after page fault
Message-ID: <20150622123826.GF4430@dhcp22.suse.cz>
References: <1433942810-7852-1-git-send-email-emunson@akamai.com>
 <1433942810-7852-2-git-send-email-emunson@akamai.com>
 <20150618152907.GG5858@dhcp22.suse.cz>
 <20150618203048.GB2329@akamai.com>
 <20150619145708.GG4913@dhcp22.suse.cz>
 <20150619164333.GD2329@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150619164333.GD2329@akamai.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <mstsxfx@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48001
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mhocko@suse.cz
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

On Fri 19-06-15 12:43:33, Eric B Munson wrote:
> On Fri, 19 Jun 2015, Michal Hocko wrote:
> 
> > On Thu 18-06-15 16:30:48, Eric B Munson wrote:
> > > On Thu, 18 Jun 2015, Michal Hocko wrote:
> > [...]
> > > > Wouldn't it be much more reasonable and straightforward to have
> > > > MAP_FAULTPOPULATE as a counterpart for MAP_POPULATE which would
> > > > explicitly disallow any form of pre-faulting? It would be usable for
> > > > other usecases than with MAP_LOCKED combination.
> > > 
> > > I don't see a clear case for it being more reasonable, it is one
> > > possible way to solve the problem.
> > 
> > MAP_FAULTPOPULATE would be usable for other cases as well. E.g. fault
> > around is all or nothing feature. Either all mappings (which support
> > this) fault around or none. There is no way to tell the kernel that
> > this particular mapping shouldn't fault around. I haven't seen such a
> > request yet but we have seen requests to have a way to opt out from
> > a global policy in the past (e.g. per-process opt out from THP). So
> > I can imagine somebody will come with a request to opt out from any
> > speculative operations on the mapped area in the future.
> > 
> > > But I think it leaves us in an even
> > > more akward state WRT VMA flags.  As you noted in your fix for the
> > > mmap() man page, one can get into a state where a VMA is VM_LOCKED, but
> > > not present.  Having VM_LOCKONFAULT states that this was intentional, if
> > > we go to using MAP_FAULTPOPULATE instead of MAP_LOCKONFAULT, we no
> > > longer set VM_LOCKONFAULT (unless we want to start mapping it to the
> > > presence of two MAP_ flags).  This can make detecting the MAP_LOCKED +
> > > populate failure state harder.
> > 
> > I am not sure I understand your point here. Could you be more specific
> > how would you check for that and what for?
> 
> My thought on detecting was that someone might want to know if they had
> a VMA that was VM_LOCKED but had not been made present becuase of a
> failure in mmap.  We don't have a way today, but adding VM_LOCKONFAULT
> is at least explicit about what is happening which would make detecting
> the VM_LOCKED but not present state easier. 

One could use /proc/<pid>/pagemap to query the residency.

> This assumes that
> MAP_FAULTPOPULATE does not translate to a VMA flag, but it sounds like
> it would have to.

Yes, it would have to have a VM flag for the vma.

> > From my understanding MAP_LOCKONFAULT is essentially
> > MAP_FAULTPOPULATE|MAP_LOCKED with a quite obvious semantic (unlike
> > single MAP_LOCKED unfortunately). I would love to also have
> > MAP_LOCKED|MAP_POPULATE (aka full mlock semantic) but I am really
> > skeptical considering how my previous attempt to make MAP_POPULATE
> > reasonable went.
> 
> Are you objecting to the addition of the VMA flag VM_LOCKONFAULT, or the
> new MAP_LOCKONFAULT flag (or both)? 

I thought the MAP_FAULTPOPULATE (or any other better name) would
directly translate into VM_FAULTPOPULATE and wouldn't be tight to the
locked semantic. We already have VM_LOCKED for that. The direct effect
of the flag would be to prevent from population other than the direct
page fault - including any speculative actions like fault around or
read-ahead.

> If you prefer that MAP_LOCKED |
> MAP_FAULTPOPULATE means that VM_LOCKONFAULT is set, I am fine with that
> instead of introducing MAP_LOCKONFAULT.  I went with the new flag
> because to date, we have a one to one mapping of MAP_* to VM_* flags.
> 
> > 
> > > If this is the preferred path for mmap(), I am fine with that. 
> > 
> > > However,
> > > I would like to see the new system calls that Andrew mentioned (and that
> > > I am testing patches for) go in as well. 
> > 
> > mlock with flags sounds like a good step but I am not sure it will make
> > sense in the future. POSIX has screwed that and I am not sure how many
> > applications would use it. This ship has sailed long time ago.
> 
> I don't know either, but the code is the question, right?  I know that
> we have at least one team that wants it here.
> 
> > 
> > > That way we give users the
> > > ability to request VM_LOCKONFAULT for memory allocated using something
> > > other than mmap.
> > 
> > mmap(MAP_FAULTPOPULATE); mlock() would have the same semantic even
> > without changing mlock syscall.
> 
> That is true as long as MAP_FAULTPOPULATE set a flag in the VMA(s).  It
> doesn't cover the actual case I was asking about, which is how do I get
> lock on fault on malloc'd memory?

OK I see your point now. We would indeed need a flag argument for mlock.
-- 
Michal Hocko
SUSE Labs
