Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 May 2013 19:27:26 +0200 (CEST)
Received: from mail-da0-f54.google.com ([209.85.210.54]:36207 "EHLO
        mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825888Ab3EGR1Y44aC0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 May 2013 19:27:24 +0200
Received: by mail-da0-f54.google.com with SMTP id u36so453376dak.41
        for <multiple recipients>; Tue, 07 May 2013 10:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=4p3miqFaSk/H5mAO9rcgRflpRRqTHyG049wvhYBIr+E=;
        b=iZNiDOQgLIzVK6+7lBKxKXpE4y6akKVlSOrRlw1827Ge3sThZeZM8z4yn7uYytW8Vg
         9128WYSWOlV1Qi66XxGvEjnrnteitPR9kZRMIJtZqMMMH2t/jROssJcORkT415NIrcly
         DstLX4br00gASO861NG/VLxTnnt69iCUmY5iw3dldubQ5XGY8RPsytuC256kCkR6ssGE
         JGo2kgJOHif6fdgNXGIh0u4Ipk6srbfa5ITWUtIQOqhndf2vuzDNWDVQEhjIQFOpxC7U
         Z6ZHNUuSoewB3LzTG04VV4OySYOYD4wLfjSov0fUsL4+tVnilOuzmXGZghutlpue9eu2
         rrpw==
X-Received: by 10.66.90.41 with SMTP id bt9mr3892536pab.197.1367947638351;
        Tue, 07 May 2013 10:27:18 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id cq1sm29007626pbc.13.2013.05.07.10.27.16
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 07 May 2013 10:27:17 -0700 (PDT)
Message-ID: <51893974.6000209@gmail.com>
Date:   Tue, 07 May 2013 10:27:16 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Jiang Liu <liuj97@gmail.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
CC:     eunb.song@samsung.com,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jogo@openwrt.org" <jogo@openwrt.org>,
        "david.daney@cavium.com" <david.daney@cavium.com>
Subject: Re: MIPS : die at free_initmem() function 3.9+
References: <21534601.395241367793582818.JavaMail.weblogic@epv6ml08> <51892FF5.9020607@gmail.com>
In-Reply-To: <51892FF5.9020607@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36348
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 05/07/2013 09:46 AM, Jiang Liu wrote:
> Hi Eunsong,
> 	Thanks for your help. I have done some code inspection and have
> found a possible reason for this issue. It seems that virt_to_page()
> can't be used to handle address in compatible segments due to following
> definitions.

This has caused multiple problems in the past.  I wrote a patch to 
correct this problem, but it looks like it was never applied.

I just sent the patch to you guys as a separate e-mail.

David Daney



>
> #define virt_to_page(kaddr)     pfn_to_page(PFN_DOWN(virt_to_phys(kaddr)))
> static inline unsigned long virt_to_phys(volatile const void *address)
> {
>          return (unsigned long)address - PAGE_OFFSET + PHYS_OFFSET;
> }
> #define __va(x)         ((void *)((unsigned long)(x) + PAGE_OFFSET - PHYS_OFFSET))
> #define __pa_symbol(x)  __pa(RELOC_HIDE((unsigned long)(x), 0))
> #define __pa(x)                                                         \
> ({                                                                      \
>      unsigned long __x = (unsigned long)(x);                             \
>      __x < CKSEG0 ? XPHYSADDR(__x) : CPHYSADDR(__x);                     \
> })
>
> #define CPHYSADDR(a)            ((_ACAST32_(a)) & 0x1fffffff)
> #define XPHYSADDR(a)            ((_ACAST64_(a)) &                       \
>                                   _CONST64_(0x000000ffffffffff))
>
> #define XKUSEG                  _CONST64_(0x0000000000000000)
> #define XKSSEG                  _CONST64_(0x4000000000000000)
> #define XKPHYS                  _CONST64_(0x8000000000000000)
> #define XKSEG                   _CONST64_(0xc000000000000000)
> #define CKSEG0                  _CONST64_(0xffffffff80000000)
> #define CKSEG1                  _CONST64_(0xffffffffa0000000)
> #define CKSSEG                  _CONST64_(0xffffffffc0000000)
> #define CKSEG3                  _CONST64_(0xffffffffe0000000)
>
> So could you please help to prepare a formal patch for this bug and send
> it to Andrew Morton for v3.10-rc1? Otherwise I could help to it too.
>
> Regards!
> Gerry
>
>
> =On 05/06/2013 06:39 AM, EUNBONG SONG wrote:
>>
>>> So on 64bits MIPS platforms, __va(__pa(x)) may not equal to x, that may cause
>>> trouble to free_initmem_default(). Could you please help to do another test
>>> by changing
>>> free_initmem_default(POISON_FREE_INITMEM);
>>> to
>>> free_initmem_default(0);
>>
>>> This test could help to identify whether this panic is caused by
>>> memset((void *)pos, poison, PAGE_SIZE);
>>> in function free_reserved_area().
>>
>> Hello, as you said i changed  "free_initmem_default(POISON_FREE_INITMEM);" to
>> "free_initmem_default(0);". Panic still occurred.
>> Actually, i put the some debug messages. and i confirmed panic occurs in __free_reserved_page() function.
>> Thanks!
>>
>> N떑꿩�r툤y鉉싕b쾊Ф푤v�^�)頻{.n�+돴쪐{콗喩zX㎍썳變}찠꼿쟺�&j:+v돣�쳭喩zZ+�+zf＂톒쉱�~넮녬i�鎬z�췿ⅱ�?솳鈺�&�)刪f뷌^j푹y쬶끷@A첺뛴��0띠h��i�
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
