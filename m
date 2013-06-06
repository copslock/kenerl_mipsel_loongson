Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jun 2013 18:13:33 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:56923 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835149Ab3FFQMzlNTvV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Jun 2013 18:12:55 +0200
Message-ID: <51B0B3CE.3090905@openwrt.org>
Date:   Thu, 06 Jun 2013 18:07:42 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>
CC:     ralf@linux-mips.org, Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: ralink: add missing SZ_1M multiplier
References: <1370526953-17122-1-git-send-email-blogic@openwrt.org> <CAGVrzcYkYQjGyo9CWPsOMTkf3QwCfisBk_G_k51bB=6Unj2mRQ@mail.gmail.com>
In-Reply-To: <CAGVrzcYkYQjGyo9CWPsOMTkf3QwCfisBk_G_k51bB=6Unj2mRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

On 06/06/13 16:27, Florian Fainelli wrote:
> 2013/6/6 John Crispin<blogic@openwrt.org>:
>> On RT5350 the memory size is set to Bytes and not MegaBytes due to a missing
>> multiplier.
> You might want to mention that the regression got introduced in
> dd63b008 ("MIPS: ralink: make use of the new memory detection code").
> This also needs to be in a future 3.10-rc pull request to Linus.
>
> Cheers

Hi Florian

correct !

i mailed it as ralf is preparing a 3.10-rc pull request and i wanted 
this to make it ....

i will ping ralf on irc and ask him to fold the "dd63b008 ("MIPS: 
ralink: make use of the new memory detection code")." bit into the comment

Thanks,
     John
