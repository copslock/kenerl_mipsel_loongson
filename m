Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Apr 2013 09:48:18 +0200 (CEST)
Received: from mail-wi0-f178.google.com ([209.85.212.178]:57737 "EHLO
        mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825665Ab3DKHrpZKkgb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Apr 2013 09:47:45 +0200
Received: by mail-wi0-f178.google.com with SMTP id ez12so241188wid.11
        for <multiple recipients>; Thu, 11 Apr 2013 00:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=rARlaBUCeeLntPlBPMCv/o5nNqVkBxqPTFsb8jE8Dw0=;
        b=nFdmEC6XLMP3VuY04Nc4EukDfI1XZ7TBFkJUSvIM6bWzURl3QTQRy4TMLONjVtrlKx
         DaE5nWiNVIEz6Q71heyKukTnk9LYMJAqIOOb8eZuVcnbN1i7t12zPy7HQ5JiSd2bePuQ
         g+kw9X4UYUbpMHAN04Bov+xj4WeMsKmXViki8YaJWWxJuNk/a1sGpmjL0mn8TI54/hyK
         dQ6hIc15HssiJHXt6zj+OJ5jIi93BUeKQCZ/ODvzzrcIuoS6GJJ2/DNSeS29aPYBpMbH
         oKZ9zpKCU41RkXQ8Emr15U3YOoQWWQFl3UxZXJk+OCEgrnOkItZ1BcRc1oz7YYFEPNYM
         V9OQ==
X-Received: by 10.180.109.197 with SMTP id hu5mr8104123wib.22.1365666404510;
        Thu, 11 Apr 2013 00:46:44 -0700 (PDT)
Received: from [0.0.0.0] ([62.159.77.166])
        by mx.google.com with ESMTPS id n2sm1395933wiy.6.2013.04.11.00.46.42
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 00:46:43 -0700 (PDT)
Message-ID: <51666A5F.6030904@gmail.com>
Date:   Thu, 11 Apr 2013 09:46:39 +0200
From:   Wladislav Wiebe <wladislav.kw@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Makefile: workaround printk recursion bug
References: <51652CF5.1080009@gmail.com> <51659556.3070502@gmail.com>
In-Reply-To: <51659556.3070502@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <wladislav.kw@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wladislav.kw@gmail.com
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

Hi,

On 10/04/13 18:37, David Daney wrote:
> On 04/10/2013 02:12 AM, Wladislav Wiebe wrote:
>>
>> From: Wladislav Wiebe <wladislav.kw@gmail.com>
>>
>> Function tracing is broken due to removal of selecting FRAME_POINTER with
>> FUNCTION_TRACER as result of commit: b732d439cb43336cd6d7e804ecb2c81193ef63b0
>>
>> Latest commit ad8c396936e328f5344e1881afde9e28d5f2045f "MIPS: Unbreak
>> function tracer for 64-bit kernel." fixes just the early startup hang,
>> but on MIPS64/CAVIUM_OCTEON2 are still random printk recursion bugs
>> which cause also Kernel hangs, especially on late startup phase when
>> network drivers get loaded. This patch enable for CAVIUM_OCTEON2/64 Bit
>> architecture -fno-omit-frame-pointer cflag when FUNCTION_TRACER get
>> enabled. This will fix random Kernel hangs with "BUG: recent printk
>> recursion!" from linux/kernel/printk.c.
>>
>> Maybe there exist a other solution in mcount handling, since in the
>> commit message from Al Cooper is mentioned that "MIPS frame pointers are
>> generally considered to be useless because they cannot be used to unwind
>> the stack. Unfortunately the MIPS function tracing code has bugs that
>> are masked by the use of frame pointers. This commit fixes the bugs so
>> that MIPS frame pointers don't need to be enabled."
>>
>> But this is just a solution for MIPS32 - on a symmetric multiprocessing
>> @MIPS64/CAVIUM_OCTEON2 it doesn't work properly.
> 
> There are a couple of problems that I see with this patch:
> 
> 1) It doesn't handle non-OCTEON2.  Surely other 64-bit targets are effected as well
> 
> 2) You don't say how it is broken or how this fixes it.
> 
> 3) Function graph tracing on 3.9.0-rc6 compiled with gcc-4.7.0 works fine for me without this.  So I see no need to clog up the make files with a rats nest of ifdef

well, didn't cross checked with gcc-4.7.0 (currently using gcc-4.3).
Will do so and get back if problem still visible.

Thanks!


> 
> Without more information about why this  is needed, I would have to say NAK.
> 
> David Daney
> 
>>
>> Signed-off-by: Wladislav Wiebe <wladislav.kw@gmail.com>
>> ---
>>   arch/mips/Makefile |    9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
>> index 6f7978f..8befe31 100644
>> --- a/arch/mips/Makefile
>> +++ b/arch/mips/Makefile
>> @@ -119,6 +119,15 @@ cflags-$(CONFIG_SB1XXX_CORELIS)    += $(call cc-option,-mno-sched-prolog) \
>>                      -fno-omit-frame-pointer
>>
>>   #
>> +# FTrace depended compiler options, currently only needed by MIPS64/OCTEON2.
>> +#
>> +ifdef CONFIG_64BIT
>> +ifdef CONFIG_CAVIUM_OCTEON2
>> +cflags-$(CONFIG_FUNCTION_TRACER) += $(call cc-option,-fno-omit-frame-pointer)
>> +endif
>> +endif
>> +
>> +#
>>   # CPU-dependent compiler/assembler options for optimization.
>>   #
>>   cflags-$(CONFIG_CPU_R3000)    += -march=r3000
>>
> 
