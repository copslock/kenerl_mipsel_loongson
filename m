Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jun 2013 07:15:04 +0200 (CEST)
Received: from mail.lemote.com ([222.92.8.138]:56885 "EHLO mail.lemote.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816469Ab3FYFPBgp6S0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 25 Jun 2013 07:15:01 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.lemote.com (Postfix) with ESMTP id 3064522737;
        Tue, 25 Jun 2013 13:14:52 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from mail.lemote.com ([127.0.0.1])
        by localhost (mail.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id w1KqJtzr8oa2; Tue, 25 Jun 2013 13:14:39 +0800 (CST)
Received: from mail.lemote.com (localhost [127.0.0.1])
        (Authenticated sender: chenhc@lemote.com)
        by mail.lemote.com (Postfix) with ESMTPA id 44FE520292;
        Tue, 25 Jun 2013 13:14:38 +0800 (CST)
Received: from 172.16.2.208
        (SquirrelMail authenticated user chenhc)
        by mail.lemote.com with HTTP;
        Tue, 25 Jun 2013 13:14:39 +0800
Message-ID: <6e5236ab6ef90f42fdc42d3bf4284f58.squirrel@mail.lemote.com>
In-Reply-To: <51C8CA95.80008@imgtec.com>
References: <1359527106-22879-1-git-send-email-chenhc@lemote.com>
    <1359527106-22879-4-git-send-email-chenhc@lemote.com>
    <5166ED66.7020307@realitydiluted.com>
    <CAAhV-H6s47NUHzbEX5UKYtkei7=s08PPXCMw39_fP_SV7Hv5Vg@mail.gmail.com>
    <CAAhV-H58Y_Rd8thj8MWXGCqqGtYJekDKrO-nXYjdp3214jnQ0A@mail.gmail.com>
    <51C8CA95.80008@imgtec.com>
Date:   Tue, 25 Jun 2013 13:14:39 +0800
Subject: Re: [PATCH V9 03/13] MIPS: Loongson: Introduce and use
 cpu_has_coherent_cache feature
From:   chenhc@lemote.com
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     "Steven J. Hill" <sjhill@realitydiluted.com>,
        "Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, "Fuxin Zhang" <zhangfx@lemote.com>,
        "Zhangjin Wu" <wuzhangjin@gmail.com>,
        "Hongliang Tao" <taohl@lemote.com>, "Hua Yan" <yanh@lemote.com>
User-Agent: SquirrelMail/1.4.22
MIME-Version: 1.0
Content-Type: text/plain;charset=gb2312
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

> On 06/22/2013 09:10 PM, Huacai Chen wrote:
>>
>> Is the 3rd patch of V10 is OK to be accepted now? If so, could the
>> patchset of V10 be merged into 3.11?
>>
> The merge window for 3.11 is closed at this point. You should get it
> prepared for 3.12, so start tracking the 'mips-for-linux-next' branch
> with your patches.
OK, if the 3rd patch has no problem, I think they can be easily applied
on mips-for-linux-next in future.

>
> Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
>
>
