Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Apr 2015 17:33:16 +0200 (CEST)
Received: from mail-qg0-f49.google.com ([209.85.192.49]:36021 "EHLO
        mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009755AbbDBPdNV2dRF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Apr 2015 17:33:13 +0200
Received: by qgeb100 with SMTP id b100so31772135qge.3
        for <linux-mips@linux-mips.org>; Thu, 02 Apr 2015 08:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=NSbSeWvNHKb2Dz/W0mzpFYk+CRZiTD5aI6wFBJx/FU8=;
        b=hb03UnTJCu9QrMtK3xwGZWEM2aIaEqPqAUGYPuD9T7LVDgAYN1Q63g1Ky3bP6giaX9
         I3OLqKVKSs28OsjXkJ9Nx7rO5ZXyF37B7k8bklDayOqLfyQs8lr62xo5YGAnlys0hIIS
         D9Xfc9sygKbeu0PRyQxsW8kvSMLyUAT3Nx4+QlObYTl9+6h2JRtwWKE7q5b0f1SSjwEs
         W8dqBvyMI1aOeWmwkoZa2ET33J3S33TDmpeIjH83cS9Srrdky1YbZ3gtHxaXlT12WrHJ
         Doo6TB+R8NsxqUdJiN3kOAMR8KdxSqVVfxdq1+kEG2NqRtIGPHohrXUF/g3nmycbtfXR
         5/EQ==
X-Gm-Message-State: ALoCoQkympctFs5JJIN6qOYVG7nW8izsBwWsHtNTggQE3moKfqYeCaGeIlWTAguvZKJ/GnyLq26v
X-Received: by 10.55.22.194 with SMTP id 63mr15566942qkw.3.1427988788436;
        Thu, 02 Apr 2015 08:33:08 -0700 (PDT)
Received: from [192.168.1.139] (h96-61-87-245.cntcnh.dsl.dynamic.tds.net. [96.61.87.245])
        by mx.google.com with ESMTPSA id z77sm3660877qkg.44.2015.04.02.08.33.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2015 08:33:07 -0700 (PDT)
Message-ID: <551D612E.4000808@hurleysoftware.com>
Date:   Thu, 02 Apr 2015 11:33:02 -0400
From:   Peter Hurley <peter@hurleysoftware.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Grant Likely <grant.likely@linaro.org>
CC:     Kevin Cernekee <cernekee@gmail.com>, gregkh@linuxfoundation.org,
        jslaby@suse.cz, robh@kernel.org, arnd@arndb.de,
        f.fainelli@gmail.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH V3 5/7] serial: earlycon: Set UPIO_MEM32BE based on DT
 properties
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>       <1416872182-6440-6-git-send-email-cernekee@gmail.com>   <54F3914F.3080905@hurleysoftware.com>   <20150328013604.488A0C4091F@trevor.secretlab.ca>        <5516DE64.6000104@hurleysoftware.com> <20150402133250.740C1C408D6@trevor.secretlab.ca>
In-Reply-To: <20150402133250.740C1C408D6@trevor.secretlab.ca>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <peter@hurleysoftware.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46707
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

