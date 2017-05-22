Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 May 2017 15:03:55 +0200 (CEST)
Received: from mail-lf0-x242.google.com ([IPv6:2a00:1450:4010:c07::242]:33451
        "EHLO mail-lf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993552AbdEVNDtKu0TN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 May 2017 15:03:49 +0200
Received: by mail-lf0-x242.google.com with SMTP id m18so5425738lfj.0;
        Mon, 22 May 2017 06:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mfjWPuBHwkvbaqNwHkKea/d8gd+qw2q0l5hVCpRl0hA=;
        b=h9M9UT611z7RDw+cdQFfzTXFt+ynmCe4/kQgl7QGxZsa5Rg6ORHFY/EB/Evm+rJZYH
         wjqEsVgkpoTdcMJZyTPo3BHy++zXSmehU3WTTSJCflEBfM0tDmffCkzmSYB6wvqtHjNY
         l/QDmca0OavGiqhHNBSWdff12kAQVG9PY3BQ8/F/N0Nv/X0aUMWRy2rhNgup56cC2lDQ
         47fhWjycprjNFV0+zLV/jDzWblBkUePXmw9o9MWN08BipQLZmBFl/qKTVjCnGdrIqe/b
         /hsRtTNk7V4uKWS/ucHTL6NuZz12mW2SpHSLO2ToFpYX16aBcdrC1D5bGnhiX6MfIQFZ
         n0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mfjWPuBHwkvbaqNwHkKea/d8gd+qw2q0l5hVCpRl0hA=;
        b=PdlMfR0o4Wvg5l+IuTQNvWKMkK5hFczjc2xYQLevkiM347Osh6nEE8gGq5U5zrW2lW
         K1j/WNatd4aYGKeKyPOz/VST1jndXwnggQkZUJQBchDuvkA8FUVB0ovSjBN/GQXNgaFm
         FUDJQQk0cqwXRjq9jkgwbEwn/otx2CXw+/D+25+RnxaJ/ExwymaUb3JJeW3zjNfRybVH
         dETuFY1JGgvYpgW+vlmomV1hMjCelNP7zz+itlSNpwaj69G5RuWI0S9qSTP52ta02OQ9
         qARYxvkzHSC9Q0K4CG4EItQagnNHClnxiFG5YaGRphlD1xxAzKIxTHlWkDwvHF9REj6l
         Myag==
X-Gm-Message-State: AODbwcD+/Rtji1YGWix07HzqRpqSfL9CX2Eq7+IHfli30cKg/l3SMH2W
        DkZ7KY+gq7gYow==
X-Received: by 10.46.7.1 with SMTP id 1mr6199417ljh.27.1495458223680;
        Mon, 22 May 2017 06:03:43 -0700 (PDT)
Received: from mobilestation ([5.164.217.172])
        by smtp.gmail.com with ESMTPSA id d188sm1299257lfg.69.2017.05.22.06.03.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 May 2017 06:03:43 -0700 (PDT)
Date:   Mon, 22 May 2017 16:03:48 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        ralf@linux-mips.org, paul.burton@imgtec.com, rabinv@axis.com,
        matt.redfearn@imgtec.com, james.hogan@imgtec.com,
        alexander.sverdlin@nokia.com, robh+dt@kernel.org,
        frowand.list@gmail.com, Sergey.Semin@t-platforms.ru,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/21] MIPS memblock: Remove bootmem code and switch to
 NO_BOOTMEM
Message-ID: <20170522130348.GA20910@mobilestation>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
 <be0b6614-708d-a32a-029d-7e606a673e5b@imgtec.com>
 <20170522102643.GA17763@mobilestation>
 <ef3d7a8c-2a73-2082-0d64-bdb4f95df204@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef3d7a8c-2a73-2082-0d64-bdb4f95df204@gentoo.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57934
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fancer.lancer@gmail.com
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

Hello folks,

