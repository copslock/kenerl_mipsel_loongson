Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jan 2013 20:07:20 +0100 (CET)
Received: from dns1.mips.com ([12.201.5.69]:45961 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6832261Ab3AQTHTT-jhs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jan 2013 20:07:19 +0100
Received: from mailgate1.mips.com (mailgate1.mips.com [12.201.5.111])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id r0HJ7Bjv021208;
        Thu, 17 Jan 2013 11:07:11 -0800
X-WSS-ID: 0MGSAFZ-01-1JH-02
X-M-MSG: 
Received: from exchdb01.mips.com (unknown [192.168.36.67])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mailgate1.mips.com (Postfix) with ESMTP id 2298136467D;
        Thu, 17 Jan 2013 11:07:10 -0800 (PST)
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchdb01.mips.com ([::1]) with mapi id 14.02.0247.003; Thu, 17 Jan 2013
 11:07:06 -0800
From:   "Hill, Steven" <sjhill@mips.com>
To:     David Daney <ddaney.cavm@gmail.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Subject: RE: [PATCH] MIPS: microMIPS: Redefine value of BRK_BUG.
Thread-Topic: [PATCH] MIPS: microMIPS: Redefine value of BRK_BUG.
Thread-Index: AQHN9NlEm+9CcxJkN0q8N792sqGhLphOWcSA//+HK/U=
Date:   Thu, 17 Jan 2013 19:07:05 +0000
Message-ID: <31E06A9FC96CEC488B43B19E2957C1B801146C7186@exchdb03.mips.com>
References: <1358444216-17213-1-git-send-email-sjhill@mips.com>,<50F83FD5.2060908@gmail.com>
In-Reply-To: <50F83FD5.2060908@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.36.79]
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: G5e6A7fuWJSQTPCxKzn4vA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 35488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

>> diff --git a/arch/mips/include/asm/break.h b/arch/mips/include/asm/break.h
>> index 9161e68..df9d090 100644
>> --- a/arch/mips/include/asm/break.h
>> +++ b/arch/mips/include/asm/break.h
>> @@ -27,6 +27,7 @@
>>   #define BRK_STACKOVERFLOW 9 /* For Ada stackchecking */
>>   #define BRK_NORLD   10      /* No rld found - not used by Linux/MIPS */
>>   #define _BRK_THREADBP       11      /* For threads, user bp (used by debuggers) */
>> +#define BRK_BUG_MM   12      /* Used by BUG() in microMIPS mode */
>>   #define BRK_BUG             512     /* Used by BUG() */
>
> Can we move the CONFIG_CPU_MICROMIPS to here and just call the thing
> BRK_BUG?
>
No, because this header file is exported in 'arch/mips/include/uapi/asm' now. I already discussed this with Ralf.

>>   #include <asm/break.h>
>> +#ifdef CONFIG_CPU_MICROMIPS
>> +#undef BRK_BUG
>> +#define BRK_BUG              BRK_BUG_MM
>> +#endif
>>
>
> ...We don't need this bit.   Doing an #undef risks using different
> values for BRK_BUG depending on whether or not asm/bug.h is included.
>
I was trying to avoid two #ifdef's in 'bug.h' but I can certainly get rid of the above and use two #ifdef's instead.

-Steve
