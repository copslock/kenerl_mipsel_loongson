Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2012 00:34:40 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:43439 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903599Ab2CKXed (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Mar 2012 00:34:33 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 0BE7E8F61;
        Mon, 12 Mar 2012 00:34:33 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lNiQ5NWhBr51; Mon, 12 Mar 2012 00:34:18 +0100 (CET)
Received: from [192.168.1.220] (unknown [134.102.132.222])
        by hauke-m.de (Postfix) with ESMTPSA id 33B258F60;
        Mon, 12 Mar 2012 00:34:18 +0100 (CET)
Message-ID: <4F5D3679.3090900@hauke-m.de>
Date:   Mon, 12 Mar 2012 00:34:17 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To:     Julian Calaby <julian.calaby@gmail.com>
CC:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        linux-mips@linux-mips.org, ralf@linux-mips.org, m@bues.ch,
        linux-usb@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 3/7] bcma: scan for extra address space
References: <1331496505-18697-1-git-send-email-hauke@hauke-m.de> <1331496505-18697-4-git-send-email-hauke@hauke-m.de> <CAGRGNgX116dRB03NTL_DFZ4b_PYcdY+Un_cVwt6ZUGR1bwZzHA@mail.gmail.com>
In-Reply-To: <CAGRGNgX116dRB03NTL_DFZ4b_PYcdY+Un_cVwt6ZUGR1bwZzHA@mail.gmail.com>
X-Enigmail-Version: 1.3.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 32651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 03/11/2012 10:59 PM, Julian Calaby wrote:
> Hi Hauke,
> 
> On Mon, Mar 12, 2012 at 07:08, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>> Some cores like the USB core have two address spaces. In the USB host
>> controller one address space is used for the OHCI and the other for the
>> EHCI controller interface. The USB controller is the only core I found
>> with two address spaces. This code is based on the AI scan function
>> ai_scan() in shared/aiutils.c i the Broadcom SDK.
>>
>> CC: Rafał Miłecki <zajec5@gmail.com>
>> CC: linux-wireless@vger.kernel.org
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
>>  drivers/bcma/scan.c       |   18 +++++++++++++++++-
>>  include/linux/bcma/bcma.h |    1 +
>>  2 files changed, 18 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/bcma/scan.c b/drivers/bcma/scan.c
>> index 3a2f672..3c2eeed 100644
>> --- a/drivers/bcma/scan.c
>> +++ b/drivers/bcma/scan.c
>> @@ -286,6 +286,22 @@ static int bcma_get_next_core(struct bcma_bus *bus, u32 __iomem **eromptr,
>>                        return -EILSEQ;
>>        }
>>
>> +
>> +       /* First Slave Address Descriptor should be port 0:
>> +        * the main register space for the core
>> +        */
>> +       tmp = bcma_erom_get_addr_desc(bus, eromptr, SCAN_ADDR_TYPE_SLAVE, 0);
>> +       if (tmp <= 0) {
>> +               /* Try again to see if it is a bridge */
>> +               tmp = bcma_erom_get_addr_desc(bus, eromptr,
>> +                                             SCAN_ADDR_TYPE_BRIDGE, 0);
>> +               if (tmp > 0) {
>> +                       pr_info("found bridge");
>> +                       return -ENXIO;
>> +               }
> 
> Should this do something if the second bcma_erom_get_addr_desc() call
> returns an error? We seem to be putting any errors from that call into
> the addr member of the core structure below.
Yes that's true, we should handle that error. If tmp <= 0 the
description entry was malformed and something went wrong and we should
handle it, a correctly found bridge should just be ignored.

I will fix this, should I resend the hole series or just this patch?
> 
>> +       }
>> +       core->addr = tmp;
>> +
>>        /* get & parse slave ports */
>>        for (i = 0; i < ports[1]; i++) {
>>                for (j = 0; ; j++) {
>> @@ -298,7 +314,7 @@ static int bcma_get_next_core(struct bcma_bus *bus, u32 __iomem **eromptr,
>>                                break;
>>                        } else {
>>                                if (i == 0 && j == 0)
>> -                                       core->addr = tmp;
>> +                                       core->addr1 = tmp;
>>                        }
>>                }
>>        }
>> diff --git a/include/linux/bcma/bcma.h b/include/linux/bcma/bcma.h
>> index 83c209f..7fe41e1 100644
>> --- a/include/linux/bcma/bcma.h
>> +++ b/include/linux/bcma/bcma.h
>> @@ -138,6 +138,7 @@ struct bcma_device {
>>        u8 core_index;
>>
>>        u32 addr;
>> +       u32 addr1;
>>        u32 wrap;
>>
>>        void __iomem *io_addr;
>> --
>> 1.7.5.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
