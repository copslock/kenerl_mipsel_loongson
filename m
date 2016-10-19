Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Oct 2016 10:41:01 +0200 (CEST)
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34016 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991948AbcJSIkxgjw2v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Oct 2016 10:40:53 +0200
Received: by mail-wm0-f67.google.com with SMTP id d199so2872321wmd.1
        for <linux-mips@linux-mips.org>; Wed, 19 Oct 2016 01:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5+sBkt6ybCtzP1Rqn2XnCvFLbJJkf5Av5qCrpM0Wp3o=;
        b=RV1IBxsEk+9soEoH6iUTrGkZjgixI/tsle+XkUf0iLcs7EWviZzCvBXunfnotSHU/o
         K6EMbUC8oFJ7SsBuRonvIZyMI1dBh4QD1XEEh7TI7tI+NR3Qr9bWO4HGeAumpa6Yra6x
         YP4U4J9dVSajlUDbavy37faOZjm9l/dZgmcsE72JVNfQBTeem2pvWXqTHzQBoxHyDq91
         50DOM59a3sDuHA7BIyl59ulsJh9Divzd2uRq29aYu8Ba6505er0Z+Qz8dyDyuo2nXGDU
         5SiCgBdme7P7fTzHpnWpmrgNDApGRtn1OA+aKacrPSKvNdf+gXueeu4E2wEEhf52J40U
         Y5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5+sBkt6ybCtzP1Rqn2XnCvFLbJJkf5Av5qCrpM0Wp3o=;
        b=gAfk1i5xMtQL35v9NARn+X4td9UnC2ytwVsoi1OIxnGO1rsBa66I5RpdiV8E4MCHfB
         Py7Qo2MtBR523pMz3dhLyEfrkMC7Z3zYeSssBf1Emf+A2ZPBYwA5Diod/g4D+H3VlYZ7
         OOzjULtMSUW1ejqvG5CPBihEx9dfSbNRjiktTysbIQNnOeWXyGFrkIYhUOZgAjo5/hsy
         n0p0pjspbErlygnJYnPovq5nJDg6X3x/S0/k0+OkUhsePCLzhTaVG8B3UL1ulyOkwgor
         8Av0qrH+pQ1GtXMjxhfSr8wTT8ZVjrjv0a+cCGEv2C9WFDjt/vIaL9CxY/yCsZZzl6qH
         1vHQ==
X-Gm-Message-State: AA6/9RnMNpeRiTRidlFn1g7V/tMTXFv0wyq+iDMrsZXb2EjRgTPlK8e0LrSQr8MtYLUVFQ==
X-Received: by 10.194.44.226 with SMTP id h2mr3479922wjm.113.1476866448255;
        Wed, 19 Oct 2016 01:40:48 -0700 (PDT)
Received: from localhost (cpc94060-newt37-2-0-cust185.19-3.cable.virginm.net. [92.234.204.186])
        by smtp.gmail.com with ESMTPSA id q187sm3779401wmd.5.2016.10.19.01.40.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Oct 2016 01:40:46 -0700 (PDT)
Date:   Wed, 19 Oct 2016 09:40:45 +0100
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
Message-ID: <20161019084045.GA19441@lucifer>
References: <20161013002020.3062-1-lstoakes@gmail.com>
 <20161013002020.3062-9-lstoakes@gmail.com>
 <20161019075903.GP29967@quack2.suse.cz>
 <20161019081352.GB7562@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161019081352.GB7562@dhcp22.suse.cz>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <lstoakes@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55502
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

On Wed, Oct 19, 2016 at 10:13:52AM +0200, Michal Hocko wrote:
> On Wed 19-10-16 09:59:03, Jan Kara wrote:
> > On Thu 13-10-16 01:20:18, Lorenzo Stoakes wrote:
> > > This patch removes the write parameter from __access_remote_vm() and replaces it
> > > with a gup_flags parameter as use of this function previously _implied_
> > > FOLL_FORCE, whereas after this patch callers explicitly pass this flag.
> > >
> > > We make this explicit as use of FOLL_FORCE can result in surprising behaviour
> > > (and hence bugs) within the mm subsystem.
> > >
> > > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> >
> > So I'm not convinced this (and the following two patches) is actually
> > helping much. By grepping for FOLL_FORCE we will easily see that any caller
> > of access_remote_vm() gets that semantics and can thus continue search
>
> I am really wondering. Is there anything inherent that would require
> FOLL_FORCE for access_remote_vm? I mean FOLL_FORCE is a really
> non-trivial thing. It doesn't obey vma permissions so we should really
> minimize its usage. Do all of those users really need FOLL_FORCE?

I wonder about this also, for example by accessing /proc/self/mem you trigger
access_remote_vm() and consequently get_user_pages_remote() meaning FOLL_FORCE
is implied and you can use /proc/self/mem to override any VMA permissions. I
wonder if this is desirable behaviour or whether this ought to be limited to
ptrace system calls. Regardless, by making the flag more visible it makes it
easier to see that this is happening.

Note that this /proc/self/mem behaviour is what triggered the bug that brought
about this discussion in the first place -
https://marc.info/?l=linux-mm&m=147363447105059 - as using /proc/self/mem this
way on PROT_NONE memory broke some assumptions.

On the other hand I see your point Jan in that you know any caller of these
functions will have FOLL_FORCE implied, and you have to decide to stop passing
the flag at _some_ point in the stack, however it seems fairly sane to have that
stopping point exist outside of exported gup functions so the gup interface
forces explicitness but callers can wrap things as they need.
