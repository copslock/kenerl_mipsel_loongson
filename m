Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Oct 2018 14:57:43 +0200 (CEST)
Received: from mail-pg1-x541.google.com ([IPv6:2607:f8b0:4864:20::541]:35527
        "EHLO mail-pg1-x541.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990490AbeJNM5ksq08g convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 14 Oct 2018 14:57:40 +0200
Received: by mail-pg1-x541.google.com with SMTP id v133-v6so7887698pgb.2;
        Sun, 14 Oct 2018 05:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QOh3/rAAMNg6qWlR3ockjsVxuDsHmKYoJ0FCAyRqfh4=;
        b=iABS1BuuIxLgQKHch2Dlc2zTZiMd5aUIeqllYaFVgeR7hoGPuvGN0BBSP3H1vOGBVn
         KnNmfDgbSWbJo+V1YyBGzEulGIQI4dKrQDtk/qd41E6RZlIfP2uxnp0+oBAtOmE4lG68
         x70+eGZP6uqx3qIucJWNiOGFfutGJX0zNuk02P85pVbzAfz/cdNnL7N6mjQ9px/1vLGR
         0JCrXbMG1TROv4dsnHtWFYQhX2S77DifFBaPTKHxH7wYOLvmaT9qB/OI8BYNCWShL/X9
         mFcN7LHngJUy/JxGOyjI6S48h8FN8nkPma5iSqUuYea8u+8O4wp45CoWdE8sNLx2J/u+
         jenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QOh3/rAAMNg6qWlR3ockjsVxuDsHmKYoJ0FCAyRqfh4=;
        b=ta8Ke/C4EU+HjdHji795qLzzMVaekxJFzeqq2QnSPxTiKipDzkLBqww9oCJQTJqKTV
         4oel/xQUIK7CzgcwZ+CZj8hdSSxPC2mKtQdYk/pzIZYAYdpN5TfJbz1+UbcPhTf6O/cD
         T3O1bmBGE5uL8ueJGS5A/tNiXav0TxTNLwHW4kxf3AA1/d+szotHL+Fg21bArj1Kh9zp
         Wr2RKQQsAxfZJzvC2SvvRsKgOkjtV1SrM+UhOI1IH+mYqFrDjU8iv8uTPukNFYDmJWe2
         HCbmU1jc26pwwJmDKcVHsT68IndG8uYfHbM18x1cKf2wj1U72I+g1Jn6+kiaLbmnCkP7
         H9Og==
X-Gm-Message-State: ABuFfojQ40V/9hTzFiNikrabZ3f6THGY7SnVeCJ8bxGJQa36mRzei8OB
        y0top7OVDevKk8148ati0epnXPJTLSvhfOwofNc=
X-Google-Smtp-Source: ACcGV60zf0Hi3mZezp2hDEDaLIs17dXAsuvuc8YysL8650sEBPqrqgQAvzNYudsoqEWRyq2I1MEzwEjavgjecjVnptw=
X-Received: by 2002:a62:8910:: with SMTP id v16-v6mr13526160pfd.106.1539521853925;
 Sun, 14 Oct 2018 05:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
 <20181013145406.4911-3-Tianyu.Lan@microsoft.com> <4D709C3A-A91C-4CA7-922A-E77618EF21B4@oracle.com>
 <alpine.DEB.2.21.1810141014350.1438@nanos.tec.linutronix.de> <1BDC7949-CFED-46C2-9D05-42864B0AD0F0@oracle.com>
In-Reply-To: <1BDC7949-CFED-46C2-9D05-42864B0AD0F0@oracle.com>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Sun, 14 Oct 2018 20:57:22 +0800
Message-ID: <CAOLK0pxC9S7YzoC-YmE7bw2VyPEZfxZSCOW+hW+t3Mi8V6Y-RQ@mail.gmail.com>
Subject: Re: [PATCH V4 2/15] KVM/MMU: Add tlb flush with range helper function
To:     liran.alon@oracle.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        christoffer.dall@arm.com, marc.zyngier@arm.com, linux@armlinux.org,
        catalin.marinas@arm.com, will.deacon@arm.com, jhogan@kernel.org,
        ralf@linux-mips.org, paul.burton@mips.com, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devel@linuxdriverproject.org,
        kvm <kvm@vger.kernel.org>, michael.h.kelley@microsoft.com,
        vkuznets@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <lantianyu1986@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lantianyu1986@gmail.com
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

Hi Liran & Thomas:
              Thanks for your review.


On Sun, Oct 14, 2018 at 5:20 PM Liran Alon <liran.alon@oracle.com> wrote:
>
>
>
> > On 14 Oct 2018, at 11:16, Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Sun, 14 Oct 2018, Liran Alon wrote:
> >>> On 13 Oct 2018, at 17:53, lantianyu1986@gmail.com wrote:
> >>>
> >>> +
> >>> +static inline bool kvm_available_flush_tlb_with_range(void)
> >>> +{
> >>> +   return kvm_x86_ops->tlb_remote_flush_with_range;
> >>> +}
> >>
> >> Seems that kvm_available_flush_tlb_with_range() is not used in this patch…
> >
> > What's wrong with that?
> >
> > It provides the implementation and later patches make use of it. It's a
> > sensible way to split patches into small, self contained entities.
> >
> > Thanks,
> >
> >       tglx
> >
>
> I guess it’s a matter of taste, but I prefer to not add dead-code for patches
> in order for each commit to compile nicely without warnings of declared and unused functions.
> I would prefer to just add this utility function on the patch that actually use it.
>
> -Liran
>

Normally, I also prefer to put the function definition into the patch
which use it.
But the following patch "KVM: Replace old tlb flush function with new
one to flush a specified range"
and other patches which use new functions will change a lot of places.
It's not friendly for review and
so I split them into pieces.
--
Best regards
Tianyu Lan
