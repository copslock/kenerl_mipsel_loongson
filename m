Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Aug 2014 04:02:53 +0200 (CEST)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:41407 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6855142AbaHOCCsVXJjD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Aug 2014 04:02:48 +0200
Received: by mail-pa0-f43.google.com with SMTP id lf10so2678051pab.16
        for <multiple recipients>; Thu, 14 Aug 2014 19:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=h5EvHdt+8yp+8ser3AXFJOkyXGDS4RVPgKEPlkYBUnk=;
        b=rS5ZugBS5SXG4UwS6DxAWQVYjb9a3SVguC42GXiEoMrg3tBDzRJY7eT5bbHukJB3gU
         mbCI7TTxXqU6JrNGH4wwMWgeuvTmKVClB70iuOOcJrZa2YdpqM1mIDyqGCQnl5uA1Wzb
         wuFkM9QoysYgJeF1m14HGUkEl/Vk/vRQc6BNyERNlgslwjFG1XYKU5GNYBEwa7JUXg4H
         BNXN/euelb6znGOYgSUnWzSN93Hx5zDT6CBzVfoNimsxjvRpx0X6FGtC1tUcld5BFKcP
         jDabDG4mhZdMSd9fXdjKHKgHwBrj8p72PjFuMCk+V2PzSNqFIg12HR6CjUMF2rB6HLD7
         AlyQ==
X-Received: by 10.68.68.225 with SMTP id z1mr8209881pbt.110.1408068160696;
        Thu, 14 Aug 2014 19:02:40 -0700 (PDT)
Received: from ShengShiZhuChengdeMacBook-Pro.local ([219.143.82.150])
        by mx.google.com with ESMTPSA id ov4sm6603416pbc.86.2014.08.14.19.02.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Aug 2014 19:02:40 -0700 (PDT)
Message-ID: <53ED6B40.8000409@gmail.com>
Date:   Fri, 15 Aug 2014 10:06:56 +0800
From:   Chen Gang <gang.chen.5i5j@gmail.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     Max Filippov <jcmvbkbc@gmail.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        "vgupta@synopsys.com" <vgupta@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jean Delvare <jdelvare@suse.de>,
        Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, hskinnemoen@gmail.com,
        egtvedt@samfundet.no, realmz6@gmail.com,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <a-jacquiot@ti.com>, starvik@axis.com,
        jesper.nilsson@axis.com, David Howells <dhowells@redhat.com>,
        rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com,
        takata@linux-m32r.org, James Hogan <james.hogan@imgtec.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        yasutake.koichi@jp.panasonic.com, Jonas Bonn <jonas@southpole.se>,
        jejb@parisc-linux.org, deller@gmx.de,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        heiko.carstens@de.ibm.com, Liqin Chen <liqin.linux@gmail.com>,
        Lennox Wu <lennox.wu@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@tilera.com>, jdike@addtoit.com,
        Richard Weinberger <richard@nod.at>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        linux390@de.ibm.com, x86@kernel.org, linux-alpha@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        Linux/MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-am33-list@redhat.com, linux@lists.openrisc.net,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH v3] arch: Kconfig: Let all architectures set endian explicitly
References: <53ECE9DD.80004@gmail.com>  <CAMo8BfLuXZ8zyEoKdo8yb6nd+pZUnx0YEL9nqHx98kt76ezfYg@mail.gmail.com> <CAMo8Bf+=EgXc0hq14y9Kdykaw_7E52kRAENU1P0fAK4tTx=JpA@mail.gmail.com>
In-Reply-To: <CAMo8Bf+=EgXc0hq14y9Kdykaw_7E52kRAENU1P0fAK4tTx=JpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <gang.chen.5i5j@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gang.chen.5i5j@gmail.com
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

On 8/15/14 9:52, Max Filippov wrote:
> On Fri, Aug 15, 2014 at 5:47 AM, Max Filippov <jcmvbkbc@gmail.com> wrote:
>> Hi Chen,
>>
>> On Thu, Aug 14, 2014 at 8:54 PM, Chen Gang <gang.chen.5i5j@gmail.com> wrote:
>>> Normal architectures:
>>>
>>>  - Big endian: avr32, frv, m68k, openrisc, parisc, s390, sparc
>>>
>>>  - Little endian: alpha, blackfin, cris, hexagon, ia64, metag, mn10300,
>>>                   score, unicore32, x86
>>>
>>>  - Choose in config time: arc, arm, arm64, c6x, m32r, mips, powerpc, sh
>>>
>>> Special architectures:
>>>
>>>  - Deside by compiler: microblaze, tile, xtensa.
>>>
>>>  - Deside by building host: um
>>>
>>>  - Next, need improve Kbuild to probe endian to deside whether need mark
>>>    __BUILDING_TIME_BIG_ENDIAN__ before real config.

Please check this comments, thanks.

>>
>> [...]
>>
>>> diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
>>> index 3a617af..a3e8f7e 100644
>>> --- a/arch/xtensa/Kconfig
>>> +++ b/arch/xtensa/Kconfig
>>> @@ -22,6 +22,8 @@ config XTENSA
>>>         select HAVE_IRQ_TIME_ACCOUNTING
>>>         select HAVE_PERF_EVENTS
>>>         select COMMON_CLK
>>> +       select CPU_BIG_ENDIAN if __BUILDING_TIME_BIG_ENDIAN__
>>> +       select CPU_LITTLE_ENDIAN if !CPU_BIG_ENDIAN
>>>         help
>>>           Xtensa processors are 32-bit RISC machines designed by Tensilica
>>>           primarily for embedded systems.  These processors are both
>>
>> I've tested this part and it doesn't select neither CPU_BIG_ENDIAN,
>> nor CPU_LITTLE_ENDIAN. And looking into the Kconfig/Kbuild I cound't
> 
> Correction: it always selects CPU_LITTLE_ENDIAN, regardless of the
> compiler endianness.
> 

Yeah, at present, it always select CPU_LITTLE_ENDIAN, next, Kbuild need
be improved for it, just the comments said.

If this patch can be pass checking, I shall improve the Kbuild for it,
also will modify some individual drivers to use CPU_*_ENDIAN.

I guess, we need Cc to kbuild for getting more ideas, suggestions, or
completions.



THanks.
-- 
Chen Gang

Open, share, and attitude like air, water, and life which God blessed
