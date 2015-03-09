Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Mar 2015 18:04:56 +0100 (CET)
Received: from mail-qc0-f172.google.com ([209.85.216.172]:44266 "EHLO
        mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008440AbbCIREzHceqJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Mar 2015 18:04:55 +0100
Received: by qcwr17 with SMTP id r17so3790945qcw.11
        for <linux-mips@linux-mips.org>; Mon, 09 Mar 2015 10:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=sXuw7hX4v9tkaayH4hzxoI+HyfWj0LVAgFqG/E34Lyk=;
        b=CxFS7uSlViynQ5AaqjCzX7byoFL9BQve9xIVdr/7JgTS1IXbo7CAUMsCqmW1bC4Qun
         ZRGzbvRPvXbpRO5VMeTKhlYVJPaqvbtt8i5DW2c7OFobDwSX/rgk7r43OeUUJiUwNy/7
         ZOzjmi3R9WPC1CVWyGn8eEr62X9NFvGppcIKHyqhWhzhrPM4uGi4tgjFVwHsfU3AevPV
         ttyA96PIff9vWx3JZFXj9B7f5ttMN8GBNk0f0WHMqkaHuFS4OkGIl1UzTWvuRhakEDlV
         zdwsbxxzftRqZsG7UmOqxiDtqE4ZSK9rV5EmF8jUjFYZEP/JYWbf3SeyU45xm9+xKqY1
         2chw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=sXuw7hX4v9tkaayH4hzxoI+HyfWj0LVAgFqG/E34Lyk=;
        b=Z7tnUnKz28pm62MClxXyK6pxUU7KERcgtYNMA82ZoeheUVuufXyUMY/5YawPQ7YZka
         7hH4Rha+74f8ULRZ1C6gHHU8u8pNzn5Y3JOPETpPtB5yrGZxc4195v2i+L8bdXSkz9/E
         Ltj5jfuPSH2O1L1RFZh/62vZmZUaQh5p/bzoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=sXuw7hX4v9tkaayH4hzxoI+HyfWj0LVAgFqG/E34Lyk=;
        b=kQiAWTnCb0W0oDJvAzx0amphYUr+KDrd106EpIFSehX7loLXGdq8jdZmPXIryjkvU2
         QhMhyqCVpCGdw7Xa2Bp0SqPxHjMGwgemRH5hUM3Lr+PFb7O4OZkh1TS+M1dbcEBFhae+
         EsUndLfAvH81X6wG8riKaMU1ooRe9uO1xoLt4FxSmgkVltmD0NgMQuIrhAyN5hjza6qu
         Fc3jsjWNfiekCEFXjhkZmIUO571bIeO+ujEgvvdzyWC6ufQCeZMUoGFcPydOM3ZPWw+E
         cN6RTHuiE6v807CoBhQ5OPJ+r0Zn4Ss4Gt08k7Sn3jJyN1D1CeBzzJPP681DGNNQlYJ9
         KmwA==
X-Gm-Message-State: ALoCoQnnsEV/yRrjderTDuCpENS9O1MntUHBkQLfC8HBENC5KmjvKrobJ7Sdosx+juRN4X+eNjoD
MIME-Version: 1.0
X-Received: by 10.140.91.71 with SMTP id y65mr35134519qgd.90.1425920689435;
 Mon, 09 Mar 2015 10:04:49 -0700 (PDT)
Received: by 10.140.19.72 with HTTP; Mon, 9 Mar 2015 10:04:49 -0700 (PDT)
In-Reply-To: <CACUy__Ux6v9O0RmSiUr6vDDJ8JSDPCsCTqm=KOiNM0M=x3hoQQ@mail.gmail.com>
References: <6D39441BF12EF246A7ABCE6654B0235320FDC2AC@LEMAIL01.le.imgtec.org>
        <20150226101739.GY17695@NP-P-BURTON>
        <CACUy__Ux6v9O0RmSiUr6vDDJ8JSDPCsCTqm=KOiNM0M=x3hoQQ@mail.gmail.com>
Date:   Mon, 9 Mar 2015 10:04:49 -0700
X-Google-Sender-Auth: 4Lte__QhenZ-kjeW2VT5dSb12hU
Message-ID: <CAL1qeaFPQvaS6OaaSdcQc-yGevwnH6OXSUK4b0QSoW2iAAForg@mail.gmail.com>
Subject: Re: [U-Boot] MIPS UHI spec
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        John Crispin <blogic@openwrt.org>,
        Jonas Gorski <jogo@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

Hi Daniel,

On Thu, Feb 26, 2015 at 4:37 AM, Daniel Schwierzeck
<daniel.schwierzeck@gmail.com> wrote:
> 2015-02-26 11:17 GMT+01:00 Paul Burton <paul.burton@imgtec.com>:
>> On Thu, Feb 19, 2015 at 01:50:23PM +0000, Matthew Fortune wrote:
>>> Hi Daniel,
>>>
>>> The spec for MIPS Unified Hosting Interface is available here:
>>>
>>> http://prplfoundation.org/wiki/MIPS_documentation
>>>
>>> As we have previously discussed, this is an ideal place to
>>> define the handover of device tree data from bootloader to
>>> kernel. Using a0 == -2 and defining which register(s) you
>>> need for the actual data will fit nicely. I'll happily
>>> include whatever is decided into the next version of the spec.
>
> this originates from an off-list discussion some months ago started by
> John Crispin.
>
> (CC +John, Ralf, Jonas, linux-mips)
>
>>
>> (CC +Andrew, Ezequiel, James, James)
>>
>> On the talk of DT handover, this recent patchset adding support for a
>> system doing so to Linux is relevant:
>>
>>     http://www.linux-mips.org/archives/linux-mips/2015-02/msg00312.html
>>
>> I'm also working on a system for which I'll need to implement DT
>> handover very soon. It would be very nice if we could agree on some
>> standard way of doing so (and eventually if the code on the Linux side
>> can be generic enough to allow a multiplatform kernel).
>>
>
> to be conformant with UHI I propose $a0 == -2 and $a1 == address of DT
> blob. It is a simple extension and should not interfere with the
> various legacy boot interfaces.

Just to be clear, is $a1 expected to be the physical or virtual
(KSEG0) address of the DTB?

Thanks,
Andrew
