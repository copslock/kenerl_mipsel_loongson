Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2014 15:34:30 +0100 (CET)
Received: from mail-qa0-f45.google.com ([209.85.216.45]:53738 "EHLO
        mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007213AbaKZOe3OsEDC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Nov 2014 15:34:29 +0100
Received: by mail-qa0-f45.google.com with SMTP id x12so1969264qac.32
        for <linux-mips@linux-mips.org>; Wed, 26 Nov 2014 06:34:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=QFO4XOreF9SbDizxzP9BmgPtQg64W3GVdbZCm/10sxo=;
        b=J7HtsyB7vYLEwX6Rl7/nRSDIzQJrrh288sd8QVaBEy3akQ/AQWeqIiLy+gea8t2Kfv
         nddWtO4rsRtSVHq/7Cw9PyZHoqSAgbJbj85l1/OjFMXX+19TWdO/ooIwlieOLZfF9YZY
         GM2TwN1gIAJCPYxPVuegJqoN4KGLEM4R1++iSH7yHag7FfFABL25hJ/ouNeoLvcawvrk
         rBirjRjUpll9mMIfes4PDf/2T7Tw94QQ7ipOumFB8IYZiefQudI+pQ76BXlV1BHkfu+F
         2n2DrbMkWNdcsIsHksPY/QcHBMkiFCg8K0cJX3vLd43i4tOV57VEbwmLydx9Z6rnP79k
         RIUw==
X-Gm-Message-State: ALoCoQlAJV8prFEtP+yJocfj4TmXp0KTbxmWxbBCR0Wyu6fdBesbfB5f9bSltAPUFYaSNcrpfTij
X-Received: by 10.140.36.168 with SMTP id p37mr45098990qgp.101.1417012463254;
        Wed, 26 Nov 2014 06:34:23 -0800 (PST)
Received: from [192.168.1.139] (h96-61-95-138.cntcnh.dsl.dynamic.tds.net. [96.61.95.138])
        by mx.google.com with ESMTPSA id n108sm2403989qge.32.2014.11.26.06.34.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Nov 2014 06:34:22 -0800 (PST)
Message-ID: <5475E4EC.7090309@hurleysoftware.com>
Date:   Wed, 26 Nov 2014 09:34:20 -0500
From:   Peter Hurley <peter@hurleysoftware.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Grant Likely <grant.likely@linaro.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, daniel@zonque.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        tushar.b@samsung.com
Subject: Re: [PATCH V2 01/10] tty: Fallback to use dynamic major number
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com>       <1415825647-6024-2-git-send-email-cernekee@gmail.com>   <20141125203431.GA9385@kroah.com>       <CAJiQ=7DOxK2NzmC9gGsnARxGMN8wRQyGX+5u5YC_vt00ADVsDg@mail.gmail.com> <20141126133306.659E9C4099B@trevor.secretlab.ca>
In-Reply-To: <20141126133306.659E9C4099B@trevor.secretlab.ca>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <peter@hurleysoftware.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peter@hurleysoftware.com
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

On 11/26/2014 08:33 AM, Grant Likely wrote:
> On Tue, 25 Nov 2014 15:37:16 -0800
> , Kevin Cernekee <cernekee@gmail.com>
>  wrote:
>> On Tue, Nov 25, 2014 at 12:34 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>>> On Wed, Nov 12, 2014 at 12:53:58PM -0800, Kevin Cernekee wrote:
>>>> From: Tushar Behera <tushar.behera@linaro.org>
>>>
>>> This email bounces, so I'm going to have to reject this patch.  I can't
>>> accept a patch from a "fake" person, let alone something that touches
>>> core code like this.
>>>
>>> Sorry, I can't accept anything in this series then.
>>
>> Oops, guess I probably should have updated his address after the V1
>> emails bounced...
>>
>> Before I send a new version, what do you think about the overall
>> approach?  Should we try to make serial8250 coexist with the other
>> "ttyS / major 4 / minor 64" drivers (possibly at the expense of
>> compatibility) or is it better to start with a simpler, cleaner driver
>> like serial/pxa?
> 
> Co-existing really needs to be fixed.

What are the requirements for co-existence?
Is it sufficient to provide 1st come-1st served minor allocation?

Anything done should be designed to solve this name problem forever,
not some expeditious band-aid.
