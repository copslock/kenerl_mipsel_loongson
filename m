Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Aug 2015 16:33:00 +0200 (CEST)
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35208 "EHLO
        mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007749AbbH1Oc6SSzTE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Aug 2015 16:32:58 +0200
Received: by wicne3 with SMTP id ne3so21283673wic.0
        for <linux-mips@linux-mips.org>; Fri, 28 Aug 2015 07:32:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/hfZdLNqN4kS9p6ea+oMZa8UpSdpkqGZEX1MQ4JLGp8=;
        b=AdX/LxUeghnlTYSFKLpsW++wjP/b2laCREsAVb8XA41tFx3RtA1Neg48rALaGv2DXR
         bx87xQIjQU8usSv44mex/Zdps0rdkXwwKn/Q6Tu2ROUPYnWl0pQWLyOfXNBZ5PsiDtrx
         D8HiA+lAgAcphfa/G+7ZKaXLCdhmx0FcH7eNBTKPkuct3dK/ElzT2LzcX7KjXjvuVBdw
         a8ICtKin6Y1oeKCNVMkPDeEV0hmkxlDblZZrlJf0g8Kb/WAPIaMrH8fSOjRKQRg/cQk+
         7H5QCls8mr4Z4tFmWEYyeUCsi99KpxuObvUQoWNbg0gI134RVcPs4z4vDOjL7Xl19qBR
         RG8g==
X-Received: by 10.194.108.5 with SMTP id hg5mr12443307wjb.25.1440772373144;
        Fri, 28 Aug 2015 07:32:53 -0700 (PDT)
Received: from localhost (nat1.scz.suse.com. [213.151.88.250])
        by smtp.gmail.com with ESMTPSA id jr5sm8344634wjc.14.2015.08.28.07.32.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Aug 2015 07:32:52 -0700 (PDT)
Date:   Fri, 28 Aug 2015 16:32:51 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Eric B Munson <emunson@akamai.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v8 4/6] mm: mlock: Add mlock flags to enable
 VM_LOCKONFAULT usage
Message-ID: <20150828143251.GF5301@dhcp22.suse.cz>
References: <1440613465-30393-1-git-send-email-emunson@akamai.com>
 <1440613465-30393-5-git-send-email-emunson@akamai.com>
 <20150828143130.GE5301@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150828143130.GE5301@dhcp22.suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <mstsxfx@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49066
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

On Fri 28-08-15 16:31:30, Michal Hocko wrote:
> On Wed 26-08-15 14:24:23, Eric B Munson wrote:
> > The previous patch introduced a flag that specified pages in a VMA
> > should be placed on the unevictable LRU, but they should not be made
> > present when the area is created.  This patch adds the ability to set
> > this state via the new mlock system calls.
> > 
> > We add MLOCK_ONFAULT for mlock2 and MCL_ONFAULT for mlockall.
> > MLOCK_ONFAULT will set the VM_LOCKONFAULT modifier for VM_LOCKED.
> > MCL_ONFAULT should be used as a modifier to the two other mlockall
> > flags.  When used with MCL_CURRENT, all current mappings will be marked
> > with VM_LOCKED | VM_LOCKONFAULT.  When used with MCL_FUTURE, the
> > mm->def_flags will be marked with VM_LOCKED | VM_LOCKONFAULT.  When used
> > with both MCL_CURRENT and MCL_FUTURE, all current mappings and
> > mm->def_flags will be marked with VM_LOCKED | VM_LOCKONFAULT.
> > 
> > Prior to this patch, mlockall() will unconditionally clear the
> > mm->def_flags any time it is called without MCL_FUTURE.  This behavior
> > is maintained after adding MCL_ONFAULT.  If a call to
> > mlockall(MCL_FUTURE) is followed by mlockall(MCL_CURRENT), the
> > mm->def_flags will be cleared and new VMAs will be unlocked.  This
> > remains true with or without MCL_ONFAULT in either mlockall()
> > invocation.

Btw. I think we really want a man page for this new mlock call.
-- 
Michal Hocko
SUSE Labs
