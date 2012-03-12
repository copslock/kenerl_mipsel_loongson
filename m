Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2012 02:31:36 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:55519 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903603Ab2CLBbU convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Mar 2012 02:31:20 +0100
Received: by iaky10 with SMTP id y10so7395992iak.36
        for <multiple recipients>; Sun, 11 Mar 2012 18:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=REfPJsNXoXD0Jyksyq1s+4vcw7uYZPzw96m36+CKYN8=;
        b=iskjAI0n2TM1QGYnnuhp6vjdqnZvV7Le+3hbBegIGUoFhRwHSFZVOdJPUD1O6qnZDC
         5xg5ukZoOpEAtnJjTa7ArYPy9uQr0YgQDHFXvmuiFaB9w0oyS6Xa2mzvKh6sOvGVRtAg
         ZPcqoC5awhGfhNVYYD36a2IktPp2UkgfoxWZCyKIK2oTldc+cdUH6ujzaa+0xcE8jb95
         IijnGPpC4GwStqNMDIqdylnrU48rmFNT/sYCBL0B1PGm4YeofBpa7x8wJkXDgHy+nPU5
         zNAh8oNpPCY/ztkVeirB3AjwlGWuLwYzSL/yzorviS2VpT6achHvY/3MdR5cVy61do4Z
         Efig==
Received: by 10.50.222.170 with SMTP id qn10mr5981008igc.57.1331515874214;
 Sun, 11 Mar 2012 18:31:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.42.239.197 with HTTP; Sun, 11 Mar 2012 18:30:54 -0700 (PDT)
In-Reply-To: <4F5D3679.3090900@hauke-m.de>
References: <1331496505-18697-1-git-send-email-hauke@hauke-m.de>
 <1331496505-18697-4-git-send-email-hauke@hauke-m.de> <CAGRGNgX116dRB03NTL_DFZ4b_PYcdY+Un_cVwt6ZUGR1bwZzHA@mail.gmail.com>
 <4F5D3679.3090900@hauke-m.de>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Mon, 12 Mar 2012 12:30:54 +1100
Message-ID: <CAGRGNgWsO9s2rW1pKBFWd_-0oTAGs9_RXNGyn_y7ic=0Zer=qQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] bcma: scan for extra address space
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        linux-mips@linux-mips.org, ralf@linux-mips.org, m@bues.ch,
        linux-usb@vger.kernel.org,
        =?ISO-8859-2?Q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 32652
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julian.calaby@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Hauke,

On Mon, Mar 12, 2012 at 10:34, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> On 03/11/2012 10:59 PM, Julian Calaby wrote:
>> Hi Hauke,
>>
>> On Mon, Mar 12, 2012 at 07:08, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>>> Some cores like the USB core have two address spaces. In the USB host
>>> controller one address space is used for the OHCI and the other for the
>>> EHCI controller interface. The USB controller is the only core I found
>>> with two address spaces. This code is based on the AI scan function
>>> ai_scan() in shared/aiutils.c i the Broadcom SDK.
>>>
>>> CC: Rafał Miłecki <zajec5@gmail.com>
>>> CC: linux-wireless@vger.kernel.org
>>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>>> ---
>>>  drivers/bcma/scan.c       |   18 +++++++++++++++++-
>>>  include/linux/bcma/bcma.h |    1 +
>>>  2 files changed, 18 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/bcma/scan.c b/drivers/bcma/scan.c
>>> index 3a2f672..3c2eeed 100644
>>> --- a/drivers/bcma/scan.c
>>> +++ b/drivers/bcma/scan.c
>>> @@ -286,6 +286,22 @@ static int bcma_get_next_core(struct bcma_bus *bus, u32 __iomem **eromptr,
>>>                        return -EILSEQ;
>>>        }
>>>
>>> +
>>> +       /* First Slave Address Descriptor should be port 0:
>>> +        * the main register space for the core
>>> +        */
>>> +       tmp = bcma_erom_get_addr_desc(bus, eromptr, SCAN_ADDR_TYPE_SLAVE, 0);
>>> +       if (tmp <= 0) {
>>> +               /* Try again to see if it is a bridge */
>>> +               tmp = bcma_erom_get_addr_desc(bus, eromptr,
>>> +                                             SCAN_ADDR_TYPE_BRIDGE, 0);
>>> +               if (tmp > 0) {
>>> +                       pr_info("found bridge");
>>> +                       return -ENXIO;
>>> +               }
>>
>> Should this do something if the second bcma_erom_get_addr_desc() call
>> returns an error? We seem to be putting any errors from that call into
>> the addr member of the core structure below.
> Yes that's true, we should handle that error. If tmp <= 0 the
> description entry was malformed and something went wrong and we should
> handle it, a correctly found bridge should just be ignored.
>
> I will fix this, should I resend the hole series or just this patch?

I'm not sure the rest of the series made it to linux-wireless, so
maybe you should resend everything.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
