Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Sep 2017 07:07:26 +0200 (CEST)
Received: from mail-out.m-online.net ([212.18.0.9]:51414 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990451AbdIRFHThuWzi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Sep 2017 07:07:19 +0200
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3xwYsL2btDz1rBPc;
        Mon, 18 Sep 2017 07:07:18 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 3xwYsL1M8Xz1qqkG;
        Mon, 18 Sep 2017 07:07:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 4Cmn-nx0z_iU; Mon, 18 Sep 2017 07:07:16 +0200 (CEST)
X-Auth-Info: /7XayquXU53qRLiJh413HRmuEkwRIwxJNABaMTCToW4=
Received: from localhost.localdomain (87-97-122-35.pool.invitel.hu [87.97.122.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 18 Sep 2017 07:07:16 +0200 (CEST)
Subject: Re: [PATCH 1/5] i2c: gpio: Convert to use descriptors
To:     Linus Walleij <linus.walleij@linaro.org>
References: <20170910214424.14945-1-linus.walleij@linaro.org>
 <20170910214424.14945-2-linus.walleij@linaro.org>
 <20170914093509.uwk47vt3wnm3rtqb@dell>
 <CACRpkdZYDALXSoEE9jdo7A5P4XZczVbh_uiLkE54=sRtA3rNDQ@mail.gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Ben Dooks <ben@fluff.org.uk>,
        Ville Syrjala <syrjala@sci.fi>,
        Magnus Damm <magnus.damm@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa@the-dreams.de>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        "arm@kernel.org" <arm@kernel.org>, Steven Miao <realmz6@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Reply-To: hs@denx.de
From:   Heiko Schocher <hs@denx.de>
Message-ID: <59BF5483.9020403@denx.de>
Date:   Mon, 18 Sep 2017 07:07:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdZYDALXSoEE9jdo7A5P4XZczVbh_uiLkE54=sRtA3rNDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <hs@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hs@denx.de
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

Hello Linux,

Am 17.09.2017 um 00:25 schrieb Linus Walleij:
> On Thu, Sep 14, 2017 at 11:35 AM, Lee Jones <lee.jones@linaro.org> wrote:
>
>>>   drivers/mfd/sm501.c                          |  49 +++++-----
>>
>> I'd prefer for this to be applied with a Tested-by.  I appreciate that
>> this is an old driver, but can you attempt to contact one of the
>> authors or someone else who might have hardware please?
>
> For SM501 specifically I guess.
>
> OK makes sense as it is the most invasive one, paging around...
>
> Ben, Ville, Magnus, Heiko, Guenther: is one of you still using this
> hardware so you can test the patch set?

I am Sorry, I do not have the hardware anymore so no chance to test
it :-(

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
