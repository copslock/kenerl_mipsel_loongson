Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Nov 2015 18:21:56 +0100 (CET)
Received: from mail-lb0-f170.google.com ([209.85.217.170]:32934 "EHLO
        mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012619AbbKERVy5gJmB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Nov 2015 18:21:54 +0100
Received: by lbbkw15 with SMTP id kw15so34545246lbb.0
        for <linux-mips@linux-mips.org>; Thu, 05 Nov 2015 09:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded_com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=4vJwkKgYEBE2eY6t87XM973X6kC38WrXxwxVlKx9zZE=;
        b=RWMDMLV7Ha7XjC7s1a6UByfZzZTL4WEJGxOPofDZyTmkAFPeybFUe/di2hVKvX+MlW
         ZiAh8Sy0vC/ueUmCiWUr+1rpmGoe+qcFML0sWRrWqBCjQ5RI144jwVJ+BmT3vFsJgFPP
         D2iAlqEZaxZDwpCbpuhpSi+/NQppkLlXUrZtlrFX84ypTUy8+iCuP61NpORAMBQez+78
         n76hDkgz6S4o3oWMYSC+xMERY25qzEioSL+hgsXX91dkSgDBnCnuXatGn6PYQ1H6QuhJ
         lRCCY9excrKWkGaMACceJowicrZQa+KapQhI1ZalRJDPgaCmsEOGyAqKqyWJfkXoD7ru
         rCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=4vJwkKgYEBE2eY6t87XM973X6kC38WrXxwxVlKx9zZE=;
        b=m6omSLSgmh0CyJF2jukt3YFbYjXkmlsG5q4TSFwsLPhX5gING7IuQAmxC2zMBD9lQu
         VU8O3CKOXJqO6HFxxhkmtnbDTW0nXUF9sxzN3Mn+pAtUqVCC/vE2UNqXbd2LPMsaBp2l
         Qc4CxaQiGMfChMfVMKh4US26Ul4wSMqt7kJgXA2yGOdLm4ShzI9/o+6Lw4NkPoxYVd+E
         XA+e8UfzmegE0YYpMu50PDUIYEglbzQaKQKriy/PxbFs5MOHa44XqV+ptNoFvjnf21jR
         G96h4BkXWM3CEe0C/FsdiomewRn5LpypBaGbJ7LweTnebyFuiLh19bviZO9JSFQj2LaE
         FaVA==
X-Gm-Message-State: ALoCoQl9V+bCm00K4G7GephtBhLrqSdhR7WHCV01lmW9VOOyrAcuuMlp9sC937d3nInkvluE11OA
X-Received: by 10.112.17.105 with SMTP id n9mr4565380lbd.78.1446744109434;
        Thu, 05 Nov 2015 09:21:49 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.81.38])
        by smtp.gmail.com with ESMTPSA id l65sm668533lfb.33.2015.11.05.09.21.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2015 09:21:48 -0800 (PST)
Subject: Re: [PATCH V2 4/9] arch: mips: ralink: add tty detection
To:     John Crispin <john@phrozen.org>, John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1446692398-44153-1-git-send-email-blogic@openwrt.org>
 <563B62AC.9000407@cogentembedded.com> <563B6735.2080505@phrozen.org>
Cc:     linux-mips@linux-mips.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <563B902B.3060702@cogentembedded.com>
Date:   Thu, 5 Nov 2015 20:21:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <563B6735.2080505@phrozen.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

On 11/05/2015 05:27 PM, John Crispin wrote:

>>> MT7688 has several uarts that can be used for console. There are several
>>> boards in the wild, that use ttyS1 or ttyS2. This patch applies a simply
>>> autodetection routine to figure out which ttyS the bootloader used as
>>> console. The uarts come up in 6 bit mode by default. The bootloader will
>>> have set 8 bit mode on the console. Find that 8bit tty and use it.
>>>
>>> Signed-off-by: John Crispin <blogic@openwrt.org>
>>> ---
>>> Changes in V2:
>>> * remove superflous inline definition
>>>
>>>    arch/mips/ralink/early_printk.c |   26 ++++++++++++++++++++++++++
>>>    1 file changed, 26 insertions(+)
>>>
>>> diff --git a/arch/mips/ralink/early_printk.c
>>> b/arch/mips/ralink/early_printk.c
>>> index 255d695..3c59ffe 100644
>>> --- a/arch/mips/ralink/early_printk.c
>>> +++ b/arch/mips/ralink/early_printk.c
>> [...]
>>> @@ -47,8 +49,32 @@ static inline int soc_is_mt7628(void)
>>>            (__raw_readl(chipid_membase) == MT7628_CHIP_NAME1);
>>>    }
>>>
>>> +static void find_uart_base(void)
>>> +{
>>> +    int i;
>>> +
>>> +    if (!soc_is_mt7628())
>>> +        return;
>>> +
>>> +    for (i = 0; i < 3; i++) {
>>> +        u32 reg = uart_r32(UART_REG_LCR + (0x100 * i));
>>
>>     Inner parens not needed, the operator precedence is natural.
>>
>
> "not needed" means "should be removed" or "not needed".

    That's completely up to you.

> checkpatch.pl certainly did not complain and a quick look around
> instantly yielded lots of places in the kernel where this is done. imho
> the brackets make it more readable

    Do you really always write 2 + (3 * 4) when you e.g. use scientific 
calculator?

[...]

MBR, Sergei
