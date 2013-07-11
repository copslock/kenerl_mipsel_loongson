Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Jul 2013 14:35:59 +0200 (CEST)
Received: from mail.lemote.com ([222.92.8.138]:57606 "EHLO mail.lemote.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6815760Ab3GKMfuC3EsA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 11 Jul 2013 14:35:50 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.lemote.com (Postfix) with ESMTP id 5F5FA230B6;
        Thu, 11 Jul 2013 20:35:38 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from mail.lemote.com ([127.0.0.1])
        by localhost (mail.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ndwh-JjR2Pei; Thu, 11 Jul 2013 20:35:26 +0800 (CST)
Received: from [192.168.0.228] (unknown [218.57.204.90])
        (Authenticated sender: zhangfx@lemote.com)
        by mail.lemote.com (Postfix) with ESMTPSA id 9884A22F44;
        Thu, 11 Jul 2013 20:35:24 +0800 (CST)
Message-ID: <51DEA687.6040208@lemote.com>
Date:   Thu, 11 Jul 2013 20:35:19 +0800
From:   Fuxin Zhang <zhangfx@lemote.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V10 12/13] MIPS: Loongson 3: Add CPU hotplug support
References: <1366030028-5084-1-git-send-email-chenhc@lemote.com> <1366030028-5084-13-git-send-email-chenhc@lemote.com> <20130628070553.GI10727@linux-mips.org> <20130628070829.GJ10727@linux-mips.org> <CAAhV-H4m5c++fFTtr9kd294MXtRH-DwTMmXP2Ds7w+6S==jorw@mail.gmail.com>
In-Reply-To: <CAAhV-H4m5c++fFTtr9kd294MXtRH-DwTMmXP2Ds7w+6S==jorw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <zhangfx@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhangfx@lemote.com
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

于 2013/7/11 17:31, Huacai Chen 写道:
> Normal labels and nops can be removed, but loongson3_play_dead()
> should be run at CKSEG0, I'm afraid that it will have a wrong behavior
> if I write it with C.
I think just replacing flush_loop with number label like 1: will be ok. 
Don't think too much.
>
> On Fri, Jun 28, 2013 at 3:08 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
>> On Fri, Jun 28, 2013 at 09:05:53AM +0200, Ralf Baechle wrote:
>>
>>>> +           "flush_loop:                             \n" /* flush L1 */
>>> Please don't use normale in inline assembler.  This might result in build
>>> errors.  it's horrible to read but number local labels like:
>> That was meant to read "Please don't use normal labels" in inline assembler.
>>
>>    Ralf
>>


-- 
江苏中科梦兰电子科技有限公司
总经理 张福新
zhangfx@lemote.com
