Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 May 2013 18:47:02 +0200 (CEST)
Received: from mail-pd0-f177.google.com ([209.85.192.177]:50507 "EHLO
        mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825883Ab3EGQq5edbnI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 May 2013 18:46:57 +0200
Received: by mail-pd0-f177.google.com with SMTP id g10so538251pdj.8
        for <multiple recipients>; Tue, 07 May 2013 09:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=OpjYFQjrY8CKx0LYIKu+thsF29sCDCQ5++7N+ocFEOM=;
        b=pPF8DAaFa7bGrNwCD87tsVeNj2CGDONXbXELuRMoiXC67h7P7kX5ypOpHbjqj2USak
         3TF+k4gHUHNH4N50UdL8E8OT86UkDbZcWFHLf6ixC37MrU83btmDqJwGXBy1uEVLSJnW
         6eMZnQ2gUB7b8Kd8GiYOoEl/uEo/FIgbUMLj/dahqDklKWCQ/TqJpty+sOd5MMiG4Rnc
         lw6k/9qEk189Cv5H49X1D1df968Ek8jy8Z2ZQ8U3nBVi5IDPJ4MgMx+nCxoKEzz102O5
         J5cQHyBE6SJ1cufnMFMqkTSpM2atbYR1lQ33KzcwDz4xXQySZulzOQ7ctisR1gn+Ibjx
         7KZg==
X-Received: by 10.66.150.226 with SMTP id ul2mr3899017pab.17.1367945210641;
        Tue, 07 May 2013 09:46:50 -0700 (PDT)
Received: from [192.168.1.104] ([114.246.179.148])
        by mx.google.com with ESMTPSA id ov2sm28861713pbc.34.2013.05.07.09.46.47
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 07 May 2013 09:46:49 -0700 (PDT)
Message-ID: <51892FF5.9020607@gmail.com>
Date:   Wed, 08 May 2013 00:46:45 +0800
From:   Jiang Liu <liuj97@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
MIME-Version: 1.0
To:     eunb.song@samsung.com
CC:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jogo@openwrt.org" <jogo@openwrt.org>,
        "david.daney@cavium.com" <david.daney@cavium.com>
Subject: Re: MIPS : die at free_initmem() function 3.9+
References: <21534601.395241367793582818.JavaMail.weblogic@epv6ml08>
In-Reply-To: <21534601.395241367793582818.JavaMail.weblogic@epv6ml08>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <liuj97@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: liuj97@gmail.com
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

Hi Eunsong,
	Thanks for your help. I have done some code inspection and have 
found a possible reason for this issue. It seems that virt_to_page()
can't be used to handle address in compatible segments due to following
definitions.

#define virt_to_page(kaddr)     pfn_to_page(PFN_DOWN(virt_to_phys(kaddr)))
static inline unsigned long virt_to_phys(volatile const void *address)
{
        return (unsigned long)address - PAGE_OFFSET + PHYS_OFFSET;
}
#define __va(x)         ((void *)((unsigned long)(x) + PAGE_OFFSET - PHYS_OFFSET))
#define __pa_symbol(x)  __pa(RELOC_HIDE((unsigned long)(x), 0))
#define __pa(x)                                                         \
({                                                                      \
    unsigned long __x = (unsigned long)(x);                             \
    __x < CKSEG0 ? XPHYSADDR(__x) : CPHYSADDR(__x);                     \
})

#define CPHYSADDR(a)            ((_ACAST32_(a)) & 0x1fffffff)
#define XPHYSADDR(a)            ((_ACAST64_(a)) &                       \
                                 _CONST64_(0x000000ffffffffff))

#define XKUSEG                  _CONST64_(0x0000000000000000)
#define XKSSEG                  _CONST64_(0x4000000000000000)
#define XKPHYS                  _CONST64_(0x8000000000000000)
#define XKSEG                   _CONST64_(0xc000000000000000)
#define CKSEG0                  _CONST64_(0xffffffff80000000)
#define CKSEG1                  _CONST64_(0xffffffffa0000000)
#define CKSSEG                  _CONST64_(0xffffffffc0000000)
#define CKSEG3                  _CONST64_(0xffffffffe0000000)

So could you please help to prepare a formal patch for this bug and send
it to Andrew Morton for v3.10-rc1? Otherwise I could help to it too.

Regards!
Gerry


=On 05/06/2013 06:39 AM, EUNBONG SONG wrote:
> 
>> So on 64bits MIPS platforms, __va(__pa(x)) may not equal to x, that may cause
>> trouble to free_initmem_default(). Could you please help to do another test
>> by changing
>> free_initmem_default(POISON_FREE_INITMEM);
>> to
>> free_initmem_default(0);
> 
>> This test could help to identify whether this panic is caused by
>> memset((void *)pos, poison, PAGE_SIZE);
>> in function free_reserved_area().
> 
> Hello, as you said i changed  "free_initmem_default(POISON_FREE_INITMEM);" to
> "free_initmem_default(0);". Panic still occurred. 
> Actually, i put the some debug messages. and i confirmed panic occurs in __free_reserved_page() function.
> Thanks!
> 
> N떑꿩�r툤y鉉싕b쾊Ф푤v�^�)頻{.n�+돴쪐{콗喩zX㎍썳變}찠꼿쟺�&j:+v돣�쳭喩zZ+�+zf＂톒쉱�~넮녬i�鎬z�췿ⅱ�?솳鈺�&�)刪f뷌^j푹y쬶끷@A첺뛴��0띠h��i�
> 
