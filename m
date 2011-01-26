Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jan 2011 13:36:20 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:39210 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491883Ab1AZMgR convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 26 Jan 2011 13:36:17 +0100
Received: by gxk21 with SMTP id 21so104525gxk.36
        for <multiple recipients>; Wed, 26 Jan 2011 04:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Mbbp8dLvRzkbE+NvpzzjeW40cMkY/xPzO8bhWoMUG0g=;
        b=TRbZO+m+PQ1lq+mGG9Gn24Yzv37KmCN4k3FWqnmR7JnX+awaGG1g112YkJJ6Jhf9iw
         5UHR0/b1k//A/aJdtmMp7GKlFCXFucfr5oPrAkaH4p2dX//SrWAdFkGl/ekY0hSUpOKZ
         91d8XnXQLFhgj3vrqcDSrnjnuv0oVTGBV1he0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nerDd2a+4rY2OnCfjGibzFcC45jPHwKxtwWXxZn+3b+Bv+0l/P+giM/shN3R6wGAtM
         xdphf7+zf0ujDWAHiAEl1bxeZ2BXVsFfxAN8JfcysgXcWelkKX1djTz+gSInqvsGnSAF
         aXQmNTOy91mhC8PeUiwyBRB6Zqms3VC/seEio=
MIME-Version: 1.0
Received: by 10.146.86.14 with SMTP id j14mr9793589yab.31.1296045370575; Wed,
 26 Jan 2011 04:36:10 -0800 (PST)
Received: by 10.147.137.18 with HTTP; Wed, 26 Jan 2011 04:36:10 -0800 (PST)
In-Reply-To: <20110124135713.GA31240@linux-mips.org>
References: <cover.1295464855.git.wuzhangjin@gmail.com>
        <bce694a8e18c01fa0d2cc667561870b56a7d672f.1295464855.git.wuzhangjin@gmail.com>
        <20110124135713.GA31240@linux-mips.org>
Date:   Wed, 26 Jan 2011 20:36:10 +0800
Message-ID: <AANLkTim-QNgjp0a1sfPejgCBY8MVKtQDefe3xeky2dun@mail.gmail.com>
Subject: Re: [PATCH 2/5] tracing, MIPS: Substitute in_kernel_space() for in_module()
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Steven Rostedt <srostedt@redhat.com>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29090
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, Jan 24, 2011 at 9:57 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Thu, Jan 20, 2011 at 03:28:29AM +0800, Wu Zhangjin wrote:
>
>> @@ -91,10 +91,16 @@ int ftrace_make_nop(struct module *mod,
>>       unsigned long ip = rec->ip;
>>
>>       /*
>> -      * We have compiled module with -mlong-calls, but compiled the kernel
>> -      * without it, we need to cope with them respectively.
>> +      * If ip is in kernel space, no long call, otherwise, long call is
>> +      * needed.
>>        */
>
> Or even better, just check if the destination is in the same 28-bit segment
> of address space.  Something like:
>
>        if ((src ^ dst) >> 28)  {
>                /* out of range of simple R_MIPS_26 relocation */
>        }

Yeah, will check if the following statement works:

if ((rec->ip ^ _mcount) >> 28) {
    ...
}

This check may be faster and clearer ;-)

>
> That way you no longer rely on a particular address layout - and there are
> plans to change the address space layout eventually!

Yeah, we really need an address space independent method.

Thanks & Regards,
Wu Zhangjin

>
>  Ralf
>
