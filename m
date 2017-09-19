Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Sep 2017 11:20:09 +0200 (CEST)
Received: from imap1.codethink.co.uk ([176.9.8.82]:37165 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992213AbdISJUCV-oYU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Sep 2017 11:20:02 +0200
Received: from [185.98.148.236] (helo=[0.0.0.0])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1duEh7-0005KT-Ug; Tue, 19 Sep 2017 10:19:54 +0100
Subject: Re: [PATCH 1/7] i2c: gpio: Convert to use descriptors
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Steven Miao <realmz6@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Schocher <hs@denx.de>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
 <20170917093906.16325-2-linus.walleij@linaro.org>
 <20170918083629.qn4dlrmk7ffipfsz@dell>
 <CACRpkdb8jDRZxuTUNoosLORqDbF4PP4RSHj3avtUqzvW2RwpmQ@mail.gmail.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <42702eb3-d1dd-5dd0-dbd6-ac163bcc27c2@codethink.co.uk>
Date:   Tue, 19 Sep 2017 10:19:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdb8jDRZxuTUNoosLORqDbF4PP4RSHj3avtUqzvW2RwpmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <ben.dooks@codethink.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60071
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben.dooks@codethink.co.uk
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

On 18/09/17 20:00, Linus Walleij wrote:
> On Mon, Sep 18, 2017 at 10:36 AM, Lee Jones <lee.jones@linaro.org> wrote:
>> On Sun, 17 Sep 2017, Linus Walleij wrote:
> 
>>> Lee: requesting ACK for Wolfram to take this patch.
>>
>> This ...
>>
>>> SM501 users: requesting Tested-by on this patch.
>>
>> ... loosely depends on this (until it doesn't).
> 
> Yeah I did my best to scout around the commit logs
> to figure out who's been contributing to the SM501 and
> using it, I hope someone will step up and test it.

I don't know if anything I have available working has an
SM501 on it. We did a couple of boards with S3C2440 and
an SM501 connected via external IO. However these have
not been supported in years (since Simtec)

I don't even think I have the PCI SM501 kit, that may have
ended up either at Simtec or one of the other engineers.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
