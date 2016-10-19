Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Oct 2016 10:14:06 +0200 (CEST)
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35475 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990522AbcJSIN64d05B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Oct 2016 10:13:58 +0200
Received: by mail-wm0-f68.google.com with SMTP id g16so2760884wmg.2
        for <linux-mips@linux-mips.org>; Wed, 19 Oct 2016 01:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VZdSOZv7kDXNmjr1dWFad4QM2/HbJc2z0OUjfa+vF5s=;
        b=EKMtfZb8TmdaLI43XnFA9b1oKAvrUJNM4NsJcWLP6yq0AM6uZWQBYUYusB/Sjz/p2X
         Umv0WGbbHasoYccOsfa520cpQ5XYkdAqO8CC49FCuDnRbH0Tyn/dKgG3IfK0oRNueQJ+
         10vvQgwJfOxhpq6fsK7XUERe0Yb4lJHwZls026p43GWrw8oeP7qnGdDMzXHV4lCl82JE
         9Ay0ZAGRXPQbnDBOymSiMgI900wb+4oCqfLeEeZ6JkRrLsJccXIr717Ul0kfmvOXdYdT
         xrxF+C+TBWHIduxH1iYdWpn1jnQ4m3Q1rbsC9rbQp6dA/LixzJltLQjaw5O1YclOi4Xd
         FYlQ==
X-Gm-Message-State: AA6/9RmhiibRpmlhmxAPHCGeCml54kr9OLG94DTRovkcMobFTvPweofTfIaBRwKNJNbDZA==
X-Received: by 10.28.166.214 with SMTP id p205mr3907518wme.24.1476864833560;
        Wed, 19 Oct 2016 01:13:53 -0700 (PDT)
Received: from localhost ([213.151.95.130])
        by smtp.gmail.com with ESMTPSA id e186sm3661190wma.5.2016.10.19.01.13.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Oct 2016 01:13:53 -0700 (PDT)
Date:   Wed, 19 Oct 2016 10:13:52 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
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
Subject: Re: [PATCH 08/10] mm: replace __access_remote_vm() write parameter
 with gup_flags
Message-ID: <20161019081352.GB7562@dhcp22.suse.cz>
References: <20161013002020.3062-1-lstoakes@gmail.com>
 <20161013002020.3062-9-lstoakes@gmail.com>
 <20161019075903.GP29967@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161019075903.GP29967@quack2.suse.cz>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <mstsxfx@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55501
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

On Wed 19-10-16 09:59:03, Jan Kara wrote:
> On Thu 13-10-16 01:20:18, Lorenzo Stoakes wrote:
> > This patch removes the write parameter from __access_remote_vm() and replaces it
> > with a gup_flags parameter as use of this function previously _implied_
> > FOLL_FORCE, whereas after this patch callers explicitly pass this flag.
> > 
> > We make this explicit as use of FOLL_FORCE can result in surprising behaviour
> > (and hence bugs) within the mm subsystem.
> > 
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> 
> So I'm not convinced this (and the following two patches) is actually
> helping much. By grepping for FOLL_FORCE we will easily see that any caller
> of access_remote_vm() gets that semantics and can thus continue search

I am really wondering. Is there anything inherent that would require
FOLL_FORCE for access_remote_vm? I mean FOLL_FORCE is a really
non-trivial thing. It doesn't obey vma permissions so we should really
minimize its usage. Do all of those users really need FOLL_FORCE?

Anyway I would rather see the flag explicit and used at more places than
hidden behind a helper function.
-- 
Michal Hocko
SUSE Labs