On Mon, May 22, 2017 at 08:47:20AM -0400, Joshua Kinard <kumba@gentoo.org> wrote:
> On 05/22/2017 06:26, Serge Semin wrote:
> > On Mon, May 22, 2017 at 11:48:36AM +0200, Marcin Nowakowski <marcin.nowakowski@imgtec.com> wrote:
> > 
> > Hello Marcin,
> > 
> >> Hi Serge,
> >>
> >> On 19.12.2016 03:07, Serge Semin wrote:
> >>> Most of the modern platforms supported by linux kernel have already
> >>> been cleaned up of old bootmem allocator by moving to nobootmem
> >>> interface wrapping up the memblock. This patchset is the first
> >>> attempt to do the similar improvement for MIPS for UMA systems
> >>> only.
> >>>
> >>> Even though the porting was performed as much careful as possible
> >>> there still might be problem with support of some platforms,
> >>> especially Loonson3 or SGI IP27, which perform early memory manager
> >>> initialization by their self.
> >>>
> >>> The patchset is split so individual patch being consistent in
> >>> functional and buildable ways. But the MIPS early memory manager
> >>> will work correctly only either with or without the whole set being
> >>> applied. For the same reason a reviewer should not pay much attention
> >>> to methods bootmem_init(), arch_mem_init(), paging_init() and
> >>> mem_init() until they are fully refactored.
> >>>
> >>> The patchset is applied on top of kernel v4.9.
> >>
> >> Have you progressed any further with these patches?
> >> They would definitely be useful to include for MIPS arch, so can you let us
> >> know if you are planning to send any updated version?
> >>
> >> thanks,
> >> Marcin
> > 
> > Sorry for such a long delay with response. I have been really busy
> > during last three months. Alas I'll still be busy for next 1-2
> > months as well. You know how it usually works with urgent projects.
> > One needs to do this thing, then that thing, and at some point I just
> > forgot about this thread.
> > 
> > Regarding the patchset. I'm still pretty much eager to make it being
> > part of kernel MIPS arch. But there was a problem I outlined
> > in the patchset header message, which I can't fix by myself.
> > Particulary It's connected with Loonson3 or SGI IP27 code alteration,
> > so to make it free of ancient boot_mem_map dependencies (see the
> > patchset header message). Without a help from someone, who has
> > Loonson64 and SGI IP27 hardware and strong desire to make it free of
> > old bootmem allocator, it is useless to make any progress from my
> > side. That's why Ralf moved this email-thread into RFC actually.
> > Anyway If either you or someone else has got such hardware and is
> > interested in the cooperation, I'll be more than happy to push
> > my efforts forward with this patchset contribution. But only after
> > I got a bit less busy with my work. As I said it will happen within
> > next 1-2 months. So do you have the hardware and desire to be part
> > of this?
> > 
> > Regards,
> > -Sergey
> 
> I have an SGI Onyx2 and just recently acquired a working SGI Origin 200.  The
> Onyx2 has NUMA issues yet to be hunted down, but I got ~3 days uptime out of
> the Origin 200 running compiles before powering it down.  Mainline needs 2-3
> small patches to make IP27 workable, last I tested.
> 
> I'd have to look at the IP27 code again and see if I can make sense of what
> it's doing.  I think it dealt with either setting up memory for an initrd
> (which I haven't used in over a decade), or it's for the NUMA stuff to discover
> all memory on each node.
> 
> -- 
> Joshua Kinard
> Gentoo/MIPS
> kumba@gentoo.org
> 6144R/F5C6C943 2015-04-27
> 177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943
> 
> "The past tempts us, the present confuses us, the future frightens us.  And our
> lives slip away, moment by moment, lost in that vast, terrible in-between."
> 
> --Emperor Turhan, Centauri Republic

It's great to hear of your willingness to help. Since both Loonson64 and SGI IP27
problematic architecture-specific code will be appropriately altered, I'll publish
the fixed general MIPS-memblock patchset within two months. I'll also try to
involve Ralf in it when I'm ready, so to make sure all my alterations are made
within kernel arch-code coding style. While I'm working on it, you can still use
the current patchset for some limited tests.

Regards,
-Sergey
