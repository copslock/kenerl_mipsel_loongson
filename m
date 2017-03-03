Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Mar 2017 18:34:12 +0100 (CET)
Received: from mail-qk0-x22f.google.com ([IPv6:2607:f8b0:400d:c09::22f]:33089
        "EHLO mail-qk0-x22f.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993457AbdCCReGDz4Jd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Mar 2017 18:34:06 +0100
Received: by mail-qk0-x22f.google.com with SMTP id n127so187174944qkf.0
        for <linux-mips@linux-mips.org>; Fri, 03 Mar 2017 09:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HPOvI22JupeQVOSdpigFYeMznKuaO2FGEDQq1yw+9dc=;
        b=AJ8zm8HwfbD99MAiVcppCz7NBoHI0qMUMorZ/rBQgb/c3Odwj9e+aIohdaKDABlKRH
         UfOHNVDOQMYq43zReEv4yrAVTHrb6XrUSntxDXDAf7yq+ULafKtvF/9mnabaUVHxULhh
         R3bcHDAfB3UN+0YYoLPfgb4ykgiXP4epU7MFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HPOvI22JupeQVOSdpigFYeMznKuaO2FGEDQq1yw+9dc=;
        b=UxTLXr6DYMKEcAJCurE2TievcsuHYgitGAxIiBPFYtz5NEKT99F34GgBJNxseVbdLV
         A+63lEt3ovwjH4/5ZA+KGTv+LiYVkGkhEJ6Jv31p78xeNAY69RvPvI4FMwkuSRoK1r/l
         9fIlIRp45f0gnaHb7w4REOW7Up6qaM2DH91pf0jrQj9kS3BKiSYlUDLo1HqA+3iDM9CF
         ijDa2ZBXOhuCX793b12dh2DIPb2RQ1qZP7GGVFqpnL/4JqOReRrR+NRF62PQQC8oh/T6
         Mb3m/EjrqXru7W28e3ZkUaIuD4UW5shg9s7K/HCTar9L70scPt/S5jzAyTZTdPWESga5
         6Mcg==
X-Gm-Message-State: AMke39nkYB3eZHo7xKCWWsR4ns9knPcjT+uOECou83YSD4qbeEUepSCxi0F1dxAdBin5iAGX
X-Received: by 10.55.190.129 with SMTP id o123mr4093401qkf.110.1488562439878;
        Fri, 03 Mar 2017 09:33:59 -0800 (PST)
Received: from [10.136.8.252] ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id s75sm8020104qka.36.2017.03.03.09.33.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Mar 2017 09:33:59 -0800 (PST)
Subject: Re: [PATCH v2 1/1] serial: 8250_dw: Allow hardware flow control to be
 used
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        James Hogan <james.hogan@imgtec.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Jason Uy <jason.uy@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Noam Camus <noamc@ezchip.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wang Hongcheng <annie.wang@amd.com>,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-clk@vger.kernel.org, Viresh Kumar <viresh.kumar@st.com>
References: <1484164100-9805-1-git-send-email-jason.uy@broadcom.com>
 <1484164100-9805-2-git-send-email-jason.uy@broadcom.com>
 <CAAG0J9-n0toSJL8Ze8Esq81dYnpfrTd42bMiR94zw_btBLjsww@mail.gmail.com>
 <1488394220.20145.68.camel@linux.intel.com>
 <20170303002129.GS996@jhogan-linux.le.imgtec.org>
 <1488547866.20145.74.camel@linux.intel.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <ab064967-e362-d9be-3040-3260e9b5c426@broadcom.com>
Date:   Fri, 3 Mar 2017 09:33:48 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0
MIME-Version: 1.0
In-Reply-To: <1488547866.20145.74.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <ray.jui@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ray.jui@broadcom.com
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

Hi Andy/Jason,

On 3/3/2017 5:31 AM, Andy Shevchenko wrote:
> Heiko, you might be interested in this as well.
> 
> On Fri, 2017-03-03 at 00:21 +0000, James Hogan wrote:
>> On Wed, Mar 01, 2017 at 08:50:20PM +0200, Andy Shevchenko wrote:
>>> On Wed, 2017-03-01 at 18:02 +0000, James Hogan wrote:
>>>> On 11 January 2017 at 19:48, Jason Uy <jason.uy@broadcom.com>
>>>> wrote:
>>>>> In the most common use case, the Synopsys DW UART driver does
>>>>> not
>>>>> set the set_termios callback function.  This prevents
>>>>> UPSTAT_AUTOCTS
>>>>> from being set when the UART flag CRTSCTS is set.  As a result,
>>>>> the
>>>>> driver will use software flow control as opposed to hardware
>>>>> flow
>>>>> control.
>>>>>
>>>>> To fix the problem, the set_termios callback function is set to
>>>>> the
>>>>> DW specific function.  The logic to set UPSTAT_AUTOCTS is moved
>>>>> so
>>>>> that any clock error will not affect setting the hardware flow
>>>>> control.
>>>> Bisection shows that this patch, commit
>>>> 6a171b29937984a5e0bf29d6577b055998f03edb, has broken boot of the
>>>> Cavium Octeon III based UTM-8 board (MIPS architecture).
>>>>
>>>> I now get the following warning:
>>>> [<ffffffff8149c2e4>] uart_get_baud_rate+0xfc/0x1f0
>>>> [<ffffffff814a5098>] serial8250_do_set_termios+0xb0/0x440
>>>> [<ffffffff8149c710>] uart_set_options+0xe8/0x190
>>>> [<ffffffff814a6cdc>] serial8250_console_setup+0x84/0x158
>>>> [<ffffffff814a11ec>] univ8250_console_setup+0x54/0x70
>>>> [<ffffffff811901a0>] register_console+0x1c8/0x418
>>>> [<ffffffff8149f004>] uart_add_one_port+0x434/0x4b0
>>>> [<ffffffff814a1af8>] serial8250_register_8250_port+0x2d8/0x440
>>>> [<ffffffff814aa620>] dw8250_probe+0x388/0x5e8
>>>> Then it hangs and the watchdog restarts the machine.
>>>>
>>>> Any ideas?
>>>
>>> 1. Does it use clock on that platform?
> 
>> I've now dug a little deeper. Essentially what is going on is:
>>
>> 1) CONFIG_HAVE_CLK=n (Octeon doesn't select it)
>> 2) The CONFIG_HAVE_CLK=n implementation of devm_clk_get() returns NULL
>> 3) The "if (IS_ERR(d->clk) || !old) {" check in dw8250_set_termios()
>>    doesn't match, since !IS_ERR(NULL)
>> 4) The CONFIG_HAVE_CLK=n implementation of clk_round_rate() returns 0
>> 5) The CONFIG_HAVE_CLK=n implementation of clk_set_rate(d->clk, 0)
>>    returns 0
>> 6) dw8250_set_termios() thinks the frequency for that baud rate has
>> been
>>    set successfully and writes 0 into uartclk
>> 7) it all goes wrong from there...
> 
> So, it means we have need special care of NULL case here, and honestly,
> I don't like it. But it seems the only feasible (quick) fix right now.

I agree. I think it should have been:

if (IS_ERR_OR_NULL(d->clk) || !old)
    goto out;

I think it makes sense to validate to make sure the 'clk' pointer is
valid before proceeding any further down below (regardless of how well
or how not well the clock framework handles it).

Thanks,

Ray

> 
>> The CONFIG_HAVE_CLK=n implementation of devm_clk_get() in particular
>> seems highly questionable to me, given that commit 93abe8e4b13a ("clk:
>> add non CONFIG_HAVE_CLK routines") which added it 5 years ago says:
>>
>>> These calls will return error for platforms that don't select
>>> HAVE_CLK
>>
>> And NULL isn't an error in this API.
> 
> Which is okay. I dunno what should be returned from clk_round_rate() if
> clk is NULL. I would fix CLK framework, though I would like to gather
> more details.
> 
> Btw, I hope you also noticed this one:
> 
> http://www.spinics.net/lists/linux-serial/msg25314.html
> 
