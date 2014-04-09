Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Apr 2014 10:25:18 +0200 (CEST)
Received: from [159.226.40.154] ([159.226.40.154]:18753 "EHLO loongson.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6819445AbaDIIZMW0kb4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Apr 2014 10:25:12 +0200
Received: by ajax-webmail-mail.loongson.cn (Coremail) ; Wed, 9 Apr 2014
 16:23:48 +0800 (GMT+08:00)
Date:   Wed, 9 Apr 2014 16:23:48 +0800 (GMT+08:00)
From:   chengxiuzhi@loongson.cn
To:     =?UTF-8?B?IumZiOWNjuaJjSI=?= <chenhc@lemote.com>
Cc:     "Matt Turner" <mattst88@gmail.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "John Crispin" <john@phrozen.org>,
        "Steven J. Hill" <steven.hill@imgtec.com>,
        "Aurelien Jarno" <aurelien@aurel32.net>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Fuxin Zhang" <zhangfx@lemote.com>,
        "Zhangjin Wu" <wuzhangjin@gmail.com>
Message-ID: <40a09947.333.1454595fc03.Coremail.chengxiuzhi@loongson.cn>
In-Reply-To: <2cc0b93d3a84977f4a2929aa0c2bfb4b.squirrel@mail.lemote.com>
References: <1396599104-24370-1-git-send-email-chenhc@lemote.com>
 <1396599104-24370-9-git-send-email-chenhc@lemote.com>
 <CAEdQ38F-WHEUFqACwGGNGsWQFqTjwwk2ZwNis8zbNWff2xT8Vw@mail.gmail.com>
 <2cc0b93d3a84977f4a2929aa0c2bfb4b.squirrel@mail.lemote.com>
Subject: Re: Re: [PATCH 8/9] MIPS: Loongson-3: Enable the COP2 usage
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [114.242.206.180]
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT2.1.7a build
 20121108(18385.4661.4609) Copyright (c) 2002-2014 www.mailtech.cn loongson
X-SendMailWithSms: false
X-CM-TRANSID: AQAAf_DxH5SUA0VTiSMAAA--.127W
X-CM-SenderInfo: xfkh0wh0lx6x3l6o00pqjv00gofq/1tbiAQAJBFEBqWEOQgAAsY
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Return-Path: <chengxiuzhi@loongson.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chengxiuzhi@loongson.cn
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

Hi Matt,
  
The different instructions between 2F and 3A is:
 madd instruction: 2F has two operands , 3A has three ones
The English version of Loongson3A usermanualis not available now, I will translating part of it and email you ASAP. 
Regards,
xiuzhi
> 
> To Matt,
> 
> At first thank you very much for your pixman work. In my opinion, Loongson-3
> has the same MMI/SIMD instructions as Loongson-2. The only difference is
> that Loongson-2's MMI/SIMD trigger COP1 exception, and Loongson-3's MMI/SIMD
> trigger COP2 exception, so we need this patch to make pixman work fine.
> 
> To Xiuzhi,
> 
> Do you have an English version of Loongson-3's user mannual? I think that
> will be very useful for Matt.
> 
> Huacai
> 
> > On Fri, Apr 4, 2014 at 1:11 AM, Huacai Chen <chenhc@lemote.com> wrote:
> >> Loongson-3 has some specific instructions (MMI/SIMD) in coprocessor 2.
> >> COP2 isn't independent because it share COP1 (FPU)'s registers. This
> >> patch enable the COP2 usage so user-space programs can use the MMI/SIMD
> >> instructions. When COP2 exception happens, we enable both COP1 (FPU)
> >> and COP2, only in this way the fp context can be saved and restored
> >> correctly.
> >
> > Is there a Loongson 3 programmers manual somewhere, similar to
> > Loongson2FUserGuide.pdf?
> >
> > I optimized pixman for Loongson 2E/2F using their SIMD instructions.
> > I've compiled pixman for Loongson 3A and I see some new instructions
> > being used in the disassembly, but I have no Loongson 3 system to test
> > on. At minimum, having a manual would be nice.
> >
> > Thanks,
> > Matt
> >
> 
> 
