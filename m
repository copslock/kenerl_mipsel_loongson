Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2016 10:12:26 +0100 (CET)
Received: from mail-yk0-f169.google.com ([209.85.160.169]:35191 "EHLO
        mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011013AbcBKJMYElY0Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Feb 2016 10:12:24 +0100
Received: by mail-yk0-f169.google.com with SMTP id r207so18395224ykd.2
        for <linux-mips@linux-mips.org>; Thu, 11 Feb 2016 01:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=JJVzqvUYuxGY1MuoRO7mBkjh/izrQl/w1yuxDkbGu6U=;
        b=fAcsoZVJcnFFcUi0pu0KVurHnJSw8GUX21/m1d+LdGwnqtnOgAlRWCS2yWNfsVQUsK
         BeK1pyY71lHHQOPO1QjFhEN44KRdYn4dl4eaLLZO8QArYv8U33wTtEi36PcRf+1mOIa4
         AZGnf9wnG5bwgRcImyD5FA2j6gUTUrtMjz7pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=JJVzqvUYuxGY1MuoRO7mBkjh/izrQl/w1yuxDkbGu6U=;
        b=OSqEFeOKsL8pxZu4XJDjwYAh6dNBy3ux5+zwk1qsBmlnVq1TERsap4MmSVdWZurxlo
         Z0qnzlgw6fQnw6SOE8N5tb7IAEBWTimcq+4TvU2VZ3/f7mO/OtRV8DCKu85iz+ab9yAb
         +oUAq3ZbZUq2fv368zcrrvbEC8ezNRcuAP6KerWFCrzqNylPn5sWpx93cvvwEX5yFfM3
         pHwXXNtRvpWlPJkeQLNKqnxhQHBnTqd4lGbLdpVO/JS95PiDbVhfp5w/x7wr/emJzY+6
         0+iKISc9E9QHa9TS8pxMMwojX1CSQwYwDhEUOcq73gk5aObpUp95+mUBuFKyOXvat+F2
         1/+w==
X-Gm-Message-State: AG10YORilhYvpztIStVezld+6HYsPpEIGekj2mVV2OHT/bQKI/wYFzWI/Vd9i5YG0I+JZOl39uaObSYO4ifHnVAM
MIME-Version: 1.0
X-Received: by 10.37.45.67 with SMTP id t64mr12291057ybt.170.1455181938085;
 Thu, 11 Feb 2016 01:12:18 -0800 (PST)
Received: by 10.129.114.84 with HTTP; Thu, 11 Feb 2016 01:12:18 -0800 (PST)
In-Reply-To: <56BC4538.20207@imgtec.com>
References: <1455125775-7245-1-git-send-email-matt.redfearn@imgtec.com>
        <CAPDyKFrMgt9snP2NLbQ6EQ5X7gjQLA+e+TEfqgjzLYTuH+G1OA@mail.gmail.com>
        <56BB9877.9000305@caviumnetworks.com>
        <56BC4538.20207@imgtec.com>
Date:   Thu, 11 Feb 2016 10:12:18 +0100
Message-ID: <CAPDyKFq9+WwkUTBNuPai1wCCTfDfehyHqzMvfW_5yN-ogbyLYw@mail.gmail.com>
Subject: Re: [PATCH v5] mmc: OCTEON: Add host driver for OCTEON MMC controller
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Zubair.Kakakhel@imgtec.com,
        Aleksey Makarov <aleksey.makarov@caviumnetworks.com>,
        Chandrakala Chavva <cchavva@caviumnetworks.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Leonid Rosenboim <lrosenboim@caviumnetworks.com>,
        Peter Swain <pswain@cavium.com>,
        Aaron Williams <aaron.williams@cavium.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <ulf.hansson@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ulf.hansson@linaro.org
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

On 11 February 2016 at 09:24, Matt Redfearn <matt.redfearn@imgtec.com> wrote:
> Hi,
> I will split the DT binding document into a separate patch, and move the
> legacy FDT patch-up code to
> arch/mips/cavium-octeon/octeon-platform.c as suggested by Florian.
>
> Ulf, your objections to the structure of the DT and driver were the only
> driver for the changes v4->v5.
> I changed the DT binding and the structure of the driver to more closely
> resemble the atmel-mci driver, which has the same concept of one controller,
> multiple slots.

I will review the driver code more closely in the next version, when
you have separated the DT binding doc and put the legacy part in
machine folder. Please keep me on cc on all patches.

Regarding "multiple slot" support. Don't follow other existing
examples in other mmc host drivers, as I find it highly unlikely that
the core will ever support this. *If* that changes, then the mmc host
driver may adopt this, but not until that.

Kind regards
Uffe

>
> Thanks,
> Matt
>
>
> On 10/02/16 20:07, David Daney wrote:
>>
>> On 02/10/2016 11:01 AM, Ulf Hansson wrote:
>>>
>>> On 10 February 2016 at 18:36, Matt Redfearn <matt.redfearn@imgtec.com>
>>> wrote:
>>>>
>>>> From: Aleksey Makarov <aleksey.makarov@caviumnetworks.com>
>>>>
>>>> The OCTEON MMC controller is currently found on cn61XX and cnf71XX
>>>> devices.  Device parameters are configured from device tree data.
>>>>
>>>> eMMC, MMC and SD devices are supported.
>>>>
>>>> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
>>>> Signed-off-by: Chandrakala Chavva <cchavva@caviumnetworks.com>
>>>> Signed-off-by: David Daney <david.daney@cavium.com>
>>>> Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
>>>> Signed-off-by: Leonid Rosenboim <lrosenboim@caviumnetworks.com>
>>>> Signed-off-by: Peter Swain <pswain@cavium.com>
>>>> Signed-off-by: Aaron Williams <aaron.williams@cavium.com>
>>>> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
>>>> ---
>>>> v5:
>>>> Incoroprate comments from review
>>>> http://patchwork.linux-mips.org/patch/9558/
>>>> - Use standard <bus-width> property instead of <cavium,bus-max-width>.
>>>> - Use standard <max-frequency> property instead of <spi-max-frequency>.
>>>> - Add octeon_mmc_of_parse_legacy function to deal with the above
>>>>    properties, since many devices have shipped with those properties
>>>>    embedded in firmware.
>>>> - Allow the <vmmc-supply> binding in addition to the legacy
>>>>    <gpios-power>.
>>>> - Remove the secondary driver for each slot.
>>>> - Use core gpio cd/wp handling
>>>
>>>
>>> Seems like you decided to ignore most comments realted to the DT
>>> bindings from the earlier version.
>>> Although, let's discuss this one more time.
>>
>>
>> I think you may have misread the patch.  The DT bindings have been
>> changed based on the feedback we received on v4.
>>
>>>
>>> Therefore I recomend you to split this patch. DT documentation should
>>> be a separate patch preceeding the actual mmc driver patch.
>>
>>
>> You may have missed it the first time it was posted, but the legacy DT
>> bindings have been around for a while.
>>
>> See:
>>
>> https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-May/015482.html
>>
>>
>>> The DT patch needs to be acked by the DT maintainers.
>>
>>
>> The legacy DT has been deployed in firmware for several years now.  We
>> are adding more "modern" bindings, and the DT maintainers are
>> encouraged to review that portion, but the legacy is what it is and it
>> isn't changing.
>>
>>>
>>> Until we somewhat agreed on the DT parts, I am going to defer the
>>> in-depth review of the driver code as I have limited bandwidth.
>>>
>>
>> As I stated above, the legacy DT bindings are not changing and must be
>> supported.  Waiting for legacy DT bindings to change is equivalent to
>> infinite deferral.
>>
>>> Does that make sense to you?
>>>
>>
>> I understand why you would say this.  However, I think it doesn't
>> fully take into account the need to support devices that have already
>> been deployed.
>>
>> That said, Matt really needs to get the DT maintainers reviewing the new
>> DT bindings.
>>
>>
>> David Daney
>
>
