Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Feb 2015 11:44:52 +0100 (CET)
Received: from mail-we0-f180.google.com ([74.125.82.180]:46489 "EHLO
        mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007588AbbB0KouhcXP2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Feb 2015 11:44:50 +0100
Received: by wevm14 with SMTP id m14so19194948wev.13;
        Fri, 27 Feb 2015 02:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=i7M2wf7R4Ozv9QzKbKk6jV4ZuauIe8fTV6WcTI27VrY=;
        b=PRN0+xYQmgPn6F9JgbJUoCi0JM+BQ/HptpPIQBZcUuKvD80NxXgKTpxh9oYQCfmnkC
         5Ewpq0CkU5nDo8/Tah4sXkOMy9zidhZuQb5DCczolPM5laWOFFFKwak4/26mtMYsSCqD
         JQK0jaDzpjGBvCHZpHWh5N56jsEM65CDrDZZ75ikoa6OP6tkKKwFVYSoJAPwP8vgfkyI
         TtM0cCcX0YHXCWz1iutPyRKyMf80t9xrR/svOvO5smf//q2EXuzBNmDIfPWdnwSu+Q9O
         +c7N0jCThjIs00JwnHMdFtTGYU5CtxGGpmY2PpFbMNIXmA9dcUzTAmDC42J79a754Br1
         TXsA==
MIME-Version: 1.0
X-Received: by 10.180.19.193 with SMTP id h1mr5246095wie.2.1425033885750; Fri,
 27 Feb 2015 02:44:45 -0800 (PST)
Received: by 10.180.89.38 with HTTP; Fri, 27 Feb 2015 02:44:45 -0800 (PST)
In-Reply-To: <CAL1qeaGT9DGnVN4Lg0McCESxuwphLFuoo1m96H5nauRcyF24xg@mail.gmail.com>
References: <6D39441BF12EF246A7ABCE6654B0235320FDC2AC@LEMAIL01.le.imgtec.org>
        <20150226101739.GY17695@NP-P-BURTON>
        <CACUy__Ux6v9O0RmSiUr6vDDJ8JSDPCsCTqm=KOiNM0M=x3hoQQ@mail.gmail.com>
        <CAL1qeaGT9DGnVN4Lg0McCESxuwphLFuoo1m96H5nauRcyF24xg@mail.gmail.com>
Date:   Fri, 27 Feb 2015 11:44:45 +0100
Message-ID: <CACUy__UdCSMW4cLDKMvu3CLBeaKpSbJ19zCMP29hwT+T_y7q4g@mail.gmail.com>
Subject: Re: [U-Boot] MIPS UHI spec
From:   Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
To:     Andrew Bresticker <abrestic@chromium.org>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        John Crispin <blogic@openwrt.org>,
        Jonas Gorski <jogo@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>, cernekee@chromium.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <daniel.schwierzeck@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46041
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.schwierzeck@gmail.com
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

2015-02-26 19:23 GMT+01:00 Andrew Bresticker <abrestic@chromium.org>:
> Hi,
>
> On Thu, Feb 26, 2015 at 4:37 AM, Daniel Schwierzeck
> <daniel.schwierzeck@gmail.com> wrote:
>> 2015-02-26 11:17 GMT+01:00 Paul Burton <paul.burton@imgtec.com>:
>>> On Thu, Feb 19, 2015 at 01:50:23PM +0000, Matthew Fortune wrote:
>>>> Hi Daniel,
>>>>
>>>> The spec for MIPS Unified Hosting Interface is available here:
>>>>
>>>> http://prplfoundation.org/wiki/MIPS_documentation
>>>>
>>>> As we have previously discussed, this is an ideal place to
>>>> define the handover of device tree data from bootloader to
>>>> kernel. Using a0 == -2 and defining which register(s) you
>>>> need for the actual data will fit nicely. I'll happily
>>>> include whatever is decided into the next version of the spec.
>>
>> this originates from an off-list discussion some months ago started by
>> John Crispin.
>>
>> (CC +John, Ralf, Jonas, linux-mips)
>>
>>>
>>> (CC +Andrew, Ezequiel, James, James)
>>>
>>> On the talk of DT handover, this recent patchset adding support for a
>>> system doing so to Linux is relevant:
>>>
>>>     http://www.linux-mips.org/archives/linux-mips/2015-02/msg00312.html
>>>
>>> I'm also working on a system for which I'll need to implement DT
>>> handover very soon. It would be very nice if we could agree on some
>>> standard way of doing so (and eventually if the code on the Linux side
>>> can be generic enough to allow a multiplatform kernel).
>
> +1.  I would like to see this happen as well.
>
>> to be conformant with UHI I propose $a0 == -2 and $a1 == address of DT
>> blob. It is a simple extension and should not interfere with the
>> various legacy boot interfaces.
>>
>> U-Boot mainline code is almost ready for DT handover. I have prepared
>> a patch [1] which completes it by implementing my proposal.
>
> Hmm... we decided to follow the ARM convention here ($a0 = 0, $a1 =
> -1, $a2 = physical address of DTB), which is also what the BMIPS
> platform (submitted by Kevin) is using for DT handover.  Is there
> already a platform using the protocol you described?

no, but with its publication the MIPS UHI spec is kind of official.
AFAIK patches to support UHI in gcc, gdb, U-Boot etc. are already
submitted or prepared. Matthew suggested that new boot protocols
should be compliant with UHI. I think the ARM convention does not fit
to UHI.

> It's still early
> enough that we could change the DT handover for Pistachio, but it
> would be good to agree on something soon.
>
> Thanks,
> Andrew

-- 
- Daniel
