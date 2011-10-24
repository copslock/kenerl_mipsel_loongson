Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Oct 2011 12:36:57 +0200 (CEST)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:34192 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491070Ab1JXKgs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Oct 2011 12:36:48 +0200
Received: by vws15 with SMTP id 15so5704132vws.36
        for <multiple recipients>; Mon, 24 Oct 2011 03:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VQOPoToXaFbtP13DyUDXObBiUGo2bsG//5553ewqxYA=;
        b=E4EjE7SBssOzWE3BR45tXzzaiVBpesp41RkNvYYZS23mNKKnyLh9GZjdQc1+Piwdp3
         fE6CRKN39H8CDgBSuTZ9110sW/XQO4JW5vdvmVrpSVu/Z1NGmnNKdLyiaUXqrH7MniAO
         G+B8akmMm+mlyGDGuaKTAlNOz3V1Riyr/D1vM=
MIME-Version: 1.0
Received: by 10.52.36.237 with SMTP id t13mr22068500vdj.45.1319452602230; Mon,
 24 Oct 2011 03:36:42 -0700 (PDT)
Received: by 10.220.108.69 with HTTP; Mon, 24 Oct 2011 03:36:42 -0700 (PDT)
In-Reply-To: <4EA5117C.3000402@st.com>
References: <1319192888-21465-1-git-send-email-keguang.zhang@gmail.com>
        <1319192888-21465-2-git-send-email-keguang.zhang@gmail.com>
        <CAD+V5YKBkW52_md9rBeVZ1RXq2FGEXt=Ergsw+z8txMreZdNsA@mail.gmail.com>
        <4EA5117C.3000402@st.com>
Date:   Mon, 24 Oct 2011 18:36:42 +0800
Message-ID: <CAJhJPsVSzXXmBOwLaGNtOsxhVEyC0fAJtiBvEWzcKcSDC8NEcA@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] MIPS: Add board support for Loongson1B
From:   Kelvin Cheung <keguang.zhang@gmail.com>
To:     Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, ralf@linux-mips.org,
        r0bertz@gentoo.org, netdev@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 31285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17065

Hi Giuseppe,

