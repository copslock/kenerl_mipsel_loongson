Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2012 08:38:24 +0200 (CEST)
Received: from ns.km20343-01.keymachine.de ([84.19.182.79]:48237 "EHLO
        km20343-01.keymachine.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1903609Ab2FTGiO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jun 2012 08:38:14 +0200
Received: from [192.168.1.20] (f053027082.adsl.alicedsl.de [78.53.27.82])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by km20343-01.keymachine.de (Postfix) with ESMTPSA id D5CE47D4162;
        Wed, 20 Jun 2012 08:38:13 +0200 (CEST)
Message-ID: <1340174293.28471.4.camel@tellur>
Subject: Re: [PATCH V2 12/16] drm/radeon: Make radeon card usable for
 Loongson.
From:   Lucas Stach <dev@lynxeye.de>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Zhangjin Wu <wuzhangjin@gmail.com>, Hua Yan <yanh@lemote.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        dri-devel@lists.freedesktop.org, Hongliang Tao <taohl@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Date:   Wed, 20 Jun 2012 08:38:13 +0200
In-Reply-To: <CAAhV-H5E-DryVLiQdjs_qmY63291aZfu-0=4zaLd2Ee7j5A+5w@mail.gmail.com>
References: <1340088624-25550-1-git-send-email-chenhc@lemote.com>
         <1340088624-25550-13-git-send-email-chenhc@lemote.com>
         <1340090395.8334.7.camel@tellur>
         <CAAhV-H5E-DryVLiQdjs_qmY63291aZfu-0=4zaLd2Ee7j5A+5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.4.2 (3.4.2-1.fc17) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-archive-position: 33734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dev@lynxeye.de
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Am Mittwoch, den 20.06.2012, 14:12 +0800 schrieb Huacai Chen:
> On Tue, Jun 19, 2012 at 3:19 PM, Lucas Stach <dev@lynxeye.de> wrote:
> > Hello Huacai,
> >
> > Am Dienstag, den 19.06.2012, 14:50 +0800 schrieb Huacai Chen:
> >> 1, Use 32-bit DMA as a workaround (Loongson has a hardware bug that it
> >>    doesn't support DMA address above 4GB).
> >
> > This is a bug of your platform/CPU and should be fixed at a lower level,
> > not in every driver. While radeon might be the only device using 40bit
> > DMA right know, it is very well possible that other devices pop up in
> > the future. So please fix your platform code to disallow >32bit DMA.
> 
> Hi, Lucas
> I have fixed my platform code to  disallow >32bit DMA. This method fix
> the DMA problems in SATA and sound card, but fails on radeon (display
> is OK, but accerlaration is unusable), because need_dma32 not only
> affect dma_mask/coherent_dma_mask, but also affect th gfp_flags of
> ttm_get_pages(). Platform code fixes cannot solve the problem of
> ttm_get_pages(), could you please give me some suggestions? Thank you.

If your platform does disallow >32bit DMA masks, radeon should already
do the right thing and set need_dma32 to true. Have a look at
radeon_device.c:783

Make sure you really disallow >32bit DMA masks, not just prefer <=32bit
masks.
> 
> >
> >> 2, Read vga bios offered by system firmware.
> >> 3, Handle io prot correctly for MIPS.
> >
> > This seems good to me, but you should really split this out in a
> > separate TTM patch.
> >
> >> 4, Don't use swiotlb on Loongson machines (when use swiotlb, GPU reset
> >>    occurs at resume from suspend).
> >>
> > While SWIOTLB might not be a common setup, simply ignoring it because it
> > doesn't work on your platform is the wrong thing to do. Could you please
> > try to root-cause the issue?
> >
[snip]
