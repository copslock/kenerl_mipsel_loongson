Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2018 22:30:11 +0100 (CET)
Received: from mail-oi0-x242.google.com ([IPv6:2607:f8b0:4003:c06::242]:44521
        "EHLO mail-oi0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990400AbeCLVaDwPswf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Mar 2018 22:30:03 +0100
Received: by mail-oi0-x242.google.com with SMTP id b8so13567852oib.11;
        Mon, 12 Mar 2018 14:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zEQU4EbQDemOhb8iAu+Txc5fp6RnzrN42H/ihuxke8w=;
        b=g4jxwLM9Z8BI7Pyo5W0cMN6HHlomKYjSFKZ27gZy0GLZzhtMD+R919hBQ/AMlA1zmM
         1CdS0df+CUlyrpNM5NZ8D8QrK6x94ZrmYMLBxNbMQhNwpzSHEGtsz5Ik0ClOFDFZ+ntK
         IOvby3r73S3hssZXlnd3XcowtYS3WExqQ7BdWrmXjGPxJUryN7MEFKxvIPxFcpPhyBZq
         ki0B4/P3OR55+E2IR7vRhsaEWPkKJE2diOOGy5z+jvW61ep3QNiPj66bKZMlKJD5F5OV
         2WWOiJVE+SJOqGZe1eWgTo4XORHPCznr6FxwjcxPQ2I/Eue7fNAtb4mI48iNpUGeluIg
         CWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zEQU4EbQDemOhb8iAu+Txc5fp6RnzrN42H/ihuxke8w=;
        b=tTMmZT48JB3350wmtLwRf63Wy7ywWj9sNTkWc8bdXw9lZ4Cwg5ftOSyTTyH0r5gOhT
         AVCvYfxsoUm6CPTOYj/9o1OgdYQr7foE4fYKZ0uR3c4vx8Mc88kedOCiXtgHxOl1Y0cY
         m+UeWWiysSaVGH2y2nGfo5mB7pYUiThVeUZJQxqZT5GDenLzH5wEFRi6ErSqsohDeUwH
         aGJpd9g08CSshaiC4rL6DGvYbBHHqjYs4rmNZPZCMcs5Oho9iVcpU8OAQlrMruROGVWy
         mtRR3Rcd5pLH1g0dOAXbknwrphVSq0+RsUaH0YK1xgGK2usIxwFBVnT2TSPygxmNYY4d
         djFg==
X-Gm-Message-State: AElRT7EFpgbxhAX0hZq/A/lM4+1dM8ERdNsjqDlQ9pVvv8AFytEW4PuS
        H3fMUGHnWBLVovf0PGb38sgkDJimF7Q2NYx+48Q=
X-Google-Smtp-Source: AG47ELvV8lePrAtYJetM9+oTplg38+bEB4Ia4hk1PwWso5AKXwJWWyW8prZHizxYXQc2vtBxzWdK36KU4Yrokki/0Mo=
X-Received: by 10.202.28.10 with SMTP id c10mr5582047oic.179.1520890197259;
 Mon, 12 Mar 2018 14:29:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.64.3 with HTTP; Mon, 12 Mar 2018 14:29:36 -0700 (PDT)
In-Reply-To: <20180312211702.GB21642@saruman>
References: <20180311174123.2578-1-hauke@hauke-m.de> <20180311174123.2578-2-hauke@hauke-m.de>
 <20180312211702.GB21642@saruman>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 12 Mar 2018 22:29:36 +0100
Message-ID: <CAFBinCA3-AOVwxAofBtEAEK1+n=Txgf14KanEW6YYV+Rr6mvGA@mail.gmail.com>
Subject: Re: [PATCH 2/3] MIPS: lantiq: enable AHB Bus for USB
To:     James Hogan <jhogan@kernel.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, ralf@linux-mips.org,
        john@phrozen.org, dev@kresin.me, linux-mips@linux-mips.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <martin.blumenstingl@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62927
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: martin.blumenstingl@googlemail.com
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

Hi James,

On Mon, Mar 12, 2018 at 10:17 PM, James Hogan <jhogan@kernel.org> wrote:
> Hi,
>
> On Sun, Mar 11, 2018 at 06:41:22PM +0100, Hauke Mehrtens wrote:
>> From: Mathias Kresin <dev@kresin.me>
>>
>> On Danube and AR9 the USB core is connected to the AHB bus, hence we need
>> to enable the AHB Bus as well.
>>
>> Fixes: dea54fbad332 ("phy: Add an USB PHY driver for the Lantiq SoCs using the RCU module")
>> Signed-off-by: Mathias Kresin <dev@kresin.me>
>
> Hauke: I think this needs your SoB line too (same for other 2 patches
> too).
>
>> ---
>>  arch/mips/lantiq/xway/sysctrl.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
>> index f11f1dd10493..e0af39b33e28 100644
>> --- a/arch/mips/lantiq/xway/sysctrl.c
>> +++ b/arch/mips/lantiq/xway/sysctrl.c
>> @@ -549,9 +549,9 @@ void __init ltq_soc_init(void)
>>               clkdev_add_static(ltq_ar9_cpu_hz(), ltq_ar9_fpi_hz(),
>>                               ltq_ar9_fpi_hz(), CLOCK_250M);
>>               clkdev_add_pmu("1f203018.usb2-phy", "phy", 1, 0, PMU_USB0_P);
>> -             clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0);
>> +             clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0 | PMU_AHBM);
>
> Checkpatch complains about these changed lines all being >80 columns,
> though there are admittedly other violations nearby too.
I suggest to keep it as suggested by Mathias/Hauke.
our (Hauke and my) plan is to remove the whole file and replace it
with a driver based on the common clock framework (in drivers/clk/)
mid-term. in my opinion this is better than just fixing the 80 column
limit


Regards
Martin