2011/10/24, Giuseppe CAVALLARO <peppe.cavallaro@st.com>:
> On 10/21/2011 7:33 PM, Wu Zhangjin wrote:
>> On Fri, Oct 21, 2011 at 6:28 PM,  <keguang.zhang@gmail.com> wrote:
>>> From: Kelvin Cheung <keguang.zhang@gmail.com>
>>>
>>> This patch adds basic platform support for Loongson1B
>>> including serial port, ethernet, and interrupt handler.
>>>
>>> Loongson1B UART is compatible with NS16550A.
>>> Loongson1B GMAC is built around Synopsys IP Core.
>>>
>>
>> Perhaps you'd better split out the GMAC support to its own patch and
>> send it to the net/ maintainer and the authors of the original files.
>
> Also suggest you to provide the stmmac patches for net-next.
> The stmmac driver has been recently updated and I've also several
> patches to commit (for example for PCI etc) on it.
>
> I'm happy that the support for big endianess arrived.
> I supported a guy some time ago but he didn't provided me the patches
> tested on his side :-(. So welcome yours and many thanks Kelvin!
>
> Please send the stmmac patches and add me on CC. I'm happy to help you
> on reviewing them.

Thanks for your review.

>>> diff --git a/drivers/net/stmmac/descs.h b/drivers/net/stmmac/descs.h
>>> index 63a03e2..4db27d0 100644
>>> --- a/drivers/net/stmmac/descs.h
>>> +++ b/drivers/net/stmmac/descs.h
>>> @@ -53,6 +53,38 @@ struct dma_desc {
>>>                        u32 reserved3:5;
>>>                        u32 disable_ic:1;
>>>                } rx;
>>> +#ifdef CONFIG_MACH_LOONGSON1
>>> +               struct {
>>> +                       /* RDES0 */
>>> +                       u32 payload_csum_error:1;
>>> +                       u32 crc_error:1;
>>> +                       u32 dribbling:1;
>>> +                       u32 error_gmii:1;
>>> +                       u32 receive_watchdog:1;
>>> +                       u32 frame_type:1;
>>> +                       u32 late_collision:1;
>>> +                       u32 ipc_csum_error:1;
>>> +                       u32 last_descriptor:1;
>>> +                       u32 first_descriptor:1;
>>> +                       u32 vlan_tag:1;
>>> +                       u32 overflow_error:1;
>>> +                       u32 length_error:1;
>>> +                       u32 sa_filter_fail:1;
>>> +                       u32 descriptor_error:1;
>>> +                       u32 error_summary:1;
>>> +                       u32 frame_length:14;
>>> +                       u32 da_filter_fail:1;
>>> +                       u32 own:1;
>>> +                       /* RDES1 */
>>> +                       u32 buffer1_size:11;
>>> +                       u32 buffer2_size:11;
>>> +                       u32 reserved1:2;
>>> +                       u32 second_address_chained:1;
>>> +                       u32 end_ring:1;
>>> +                       u32 reserved2:5;
>>> +                       u32 disable_ic:1;
>>> +               } erx;          /* -- enhanced -- */
>>> +#else
>>>                struct {
>>>                        /* RDES0 */
>>>                        u32 payload_csum_error:1;
>>> @@ -83,6 +115,7 @@ struct dma_desc {
>>>                        u32 reserved2:2;
>>>                        u32 disable_ic:1;
>>>                } erx;          /* -- enhanced -- */
>>> +#endif
>>>
>>>                /* Transmit descriptor */
>>>                struct {
>>> @@ -113,6 +146,40 @@ struct dma_desc {
>>>                        u32 last_segment:1;
>>>                        u32 interrupt:1;
>>>                } tx;
>>> +#ifdef CONFIG_MACH_LOONGSON1
>>> +               struct {
>>> +                       /* TDES0 */
>>> +                       u32 deferred:1;
>>> +                       u32 underflow_error:1;
>>> +                       u32 excessive_deferral:1;
>>> +                       u32 collision_count:4;
>>> +                       u32 vlan_frame:1;
>>> +                       u32 excessive_collisions:1;
>>> +                       u32 late_collision:1;
>>> +                       u32 no_carrier:1;
>>> +                       u32 loss_carrier:1;
>>> +                       u32 payload_error:1;
>>> +                       u32 frame_flushed:1;
>>> +                       u32 jabber_timeout:1;
>>> +                       u32 error_summary:1;
>>> +                       u32 ip_header_error:1;
>>> +                       u32 time_stamp_status:1;
>>> +                       u32 reserved1:13;
>>> +                       u32 own:1;
>>> +                       /* TDES1 */
>>> +                       u32 buffer1_size:11;
>>> +                       u32 buffer2_size:11;
>>> +                       u32 time_stamp_enable:1;
>>> +                       u32 disable_padding:1;
>>> +                       u32 second_address_chained:1;
>>> +                       u32 end_ring:1;
>>> +                       u32 crc_disable:1;
>>> +                       u32 checksum_insertion:2;
>>> +                       u32 first_segment:1;
>>> +                       u32 last_segment:1;
>>> +                       u32 interrupt:1;
>>> +               } etx;          /* -- enhanced -- */
>>> +#else
>>>                struct {
>>>                        /* TDES0 */
>>>                        u32 deferred:1;
>>> @@ -148,6 +215,7 @@ struct dma_desc {
>>>                        u32 buffer2_size:13;
>>>                        u32 reserved4:3;
>>>                } etx;          /* -- enhanced -- */
>>> +#endif
>>>        } des01;
>>>        unsigned int des2;
>>>        unsigned int des3;
>>
>>
>> If the difference is very much, perhaps a new dma_desc struct can be
>> defined instead.
>>
>
> Concerning the descriptors, we could have two different files:
>
> descs_le.h
> descs_be.h
>
> and select their inclusion inside the common.h.
>
> Please use instead of the macro CONFIG_MACH_LOONGSON1 another one more
> generic e.g. CONFIG_STMMAC_BE  (and add it in the driver's Kconfig).
>
> On your platform you will have to enable it by default.
> Or it could be the default on MIPS: LE will be on ARM and SuperH.

Loongson1B(MIPS32 R2 compatible) is little endian.
And as you can see, the bitfield of RX/TX descriptor is different from
the enhanced descriptor.

>>> diff --git a/drivers/net/stmmac/enh_desc.c
>>> b/drivers/net/stmmac/enh_desc.c
>>> index e5dfb6a..3b5e4f1 100644
>>> --- a/drivers/net/stmmac/enh_desc.c
>>> +++ b/drivers/net/stmmac/enh_desc.c
>>> @@ -108,6 +108,7 @@ static int enh_desc_get_tx_len(struct dma_desc *p)
>>>  static int enh_desc_coe_rdes0(int ipc_err, int type, int payload_err)
>>>  {
>>>        int ret = good_frame;
>>> +#ifndef CONFIG_MACH_LOONGSON1
>>>        u32 status = (type << 2 | ipc_err << 1 | payload_err) & 0x7;
>>>
>>>        /* bits 5 7 0 | Frame status
>>> @@ -145,6 +146,7 @@ static int enh_desc_coe_rdes0(int ipc_err, int type,
>>> int payload_err)
>>>                CHIP_DBG(KERN_ERR "RX Des0 status: No IPv4, IPv6
>>> frame.\n");
>>>                ret = discard_frame;
>>>        }
>>> +#endif
>>>        return ret;
>>>  }
>
>>>
>>> @@ -232,9 +234,17 @@ static void enh_desc_init_rx_desc(struct dma_desc
>>> *p, unsigned int ring_size,
>>>        int i;
>>>        for (i = 0; i < ring_size; i++) {
>>>                p->des01.erx.own = 1;
>>> +#ifdef CONFIG_MACH_LOONGSON1
>>> +               p->des01.erx.buffer1_size = BUF_SIZE_2KiB - 1;
>>> +#else
>>>                p->des01.erx.buffer1_size = BUF_SIZE_8KiB - 1;
>>> +#endif
>>>                /* To support jumbo frames */
>>> +#ifdef CONFIG_MACH_LOONGSON1
>>> +               p->des01.erx.buffer2_size = BUF_SIZE_2KiB - 1;
>>> +#else
>>>                p->des01.erx.buffer2_size = BUF_SIZE_8KiB - 1;
>>> +#endif
>>>                if (i == ring_size - 1)
>>>                        p->des01.erx.end_ring = 1;
>>>                if (disable_rx_ic)
>>> @@ -292,9 +302,15 @@ static void enh_desc_prepare_tx_desc(struct dma_desc
>>> *p, int is_fs, int len,
>>>                                     int csum_flag)
>>>  {
>>>        p->des01.etx.first_segment = is_fs;
>>> +#ifdef CONFIG_MACH_LOONGSON1
>>> +       if (unlikely(len > BUF_SIZE_2KiB)) {
>>> +               p->des01.etx.buffer1_size = BUF_SIZE_2KiB - 1;
>>> +               p->des01.etx.buffer2_size = len - BUF_SIZE_2KiB + 1;
>>> +#else
>>>        if (unlikely(len > BUF_SIZE_4KiB)) {
>>>                p->des01.etx.buffer1_size = BUF_SIZE_4KiB;
>>>                p->des01.etx.buffer2_size = len - BUF_SIZE_4KiB;
>>> +#endif
>>>        } else {
>>>                p->des01.etx.buffer1_size = len;
>>>        }
>
> No. I do not want to see all these ifdef inside the code.
> I had to rework some driver's part just last week to avoid this kind of
> code. I suggest you to re-base the work against the net-next kernel and
> look at how the ring/chained modes have been managed.
>
> I added a new file called descs_com.h that you can re-use adding small
> inline functions where define the changes for be mode.

According to datasheet of Loongson 1B, the buffer size in RX/TX
descriptor is only 2KB.
So the Loongson1B's GMAC could not handle jumbo frames.
And the second buffer is useless in this case.
Am I right?

Is there a better way than ifdef CONFIG_MACH_LOONGSON1 to avoid duplicate code?

>> Is it possible to add two new macros RX_BUF_SIZE and TX_BUF_SIZE to .h
>> instead? which may reduce code duplication.
>
> This code exists because we have to properly handle the jumbo frames.
>
> Note that this code has been reworked to use the ring/chained modes.
> Take a look at descs_com.h.
>
> I expect to see the driver on your platform that uses jumbo and
> chained/ring modes.
>
> Best Regards
> Giuseppe
>
>>
>> Regards,
>> Wu Zhangjin
>>
>>> --
>>> 1.7.1
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe netdev" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>


-- 
Best Regards!
Kelvin
