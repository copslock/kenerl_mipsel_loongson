Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Aug 2010 12:14:31 +0200 (CEST)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:48187 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491818Ab0HDKO1 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Aug 2010 12:14:27 +0200
Received: by eyd10 with SMTP id 10so2196927eyd.36
        for <linux-mips@linux-mips.org>; Wed, 04 Aug 2010 03:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=c9nl+vBptVSKMPqPFRNSq3aMcr9lTCzwHdQnlkXDU6g=;
        b=jzr2UANF4/r6Wg7/xFEaVyvQe1GPwcCth0TVmzzACaG1jzLE3J+9ELqaku/p/sEJOp
         th5nALQfh0D5wMfjSIf96be6e5iZ1QEqwmpQiGDHv4SpQy6YLDgZaMmK8eP6Cu2uxYRM
         Kws58IZqacGHhlSVqcaSyhiEOcrWfx5bCgOXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=imZOcxLyoj36QFQhJmXQPikosyioEHRylYLfHo91k25M0bHAshXzXlyK/E1r71ce9X
         uTogwz5M177acFKVixdVSAEoQXe5pOJFkZYKigPMf8B3a/T7b8hKbKBZJ0BKtuwEqnJb
         hKvKRGjUgCbm2wCODWkz/2CBP3OpY7wly7UxI=
MIME-Version: 1.0
Received: by 10.213.105.207 with SMTP id u15mr6475266ebo.83.1280916867345; 
        Wed, 04 Aug 2010 03:14:27 -0700 (PDT)
Received: by 10.14.127.13 with HTTP; Wed, 4 Aug 2010 03:14:27 -0700 (PDT)
In-Reply-To: <4C592027.8010902@paralogos.com>
References: <AANLkTinCjSTE7sYa7JdqwAEe-4nZJKAvVfg5q4YVVqC7@mail.gmail.com>
        <4C592027.8010902@paralogos.com>
Date:   Wed, 4 Aug 2010 18:14:27 +0800
Message-ID: <AANLkTinVxFnNzQaHUCqxTQk708MEuUAiEuRGGPN8WcuS@mail.gmail.com>
Subject: Re: [Q] enabling FPU for vpe1
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27564
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

Thanks for looking into this.

I did do that. But the CU1 bit of TC#1 (in VPE#1) can not be set by
TC#0 or itself. Looks like VPE#1 is not seeing the FPU at all...


Deng-Cheng


2010/8/4 Kevin D. Kissell <kevink@paralogos.com>:
> Check the MIPS MT spec.  If I recall correctly, it's possible to enable
> access to the FPU by either VPE by setting the right bits while the
> processor is in the MT configuration mode.
>
> Deng-Cheng Zhu wrote:
>> Hi,
>>
>>
>> I'm working on a 34Kf CPU. I understand that only one TC can use the
>> FPU at any given time.
>>
>> My question is: If a TC is attached to the 2nd VPE (i.e. VPE1), can I
>> enable FPU for it?
>>
>> I experimented on this, but failed to do it. Am I missing something?
>>
>>
>> Thanks
>>
>> Deng-Cheng
>>
>>
>
>
