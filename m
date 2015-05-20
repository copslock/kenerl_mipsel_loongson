Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2015 14:54:31 +0200 (CEST)
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:40877 "EHLO
        mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010189AbbETMy37D0l3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2015 14:54:29 +0200
X-IronPort-AV: E=Sophos;i="5.13,464,1427785200"; 
   d="scan'208";a="65330017"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw2-out.broadcom.com with ESMTP; 20 May 2015 06:04:45 -0700
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.3.235.1; Wed, 20 May 2015 05:54:23 -0700
Received: from mail-sj1-12.sj.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP Server id
 14.3.235.1; Wed, 20 May 2015 05:54:23 -0700
Received: from [10.176.128.60] (xl-bun-02.bun.broadcom.com [10.176.128.60])     by
 mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id E08A827A81;        Wed, 20 May
 2015 05:54:21 -0700 (PDT)
Message-ID: <555C83FC.7010701@broadcom.com>
Date:   Wed, 20 May 2015 14:54:20 +0200
From:   Arend van Spriel <arend@broadcom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111103 Lightning/1.0b2 Thunderbird/3.1.16
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Hante Meuleman <meuleman@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH RESEND] mips: bcm47xx: allow retrieval of complete nvram
 contents
References: <1432122655-3224-1-git-send-email-arend@broadcom.com> <CACna6rxeU0FUiTRNXFgK-xxSDY8WA82h7MLmcPc=7eM5sqMdBw@mail.gmail.com>
In-Reply-To: <CACna6rxeU0FUiTRNXFgK-xxSDY8WA82h7MLmcPc=7eM5sqMdBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <arend@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arend@broadcom.com
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

On 05/20/15 14:31, Rafał Miłecki wrote:
> On 20 May 2015 at 13:50, Arend van Spriel<arend@broadcom.com>  wrote:
>> From: Hante Meuleman<meuleman@broadcom.com>
>>
>> Host platforms such as routers supported by OpenWRT can
>> support NVRAM reading directly from internal NVRAM store.
>> The brcmfmac for one requires the complete nvram contents
>> to select what needs to be sent to wireless device.
>
> First of all, I have to ask you to rebase this patch on top of
> upstream-sfr. Mostly because of
> MIPS: BCM47XX: Make sure NVRAM buffer ends with \0

No idea what upstream-sfr is. I applied the patch on top of the master 
branch of linux-mips repo [1]. What am I missing here?

Regards,
Arend

[1] http://git.linux-mips.org/cgit/ralf/linux.git

>> @@ -146,20 +147,21 @@ static int nvram_init(void)
>>                  return -ENODEV;
>>
>>          err = mtd_read(mtd, 0, sizeof(header),&bytes_read, (uint8_t *)&header);
>> -       if (!err&&  header.magic == NVRAM_MAGIC) {
>> -               u8 *dst = (uint8_t *)nvram_buf;
>> -               size_t len = header.len;
>> -
>> -               if (header.len>  NVRAM_SPACE) {
>> +       if (!err&&  header.magic == NVRAM_MAGIC&&
>> +           header.len>  sizeof(header)) {
>> +               if (header.len>  NVRAM_SPACE - 2) {
>>                          pr_err("nvram on flash (%i bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
>>                                  header.len, NVRAM_SPACE);
>> -                       len = NVRAM_SPACE;
>> +                       header.len = NVRAM_SPACE - 2;
>>                  }
>
> I guess I preferred having "len" helper, but it's a minor thing.
> What's the trick with this NVRAM_SPACE - 2? Requiring string I to be
> ended with double \0 sounds like a wrong design in some driver. I
> don't think it's anything common/any standard to mark the buffer end
> with an extra \0. I'm pretty sure bcm47xx_nvram_getenv doesn't need it
> and bcm47xx_nvram_get_contents you implemented provides buffer length
> anyway.
> Moreover this trick isn't compatible with what nvram_find_and_copy does.
>
>
>> -               err = mtd_read(mtd, 0, len,&bytes_read, dst);
>> +               err = mtd_read(mtd, 0, header.len,&bytes_read,
>> +                              (u8 *)nvram_buf);
>>                  if (err)
>>                          return err;
>>
>> +               pheader = (struct nvram_header *)nvram_buf;
>> +               pheader->len = header.len;
>
> I preferred your OpenWrt patch version with just keeping a buffer
> content length in separated variable. It won't kill us to have one
> more static size_t and we'll at least keep a real header copy without
> hacking it for implementation needs.
> Again, what you did here doesn't match nvram_find_and_copy, so please
> make sure you'll e.g. set content length variable in
> nvram_find_and_copy as well.
>
