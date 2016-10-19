Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Oct 2016 19:01:41 +0200 (CEST)
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36667 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991978AbcJSRBelTeUb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Oct 2016 19:01:34 +0200
Received: by mail-lf0-f67.google.com with SMTP id b75so2981571lfg.3
        for <linux-mips@linux-mips.org>; Wed, 19 Oct 2016 10:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L2u3TgydR1ZWwHYZve8NmX5p04H78/yJ76NJarNgbPU=;
        b=HsgqXxOIjQz6SBEbd9kkgclE3sbieADWg+2be1MexqKkXlIxHkmICJdm8P0TUPckyv
         /hbYe8JR+s1kxpT+EbAJQxL1xETF5qdsLkn13tztrEVwuKPGcbQFK4ZaFTtsPF087pee
         Sc0vpLRaMop5Uznd0X2/wJNcoh1PB9KRVDRq2kQbNjRtgMVmFJlSdBL7zaORB9NIfSZq
         zkhM6gLB/w7QoLiBQ2rIdEVMZ70CelY74bn98cvzDE3UmCe1coc/ujVsBebn37XFl6Fs
         RRwaSn6c+WPzVyj4js5Zg+sJHfTY9jJgEHoJgDJ0ubdwtf4Q72554iJg7DBUBRXxQWLJ
         a8tQ==
X-Gm-Message-State: AA6/9Rm1aSXCzaO8K5ArAtz23PV/uu5KdwVKR0u+Idiyv0CbyZ1NOtELOJAJfe5vU12P7w==
X-Received: by 10.28.223.84 with SMTP id w81mr5651417wmg.98.1476896489035;
        Wed, 19 Oct 2016 10:01:29 -0700 (PDT)
Received: from localhost (ip-94-113-214-7.net.upcbroadband.cz. [94.113.214.7])
        by smtp.gmail.com with ESMTPSA id wn5sm28843676wjb.42.2016.10.19.10.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Oct 2016 10:01:28 -0700 (PDT)
Date:   Wed, 19 Oct 2016 19:01:27 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        ceph-devel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, kvm@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-cris-kernel@axis.com, linux-fbdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mips@linux-mips.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 00/10] mm: adjust get_user_pages* functions to explicitly
 pass FOLL_* flags
Message-ID: <20161019170127.GN24393@dhcp22.suse.cz>
References: <20161013002020.3062-1-lstoakes@gmail.com>
 <20161018153050.GC13117@dhcp22.suse.cz>
 <20161019085815.GA22239@lucifer>
 <20161019090727.GE7517@dhcp22.suse.cz>
 <5807A427.7010200@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5807A427.7010200@linux.intel.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <mstsxfx@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55517
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mhocko@kernel.org
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

On Wed 19-10-16 09:49:43, Dave Hansen wrote:
> On 10/19/2016 02:07 AM, Michal Hocko wrote:
> > On Wed 19-10-16 09:58:15, Lorenzo Stoakes wrote:
> >> On Tue, Oct 18, 2016 at 05:30:50PM +0200, Michal Hocko wrote:
> >>> I am wondering whether we can go further. E.g. it is not really clear to
> >>> me whether we need an explicit FOLL_REMOTE when we can in fact check
> >>> mm != current->mm and imply that. Maybe there are some contexts which
> >>> wouldn't work, I haven't checked.
> >>
> >> This flag is set even when /proc/self/mem is used. I've not looked deeply into
> >> this flag but perhaps accessing your own memory this way can be considered
> >> 'remote' since you're not accessing it directly. On the other hand, perhaps this
> >> is just mistaken in this case?
> > 
> > My understanding of the flag is quite limited as well. All I know it is
> > related to protection keys and it is needed to bypass protection check.
> > See arch_vma_access_permitted. See also 1b2ee1266ea6 ("mm/core: Do not
> > enforce PKEY permissions on remote mm access").
> 
> Yeah, we need the flag to tell us when PKEYs should be applied or not.
> The current task's PKRU (pkey rights register) should really only be
> used to impact access to the task's memory, but has no bearing on how a
> given task should access remote memory.

The question I had earlier was whether this has to be an explicit FOLL
flag used by g-u-p users or we can just use it internally when mm !=
current->mm

-- 
Michal Hocko
SUSE Labs
