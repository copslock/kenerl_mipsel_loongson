Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Nov 2018 13:34:59 +0100 (CET)
Received: from mail-pf1-x443.google.com ([IPv6:2607:f8b0:4864:20::443]:33123
        "EHLO mail-pf1-x443.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993961AbeK0Me4h7bUI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Nov 2018 13:34:56 +0100
Received: by mail-pf1-x443.google.com with SMTP id c123so7600740pfb.0;
        Tue, 27 Nov 2018 04:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y45q130fS/TxDRFjsRk4GQsRQWsmPIxqlM2WlMei9JA=;
        b=qvGEXVy+TmVHiDzQ6vk2+gkFO7+PC7KYLy04bPHCIgsk04EIEq+hVczwQdtICeROzA
         9cd2Sxpwnain8o9Jksg+Mqh8QLPfeqCGNRnyV3VPMP+2Q1WrnDU++csAzusonO6v88LI
         gJgS1gM4lHeRAzin0wfJNeKV2ypFRhjzNYf9ootqK0FR3Tdm+xPan2B8CB+aJ+VVyDfL
         oTs9rSEYqAC0WO6kcPbjoULQJ3nTWi/ataYrDTthBLL3xcs01voiN7akKHzZzVSVxid3
         amWd5lw3h+xL/B++R8lr45zczRycKQk+FX4AKpfs0BU9xxz+BW6Bq5R+EkBWvoy7kL69
         xZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y45q130fS/TxDRFjsRk4GQsRQWsmPIxqlM2WlMei9JA=;
        b=ojJ2CC2wAa4UI0OeqgnOZqmX1SEB4ipuNLMAkwum0l10u1vLLXCQBlH3h3HXBQHOCz
         QaxjDAE2vhgRrzha+MunqncwvRIsHv2U9TWnpxVJDO4pRpyM0XwYUE1HDhDiaw4tg4sq
         bI61VGuok1y962kD/KqarXQjYdl9oZSgn01xJBIRZdrTXsNkvpxfMXbAnIO/ej+wDEln
         x6zlxjal9ha0eSSm7GdngHiXtu1piiyajB3gJoUBh6t4wabaoIosgx7H4HJyJnKYqfO6
         8FiAAmLzrn/M5QQd1NRRvy7thAibAUAB6rdMVEpWLeV5AgPmfwEBmZTiZq0V1u8koyZA
         fx/w==
X-Gm-Message-State: AA+aEWYvF/1O2wShY2WyRzGx/kHnjcyEIjgEwR2e8zyo1UKQVGJDs6hL
        2NKyJjaRYuN5p93mWA4c4CCBWOkeznZSQnJHda8=
X-Google-Smtp-Source: AFSGD/WUOf5DakCu9tDqJpZdbiE2MnMSBasGV0QI7FaRvcuOE1sg3HAFCXNpaQ6FKxZxF8G6aCI9KoAqgXspnh9ke7c=
X-Received: by 2002:a63:6506:: with SMTP id z6mr28940347pgb.334.1543322093121;
 Tue, 27 Nov 2018 04:34:53 -0800 (PST)
MIME-Version: 1.0
References: <20181108144259.10817-1-Tianyu.Lan@microsoft.com>
 <CAOLK0pyvtfhoGM+D7h=gXwNpNjXGZiDJKpuVi9HOwb++4asCXw@mail.gmail.com> <20181127121129.GR3088@unbuntlaptop>
In-Reply-To: <20181127121129.GR3088@unbuntlaptop>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Tue, 27 Nov 2018 20:34:41 +0800
Message-ID: <CAOLK0pzL6wKbGEH_EPQ9cO8NByx4URO09=XAuYo-vEgaYjtVBQ@mail.gmail.com>
Subject: Re: [PATCH V5 00/10] x86/KVM/Hyper-v: Add HV ept tlb range flush
 hypercall support in KVM
To:     dan.carpenter@oracle.com
Cc:     linux-mips@linux-mips.org, kvm <kvm@vger.kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>, benh@kernel.crashing.org,
        will.deacon@arm.com, christoffer.dall@arm.com, paulus@ozlabs.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvmarm@lists.cs.columbia.edu,
        sthemmin@microsoft.com, mpe@ellerman.id.au,
        "the arch/x86 maintainers" <x86@kernel.org>, linux@armlinux.org.uk,
        michael.h.kelley@microsoft.com, Ingo Molnar <mingo@redhat.com>,
        catalin.marinas@arm.com, jhogan@kernel.org,
        Tianyu Lan <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
        haiyangz@microsoft.com, kvm-ppc@vger.kernel.org, bp@alien8.de,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        ralf@linux-mips.org, paul.burton@mips.com,
        devel@linuxdriverproject.org, vkuznets@redhat.com,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <lantianyu1986@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67528
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

On Tue, Nov 27, 2018 at 8:12 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Tue, Nov 27, 2018 at 07:59:22PM +0800, Tianyu Lan wrote:
> > Gentile Ping...
> >
> > On Thu, Nov 8, 2018 at 10:43 PM <lantianyu1986@gmail.com> wrote:
> > >
> > > From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> > >
> > > Sorry. Some patches was blocked and I try to resend via another account.
>
> The patches were still blocked?  They didn't show up on driver-devel.
>
> regards,
> dan carpenter
>

Hi Dan:
            Thanks for reminder. I double check kvm maillist archive
and this series is available.
https://marc.info/?l=kvm&m=154168821118117&w=2

-- 
Best regards
Tianyu Lan
