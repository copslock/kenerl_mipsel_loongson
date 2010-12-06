Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Dec 2010 18:40:46 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:51060 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492036Ab0LFRkm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Dec 2010 18:40:42 +0100
Received: by gyg4 with SMTP id 4so6627110gyg.36
        for <multiple recipients>; Mon, 06 Dec 2010 09:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=ARi+Mjrz5SkGRaXaYykSUHjna0yv0dvq51uk+OOXUYw=;
        b=o0m0sTXfV+XXxEZzORIP2gnTf1jZ1xX1MIaZ0vJWJGgQnaiL8ywur+LkJy+EG1ys60
         nDCefFBfniIJOw+QCpb3fw5cvaS8Qd+Sd8FJ0bgPnXTUUXiiQZTv3mtI91whsDlMA3mb
         N/A1b+aY3I2GgFo5Q2BqbMnwHHuadC2UQ3uCk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=foJ7ccsbHZOj0X/f8kkZB5eHbMH3WaW7WeHvYXVuqZ5vAf58qxwDc0sTZ2UQc4pAYx
         5+xln85sX+ULZv7rAhXiVkctkGJdUBWH8zY3hi8O4h0D0fySqeMBRjU3Z7Zj46WWIJcg
         3ILlE4EZqTswWQ1GzZXoWW5SP5DWZCXGfqNqU=
Received: by 10.223.102.79 with SMTP id f15mr184964fao.134.1291657235296; Mon,
 06 Dec 2010 09:40:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.204.46.199 with HTTP; Mon, 6 Dec 2010 09:40:15 -0800 (PST)
In-Reply-To: <20101206173040.GA18372@ericsson.com>
References: <1291617494-18430-1-git-send-email-mattst88@gmail.com> <20101206173040.GA18372@ericsson.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Mon, 6 Dec 2010 17:40:15 +0000
Message-ID: <AANLkTikGgfBuj086eRvy4VzzyE2suJCL9z=SfmOiFiPx@mail.gmail.com>
Subject: Re: [PATCH] I2C: SiByte: Convert the driver to make use of interrupts
To:     Guenter Roeck <guenter.roeck@ericsson.com>
Cc:     Jean Delvare <khali@linux-fr.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <mattst88@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28614
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, Dec 6, 2010 at 5:30 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Mon, Dec 06, 2010 at 01:38:14AM -0500, Matt Turner wrote:
>> From: Maciej W. Rozycki <macro@linux-mips.org>
>>
>> This is a rewrite of large parts of the driver mainly so that it uses
>> SMBus interrupts to offload the CPU from busy-waiting on status inputs.
>> As a part of the overhaul of the init and exit calls, all accesses to the
>> hardware got converted to use accessory functions via an ioremap() cookie.
>>
>> Minimally rebased by Matt Turner.
>>
>> Tested-by: Matt Turner <mattst88@gmail.com>
>> Signed-off-by: Matt Turner <mattst88@gmail.com>
>
>
> I applied the patch to my 1480 tree. Unfortunately, it doesn't work with my system.
> As far as I can see, the driver does not get any interrupts.
>
> My tree is 2.6.32, though. Do you know if I might be missing some other relevant patch ?
>
> Thanks,
> Guenter

I think this patch depends on
http://www.linux-mips.org/archives/linux-mips/2010-12/msg00030.html

Thanks for testing and the suggestions! :)

Matt
