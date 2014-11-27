Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Nov 2014 14:50:29 +0100 (CET)
Received: from mail-ie0-f169.google.com ([209.85.223.169]:59770 "EHLO
        mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007400AbaK0Nu2BPVCB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Nov 2014 14:50:28 +0100
Received: by mail-ie0-f169.google.com with SMTP id y20so4566417ier.14
        for <linux-mips@linux-mips.org>; Thu, 27 Nov 2014 05:50:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-type;
        bh=URiCj84wSLQM2APRmTjMOFmbcu3pdDW68d7ZdFiEn3k=;
        b=DmV4vuS2eCoupip59O0ldYRywD/70fhddNQDAGIYAbFkVh3xFoyxV8TgznlQzQATZL
         te96N5reoB68Hpqm1Wp+pr5ALcaR2mp9GXa1/acZelZid4aqgkaCgjdUlGYMYO5CkYl6
         oeCd6J3jnWvq23D1T2lxPpTCwUawDXgRejGDCnm+s9/YL+/BjuS3hs774Gb9MZEJGX54
         bYkOv8g9djzhGobKnDRWXXSflhVjjpOeOEHcIC/JfcCQEbrFHuO715Wy7ilfhjhMVrJQ
         nS2KkOUQbBKlBptnlJ3NU2kIv4GxnbjjkjLblh46gRHsgk9UcbqIwiuIIceZ0BYBzl+l
         0s0w==
X-Gm-Message-State: ALoCoQlRZehd4pW/UKHhIFaTYWdDkBHIcI7/hsIb0C/KUvviVwr/7b6+iwnJdJtH6E17fftn8PQ3
X-Received: by 10.107.12.34 with SMTP id w34mr35555751ioi.3.1417096221651;
 Thu, 27 Nov 2014 05:50:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.91.35 with HTTP; Thu, 27 Nov 2014 05:50:01 -0800 (PST)
In-Reply-To: <5475E4EC.7090309@hurleysoftware.com>
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
 <1415825647-6024-2-git-send-email-cernekee@gmail.com> <20141125203431.GA9385@kroah.com>
 <CAJiQ=7DOxK2NzmC9gGsnARxGMN8wRQyGX+5u5YC_vt00ADVsDg@mail.gmail.com>
 <20141126133306.659E9C4099B@trevor.secretlab.ca> <5475E4EC.7090309@hurleysoftware.com>
From:   Grant Likely <grant.likely@linaro.org>
Date:   Thu, 27 Nov 2014 13:50:01 +0000
X-Google-Sender-Auth: 6OJHuFO4w3hbCYggudgN19Ej4nI
Message-ID: <CACxGe6uLWZav=AfaK2w17PW6vtxF8S0=OUvCMB-uFSvhs2cLtw@mail.gmail.com>
Subject: Re: [PATCH V2 01/10] tty: Fallback to use dynamic major number
To:     Peter Hurley <peter@hurleysoftware.com>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        tushar.b@samsung.com
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@linaro.org
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

On Wed, Nov 26, 2014 at 2:34 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> On 11/26/2014 08:33 AM, Grant Likely wrote:
>> On Tue, 25 Nov 2014 15:37:16 -0800
>> , Kevin Cernekee <cernekee@gmail.com>
>>  wrote:
>>> On Tue, Nov 25, 2014 at 12:34 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>>>> On Wed, Nov 12, 2014 at 12:53:58PM -0800, Kevin Cernekee wrote:
>>>>> From: Tushar Behera <tushar.behera@linaro.org>
>>>>
>>>> This email bounces, so I'm going to have to reject this patch.  I can't
>>>> accept a patch from a "fake" person, let alone something that touches
>>>> core code like this.
>>>>
>>>> Sorry, I can't accept anything in this series then.
>>>
>>> Oops, guess I probably should have updated his address after the V1
>>> emails bounced...
>>>
>>> Before I send a new version, what do you think about the overall
>>> approach?  Should we try to make serial8250 coexist with the other
>>> "ttyS / major 4 / minor 64" drivers (possibly at the expense of
>>> compatibility) or is it better to start with a simpler, cleaner driver
>>> like serial/pxa?
>>
>> Co-existing really needs to be fixed.
>
> What are the requirements for co-existence?
> Is it sufficient to provide 1st come-1st served minor allocation?

Should be sufficient. Basically, if the hardware doesn't exist, the
driver shouldn't be trying to grab the minor numbers.

Also, on hardware where both exists, there should be some sane
fallback so that all UARTs get assigned numbers. On DT systems we can
also use /aliases to ensure consistent assignment of numbers.

g.
