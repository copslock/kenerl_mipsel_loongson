Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Oct 2016 11:24:04 +0200 (CEST)
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34050 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991986AbcJSJX5gKBOu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Oct 2016 11:23:57 +0200
Received: by mail-wm0-f65.google.com with SMTP id d199so3033964wmd.1
        for <linux-mips@linux-mips.org>; Wed, 19 Oct 2016 02:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=++FvlNLVYzOp8+DkPkQd2fkTJ+ESt47iJEedHbRBZLk=;
        b=JWLyutsMcRRTFKlpi6fY5KqJE6gnerhl3XqcFBUtbArWnKOJ1hptOmY04sPBJZd6hQ
         ae5zDMRBROFhSExbLvZOU4727XzIziFCY53D3DbQ1JIk6jKzhl4f1kskIrrJEBf2eleW
         JpscWq13ySqLX2RZZkeQqnQLl1Ynchh/RQvNzIZdUbSJdYkAVkuxaosu6pAyGR/9Wfae
         08HOZmr//1jOfu7Hxcu94DaJa/qwvaP3TvwLD7D6BY7mdaDkQQ2xlpj/wcnBODxY6bVC
         ykUY2uV68nU6Bvi1Rsh6XNGYcjvbDsvUagV8sozZKkNfvyD5rY796VipA2dkpEZumTpl
         07iw==
X-Gm-Message-State: AA6/9RnTfv6aTv8ulTxzFVZNlL5BpQYEX/lQnPNlUrb+6YQDIpWJvrk9pXcA5UOmf9BcnA==
X-Received: by 10.194.188.37 with SMTP id fx5mr3621591wjc.170.1476869032188;
        Wed, 19 Oct 2016 02:23:52 -0700 (PDT)
Received: from localhost ([213.151.95.130])
        by smtp.gmail.com with ESMTPSA id ct1sm67516236wjd.13.2016.10.19.02.23.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Oct 2016 02:23:51 -0700 (PDT)
Date:   Wed, 19 Oct 2016 11:23:51 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
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
Message-ID: <20161019092350.GF7517@dhcp22.suse.cz>
References: <20161013002020.3062-1-lstoakes@gmail.com>
 <20161013002020.3062-9-lstoakes@gmail.com>
 <20161019075903.GP29967@quack2.suse.cz>
 <20161019081352.GB7562@dhcp22.suse.cz>
 <20161019084045.GA19441@lucifer>
 <20161019085204.GD7517@dhcp22.suse.cz>
 <20161019090646.GA24243@lucifer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161019090646.GA24243@lucifer>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <mstsxfx@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55507
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

On Wed 19-10-16 10:06:46, Lorenzo Stoakes wrote:
> On Wed, Oct 19, 2016 at 10:52:05AM +0200, Michal Hocko wrote:
> > yes this is the desirable and expected behavior.
> >
> > > wonder if this is desirable behaviour or whether this ought to be limited to
> > > ptrace system calls. Regardless, by making the flag more visible it makes it
> > > easier to see that this is happening.
> >
> > mem_open already enforces PTRACE_MODE_ATTACH
> 
> Ah I missed this, that makes a lot of sense, thanks!
> 
> I still wonder whether other invocations of access_remote_vm() in fs/proc/base.c
> (the principle caller of this function) need FOLL_FORCE, for example the various
> calls that simply read data from other processes, so I think the point stands
> about keeping this explicit.

I do agree. Making them explicit will help to clean them up later,
should there be a need.

-- 
Michal Hocko
SUSE Labs
