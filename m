Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Oct 2016 15:56:27 +0200 (CEST)
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36555 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992991AbcJRN4Rxm2Fz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Oct 2016 15:56:17 +0200
Received: by mail-lf0-f65.google.com with SMTP id b75so32556190lfg.3
        for <linux-mips@linux-mips.org>; Tue, 18 Oct 2016 06:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x5pwEGrbw2h5NC+62Kqklj23B5o1GicvxazdryldPV8=;
        b=Cf2XW8kbuO+NoNROrbUau1a+0qvpWvYKkd5/QVpvXx4kYH4nmcACCWl6aTR0wfXKR/
         XRcjUQNqG2e6rMBBnbwNHs2oeRQseCiQQzBxSlK8BmN+JqnobdC0JxKbd3uFqIEz1rty
         dQouhnCYZ+ryklSC3W6aV6C2/m36WzO+I18Zk663TndoafzZAvxOx8njkX3NfWxtApKD
         2EzQV5VOYCq8RAjfKNRxm00a96sFTTrrN0dFn66JIc+bdh+r9ys2LM60+rcldjUnQuGJ
         fOFgIG6QKVbBKrk0+Fk/yZkKfRgPpckX2xGazmZydaO0yEnkBbbTBhmQx2uHzdv02MRH
         4m0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x5pwEGrbw2h5NC+62Kqklj23B5o1GicvxazdryldPV8=;
        b=Rqkcu4cpXqzvI5VU1Qvx/cnpEv8atKJ2MaqfbqU0HFIagWAm5kKPtLTi3NB3PZkcE3
         +x++xY73VfTzSbUKFzEaQ77PAD0ZnntxhMLKWSrBZgXCL2bd8+RucJbwCMhZMeHepUQw
         dYgodA8YSV8k3l/FrFH0abLWAbdKc+UHkIgfRGpiMR3euK+iWtMR1weprGZh2SS2Vh62
         f76Y9u4TJKm8wkHczkUBLVFb61HXYGDDwCUy1UzCQvzae04tQFgvV4hzD1sxvgAIYwbf
         qjZcIVbx+KAx1GsbQSJKE1B2C8CkQR5cXFa4gHLrQEnyRCNV4WlFN65WiEx9Y4Lqs0Yx
         GyUA==
X-Gm-Message-State: AA6/9RlZ9RFsKtC3nzmLeM4cGpzt/vprrqxpW1eTU51V8pYeeWVO1+FeeJqD+3kLXVvxpQ==
X-Received: by 10.194.189.198 with SMTP id gk6mr306773wjc.167.1476798972276;
        Tue, 18 Oct 2016 06:56:12 -0700 (PDT)
Received: from localhost (cpc94060-newt37-2-0-cust185.19-3.cable.virginm.net. [92.234.204.186])
        by smtp.gmail.com with ESMTPSA id vx1sm29668481wjc.3.2016.10.18.06.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Oct 2016 06:56:10 -0700 (PDT)
Date:   Tue, 18 Oct 2016 14:56:09 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
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
Subject: Re: [PATCH 04/10] mm: replace get_user_pages_locked() write/force
 parameters with gup_flags
Message-ID: <20161018135609.GA30025@lucifer>
References: <20161013002020.3062-1-lstoakes@gmail.com>
 <20161013002020.3062-5-lstoakes@gmail.com>
 <20161018125425.GD29967@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161018125425.GD29967@quack2.suse.cz>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <lstoakes@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55488
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

On Tue, Oct 18, 2016 at 02:54:25PM +0200, Jan Kara wrote:
> > @@ -1282,7 +1282,7 @@ long get_user_pages(unsigned long start, unsigned long nr_pages,
> >  			    int write, int force, struct page **pages,
> >  			    struct vm_area_struct **vmas);
> >  long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
> > -		    int write, int force, struct page **pages, int *locked);
> > +		    unsigned int gup_flags, struct page **pages, int *locked);
>
> Hum, the prototype is inconsistent with e.g. __get_user_pages_unlocked()
> where gup_flags come after **pages argument. Actually it makes more sense
> to have it before **pages so that input arguments come first and output
> arguments second but I don't care that much. But it definitely should be
> consistent...

It was difficult to decide quite how to arrange parameters as there was
inconsitency with regards to parameter ordering already - for example
__get_user_pages() places its flags argument before pages whereas, as you note,
__get_user_pages_unlocked() puts them afterwards.

I ended up compromising by trying to match the existing ordering of the function
as much as I could by replacing write, force pairs with gup_flags in the same
location (with the exception of get_user_pages_unlocked() which I felt should
match __get_user_pages_unlocked() in signature) or if there was already a
gup_flags parameter as in the case of __get_user_pages_unlocked() I simply
removed the write, force pair and left the flags as the last parameter.

I am happy to rearrange parameters as needed, however I am not sure if it'd be
worthwhile for me to do so (I am keen to try to avoid adding too much noise here
:)

If we were to rearrange parameters for consistency I'd suggest adjusting
__get_user_pages_unlocked() to put gup_flags before pages and do the same with
get_user_pages_unlocked(), let me know what you think.
