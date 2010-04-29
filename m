Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Apr 2010 14:21:15 +0200 (CEST)
Received: from mx1.moondrake.net ([212.85.150.166]:38769 "EHLO
        mx1.mandriva.com" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S1492653Ab0D2MVL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Apr 2010 14:21:11 +0200
Received: by mx1.mandriva.com (Postfix, from userid 501)
        id 40DD727C006; Thu, 29 Apr 2010 14:21:10 +0200 (CEST)
Received: from office-abk.mandriva.com (unknown [195.7.104.248])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.mandriva.com (Postfix) with ESMTP id B6921274006;
        Thu, 29 Apr 2010 14:21:05 +0200 (CEST)
Received: from anduin.mandriva.com (fw2.mandriva.com [192.168.2.3])
        by office-abk.mandriva.com (Postfix) with ESMTP id 830F985AFA;
        Thu, 29 Apr 2010 14:38:47 +0200 (CEST)
Received: from anduin.mandriva.com (localhost [127.0.0.1])
        by anduin.mandriva.com (Postfix) with ESMTP id 208C5FF855;
        Thu, 29 Apr 2010 14:23:01 +0200 (CEST)
From:   Arnaud Patard <apatard@mandriva.com>
To:     wuzhangjin@gmail.com
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] loongson 2f: Add gpio/gpioilb support
References: <m3sk6ewpep.fsf@anduin.mandriva.com>
        <1272543102.30655.138.camel@localhost>
Organization: Mandriva
Date:   Thu, 29 Apr 2010 14:23:01 +0200
In-Reply-To: <1272543102.30655.138.camel@localhost> (Wu Zhangjin's message of "Thu, 29 Apr 2010 20:11:42 +0800")
Message-ID: <m3iq7awiqi.fsf@anduin.mandriva.com>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <arnaud.patard@mandriva.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apatard@mandriva.com
Precedence: bulk
X-list: linux-mips

Wu Zhangjin <wuzhangjin@gmail.com> writes:

> On Thu, 2010-04-29 at 11:58 +0200, Arnaud Patard wrote:
>> This patch is adding support for the 4 GPIO availables on the ST LS2F
>> cpus.
>> 
>> Signed-off-by: Arnaud Patard <apatard@mandriva.com>
>> ---
> [...]
>> Index: linux-2.6/arch/mips/loongson/common/gpio.c
> [...]
>> +
>> +static int __init ls2f_gpio_setup(void)
>> +{
>> +	return gpiochip_add(&ls2f_chip);
>> +}
>> +arch_initcall(ls2f_gpio_setup);
>> +
>
> The above blank line is at the end of the file, we can remove it,
> otherwise, "git am" will complain about it.

Then, please, either fix your tool or fix it yourself. Last time I've
looked at Documentation/SubmittingPatches, it was not
mentionned. Moreover, checkpatch.pl is not complaining. If you really
think, it's a must have, ask to fix checkpatch.pl first otherwise it's
going to be missed again and again.

Thanks,
Arnaud
