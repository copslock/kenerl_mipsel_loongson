Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Oct 2011 16:05:17 +0200 (CEST)
Received: from mail-vx0-f177.google.com ([209.85.220.177]:55486 "EHLO
        mail-vx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491074Ab1JXOFN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Oct 2011 16:05:13 +0200
Received: by vcbfl15 with SMTP id fl15so6320196vcb.36
        for <multiple recipients>; Mon, 24 Oct 2011 07:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Nj7Jx1omc3dlPylwONsbbhheNosdA7MYI/eoxCCohew=;
        b=DmaEF6iY2IP64gaaUJwoZkaYQsVVEi39QW1cGw1awSSNRofptCcLXdL2qv79RBjiIz
         SRWfMLfe/6IVTUDBUF04Bzf9xmHbHhnr5TTbOZIuDfiOEoyssPHy2PTcpTxwnZ0vi4/J
         6UavRfLqMNSaZTNAeqqYB+XfDtk2JRA0uMDNU=
MIME-Version: 1.0
Received: by 10.52.26.242 with SMTP id o18mr5944678vdg.100.1319465106913; Mon,
 24 Oct 2011 07:05:06 -0700 (PDT)
Received: by 10.220.108.69 with HTTP; Mon, 24 Oct 2011 07:05:06 -0700 (PDT)
In-Reply-To: <4EA557B2.4020504@st.com>
References: <1319192888-21465-1-git-send-email-keguang.zhang@gmail.com>
        <1319192888-21465-2-git-send-email-keguang.zhang@gmail.com>
        <CAD+V5YKBkW52_md9rBeVZ1RXq2FGEXt=Ergsw+z8txMreZdNsA@mail.gmail.com>
        <4EA5117C.3000402@st.com>
        <CAJhJPsVSzXXmBOwLaGNtOsxhVEyC0fAJtiBvEWzcKcSDC8NEcA@mail.gmail.com>
        <4EA557B2.4020504@st.com>
Date:   Mon, 24 Oct 2011 22:05:06 +0800
Message-ID: <CAJhJPsXxUAuF9HdivLd66MQC45mz-iYAuF1SdGdU=-duxJJ5bQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] MIPS: Add board support for Loongson1B
From:   Kelvin Cheung <keguang.zhang@gmail.com>
To:     Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, ralf@linux-mips.org,
        r0bertz@gentoo.org, netdev@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 31292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17268

2011/10/24, Giuseppe CAVALLARO <peppe.cavallaro@st.com>:
> Hello Kelvin.
>
> On 10/24/2011 12:36 PM, Kelvin Cheung wrote:
>
> [snip]
>
>> According to datasheet of Loongson 1B, the buffer size in RX/TX
>> descriptor is only 2KB. So the Loongson1B's GMAC could not handle
>> jumbo frames. And the second buffer is useless in this case. Am I
>> right? Is there a better way than ifdef CONFIG_MACH_LOONGSON1 to
>> avoid duplicate code?
>
> Sorry for my misunderstanding.
>
> I think you have to use the normal descriptor and remove the enh_desc
> from the platform w/o modifying the driver at all.
>
> The driver will be able to select/configure all automatically (also jumbo).
>
> Let me know.

That's the problem.
The bitfield definition of Loongson1B is also different from normal descriptor.

Moreover, I want to enable the TX checksum offload function which is
not supported in normal descriptor.

Any suggestions?

> Note:
> IIRC, there is a bit difference in case of normal descriptors for
> Synopsys databook newer than the 1.91 (I used for testing this mode).
> In any case, I remember that, on some platforms, the normal descriptors
> have been used w/o problems also on these new chip generations.
>
> Peppe
>
>


-- 
Best Regards!
Kelvin
