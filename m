Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jan 2013 01:42:51 +0100 (CET)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:58918 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824789Ab3ARAmu1hcTk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Jan 2013 01:42:50 +0100
Received: by mail-pa0-f46.google.com with SMTP id kp14so401642pab.5
        for <multiple recipients>; Thu, 17 Jan 2013 16:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=5tnTxl/f8DMTaIdTEfxAcpYDNP15eAHVj/zRF1JyPxc=;
        b=eQxfeUMdr8sh1iOLoFudgIgsVA4cyOOLjI8Mqc2eWlGr7rLOHMuE8qDFge2LDd4t2x
         A2UU1jxjVmGkMzRrJXPGyKsctdX/9rfQeDdEbrkG6Psy7olgdEmXPwuhTMzc3kyw5ipX
         ErsyJpd+uafj6GdTEldudeAv8u9izvk3PmCVQiOpnYF0Y0awf7TnT2YE+uYbmXkZgZZ+
         Za5snX9jH44lmOG4KLwXO0WsRKiQfxoBC/yWrAsNKodY8e89LBkIbscMQ//RFEpL58cH
         LWsrXn1HpziLbngmi8UM1l6Adm9yFaEZyKfYiybzOdq7e7BUrayoFh0791A6D7EwfQ2j
         p1XA==
X-Received: by 10.68.229.169 with SMTP id sr9mr18492721pbc.120.1358469763217;
        Thu, 17 Jan 2013 16:42:43 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id bv10sm2250882pab.14.2013.01.17.16.42.41
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 17 Jan 2013 16:42:42 -0800 (PST)
Message-ID: <50F89A81.8040703@gmail.com>
Date:   Thu, 17 Jan 2013 16:42:41 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     "Steven J. Hill" <sjhill@mips.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: microMIPS: Redefine value of BRK_BUG.
References: <1358444216-17213-1-git-send-email-sjhill@mips.com> <50F83FD5.2060908@gmail.com> <20130117225410.GB19406@linux-mips.org>
In-Reply-To: <20130117225410.GB19406@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35490
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 01/17/2013 02:54 PM, Ralf Baechle wrote:
> On Thu, Jan 17, 2013 at 10:15:49AM -0800, David Daney wrote:
>
>>> diff --git a/arch/mips/include/asm/break.h b/arch/mips/include/asm/break.h
>>> index 9161e68..df9d090 100644
>>> --- a/arch/mips/include/asm/break.h
>>> +++ b/arch/mips/include/asm/break.h
>>> @@ -27,6 +27,7 @@
>>>   #define BRK_STACKOVERFLOW 9	/* For Ada stackchecking */
>>>   #define BRK_NORLD	10	/* No rld found - not used by Linux/MIPS */
>>>   #define _BRK_THREADBP	11	/* For threads, user bp (used by debuggers) */
>>> +#define BRK_BUG_MM	12	/* Used by BUG() in microMIPS mode */
>>>   #define BRK_BUG		512	/* Used by BUG() */
>>
>> Can we move the CONFIG_CPU_MICROMIPS to here and just call the thing
>> BRK_BUG?
>>
>> Or perhaps redefining it unconditionally.  I am not sure what the
>> implications of doing that would be.
>>
>> That way...
>
> The kernel decodes break and trap instruction in traps.c.  For a microMIPS-
> enabled kernel it needs to be able to decode both classic and microMIPS
> encoded instructions so we want separate symbols.

For any given kernel, BUG() will be implemented using exactly one trap 
value.  That should be the value tested in traps.c

So we could make non-microMIPS use the same value as microMIPS and then 
we don't have to test for two values.

Side note:  The values used only internally to the kernel should not be 
exported in a userspace visible header file.


>
> Or we do something like
>
> #define BRK_MM_BUG	 12      /* Used by BUG() in microMIPS mode */
> #define BRK_CM_BUG	512     /* Used by BUG() */
>
> #ifdef __mips_micromips
> #define BRK_BUG		BRK_MM_BUG
> #else
> #define BRK_BUG		BRK_CM_BUG
> #endif
>
> This makes the BRK_MM_* / BRK_CM_* macros available for decoding instructions
> and the microMIPS-agnostic BRK_BUG for code such as BUG().
>
>>>   #define BRK_KDB		513	/* Used in KDB_ENTER() */
>>>   #define BRK_MEMU	514	/* Used by FPU emulator */
>>> diff --git a/arch/mips/include/asm/bug.h b/arch/mips/include/asm/bug.h
>>> index 540c98a..b716fb9 100644
>>> --- a/arch/mips/include/asm/bug.h
>>> +++ b/arch/mips/include/asm/bug.h
>>> @@ -7,6 +7,10 @@
>>>   #ifdef CONFIG_BUG
>>>
>>>   #include <asm/break.h>
>>> +#ifdef CONFIG_CPU_MICROMIPS
>>> +#undef BRK_BUG
>>> +#define BRK_BUG		BRK_BUG_MM
>>> +#endif
>>>
>>
>> ...We don't need this bit.   Doing an #undef risks using different
>> values for BRK_BUG depending on whether or not asm/bug.h is
>> included.
>
> And generally is not very elegant.
>
>    Ralf
>
>
