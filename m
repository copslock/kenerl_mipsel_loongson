Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Oct 2016 11:07:41 +0200 (CEST)
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34841 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991984AbcJSJHfI9vMv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Oct 2016 11:07:35 +0200
Received: by mail-wm0-f68.google.com with SMTP id g16so2956216wmg.2
        for <linux-mips@linux-mips.org>; Wed, 19 Oct 2016 02:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Ebe/w/VH8+OvNwy93n4BXgyFzdLGH1Nt9fmzdY8AbM=;
        b=cYdD6KBfZ3VQxU14jCEsQ1IUMtFPxGlyK5QHQXeTJSFnJDQ6q+hIQZxue+3f0ZVPCG
         v9J258ZfX4PdB1iGR9wlNpwca8b7HCAY9quUgPFukJsn8KrKQWhNesOrah24kCqsRhV1
         emhsUubH/mwbwuN3wVY8d63j0wfCZPuzFFQ/i9i9XRadAAM7rdFhOtdOeAi0TcNe4vRP
         vO7ovBKb8iLyOiwa8gllUnMRyYZLU536LJZIT4UTK1Y8gNob+Fc6isTqBYVWfVW8xIBo
         Sqg4Ck28etMFbC6uZyQn5BD0qOGNQsfgVxoeBgs8cbXswinlSGLpqIGpO3Dp3v91kuZ9
         6Diw==
X-Gm-Message-State: AA6/9RnPvXNYYGWLDODekFtwmEgNmJMBDqX0ond6yUL+i+d+FznPYesUGdSiUbZQIHAiuw==
X-Received: by 10.28.174.209 with SMTP id x200mr4582211wme.55.1476868049809;
        Wed, 19 Oct 2016 02:07:29 -0700 (PDT)
Received: from localhost ([213.151.95.130])
        by smtp.gmail.com with ESMTPSA id jb2sm24886480wjb.44.2016.10.19.02.07.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Oct 2016 02:07:28 -0700 (PDT)
Date:   Wed, 19 Oct 2016 11:07:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>,
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
Subject: Re: [PATCH 00/10] mm: adjust get_user_pages* functions to explicitly
 pass FOLL_* flags
Message-ID: <20161019090727.GE7517@dhcp22.suse.cz>
References: <20161013002020.3062-1-lstoakes@gmail.com>
 <20161018153050.GC13117@dhcp22.suse.cz>
 <20161019085815.GA22239@lucifer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161019085815.GA22239@lucifer>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <mstsxfx@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55506
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

On Wed 19-10-16 09:58:15, Lorenzo Stoakes wrote:
> On Tue, Oct 18, 2016 at 05:30:50PM +0200, Michal Hocko wrote:
> > I am wondering whether we can go further. E.g. it is not really clear to
> > me whether we need an explicit FOLL_REMOTE when we can in fact check
> > mm != current->mm and imply that. Maybe there are some contexts which
> > wouldn't work, I haven't checked.
> 
> This flag is set even when /proc/self/mem is used. I've not looked deeply into
> this flag but perhaps accessing your own memory this way can be considered
> 'remote' since you're not accessing it directly. On the other hand, perhaps this
> is just mistaken in this case?

My understanding of the flag is quite limited as well. All I know it is
related to protection keys and it is needed to bypass protection check.
See arch_vma_access_permitted. See also 1b2ee1266ea6 ("mm/core: Do not
enforce PKEY permissions on remote mm access").

-- 
Michal Hocko
SUSE Labs
