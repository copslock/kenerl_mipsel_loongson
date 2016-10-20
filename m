Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2016 21:27:04 +0200 (CEST)
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35133 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993038AbcJTT0y5C2xP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Oct 2016 21:26:54 +0200
Received: by mail-qk0-f174.google.com with SMTP id z190so113481973qkc.2
        for <linux-mips@linux-mips.org>; Thu, 20 Oct 2016 12:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iFmNBql8JYnYoA9ZXXH2SEKrBjF8OxsRLMooc9h9Gmw=;
        b=PEXyGZMLBGcJbfPxD9hC+iQR834Ey7tcmQwXuiZ+KsYk9Kub30E7kVpcffHFRat1mY
         DHeU86Livk344DE/X6ZxnlF6/HqdgS6J5xbsHyyb5kQ97ygolV7ixkSXh3hBpdgj16zS
         YN3BjD4+dtVqhdW4RKdmT6tVtuxy5mFIy0FYW+N7GAjr32oRAzuXqHbcXCWn5rvTdSpp
         wQ0C1hAkO4jfDUQd0YMLVvQYrlSWL1mJaiVrXtGdqBQAndReUo3VtHLCIsf0uVRkEhZu
         7d98Np36SNDuVx8G/Cldr1Wg/o5ao88rIdod3AeP/0nRCmk/Y1PagIfflk1SmRhgOoJC
         7Y5Q==
X-Gm-Message-State: ABUngvfuERw+rAsLpg1cahXcucZZ+bIA7IrYLkpZRyGYSL85k214O8m3ibdaptSPOB8pGw==
X-Received: by 10.194.77.237 with SMTP id v13mr1272678wjw.220.1476991608427;
        Thu, 20 Oct 2016 12:26:48 -0700 (PDT)
Received: from localhost (ip-94-113-214-7.net.upcbroadband.cz. [94.113.214.7])
        by smtp.gmail.com with ESMTPSA id rv12sm81331966wjb.29.2016.10.20.12.26.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Oct 2016 12:26:47 -0700 (PDT)
Date:   Thu, 20 Oct 2016 21:26:47 +0200
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
Message-ID: <20161020192646.GC27342@dhcp22.suse.cz>
References: <20161013002020.3062-1-lstoakes@gmail.com>
 <20161018153050.GC13117@dhcp22.suse.cz>
 <20161019085815.GA22239@lucifer>
 <20161019090727.GE7517@dhcp22.suse.cz>
 <5807A427.7010200@linux.intel.com>
 <20161019170127.GN24393@dhcp22.suse.cz>
 <5807AC2B.4090208@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5807AC2B.4090208@linux.intel.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <mstsxfx@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55527
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

On Wed 19-10-16 10:23:55, Dave Hansen wrote:
> On 10/19/2016 10:01 AM, Michal Hocko wrote:
> > The question I had earlier was whether this has to be an explicit FOLL
> > flag used by g-u-p users or we can just use it internally when mm !=
> > current->mm
> 
> The reason I chose not to do that was that deferred work gets run under
> a basically random 'current'.  If we just use 'mm != current->mm', then
> the deferred work will sometimes have pkeys enforced and sometimes not,
> basically randomly.

OK, I see (async_pf_execute and ksm ). It makes more sense to me. Thanks
for the clarification.

-- 
Michal Hocko
SUSE Labs
