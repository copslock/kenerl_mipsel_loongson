Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 May 2015 20:45:12 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:46364 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007229AbbE2SpK1BLmB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 29 May 2015 20:45:10 +0200
Received: from [192.168.0.100] (ip-2-203-132-86.web.vodafone.de [2.203.132.86])
        by hauke-m.de (Postfix) with ESMTPSA id 5BF2E20200;
        Fri, 29 May 2015 20:45:12 +0200 (CEST)
Message-ID: <5568B391.6050402@hauke-m.de>
Date:   Fri, 29 May 2015 20:44:33 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
MIME-Version: 1.0
To:     Arend van Spriel <arend@broadcom.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH V2] mips: bcm47xx: allow retrieval of complete nvram contents
References: <1432214843-16057-1-git-send-email-arend@broadcom.com> <55687EDA.9070909@hauke-m.de> <55689A67.9070904@broadcom.com> <5568AF66.3070403@broadcom.com>
In-Reply-To: <5568AF66.3070403@broadcom.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47731
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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



On 05/29/2015 08:26 PM, Arend van Spriel wrote:
> On 05/29/15 18:57, Arend van Spriel wrote:
>> On 05/29/15 16:59, Hauke Mehrtens wrote:
>>>
>>>
>>> On 05/21/2015 03:27 PM, Arend van Spriel wrote:
>>>> From: Hante Meuleman<meuleman@broadcom.com>
>>>>
>>>> Host platforms such as routers supported by OpenWrt can
>>>> support NVRAM reading directly from internal NVRAM store.
>>>> The brcmfmac for one requires the complete nvram contents
>>>> to select what needs to be sent to wireless device.
>>>>
>>>> Reviewed-by: Arend Van Spriel<arend@broadcom.com>
>>>> Reviewed-by: Franky (Zhenhui) Lin<frankyl@broadcom.com>
>>>> Reviewed-by: Pieter-Paul Giesberts<pieterpg@broadcom.com>
>>>> Reviewed-by: Daniel (Deognyoun) Kim<dekim@broadcom.com>
>>>> Signed-off-by: Hante Meuleman<meuleman@broadcom.com>
>>>> Signed-off-by: Arend van Spriel<arend@broadcom.com>
>>>> ---
>>>> Change log:
>>>> -----------
>>>> V2: - correct header length for nvram_find_and_copy().
>>>> - get rid of 'NVRAM_SPACE - 2' magic.
>>>> ---
>>>> arch/mips/bcm47xx/nvram.c | 61
>>>> ++++++++++++++++++++++++++++++++-----------
>>>> include/linux/bcm47xx_nvram.h | 15 +++++++++++
>>>> 2 files changed, 61 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
>>>> index 95d028c..f4f62d3 100644
>>>> --- a/arch/mips/bcm47xx/nvram.c
>>>> +++ b/arch/mips/bcm47xx/nvram.c
>>>> @@ -94,17 +94,22 @@ static int nvram_find_and_copy(void __iomem
>>>> *iobase, u32 lim)
>>>> return -ENXIO;
>>>>
>>>> found:
>>>> - if (header->len> size)
>>>> - pr_err("The nvram size accoridng to the header seems to be bigger
>>>> than the partition on flash\n");
>>>> - if (header->len> NVRAM_SPACE)
>>>> - pr_err("nvram on flash (%i bytes) is bigger than the reserved space
>>>> in memory, will just copy the first %i bytes\n",
>>>> - header->len, NVRAM_SPACE - 1);
>>>> -
>>>> src = (u32 *)header;
>>>> dst = (u32 *)nvram_buf;
>>>> for (i = 0; i< sizeof(struct nvram_header); i += 4)
>>>> *dst++ = __raw_readl(src++);
>>>> - for (; i< header->len&& i< NVRAM_SPACE&& i< size; i += 4)
>>>> + header = (struct nvram_header *)nvram_buf;
>>>> + if (header->len> size) {
>>>> + pr_err("The nvram size according to the header seems to be bigger
>>>> than the partition on flash\n");
>>>
>>> Thanks for fixing a typo. ;-)
>>>
>>>> + header->len = size;
>>>
>>> I haven't seen this error case, I just added it to be save.
>>
>> It does seem an unlikely error case. At least it would probably been
>> noticed during production writing the content to flash.
>>
>>>> + }
>>>> + if (header->len>= NVRAM_SPACE) {
>>>> + pr_err("nvram on flash (%i bytes) is bigger than the reserved space
>>>> in memory, will just copy the first %i bytes\n",
>>>> + header->len, NVRAM_SPACE - 1);
>>>> + header->len = NVRAM_SPACE - 1;
>>>> + }
>>>
>>> After fixing the length the header is better, but it also contains a
>>> CRC, which is still wrong, but we ignore it and I do not think we have
>>> to check.
>>>
>>> I still think that the best approach would be to remove the nvram header
>>> and add a extra variable storing the actual size of the nvram buf. I
>>> also think this would make some of this code easier.
>>
>> Let's do that then.
> 
> Hi Hauke,
> 
> Forgot to ask. What is the reason for using the fixed nvram space. Could
> we allocate it using vzalloc()?

On mips this is needed very early in the boot process at least for the
older SoCs using ssb. In this state we can not allocate memory.

Hauke

> 
> Regards,
> Arend
> 
>>>> + /* proceed reading data after header */
>>>> + for (; i< header->len; i += 4)
>>>> *dst++ = readl(src++);
>>>> nvram_buf[NVRAM_SPACE - 1] = '\0';
>>>>
>>>> @@ -139,6 +144,7 @@ static int nvram_init(void)
>>>> #ifdef CONFIG_MTD
>>>> struct mtd_info *mtd;
>>>> struct nvram_header header;
>>>> + struct nvram_header *pheader;
>>>> size_t bytes_read;
>>>> int err;
>>>>
>>>> @@ -147,20 +153,21 @@ static int nvram_init(void)
>>>> return -ENODEV;
>>>>
>>>> err = mtd_read(mtd, 0, sizeof(header),&bytes_read, (uint8_t *)&header);
>>>> - if (!err&& header.magic == NVRAM_MAGIC) {
>>>> - u8 *dst = (uint8_t *)nvram_buf;
>>>> - size_t len = header.len;
>>>> -
>>>> - if (len>= NVRAM_SPACE) {
>>>> - len = NVRAM_SPACE - 1;
>>>> + if (!err&& header.magic == NVRAM_MAGIC&&
>>>> + header.len> sizeof(header)) {
>>>> + if (header.len>= NVRAM_SPACE) {
>>>> pr_err("nvram on flash (%i bytes) is bigger than the reserved space
>>>> in memory, will just copy the first %i bytes\n",
>>>> - header.len, len);
>>>> + header.len, NVRAM_SPACE);
>>>> + header.len = NVRAM_SPACE - 1;
>>>> }
>>>>
>>>> - err = mtd_read(mtd, 0, len,&bytes_read, dst);
>>>> + err = mtd_read(mtd, 0, header.len,&bytes_read,
>>>> + (u8 *)nvram_buf);
>>>> if (err)
>>>> return err;
>>>>
>>>> + pheader = (struct nvram_header *)nvram_buf;
>>>> + pheader->len = header.len;
>>>> return 0;
>>>> }
>>>> #endif
>>>> @@ -219,3 +226,27 @@ int bcm47xx_nvram_gpio_pin(const char *name)
>>>> return -ENOENT;
>>>> }
>>>> EXPORT_SYMBOL(bcm47xx_nvram_gpio_pin);
>>>> +
>>>> +char *bcm47xx_nvram_get_contents(size_t *nvram_size)
>>>> +{
>>>> + int err;
>>>> + char *nvram;
>>>> + struct nvram_header *header;
>>>> +
>>>> + if (!nvram_buf[0]) {
>>>> + err = nvram_init();
>>>> + if (err)
>>>> + return NULL;
>>>> + }
>>>> +
>>>> + header = (struct nvram_header *)nvram_buf;
>>>> + *nvram_size = header->len - sizeof(struct nvram_header);
>>>> + nvram = vmalloc(*nvram_size);
>>>> + if (!nvram)
>>>> + return NULL;
>>>> + memcpy(nvram,&nvram_buf[sizeof(struct nvram_header)], *nvram_size);
>>>
>>> I have no real opinion if we need to copy it or provide a pointer to the
>>> nvram buf. I trust brcmfmac that it does not screw around with this
>>> data. ;-)
>>
>> I would not dare. Most variables are pitch black magic to me.
>>
>> Regards,
>> Arend
>>
>>>> +
>>>> + return nvram;
>>>> +}
>>>> +EXPORT_SYMBOL(bcm47xx_nvram_get_contents);
>>>> +
>>>> diff --git a/include/linux/bcm47xx_nvram.h
>>>> b/include/linux/bcm47xx_nvram.h
>>>> index b12b07e..c73927c 100644
>>>> --- a/include/linux/bcm47xx_nvram.h
>>>> +++ b/include/linux/bcm47xx_nvram.h
>>>> @@ -10,11 +10,17 @@
>>>>
>>>> #include<linux/types.h>
>>>> #include<linux/kernel.h>
>>>> +#include<linux/vmalloc.h>
>>>>
>>>> #ifdef CONFIG_BCM47XX
>>>> int bcm47xx_nvram_init_from_mem(u32 base, u32 lim);
>>>> int bcm47xx_nvram_getenv(const char *name, char *val, size_t val_len);
>>>> int bcm47xx_nvram_gpio_pin(const char *name);
>>>> +char *bcm47xx_nvram_get_contents(size_t *val_len);
>>>> +static inline void bcm47xx_nvram_release_contents(char *nvram)
>>>> +{
>>>> + vfree(nvram);
>>>> +};
>>>> #else
>>>> static inline int bcm47xx_nvram_init_from_mem(u32 base, u32 lim)
>>>> {
>>>> @@ -29,6 +35,15 @@ static inline int bcm47xx_nvram_gpio_pin(const
>>>> char *name)
>>>> {
>>>> return -ENOTSUPP;
>>>> };
>>>> +
>>>> +static inline char *bcm47xx_nvram_get_contents(size_t *val_len)
>>>> +{
>>>> + return NULL;
>>>> +};
>>>> +
>>>> +static inline void bcm47xx_nvram_release_contents(char *nvram)
>>>> +{
>>>> +};
>>>> #endif
>>>>
>>>> #endif /* __BCM47XX_NVRAM_H */
>>>>
>>
>>
> 
