Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Mar 2015 20:29:22 +0100 (CET)
Received: from mail-qg0-f51.google.com ([209.85.192.51]:35619 "EHLO
        mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008992AbbC1T3Usfw-J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Mar 2015 20:29:20 +0100
Received: by qgh3 with SMTP id 3so143668331qgh.2
        for <linux-mips@linux-mips.org>; Sat, 28 Mar 2015 12:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/QYc+HOtF19KVG7SgIv8Pbd+0e9VARzZZoGXzvbYk04=;
        b=eVzggk0JKc06Q6oXWBRKpnXYaS1Axyh//OuMTC9OoBJxb2oSObLDxGvIZNXClja5Uw
         kLDBuqlEM4Ubr/ur8pgYzhX9i6UlObGfHwQEdpNPfUn0VgyRVNt7tqaH0qFbjb4wp8ke
         przPtkYpEIp9NdTQrNtUMViXA/NKo+5nthkMJ9+7rjoqr065dQec085Ice/klU8PrNXs
         u8Bb0h7Hv7VvhRCu9CUsjsvlPkrsyMY83CGE95Ze6VI8fCxWvWIaMF9GgX86Eb4O0fYA
         DFH+SfGACgWgr5USlsLTE2yGIZkv1xYnJFtL0CvDUObYb46+oeAQpSs+A+UnuHgioggw
         JAWw==
X-Received: by 10.55.23.208 with SMTP id 77mr52288636qkx.21.1427570956075;
 Sat, 28 Mar 2015 12:29:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.90.18 with HTTP; Sat, 28 Mar 2015 12:28:55 -0700 (PDT)
In-Reply-To: <5516DE64.6000104@hurleysoftware.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
 <1416872182-6440-6-git-send-email-cernekee@gmail.com> <54F3914F.3080905@hurleysoftware.com>
 <20150328013604.488A0C4091F@trevor.secretlab.ca> <5516DE64.6000104@hurleysoftware.com>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Sat, 28 Mar 2015 12:28:55 -0700
Message-ID: <CAJiQ=7AS5+HkHcjRsYKi-EHVc3F1fg3Zp=1fCor1HrKeSWU72Q@mail.gmail.com>
Subject: Re: [PATCH V3 5/7] serial: earlycon: Set UPIO_MEM32BE based on DT properties
To:     Peter Hurley <peter@hurleysoftware.com>
Cc:     Grant Likely <grant.likely@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46577
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Sat, Mar 28, 2015 at 10:01 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
>>> I know these got ACKs already but as you point out in the commit log,
>>> earlycon _will_ need reg-io-width, reg-offset and reg-shift. Since the
>>> distinction between early_init_dt_scan_chosen_serial() and
>>> of_setup_earlycon() is arbitrary, I'd rather see of_setup_earlycon()
>>> taught to properly decode of_serial driver bindings instead of a
>>> stack of parameters to of_setup_earlycon().
>>>
>>> In fact, this patch allows a mis-defined devicetree to bring up a
>>> functioning earlycon because the 'big-endian' property is directly
>>> associated with UPIO_MEM32BE, which will create incompatibility problems
>>> when DT earlycon is fixed to decode the of_serial DT bindings.
>>
>> That's a good point. This hasn't been merged yet, so there isn't any
>> impact on addressing this. I would propose that for consistency, the
>> earlycon code should always default to 8-bit access. if big-endian
>> accesses are required, then reg-io-width + big-endian must be specified.
>>
>> Something like the following would do it and would be future-proof. We
>> can add support for 16 or 64bit big or little endian access if it ever
>> became necessary.
>
> I was planning on adding MEM32BE support to OF earlycon on top of my
> patch series 'OF earlycon cleanup', which adds full support for the
> of_serial driver DT properties (among other things).

Hi Peter,

This is my latest work-in-progress, incorporating the feedback from
you and Grant:

https://github.com/cernekee/linux/commits/endian

Not sure if this code plays nice with your recent cleanups?  If we're
touching the same files/functions we should probably coordinate.

Also, it is untested, as I do not currently have access to BE systems.
If I get desperate I can try it on an LE system, adding the big-endian
properties in DT and then hacking the 8250 driver to swap LE accesses
for BE accesses.

> Unfortunately, that series is waiting on two things:
> 1. libfdt upstream patch, which I submitted but was referred back to me
> to add test cases. That was 3 weeks ago and I simply haven't had a free
> day to burn to figure out how their test matrix is organized. I don't
> think that's going to change anytime soon; I might just abandon that patch
> and do the string manipulation on the stack.
>
> ATM, earlycon is still broken if stdout-path options have been set.
>
> 2. Rob never got back to me on my query [1] to unify the OF_EARLYCON_DECLARE
> macro with the EARLYCON_DECLARE macro so that all earlycon consoles
> are named.

Side note:

AFAIK we still have a problem if somebody wants to build serial8250 +
(any other tty driver that occupies major 4 / minor 64) into the same
kernel, and use DT to pick the correct driver at runtime.
serial8250_init() starts registering ports before it knows whether the
system even has an 8250.  I talked to Rob about it earlier this week
and he suggested that you might have some thoughts on how to fix it.
