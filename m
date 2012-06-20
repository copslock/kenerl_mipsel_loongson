Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2012 08:55:04 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:44864 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903609Ab2FTGy5 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Jun 2012 08:54:57 +0200
Received: by lbbgg6 with SMTP id gg6so178965lbb.36
        for <multiple recipients>; Tue, 19 Jun 2012 23:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=tk0Wy/zOXZT6bc7Avt7W70tr8XjfEw02ubTljOWNyB8=;
        b=HbdDhHebhg22ilS0CQC0vLOmTAo7gIKUXhDIEBeSB5PYh7jbiQN5MgAdoqVry5B9CW
         36AuHcDU3rGUqvpVgrShw2VR0R5J1qaTLHnHaRv7jeSqEFVN9OAoy9JMX/a7ikshCTtp
         rPz0nghQP15XMdnxCS8Lfew4NDXvMKguPUZdcFQcaSS0MbLZSq78sIDjYUj3F6UozRta
         xOiTYkwQyFKRJyMFYmhwAenHaGH3R1PlHUZ/OmilkfdFYlSc5kYhsNa8noa43AnvBGK5
         zMmcnmLSXtbCFnbb1gmtozZwIW2Hiqt/nN04N1uldxlHquNSOUt9Ltr0aUXx7+b3VHt9
         NvJg==
MIME-Version: 1.0
Received: by 10.112.43.67 with SMTP id u3mr9312507lbl.16.1340175292229; Tue,
 19 Jun 2012 23:54:52 -0700 (PDT)
Received: by 10.152.5.103 with HTTP; Tue, 19 Jun 2012 23:54:51 -0700 (PDT)
In-Reply-To: <1340174293.28471.4.camel@tellur>
References: <1340088624-25550-1-git-send-email-chenhc@lemote.com>
        <1340088624-25550-13-git-send-email-chenhc@lemote.com>
        <1340090395.8334.7.camel@tellur>
        <CAAhV-H5E-DryVLiQdjs_qmY63291aZfu-0=4zaLd2Ee7j5A+5w@mail.gmail.com>
        <1340174293.28471.4.camel@tellur>
Date:   Wed, 20 Jun 2012 14:54:51 +0800
Message-ID: <CAAhV-H5G7aRhYaU_4ueuoSp6b9cXNA3jSHV6q8kuacBwD2PMTw@mail.gmail.com>
Subject: Re: [PATCH V2 12/16] drm/radeon: Make radeon card usable for Loongson.
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Lucas Stach <dev@lynxeye.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Zhangjin Wu <wuzhangjin@gmail.com>, Hua Yan <yanh@lemote.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        dri-devel@lists.freedesktop.org, Hongliang Tao <taohl@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 33735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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

On Wed, Jun 20, 2012 at 2:38 PM, Lucas Stach <dev@lynxeye.de> wrote:
> Am Mittwoch, den 20.06.2012, 14:12 +0800 schrieb Huacai Chen:
>> On Tue, Jun 19, 2012 at 3:19 PM, Lucas Stach <dev@lynxeye.de> wrote:
>> > Hello Huacai,
>> >
>> > Am Dienstag, den 19.06.2012, 14:50 +0800 schrieb Huacai Chen:
>> >> 1, Use 32-bit DMA as a workaround (Loongson has a hardware bug that it
>> >>    doesn't support DMA address above 4GB).
>> >
>> > This is a bug of your platform/CPU and should be fixed at a lower level,
>> > not in every driver. While radeon might be the only device using 40bit
>> > DMA right know, it is very well possible that other devices pop up in
>> > the future. So please fix your platform code to disallow >32bit DMA.
>>
>> Hi, Lucas
>> I have fixed my platform code to  disallow >32bit DMA. This method fix
>> the DMA problems in SATA and sound card, but fails on radeon (display
>> is OK, but accerlaration is unusable), because need_dma32 not only
>> affect dma_mask/coherent_dma_mask, but also affect th gfp_flags of
>> ttm_get_pages(). Platform code fixes cannot solve the problem of
>> ttm_get_pages(), could you please give me some suggestions? Thank you.
>
> If your platform does disallow >32bit DMA masks, radeon should already
> do the right thing and set need_dma32 to true. Have a look at
> radeon_device.c:783
>
> Make sure you really disallow >32bit DMA masks, not just prefer <=32bit
> masks.
I know, my previous code change is provide an arch-specific
dma_map_ops::set_dma_mask() and dma_set_coherent_mask() to force the
dma_mask/coherent_dma_mask <=bit, but always return success. In fact
the right way is return an error code when driver try to set the
dma_mask >32bit. Thank you very much!

>>
>> >
>> >> 2, Read vga bios offered by system firmware.
>> >> 3, Handle io prot correctly for MIPS.
>> >
>> > This seems good to me, but you should really split this out in a
>> > separate TTM patch.
>> >
>> >> 4, Don't use swiotlb on Loongson machines (when use swiotlb, GPU reset
>> >>    occurs at resume from suspend).
>> >>
>> > While SWIOTLB might not be a common setup, simply ignoring it because it
>> > doesn't work on your platform is the wrong thing to do. Could you please
>> > try to root-cause the issue?
>> >
> [snip]
>
>