On 04/02/2015 09:32 AM, Grant Likely wrote:
> On Sat, 28 Mar 2015 13:01:24 -0400
> , Peter Hurley <peter@hurleysoftware.com>
>  wrote:
>> Hi Grant,
>>
>> On 03/27/2015 09:36 PM, Grant Likely wrote:
>>> On Sun, 01 Mar 2015 17:23:11 -0500
>>> , Peter Hurley <peter@hurleysoftware.com>
>>>  wrote:
>>>> Hi Kevin,
>>>>
>>>> On 11/24/2014 06:36 PM, Kevin Cernekee wrote:
>>>>> If an earlycon (stdout-path) node is being used, check for "big-endian"
>>>>> or "native-endian" properties and pass the appropriate iotype to the
>>>>> driver.
>>>>>
>>>>> Note that LE sets UPIO_MEM (8-bit) but BE sets UPIO_MEM32BE (32-bit).  The
>>>>> big-endian property only really makes sense in the context of 32-bit
>>>>> registers, since 8-bit accesses never require data swapping.
>>>>>
>>>>> At some point, the of_earlycon code may want to pass in the reg-io-width,
>>>>> reg-offset, and reg-shift parameters too.
>>>>>
>>>>> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
>>>>> ---
>>>>>  drivers/of/fdt.c              | 7 ++++++-
>>>>>  drivers/tty/serial/earlycon.c | 4 ++--
>>>>>  include/linux/serial_core.h   | 2 +-
>>>>>  3 files changed, 9 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>>>>> index 658656f..9d21472 100644
>>>>> --- a/drivers/of/fdt.c
>>>>> +++ b/drivers/of/fdt.c
>>>>> @@ -794,6 +794,8 @@ int __init early_init_dt_scan_chosen_serial(void)
>>>>>  
>>>>>  	while (match->compatible[0]) {
>>>>>  		unsigned long addr;
>>>>> +		unsigned char iotype = UPIO_MEM;
>>>>> +
>>>>>  		if (fdt_node_check_compatible(fdt, offset, match->compatible)) {
>>>>>  			match++;
>>>>>  			continue;
>>>>> @@ -803,7 +805,10 @@ int __init early_init_dt_scan_chosen_serial(void)
>>>>>  		if (!addr)
>>>>>  			return -ENXIO;
>>>>>  
>>>>> -		of_setup_earlycon(addr, match->data);
>>>>> +		if (of_fdt_is_big_endian(fdt, offset))
>>>>> +			iotype = UPIO_MEM32BE;
>>>>> +
>>>>> +		of_setup_earlycon(addr, iotype, match->data);
>>>>
>>>> I know these got ACKs already but as you point out in the commit log,
>>>> earlycon _will_ need reg-io-width, reg-offset and reg-shift. Since the
>>>> distinction between early_init_dt_scan_chosen_serial() and
>>>> of_setup_earlycon() is arbitrary, I'd rather see of_setup_earlycon()
>>>> taught to properly decode of_serial driver bindings instead of a
>>>> stack of parameters to of_setup_earlycon().
>>>>
>>>> In fact, this patch allows a mis-defined devicetree to bring up a
>>>> functioning earlycon because the 'big-endian' property is directly
>>>> associated with UPIO_MEM32BE, which will create incompatibility problems
>>>> when DT earlycon is fixed to decode the of_serial DT bindings.
>>>
>>> That's a good point. This hasn't been merged yet, so there isn't any
>>> impact on addressing this. I would propose that for consistency, the
>>> earlycon code should always default to 8-bit access. if big-endian
>>> accesses are required, then reg-io-width + big-endian must be specified.
>>>
>>> Something like the following would do it and would be future-proof. We
>>> can add support for 16 or 64bit big or little endian access if it ever
>>> became necessary.
>>
>> I was planning on adding MEM32BE support to OF earlycon on top of my
>> patch series 'OF earlycon cleanup', which adds full support for the
>> of_serial driver DT properties (among other things).
>>
>> Unfortunately, that series is waiting on two things:
>> 1. libfdt upstream patch, which I submitted but was referred back to me
>> to add test cases. That was 3 weeks ago and I simply haven't had a free
>> day to burn to figure out how their test matrix is organized. I don't
>> think that's going to change anytime soon; I might just abandon that patch
>> and do the string manipulation on the stack.
>>
>> ATM, earlycon is still broken if stdout-path options have been set.
> 
> I don't seem to have that patch. Can you send it to me please?

Will do.

> I do have a thought though. Would it be better to teach
> fdt_path_offset() to recognize the ':' delimiter?  It's never a valid
> character for a path.
>
> The unittests are easy. "make check" builds and runs them. Adding a test
> is as simple as editing tests/parent_offset.c. main() calls check_path()
> several times to test calls to fdt_path_offset(). The tests can be added
> directly to that file.

Well, the patch reimplements fdt_path_offset() in terms of a new
length-limited function, fdt_path_offset_namelen(). So the existing tests
of fdt_path_offset() are already exercising the patch.

The issue is that the unit tests for fdt_path_offset_namelen() will need
additional nodes and properties defined to properly test the functionality,
and it's not clear to which fdt files these changes are required.

Not that I can't figure it out, but right now, I just have way more
pressing matters, like outstanding regressions and the 8250 split, both
of which are overdue.

Regards,
Peter Hurley
