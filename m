Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Dec 2010 15:54:30 +0100 (CET)
Received: from gateway01.websitewelcome.com ([69.56.184.19]:55216 "HELO
        gateway01.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491081Ab0LXOy1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Dec 2010 15:54:27 +0100
Received: (qmail 28759 invoked from network); 24 Dec 2010 14:53:35 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway01.websitewelcome.com with SMTP; 24 Dec 2010 14:53:35 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:X-Source:X-Source-Args:X-Source-Dir;
        b=PcPMLr8jqJhaYsVWgBIpjrvP8ufmMWLYnc04sq2rNTFRqg9jot3ZTZqlNfOGl2vrjjYXCRbWYgNV9h/31TpIbLn1LTIinYBWwLW7QKipou1sj3fDnxNl6YQZN+Wr4WnZ;
Received: from [74.125.122.49] (port=35229 helo=kkissell-macbookpro.local)
        by gator750.hostgator.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1PW91f-0006XY-Ro; Fri, 24 Dec 2010 08:53:48 -0600
Message-ID: <4D14B3FA.5080304@paralogos.com>
Date:   Fri, 24 Dec 2010 06:53:46 -0800
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Anoop P A <anoop.pa@gmail.com>
CC:     STUART VENTERS <stuart.venters@adtran.com>,
        "Anoop P.A." <Anoop_P.A@pmc-sierra.com>, linux-mips@linux-mips.org
Subject: Re: SMTC support status in latest git head.
References: <8F242B230AD6474C8E7815DE0B4982D7179FB88D@EXV1.corp.adtran.com>      <4D1492E0.5090407@paralogos.com> <1293201545.27661.55.camel@paanoop1-desktop>
In-Reply-To: <1293201545.27661.55.camel@paanoop1-desktop>
Content-Type: multipart/mixed;
 boundary="------------060200050507040401000609"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------060200050507040401000609
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Excellent!  Now, does the attached patch (relative to 2.6.37.11) also 
fix things, while preserving the other fixes and performance enhancements?

/K.

On 12/24/10 6:39 AM, Anoop P A wrote:
> Hi Kevin, Stuart ,
>
> Woohooo You guys spotted !.
>
>   http://git.linux-mips.org/?p=linux.git;a=commit;h=d5ec6e3c seems to be
> the culprit
>
> Once I restored previous version of stackframe.h 2.6.33-stable started
> booting !.
>
> Thanks,
> Anoop
>
> On Fri, 2010-12-24 at 04:32 -0800, Kevin D. Kissell wrote:
>> Thank you, Stuart!  I've spotted some definite breakage to SMTC between
>> those versions.  In arch/mips/include/asm/stackframe.h, someone moved
>> the store of the Status register value in SAVE_SOME (line 169 or 204,
>> depending on the version) from two instructions after the mfc0 to a
>> point after the #ifdef for SMTC, presumably to get better pipelining of
>> the register access.  Unfortunately, the v1 register is also used in the
>> SMTC-specific fragment to save TCStatus, so the Status value gets
>> clobbered before it gets stored.  This will eventually result in the
>> Status register getting a TCStatus value, which has some bits on common,
>> but isn't identical and sooner or later Bad Things will happen.
>>
>> I'm a little surprised this wasn't caught by visual inspection of the patch.
>>
>> Possible solutions would include reverting the store of the CP0_STATUS
>> value to the block above the #ifdef, or, to retain whatever performance
>> advantage was obtained by moving the store downward, to use v0/$2
>> instead of v1/$3, as the staging register for the TCStatus value.  I'd
>> lean toward the second option, but I'm not in a position to test and
>> submit a patch just now.
>>
>>               Regards,
>>
>>               Kevin K.
>>
>> On 12/23/10 1:09 PM, STUART VENTERS wrote:
>>> Kevin,
>>>
>>> I'm not sure if it's useful,
>>>      but finally I got the time to look at the two kernel versions Anoop pointed out.
>>>       works   2.6.32-stable with patch 804
>>>       works_not 2.6.33-stable
>>>
>>> greping for files with CONFIG_MIPS_MT_SMTC
>>>      and looking for timer interrupt related stuff found the following differences:
>>>
>>>
>>> arch/mips/include/asm/irq.h
>>> arch/mips/kernel/irq.c
>>>     do_IRQ
>>>
>>> arch/mips/include/asm/stackframe.h
>>>     SAVE_SOME SAVE_TEMP get/set_saved_sp
>>>
>>> arch/mips/include/asm/time.h
>>>     clocksource_set_clock
>>>
>>> arch/mips/kernel/process.c
>>>     cpu_idle
>>>
>>> arch/mips/kernel/smtc.c
>>>     __irq_entry
>>>     ipi_decode
>>>         SMTC_CLOCK_TICK
>>>
>>>
>>> Enclosed are the two subsets of files for a more expert look.
>>>
>>> I'll try to look in more detail after Christmas.
>>>
>>>
>>> Cheers,
>>>
>>> Stuart
>>>
>>>
>>>
>>>
>


--------------060200050507040401000609
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="smtc_stackframe.h.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="smtc_stackframe.h.patch"

LS0tIHN0YWNrZnJhbWUuaAkyMDEwLTEyLTI0IDA2OjQ3OjA2LjAwMDAwMDAwMCAtMDgwMAor
Kysgc3RhY2tmcmFtZS5oLnRlc3QJMjAxMC0xMi0yNCAwNjo0ODo1Ni4wMDAwMDAwMDAgLTA4
MDAKQEAgLTE5NSw5ICsxOTUsOSBAQAogCQkgKiB0byBjb3ZlciB0aGUgcGlwZWxpbmUgZGVs
YXkuCiAJCSAqLwogCQkuc2V0CW1pcHMzMgotCQltZmMwCXYxLCBDUDBfVENTVEFUVVMKKwkJ
bWZjMAl2MCwgQ1AwX1RDU1RBVFVTCiAJCS5zZXQJbWlwczAKLQkJTE9OR19TCXYxLCBQVF9U
Q1NUQVRVUyhzcCkKKwkJTE9OR19TCXYwLCBQVF9UQ1NUQVRVUyhzcCkKICNlbmRpZiAvKiBD
T05GSUdfTUlQU19NVF9TTVRDICovCiAJCUxPTkdfUwkkNCwgUFRfUjQoc3ApCiAJCUxPTkdf
UwkkNSwgUFRfUjUoc3ApCg==
--------------060200050507040401000609--
