Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2011 21:46:54 +0200 (CEST)
Received: from mail-vx0-f177.google.com ([209.85.220.177]:34655 "EHLO
        mail-vx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492171Ab1HSTqu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2011 21:46:50 +0200
Received: by vxj2 with SMTP id 2so3487723vxj.36
        for <linux-mips@linux-mips.org>; Fri, 19 Aug 2011 12:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jpxH/l+NFJn4EN0Xpcja3fHyMtVWE7cr3rbhND92qAg=;
        b=pX3BRUYT2qV2RhCuy/NyPG6UhDKKUm+0R2CYnLulNtxb7ue9MTC3ARDjtg0OiQaSXg
         b6ft+k3xIFDn5v9L7cztHn2Ata4pDYSU8Y7s+KHDsel9fBHCmeTuRqk9R+XtOMRw5N5Z
         SgofhklyK9tQPvxjXSAQBr02oROZECbK00Zck=
Received: by 10.52.71.41 with SMTP id r9mr137002vdu.289.1313783204445; Fri, 19
 Aug 2011 12:46:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.52.156.131 with HTTP; Fri, 19 Aug 2011 12:41:59 -0700 (PDT)
In-Reply-To: <1313777242.2970.131.camel@work-vm>
References: <CAEdQ38HGfd9YWE+WLuirE4Km6UE6N26toTj=-1BuXAQUux6t5g@mail.gmail.com>
 <1313777242.2970.131.camel@work-vm>
From:   Matt Turner <mattst88@gmail.com>
Date:   Fri, 19 Aug 2011 15:41:59 -0400
Message-ID: <CAEdQ38F4zi76ug+ABZPnPLcLvGfUFRhr6SKzYCN+24Otq+qAAQ@mail.gmail.com>
Subject: Re: select() to /dev/rtc0 to wait for clock tick timed out
To:     john stultz <johnstul@us.ibm.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 30926
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14680

On Fri, Aug 19, 2011 at 2:07 PM, john stultz <johnstul@us.ibm.com> wrote:
> On Fri, 2011-08-19 at 00:16 -0400, Matt Turner wrote:
>> Hi John,
>>
>> I just sent a patch series to linux-mips@ that enables the RTC on a
>> particular Broadcom MIPS motherboard (BCM91250A SWARM). The RTC is an
>> M41T80.
>>
>> When I first found the patchset (it was originally sent a a few years
>> ago) and applied it to 2.6.37, it worked perfectly.
>>
>> Applied to 3.x (and I think even 2.6.38) I get the following when I run hwclock:
>>
>> # hwclock --systohc
>> select() to /dev/rtc0 to wait for clock tick timed out
>
> So do alarm interrupts actually work on the hardware?
>
> The rtc-m41t80.c driver looks like it should support them ok.
>
> Does the test program at the end of Documentation/rtc.txt do much?
>
> thanks
> -john

Counting 5 update (1/sec) interrupts from reading /dev/rtc0:

... and then it doesn't count.

Would it help if I tried to bisect this? (Is there an easy way to
bisect 2.6.37..master with my patches applied to each iteration?)

Thanks,
Matt
