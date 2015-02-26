Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Feb 2015 13:37:35 +0100 (CET)
Received: from mail-we0-f177.google.com ([74.125.82.177]:42131 "EHLO
        mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007076AbbBZMhdyUtoV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Feb 2015 13:37:33 +0100
Received: by wesw62 with SMTP id w62so10236324wes.9;
        Thu, 26 Feb 2015 04:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VRbQR9zXB3q1mVRGkPlFrP7fb2eeMRiQ1Nk9v3aQ8Wc=;
        b=MOc6kLHd83tyWBUyCgPeW3LfVXFVSjRmA3ZZk2PgL+pgeJKaIFvljK/4p8DOs9G0Cc
         GD86/ufI20E85wsBmRMM++JqSHeYU9QdTqS8R3AAgP9kaR4hApMuRi0s+GhfbIWf4ihD
         ASalrg4/RVdU/eU7l9ezmmcPGMfciHE3eQGQp+Ini5u19GVgIExVXaHIBnnkds4yyutU
         e/B+q0PyNrYTuxh825Dstg07lA4asGfukC55GnPHhmee1l8klQgrQ62iPnTRPSU/KBe3
         fFLiJzsO0iDYdTcKVtH7KCQ9R/qAM+KMYZOUDJYC02ulqgt8m++2OcYuUrOscC6gidSv
         H7gQ==
MIME-Version: 1.0
X-Received: by 10.194.109.9 with SMTP id ho9mr16013381wjb.29.1424954249050;
 Thu, 26 Feb 2015 04:37:29 -0800 (PST)
Received: by 10.180.89.38 with HTTP; Thu, 26 Feb 2015 04:37:28 -0800 (PST)
In-Reply-To: <20150226101739.GY17695@NP-P-BURTON>
References: <6D39441BF12EF246A7ABCE6654B0235320FDC2AC@LEMAIL01.le.imgtec.org>
        <20150226101739.GY17695@NP-P-BURTON>
Date:   Thu, 26 Feb 2015 13:37:28 +0100
Message-ID: <CACUy__Ux6v9O0RmSiUr6vDDJ8JSDPCsCTqm=KOiNM0M=x3hoQQ@mail.gmail.com>
Subject: Re: [U-Boot] MIPS UHI spec
From:   Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Matthew Fortune <Matthew.Fortune@imgtec.com>,
        "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
        Andrew Bresticker <abrestic@chromium.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        John Crispin <blogic@openwrt.org>,
        Jonas Gorski <jogo@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <daniel.schwierzeck@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45999
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

2015-02-26 11:17 GMT+01:00 Paul Burton <paul.burton@imgtec.com>:
> On Thu, Feb 19, 2015 at 01:50:23PM +0000, Matthew Fortune wrote:
>> Hi Daniel,
>>
>> The spec for MIPS Unified Hosting Interface is available here:
>>
>> http://prplfoundation.org/wiki/MIPS_documentation
>>
>> As we have previously discussed, this is an ideal place to
>> define the handover of device tree data from bootloader to
>> kernel. Using a0 == -2 and defining which register(s) you
>> need for the actual data will fit nicely. I'll happily
>> include whatever is decided into the next version of the spec.

this originates from an off-list discussion some months ago started by
John Crispin.

(CC +John, Ralf, Jonas, linux-mips)

>
> (CC +Andrew, Ezequiel, James, James)
>
> On the talk of DT handover, this recent patchset adding support for a
> system doing so to Linux is relevant:
>
>     http://www.linux-mips.org/archives/linux-mips/2015-02/msg00312.html
>
> I'm also working on a system for which I'll need to implement DT
> handover very soon. It would be very nice if we could agree on some
> standard way of doing so (and eventually if the code on the Linux side
> can be generic enough to allow a multiplatform kernel).
>

to be conformant with UHI I propose $a0 == -2 and $a1 == address of DT
blob. It is a simple extension and should not interfere with the
various legacy boot interfaces.

U-Boot mainline code is almost ready for DT handover. I have prepared
a patch [1] which completes it by implementing my proposal.

[1] http://git.denx.de/?p=u-boot/u-boot-mips.git;a=commitdiff;h=3464e8de491c640d14d72853a741cc367ebabc79

-- 
- Daniel
