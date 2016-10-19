Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Oct 2016 11:07:00 +0200 (CEST)
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33412 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991986AbcJSJGyEIvvv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Oct 2016 11:06:54 +0200
Received: by mail-wm0-f65.google.com with SMTP id f193so2964451wmg.0
        for <linux-mips@linux-mips.org>; Wed, 19 Oct 2016 02:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g8mVvMHXODiabubIJ9TJpz7BXquhXEzraZkMJsmnx+I=;
        b=0ERK6/jmalQRvv09MKiGDw3XHwN68SVun/PSlmtEY82dfDaOVj1NYMyJJw66/V6GvC
         o8art0QccNz078ox5+FKRj8PqOXqgoJ9NUYdFSqqZP7xnS/jVOEKn/JN6+42h7k2pbEt
         bH+nqk7qoKyrtUKKczS4SngDgHhZ+nD6atA0KZUeHVQzSYAa8GXi/M0U981pIW4ddna8
         w/rUqZYLETdovLN6ydzee+fEWbbVyCCERue+9MJCLKWQ1RodotsKFdOpoCBZvYYAPssX
         wCGUEHGNPIPtGjJwTdoucdB1dN0PBZLiMHR1GNxD0mxHPRuV5Ix/zT8R2IrFiWTHGce/
         IrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g8mVvMHXODiabubIJ9TJpz7BXquhXEzraZkMJsmnx+I=;
        b=EtGyVETons2TEF2LlO4dkyENfQQmZinqJjt8D22K5oxvJwsYThxG6uYWCmTfGu64Cv
         zLU8waK/wXrMCsCsnUbXgAUM3FL3nnMsYqLyQedMtV/YC5m08Bu9avD9ekM8EmOSu6je
         TVlqysb/NImrtXjrbG8sZtASWaigOiFuEnw4e5MihGvRa4/jLUYA1iaCGE1iFuWdy+bo
         IoeMiYJk5oFjMrlZD2b4ENs89S2svd+h9/CW2GAYUMc2JHOHOqGh9qS03DWiV4DM1cgj
         u05Jy+u4BeqqE7i8YYdAAlZG2cU7e7tVB+oz8Vu857cDjvXkdIdhPLjOIHQKFiFTtdJe
         A7eQ==
X-Gm-Message-State: AA6/9Rng7o219AqRkKSKWnUANFU8DEhCe0FxeoW1rLZTaRPwwQWQIpbjwKi9lg4O9Iy86g==
X-Received: by 10.28.197.69 with SMTP id v66mr4087050wmf.7.1476868008700;
        Wed, 19 Oct 2016 02:06:48 -0700 (PDT)
Received: from localhost (cpc94060-newt37-2-0-cust185.19-3.cable.virginm.net. [92.234.204.186])
        by smtp.gmail.com with ESMTPSA id k188sm3921266wmd.12.2016.10.19.02.06.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Oct 2016 02:06:47 -0700 (PDT)
Date:   Wed, 19 Oct 2016 10:06:46 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>
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
Message-ID: <20161019090646.GA24243@lucifer>
References: <20161013002020.3062-1-lstoakes@gmail.com>
 <20161013002020.3062-9-lstoakes@gmail.com>
 <20161019075903.GP29967@quack2.suse.cz>
 <20161019081352.GB7562@dhcp22.suse.cz>
 <20161019084045.GA19441@lucifer>
 <20161019085204.GD7517@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161019085204.GD7517@dhcp22.suse.cz>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <lstoakes@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55505
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lstoakes@gmail.com
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

On Wed, Oct 19, 2016 at 10:52:05AM +0200, Michal Hocko wrote:
> yes this is the desirable and expected behavior.
>
> > wonder if this is desirable behaviour or whether this ought to be limited to
> > ptrace system calls. Regardless, by making the flag more visible it makes it
> > easier to see that this is happening.
>
> mem_open already enforces PTRACE_MODE_ATTACH

Ah I missed this, that makes a lot of sense, thanks!

I still wonder whether other invocations of access_remote_vm() in fs/proc/base.c
(the principle caller of this function) need FOLL_FORCE, for example the various
calls that simply read data from other processes, so I think the point stands
about keeping this explicit.
