Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Dec 2010 19:04:52 +0100 (CET)
Received: from mail-ew0-f54.google.com ([209.85.215.54]:45558 "EHLO
        mail-ew0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492046Ab0LFSEs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Dec 2010 19:04:48 +0100
Received: by ewy24 with SMTP id 24so34141551ewy.27
        for <multiple recipients>; Mon, 06 Dec 2010 10:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=+B8/H8wueQ5fv+MfuBPypWCySaF9lKGpOCMlm27GRXQ=;
        b=K/5idjwPMd+a7HiR6w92YLZbAlq67eS5OwXU0OUmg5suB8LPtl3Hixwcd+g5TGECJh
         gI3sg6FsUY6iF7fVJE4Jql4o5Z6AOVbmE6e12Cf/qdyH9aERwW+muB/zHCbHtK0PdubP
         r7Fz+lt5F4xHn5TA2j9PU8IPiqFYw5cRJguao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=U+oDFhpGW5g8ZBIIi0SDEIO+7DqHsYORINchKCRvFVooTYoEJ9nbC/EdfEoy89FP9m
         UYJP0T+MI/Madudkm+EBiy+Pn/49Vph+YSFrocr1d37hG1Yv8fB3QdTrlrQgJvuyoTa2
         M4Z5wIRYJvi/Li/E3lThSU22Z4yOn/+PTolio=
Received: by 10.213.33.133 with SMTP id h5mr2617770ebd.87.1291658687211; Mon,
 06 Dec 2010 10:04:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.204.46.199 with HTTP; Mon, 6 Dec 2010 10:04:26 -0800 (PST)
In-Reply-To: <20101206180203.GA18478@ericsson.com>
References: <1291617494-18430-1-git-send-email-mattst88@gmail.com>
 <20101206173040.GA18372@ericsson.com> <AANLkTikGgfBuj086eRvy4VzzyE2suJCL9z=SfmOiFiPx@mail.gmail.com>
 <20101206180203.GA18478@ericsson.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Mon, 6 Dec 2010 18:04:26 +0000
Message-ID: <AANLkTinWvXG0thg534eHG9=3=Qdb3iArOKHJgeP9jrm4@mail.gmail.com>
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
X-archive-position: 28619
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, Dec 6, 2010 at 6:02 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Mon, Dec 06, 2010 at 12:40:15PM -0500, Matt Turner wrote:
>> On Mon, Dec 6, 2010 at 5:30 PM, Guenter Roeck
>> <guenter.roeck@ericsson.com> wrote:
>> > On Mon, Dec 06, 2010 at 01:38:14AM -0500, Matt Turner wrote:
>> >> From: Maciej W. Rozycki <macro@linux-mips.org>
>> >>
>> >> This is a rewrite of large parts of the driver mainly so that it uses
>> >> SMBus interrupts to offload the CPU from busy-waiting on status inputs.
>> >> As a part of the overhaul of the init and exit calls, all accesses to the
>> >> hardware got converted to use accessory functions via an ioremap() cookie.
>> >>
>> >> Minimally rebased by Matt Turner.
>> >>
>> >> Tested-by: Matt Turner <mattst88@gmail.com>
>> >> Signed-off-by: Matt Turner <mattst88@gmail.com>
>> >
>> >
>> > I applied the patch to my 1480 tree. Unfortunately, it doesn't work with my system.
>> > As far as I can see, the driver does not get any interrupts.
>> >
>> > My tree is 2.6.32, though. Do you know if I might be missing some other relevant patch ?
>> >
>> > Thanks,
>> > Guenter
>>
>> I think this patch depends on
>> http://www.linux-mips.org/archives/linux-mips/2010-12/msg00030.html
>>
> I did apply the second patch as well, since you had mentioned it in your patch.
> That did not help, though. Frankly, I don't see the dependency in the first place - the other
> patch only affects drivers/rtc/rtc-m41t80.c, and I would hope that SMBus support does not depend
> on an rtc driver. Am I missing something ?
>
> Thanks,
> Guenter

Indeed that does not make much sense. I really don't know. Perhaps
Maciej can shed some light on this? It certainly might be the case
that these patches haven't ever been tested on a BCM91480 before.

Matt
