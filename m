Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Dec 2015 14:17:06 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:46097 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007470AbbLLNRDbhEY3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 12 Dec 2015 14:17:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=hwL196C8C3ddC1fsfWdCnTDKplw5Cb++y+M+CRhaG8w=;
        b=Ki4ceL7W0QG1ezX5boPYtaPXEa91JAep0P1hjX9uHLARrbT+MID+732NR2QEQF9xtCvTzLHYO/em6f94aDCt5Fi/w8JiuSKLGXkU1DqC1OOWX0LMpgnCAxqTsaV9KxkYylsgM3a1mOxZNgcq0GfoE6tn7Uop1MZyrCPU8Z7kkqRei7n8RElnoE223ju8iGMZHC8ln5UWenWqyb9kipCdFzRqlKma8zxZbOOialiioplo3Jbdyp9Ltop9HANHMnL9426YiK/mpAR7d7rfOmPeOEys0y8wwDE5WInlw4O9ORfDSAC+MrgxlaYcTjga+bz64/q3/lWcPTmk5SoxCtyhLg==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:36986 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a7k2i-0004Of-59 (Exim); Sat, 12 Dec 2015 13:16:57 +0000
Subject: Re: [PATCH linux-next (v3) 1/3] MIPS: bcm963xx: Add Broadcom BCM963xx
 board nvram data structure
To:     Jonas Gorski <jogo@openwrt.org>
References: <566B460F.1040603@simon.arlott.org.uk>
 <CAOiHx=m3cXTePDjH04Yoz3wQO9Ta9jSn=JrkfNgphoPcQVaGXg@mail.gmail.com>
 <566B4D34.9040707@simon.arlott.org.uk>
 <CAOiHx=nrZdvezkyLi0kfvZ6Rp3YtechtP=J2orpUsVkXvA_6HQ@mail.gmail.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-api@vger.kernel.org
From:   Simon Arlott <simon@fire.lp0.eu>
Message-ID: <566C1E44.3010506@simon.arlott.org.uk>
Date:   Sat, 12 Dec 2015 13:16:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <CAOiHx=nrZdvezkyLi0kfvZ6Rp3YtechtP=J2orpUsVkXvA_6HQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50564
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: simon@fire.lp0.eu
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

On 11/12/15 23:29, Jonas Gorski wrote:
> On Fri, Dec 11, 2015 at 11:24 PM, Simon Arlott <simon@fire.lp0.eu> wrote:
>> On 11/12/15 22:02, Jonas Gorski wrote:
>>> On Fri, Dec 11, 2015 at 10:54 PM, Simon Arlott <simon@fire.lp0.eu> wrote:
>>>> Broadcom BCM963xx boards have multiple nvram variants across different
>>>> SoCs with additional checksum fields added whenever the size of the
>>>> nvram was extended.
>>>>
>>>> Add this structure as a header file so that multiple drivers and userspace
>>>> can use it.
>>>>
>>>> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
>>>> ---
>>>> v3: Fix includes/type names, add comments explaining the nvram struct.
>>>>
>>>> v2: Use external struct bcm963xx_nvram definition for bcm963268part.
...
>>>> diff --git a/include/uapi/linux/bcm963xx_nvram.h b/include/uapi/linux/bcm963xx_nvram.h
>>>> new file mode 100644
>>>> index 0000000..2dcb307
>>>> --- /dev/null
>>>> +++ b/include/uapi/linux/bcm963xx_nvram.h
>>>
>>> Why uapi? The nvram layout isn't really enforced to be that way, and
>>> at least Huawei uses a modified one on some devices (in case you
>>> wondered why bcm63xx doesn't fail a crc32-"broken" one), so IMHO it
>>> should be kept for in-kernel use only.
>>
>> Because Florian suggested include/uapi/linux/bcm963xx_nvram.h; I could
>> move it to include/linux/ instead if this is preferred.
...
>>>> + * Do not use the __reserved fields, especially not as an offset for CRC
>>>> + * calculations (use BCM963XX_NVRAM_*_SIZE instead). These may be removed or
>>>> + * repositioned.
> 
> Because I just saw that: Nobody will read that. ;p

I'll move this to include/linux/bcm963xx_nvram.h and omit the linux-api
mailing list when I next send the patch series.

-- 
Simon Arlott
