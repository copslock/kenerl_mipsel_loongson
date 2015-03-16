Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Mar 2015 16:56:12 +0100 (CET)
Received: from mail-qc0-f169.google.com ([209.85.216.169]:36517 "EHLO
        mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008786AbbCPP4ItD5G5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Mar 2015 16:56:08 +0100
Received: by qcto4 with SMTP id o4so47625975qct.3
        for <linux-mips@linux-mips.org>; Mon, 16 Mar 2015 08:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=js+ajterNIEWER+0JsAIS7h1ZWGn/PBLDIiNCRIyQQI=;
        b=b4QPx3Yhn3ZFAKIYYBBFIGaAFNp2NohEk5noR98CcEebFNbLlk/PncuEli3Diy/DSK
         oTDRfalVj+RscrqhVsgUhwhAfnoQUE7zShCrS9nk1WbzbabmminzviVVsMz2UsWPuULu
         tmlVoiemZlrJQHQURtASMawxAdl4xaTjxzHIaAa8YpCK3LwK/oJI4eagTUJlHVNk3SlM
         R9/F5dTphvU/LffkMfYvqWoi8eKTjzS9DP7k6nocjficfZp/2CE2ZFClo5aX/L4Z87KS
         c61xtUDZzOqKQ7DANUA95xFsIdQyHwm/I6zmutU/hCsnMS3lOa6eScdqfQ+xrU7VzfxN
         DlJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=js+ajterNIEWER+0JsAIS7h1ZWGn/PBLDIiNCRIyQQI=;
        b=kP2e+Y7hgBaCPRcGJ//2HJhOJ7pTN4xGdx7IAzdgwaKr2opqOxQE5cXAeeQgS6G1AA
         zhWwfhNfW0v7rY4ct/xEhsScPFmPD2Ru3S6WcDnE15Dzk5wmz/JPcGRW1dNUvVdSsC53
         LOegw3igntbh/iq2Xd+oh1zVwd75PB5Irvj1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=js+ajterNIEWER+0JsAIS7h1ZWGn/PBLDIiNCRIyQQI=;
        b=JYoR5YC6/8Wyj3lv3zuX1bjDK1Ah6/QqLdkDZ6vtyWGODpjEmBE3DRBAyPW3CVW0yS
         AIRYbHOOCGFyEHRUD16mhvG7IpJhvnniTGCZUihqYDT03QZhYTPmT042weleOKieqiO5
         mfdh2maqE/3LnoOM3BaisjiGa3WbTvUd4Na/GznABnTW8/Zky5FzX5B5k0Oq6JiliJ5f
         tTQHp/MOOdVWzNpGWJJQA8tb5gj9deIEN7ZdWqOU/6mzHrFM6iHZnP5XcaAT3NFXJQ12
         flYdAHdqI1rueKFLg/NsXwyfcd5cKA21rmj97VbMy9mdoxhqbFfizChGO2mhH2nKHZlA
         PkmQ==
X-Gm-Message-State: ALoCoQmFGikDxVDqvprkDdYNJcEFky9LwHNGgOlftWyiCCKI1F0mNvP3iDBnHwnSXg/3ebQitwl+
MIME-Version: 1.0
X-Received: by 10.140.151.74 with SMTP id 71mr78529759qhx.15.1426521363846;
 Mon, 16 Mar 2015 08:56:03 -0700 (PDT)
Received: by 10.140.19.72 with HTTP; Mon, 16 Mar 2015 08:56:03 -0700 (PDT)
In-Reply-To: <6D39441BF12EF246A7ABCE6654B023532100679F@LEMAIL01.le.imgtec.org>
References: <6D39441BF12EF246A7ABCE6654B0235320FDC2AC@LEMAIL01.le.imgtec.org>
        <20150226101739.GY17695@NP-P-BURTON>
        <CACUy__Ux6v9O0RmSiUr6vDDJ8JSDPCsCTqm=KOiNM0M=x3hoQQ@mail.gmail.com>
        <5506B0B2.3020606@imgtec.com>
        <6D39441BF12EF246A7ABCE6654B023532100679F@LEMAIL01.le.imgtec.org>
Date:   Mon, 16 Mar 2015 08:56:03 -0700
X-Google-Sender-Auth: uPN1bgIycsCaqQSzNzuzaJT1L6c
Message-ID: <CAL1qeaGqRy_sV8mzM7+8VWipyq1nhbB3SVQpZGAEkPEvKfE=yg@mail.gmail.com>
Subject: Re: [U-Boot] MIPS UHI spec
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>
Cc:     James Hogan <James.Hogan@imgtec.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Paul Burton <Paul.Burton@imgtec.com>,
        "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
        Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>,
        James Hartley <James.Hartley@imgtec.com>,
        John Crispin <blogic@openwrt.org>,
        Jonas Gorski <jogo@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46404
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

On Mon, Mar 16, 2015 at 4:53 AM, Matthew Fortune
<Matthew.Fortune@imgtec.com> wrote:
> James Hogan <James.Hogan@imgtec.com> writes:
>> On 26/02/15 12:37, Daniel Schwierzeck wrote:
>> > 2015-02-26 11:17 GMT+01:00 Paul Burton <paul.burton@imgtec.com>:
>> >> On Thu, Feb 19, 2015 at 01:50:23PM +0000, Matthew Fortune wrote:
>> >>> Hi Daniel,
>> >>>
>> >>> The spec for MIPS Unified Hosting Interface is available here:
>> >>>
>> >>> http://prplfoundation.org/wiki/MIPS_documentation
>> >>>
>> >>> As we have previously discussed, this is an ideal place to define
>> >>> the handover of device tree data from bootloader to kernel. Using a0
>> >>> == -2 and defining which register(s) you need for the actual data
>> >>> will fit nicely. I'll happily include whatever is decided into the
>> >>> next version of the spec.
>> >
>> > this originates from an off-list discussion some months ago started by
>> > John Crispin.
>> >
>> > (CC +John, Ralf, Jonas, linux-mips)
>> >
>> >>
>> >> (CC +Andrew, Ezequiel, James, James)
>> >>
>> >> On the talk of DT handover, this recent patchset adding support for a
>> >> system doing so to Linux is relevant:
>> >>
>> >>
>> >> http://www.linux-mips.org/archives/linux-mips/2015-02/msg00312.html
>> >>
>> >> I'm also working on a system for which I'll need to implement DT
>> >> handover very soon. It would be very nice if we could agree on some
>> >> standard way of doing so (and eventually if the code on the Linux
>> >> side can be generic enough to allow a multiplatform kernel).
>> >>
>> >
>> > to be conformant with UHI I propose $a0 == -2 and $a1 == address of DT
>> > blob. It is a simple extension and should not interfere with the
>> > various legacy boot interfaces.
>>
>> I was just looking at Andrew's patch:
>> http://patchwork.linux-mips.org/patch/9549/
>>
>> How would the other registers (i.e. $a2 and $a3) be defined for this
>> boot interface? I'm guessing any future extensions are envisioned to use
>> a different negative value of $a0, in which case treating them as
>> unused/undefined is fine, but perhaps that should be spelt out in the
>> UHI spec?
>
> Sounds sensible. Making it explicit may help prevent anyone extending this
> and presuming that they can give meaning to one of the unused registers.
>
> Did anyone come to a conclusion on physical vs virtual address for the
> DTB? I forgot to reply to the thread, I would have thought the KSEG0
> address would be the obvious choice so that it is immediately usable from
> ordinary memory accesses. However, that is only because I don't follow how
> the kernel would benefit from being given a physical address. It can't be
> remapped except for the case of segmentation control (I believe) so there
> seems little risk in using KSEG0.

We've changed our bootloader to pass the DTB via KSEG0.  V2 of the
Pistachio platform patches I posted last week used this protocol.

Thanks,
Andrew
