Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2018 05:38:44 +0200 (CEST)
Received: from mail-io1-f66.google.com ([209.85.166.66]:46154 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990412AbeIYDihe3CKS convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 25 Sep 2018 05:38:37 +0200
Received: by mail-io1-f66.google.com with SMTP id y12-v6so19321342ioj.13;
        Mon, 24 Sep 2018 20:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FHHwzBW7g3qOnNhrt/f9DbTQ5B0XU0w/gTZNaswBLkU=;
        b=KKKCV0PdZkcBO0g5xl7Z6RcYiM7yWevVzR1TOiDYKlCHbTVnOY/2euNv4kXNuW4bIM
         CgHjR2bAhH/BGc+zo/+qBY/IJqHamGO5Crki9i2zRWUdoOMbUhTHM5ZHUZgwW9988tPX
         a3WCyRNtV7QJzhzhoEcYReUzsCmIsKkcGpxUrjw7Q22mXtYcJWlLVRZtWhwEUCjiXLwU
         FcOOkUFXihCgMsd4dHIT2tqpYTAWiwbM7l0mN7C8Pwc+v+fiUDy4PU982twtFqmLrwQk
         Hyd66i4k8U2H1b7ISrXj8wZ30NeVtByR/X8PZoqvi0BP9ntH/vlUSPE7tttQNIHOBiPY
         /Dfw==
X-Gm-Message-State: ABuFfoguBwoeWNDnOeVhpLNZMUaHQsnNEyf5N2CAOijQxQY3HIKcOPd6
        7I2ac1tUN2cp9+cM3RlNR00B/vK2D4XZ4g==
X-Google-Smtp-Source: ACcGV62eibkn/dMU5cMeqCIO3kqjYwq//f9ym7fW3rmkgv4gd2F1x3gOUDnCo+ObPUDQUrX/qdc98g==
X-Received: by 2002:a5e:860d:: with SMTP id z13-v6mr1592549ioj.28.1537846711190;
        Mon, 24 Sep 2018 20:38:31 -0700 (PDT)
Received: from mail-it1-f179.google.com (mail-it1-f179.google.com. [209.85.166.179])
        by smtp.gmail.com with ESMTPSA id a79-v6sm480311itc.33.2018.09.24.20.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 20:38:30 -0700 (PDT)
Received: by mail-it1-f179.google.com with SMTP id j81-v6so13633295ite.0;
        Mon, 24 Sep 2018 20:38:30 -0700 (PDT)
X-Received: by 2002:a24:ad2e:: with SMTP id c46-v6mr1209191itf.82.1537846710225;
 Mon, 24 Sep 2018 20:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180924113103.337261320@linuxfoundation.org> <20180924113116.349047480@linuxfoundation.org>
 <20180925013548.GA28493@roeck-us.net>
In-Reply-To: <20180925013548.GA28493@roeck-us.net>
From:   =?UTF-8?B?U1ogTGluICjmnpfkuIrmmbop?= <sz.lin@moxa.com>
Date:   Tue, 25 Sep 2018 11:38:16 +0800
X-Gmail-Original-Message-ID: <CAFk6z8PzPo9Uza_pwxo=tm9nWWgax2GJMktUmYu_1QrJGJpy6A@mail.gmail.com>
Message-ID: <CAFk6z8PzPo9Uza_pwxo=tm9nWWgax2GJMktUmYu_1QrJGJpy6A@mail.gmail.com>
Subject: Re: [PATCH 4.9 111/111] MIPS: VDSO: Drop gic_get_usm_range() usage
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>,
        paul.burton@imgtec.com, jason@lakedaemon.net, marc.zyngier@arm.com,
        tglx@linutronix.de, linux-mips@linux-mips.org, ralf@linux-mips.org,
        SZ Lin <sz.lin@moxa.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <lin.sunze@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66546
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sz.lin@moxa.com
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

Hi,

Guenter Roeck <linux@roeck-us.net> 於 2018年9月25日 週二 上午9:36寫道：
>
> On Mon, Sep 24, 2018 at 01:53:18PM +0200, Greg Kroah-Hartman wrote:
> > 4.9-stable review patch.  If anyone has any objections, please let me know.
> >
>
> This patch breaks v4.4.y and v4.9.y builds.
> It includes asm/mips-cps.h which doesn't exist in those releases.

I am sorry for my fault, thanks for your report.

Since the patch b025d51873d5fe6 "MIPS: CM: Specify register size when
generating accessors" which created asm/mips-cps.h is not a bug-fixed
patch, hence I will not backport this header.

Hi Greg,

Could you please help to revert this commit? This commit was intended
to fix dependency of 70d7783 "MIPS: VDSO: Match data page cache
colouring when D$ aliases", but I saw 70d7783 was merged before this
commit; therefore, I don't think it is necessary to keep this commit.

I apology for any inconvenience caused, and I will be more careful next time.

SZ Lin (林上智)

>
> Building mips:malta_defconfig:smp:initrd ... failed
> ------------
> Error log:
> arch/mips/kernel/vdso.c:23:26: fatal error: asm/mips-cps.h: No such file or directory
>
> Guenter
>
> > ------------------
> >
> > From: Paul Burton <paul.burton@imgtec.com>
> >
> > commit 00578cd864d45ae4b8fa3f684f8d6f783dd8d15d upstream.
> >
> > We don't really need gic_get_usm_range() to abstract discovery of the
> > address of the GIC user-visible section now that we have access to its
> > base address globally.
> >
> > Switch to calculating it ourselves, which will allow us to stop
> > requiring the irqchip driver to care about a counter exposed to userland
> > for use via the VDSO.
> >
> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > Cc: Jason Cooper <jason@lakedaemon.net>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: linux-mips@linux-mips.org
> > Patchwork: https://patchwork.linux-mips.org/patch/17040/
> > Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> > Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  arch/mips/kernel/vdso.c |   15 +++++----------
> >  1 file changed, 5 insertions(+), 10 deletions(-)
> >
> > --- a/arch/mips/kernel/vdso.c
> > +++ b/arch/mips/kernel/vdso.c
> > @@ -13,7 +13,6 @@
> >  #include <linux/err.h>
> >  #include <linux/init.h>
> >  #include <linux/ioport.h>
> > -#include <linux/irqchip/mips-gic.h>
> >  #include <linux/kernel.h>
> >  #include <linux/mm.h>
> >  #include <linux/sched.h>
> > @@ -21,6 +20,7 @@
> >  #include <linux/timekeeper_internal.h>
> >
> >  #include <asm/abi.h>
> > +#include <asm/mips-cps.h>
> >  #include <asm/page.h>
> >  #include <asm/vdso.h>
> >
> > @@ -101,9 +101,8 @@ int arch_setup_additional_pages(struct l
> >  {
> >       struct mips_vdso_image *image = current->thread.abi->vdso;
> >       struct mm_struct *mm = current->mm;
> > -     unsigned long gic_size, vvar_size, size, base, data_addr, vdso_addr;
> > +     unsigned long gic_size, vvar_size, size, base, data_addr, vdso_addr, gic_pfn;
> >       struct vm_area_struct *vma;
> > -     struct resource gic_res;
> >       int ret;
> >
> >       if (down_write_killable(&mm->mmap_sem))
> > @@ -127,7 +126,7 @@ int arch_setup_additional_pages(struct l
> >        * only map a page even though the total area is 64K, as we only need
> >        * the counter registers at the start.
> >        */
> > -     gic_size = gic_present ? PAGE_SIZE : 0;
> > +     gic_size = mips_gic_present() ? PAGE_SIZE : 0;
> >       vvar_size = gic_size + PAGE_SIZE;
> >       size = vvar_size + image->size;
> >
> > @@ -168,13 +167,9 @@ int arch_setup_additional_pages(struct l
> >
> >       /* Map GIC user page. */
> >       if (gic_size) {
> > -             ret = gic_get_usm_range(&gic_res);
> > -             if (ret)
> > -                     goto out;
> > +             gic_pfn = virt_to_phys(mips_gic_base + MIPS_GIC_USER_OFS) >> PAGE_SHIFT;
> >
> > -             ret = io_remap_pfn_range(vma, base,
> > -                                      gic_res.start >> PAGE_SHIFT,
> > -                                      gic_size,
> > +             ret = io_remap_pfn_range(vma, base, gic_pfn, gic_size,
> >                                        pgprot_noncached(PAGE_READONLY));
> >               if (ret)
> >                       goto out;
> >
> >
