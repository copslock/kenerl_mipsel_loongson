Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Sep 2013 19:45:20 +0200 (CEST)
Received: from mail-oa0-f49.google.com ([209.85.219.49]:42414 "EHLO
        mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823043Ab3I3RpRnlWWr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Sep 2013 19:45:17 +0200
Received: by mail-oa0-f49.google.com with SMTP id i4so3961816oah.22
        for <multiple recipients>; Mon, 30 Sep 2013 10:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=opDAo70DctiAr9pipF0iPh+xixJ0rEuDe97YsWSWvVk=;
        b=YT1ND1uHG0wWDZokaiJHFWpa6bunJyvYpCQ5U2lPBjkmj3rpj6furftRUvYtiZaSpp
         lVBEzz0e58PcoSGHYomcakp4zo1mLysKcr1Rq+EdEqzCcFQChTYqKb6UXQACiRabr1nr
         jLMrJLAoS6axroV0jYwEKF5yskOzTX0BRGK7H7XtVSZwyOChZukjcWOG3DBCnM7tH9sm
         nXQj6/DxhokuBTk6APJp31dlq99s/JKOvwf4ZUT8OO+lwS7yQEtloKaJLZ3ZKRbRDPEE
         actNFUfb2OolwStYi9MdcW51O7OViV21r/44hBOSGQVOSzmIL3awqnQ0Uyqz//0C4XsS
         5Vgg==
X-Received: by 10.182.144.136 with SMTP id sm8mr1181336obb.63.1380563111011;
        Mon, 30 Sep 2013 10:45:11 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id s9sm2120777obu.4.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 30 Sep 2013 10:45:10 -0700 (PDT)
Message-ID: <5249B8A4.9070905@gmail.com>
Date:   Mon, 30 Sep 2013 10:45:08 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     "Pinski, Andrew" <Andrew.Pinski@caviumnetworks.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>
Subject: Re: Issue with BUG() in asm-gemeric/bug.h if CONFIG_BUG=n
References: <20130930145630.GA14672@linux-mips.org>,<52499E8B.6000702@gmail.com> <C9BC92C2-A7F5-4F9A-B001-D1A7F4ADEA5A@caviumnetworks.com>
In-Reply-To: <C9BC92C2-A7F5-4F9A-B001-D1A7F4ADEA5A@caviumnetworks.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38071
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

On 09/30/2013 10:15 AM, Pinski, Andrew wrote:
>> On Sep 30, 2013, at 9:20 AM, "David Daney" <ddaney.cavm@gmail.com> wrote:
>
>>
>>> On 09/30/2013 07:56 AM, Ralf Baechle wrote:
>>> Lately I received several patches for build issues that only strike if
>>> CONFIG_BUG is disabled.  Here's a test case extracted from one of them:
>>>
>>> /*
>>>   * Definition of BUG taken from asm-generic/bug.h for the CONFIG_BUG=n case
>>>   */
>>> #define BUG()    do {} while(0)
>>>
>>> int foo(int arg)
>>> {
>>>     int res;
>>>
>>>     if (arg == 1)
>>>         res = 23;
>>>     else if (arg == 2)
>>>         res = 42;
>>>     else
>>>         BUG();
>>>
>>>     return res;
>>> }
>>>
>>> [ralf@h7 ~]$ gcc -O2 -Wall -c bug.c
>>> bug.c: In function ‘foo’:
>>> bug.c:17:2: warning: ‘res’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>>>    return res;
>>>    ^
>>>
>>> It's fairly obvious to see what's happening here - GCC doesn't know that
>>> the else case can not be reached, thus razorsharply concludes that res
>>> may be used uninitialized.
>>>
>>> There several locations where MIPS - possibly other architectures as well -
>>> is affected by this.
>>>
>>> I think the definition of BUG should be changed to something like
>>>
>>> #define BUG()    unreachable()
>>> 16304
>>> unreachable() will depending on the compiler being used, expand either
>>> into a call to __builtin_unreachable() or where that function is
>>> unavailable, into do {} while (1).
>>
>> The *only* reason we have CONFIG_BUG=n is to reduce code size.
>>
>> Sticking in that empty loop, negates the entire point.
>>
>> IMHO: We should do one of:
>> o Make CONFIG_BUG=y mandatory
>> o Ignore the warnings.
>> o Fix the warning sites so they quit Warning.
>>
>> So I don't think the patch is really an improvement over the status quo.
>
> What about using __builtin_unreachable when we can but turn off warnings and use do{}while(0) when __builtin_unreachable does not exist?  This seems the both worlds.  Newer compilers produce better code with unreachable anyways.
>

Simply not true.

do{}while(0) is a NOP it is no more useful than an ';' statement.  It 
doesn't serve as a magic uninitialized variable hiding mechanism.

David Daney


> Thanks,
> Andrew
>
>
>>
>> David Daney
>>>
>>> __builtin_unreachable() was introduce for GCC 4.5.0.
>>>
>>> This means there'd be minor bloat for antique compilers - but probably
>>> even better code generation for compilers supporting __builtin_unreachable().
>>>
>>>    Ralf
>>>
>>> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>>>
>>>   include/asm-generic/bug.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
>>> index 7d10f96..6f78771 100644
>>> --- a/include/asm-generic/bug.h
>>> +++ b/include/asm-generic/bug.h
>>> @@ -108,7 +108,7 @@ extern void warn_slowpath_null(const char *file, const int line);
>>>
>>>   #else /* !CONFIG_BUG */
>>>   #ifndef HAVE_ARCH_BUG
>>> -#define BUG() do {} while(0)
>>> +#define BUG() unreachable()
>>>   #endif
>>>
>>>   #ifndef HAVE_ARCH_BUG_ON
>>>
>>> ----- End forwarded message -----
>>>
>>>    Ralf
>>
>>
>
>
