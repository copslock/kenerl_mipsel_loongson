Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Mar 2015 18:01:44 +0100 (CET)
Received: from mail-qc0-f172.google.com ([209.85.216.172]:34022 "EHLO
        mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009332AbbC1RBmh4cmJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Mar 2015 18:01:42 +0100
Received: by qcay5 with SMTP id y5so40685321qca.1
        for <linux-mips@linux-mips.org>; Sat, 28 Mar 2015 10:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=zRQpDff1uUhURc5WPnFwSSgoVzYia6lLHMLcHyAHrVw=;
        b=P18DFgxvQ8KgWcchPaF9lZJd6gb5kxKbTS3+2t5M1Vw1eY2TjfGh9PK/bWS2jILnb0
         t4QEuTjYCSlutiKJh6AWjBwG3kfCVUP1bGqG1CKx+DZvqMTFj0rlO55Yy3/WGltfPgvp
         W21KX5kVnriT05tD2rL/R2QBrZaXBrUtv7jL1bXJHNKtoeOxkxtjTYyNf5iuKOAIthmU
         507qIHotx2QBv1ZyrUOXP72Ce7Ebt9vyj5/1itx0EmHKaDhCoS2tsz/3VY88xB+NW2Uc
         yGEaXUhUIOTCVgNw0FmXHkm8S89kB0IHrBA6dhSJ17Mu5ylfMJhlrdl/uX6WRP1C5Urv
         C2SQ==
X-Gm-Message-State: ALoCoQm7z6VUij8oZnelU+dZWPgZsGOki6dvNs6Tmb1tyh4xsMIXpCJNlXhECZ1vzyaO/LBuKw++
X-Received: by 10.55.21.39 with SMTP id f39mr50323330qkh.44.1427562097876;
        Sat, 28 Mar 2015 10:01:37 -0700 (PDT)
Received: from [192.168.1.139] (h96-61-87-245.cntcnh.dsl.dynamic.tds.net. [96.61.87.245])
        by mx.google.com with ESMTPSA id l204sm3970755qhl.34.2015.03.28.10.01.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2015 10:01:37 -0700 (PDT)
Message-ID: <5516DE64.6000104@hurleysoftware.com>
Date:   Sat, 28 Mar 2015 13:01:24 -0400
From:   Peter Hurley <peter@hurleysoftware.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Grant Likely <grant.likely@linaro.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
CC:     arnd@arndb.de, f.fainelli@gmail.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH V3 5/7] serial: earlycon: Set UPIO_MEM32BE based on DT
 properties
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>       <1416872182-6440-6-git-send-email-cernekee@gmail.com>   <54F3914F.3080905@hurleysoftware.com> <20150328013604.488A0C4091F@trevor.secretlab.ca>
In-Reply-To: <20150328013604.488A0C4091F@trevor.secretlab.ca>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <peter@hurleysoftware.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46573
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

Hi Grant,

On 03/27/2015 09:36 PM, Grant Likely wrote:
> On Sun, 01 Mar 2015 17:23:11 -0500
> , Peter Hurley <peter@hurleysoftware.com>
>  wrote:
>> Hi Kevin,
>>
>> On 11/24/2014 06:36 PM, Kevin Cernekee wrote:
>>> If an earlycon (stdout-path) node is being used, check for "big-endian"
>>> or "native-endian" properties and pass the appropriate iotype to the
>>> driver.
>>>
>>> Note that LE sets UPIO_MEM (8-bit) but BE sets UPIO_MEM32BE (32-bit).  The
>>> big-endian property only really makes sense in the context of 32-bit
>>> registers, since 8-bit accesses never require data swapping.
>>>
>>> At some point, the of_earlycon code may want to pass in the reg-io-width,
>>> reg-offset, and reg-shift parameters too.
>>>
>>> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
>>> ---
>>>  drivers/of/fdt.c              | 7 ++++++-
>>>  drivers/tty/serial/earlycon.c | 4 ++--
>>>  include/linux/serial_core.h   | 2 +-
>>>  3 files changed, 9 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>>> index 658656f..9d21472 100644
>>> --- a/drivers/of/fdt.c
>>> +++ b/drivers/of/fdt.c
>>> @@ -794,6 +794,8 @@ int __init early_init_dt_scan_chosen_serial(void)
>>>  
>>>  	while (match->compatible[0]) {
>>>  		unsigned long addr;
>>> +		unsigned char iotype = UPIO_MEM;
>>> +
>>>  		if (fdt_node_check_compatible(fdt, offset, match->compatible)) {
>>>  			match++;
>>>  			continue;
>>> @@ -803,7 +805,10 @@ int __init early_init_dt_scan_chosen_serial(void)
>>>  		if (!addr)
>>>  			return -ENXIO;
>>>  
>>> -		of_setup_earlycon(addr, match->data);
>>> +		if (of_fdt_is_big_endian(fdt, offset))
>>> +			iotype = UPIO_MEM32BE;
>>> +
>>> +		of_setup_earlycon(addr, iotype, match->data);
>>
>> I know these got ACKs already but as you point out in the commit log,
>> earlycon _will_ need reg-io-width, reg-offset and reg-shift. Since the
>> distinction between early_init_dt_scan_chosen_serial() and
>> of_setup_earlycon() is arbitrary, I'd rather see of_setup_earlycon()
>> taught to properly decode of_serial driver bindings instead of a
>> stack of parameters to of_setup_earlycon().
>>
>> In fact, this patch allows a mis-defined devicetree to bring up a
>> functioning earlycon because the 'big-endian' property is directly
>> associated with UPIO_MEM32BE, which will create incompatibility problems
>> when DT earlycon is fixed to decode the of_serial DT bindings.
> 
> That's a good point. This hasn't been merged yet, so there isn't any
> impact on addressing this. I would propose that for consistency, the
> earlycon code should always default to 8-bit access. if big-endian
> accesses are required, then reg-io-width + big-endian must be specified.
> 
> Something like the following would do it and would be future-proof. We
> can add support for 16 or 64bit big or little endian access if it ever
> became necessary.

I was planning on adding MEM32BE support to OF earlycon on top of my
patch series 'OF earlycon cleanup', which adds full support for the
of_serial driver DT properties (among other things).

Unfortunately, that series is waiting on two things:
1. libfdt upstream patch, which I submitted but was referred back to me
to add test cases. That was 3 weeks ago and I simply haven't had a free
day to burn to figure out how their test matrix is organized. I don't
think that's going to change anytime soon; I might just abandon that patch
and do the string manipulation on the stack.

ATM, earlycon is still broken if stdout-path options have been set.

2. Rob never got back to me on my query [1] to unify the OF_EARLYCON_DECLARE
macro with the EARLYCON_DECLARE macro so that all earlycon consoles
are named.

Regards,
Peter Hurley

[1] https://lkml.org/lkml/2015/3/6/571
