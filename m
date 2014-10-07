Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 02:28:09 +0200 (CEST)
Received: from mail-lb0-f169.google.com ([209.85.217.169]:45034 "EHLO
        mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010553AbaJGA2IfBY09 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 02:28:08 +0200
Received: by mail-lb0-f169.google.com with SMTP id 10so5230320lbg.0
        for <linux-mips@linux-mips.org>; Mon, 06 Oct 2014 17:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1rnd2Ag9AoVdaBFWn94/wPATV5yFZRSBnQb0aEIDAk0=;
        b=o9j7+A2Ktn5LBtLZ/WhHuHJ+s1jZCIIgP09MjEfQrO4NLx1jwIMRi/y748873tluva
         UmSLbEsjnxuKjpsFVHBB01GeoQRea/i1+wEdSF3RGzVt615oC1a7DDLP9YmuedMGvpj0
         42BnjK8tnS5AUjfBX10k+EY64sucZBypOUjPob9MbroRVvYqZZbJZa++JosiEuNbjMzR
         5SKqEjORzMKXAJV5GdE0YH21TOvBs/TsH9v8VydOUlvDJ+HB0gmK/HnAhJC6C5rOrwbe
         hprD8xZo/YrqO6erB4dEvou8ph7M0m5KqcLT522RJJxQx0g5+9roxppiRsOWQqZoOSCr
         5YnQ==
MIME-Version: 1.0
X-Received: by 10.112.126.194 with SMTP id na2mr222165lbb.70.1412641682901;
 Mon, 06 Oct 2014 17:28:02 -0700 (PDT)
Received: by 10.25.213.80 with HTTP; Mon, 6 Oct 2014 17:28:02 -0700 (PDT)
In-Reply-To: <20141007002147.GE23797@brightrain.aerifal.cx>
References: <1412627010-4311-1-git-send-email-ddaney.cavm@gmail.com>
        <20141006205459.GZ23797@brightrain.aerifal.cx>
        <5433071B.4050606@caviumnetworks.com>
        <20141006213101.GA23797@brightrain.aerifal.cx>
        <54330D79.80102@caviumnetworks.com>
        <20141006215813.GB23797@brightrain.aerifal.cx>
        <543327E7.4020608@amacapital.net>
        <54332A64.5020605@caviumnetworks.com>
        <20141007000514.GD23797@brightrain.aerifal.cx>
        <CA+=Sn1nR2ugXUf=V9F9O6VLAP1d6WhBDioZzu0G05-8z6KMMuA@mail.gmail.com>
        <20141007002147.GE23797@brightrain.aerifal.cx>
Date:   Mon, 6 Oct 2014 17:28:02 -0700
Message-ID: <CA+=Sn1n_S-JT1pZwMtDGM+Vkbp7rsg4bPAeESwJpSkbx8vqn5g@mail.gmail.com>
Subject: Re: [PATCH resend] MIPS: Allow FPU emulator to use non-stack area.
From:   Andrew Pinski <pinskia@gmail.com>
To:     Rich Felker <dalias@libc.org>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Daney <ddaney.cavm@gmail.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <pinskia@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pinskia@gmail.com
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

On Mon, Oct 6, 2014 at 5:21 PM, Rich Felker <dalias@libc.org> wrote:
> On Mon, Oct 06, 2014 at 05:11:38PM -0700, Andrew Pinski wrote:
>> On Mon, Oct 6, 2014 at 5:05 PM, Rich Felker <dalias@libc.org> wrote:
>> > On Mon, Oct 06, 2014 at 04:48:52PM -0700, David Daney wrote:
>> >> On 10/06/2014 04:38 PM, Andy Lutomirski wrote:
>> >> >On 10/06/2014 02:58 PM, Rich Felker wrote:
>> >> >>On Mon, Oct 06, 2014 at 02:45:29PM -0700, David Daney wrote:
>> >> [...]
>> >> >>This is a huge ill-designed mess.
>> >> >
>> >> >Amen.
>> >> >
>> >> >Can the kernel not just emulate the instructions directly?
>> >>
>> >> In theory it could, but since there can be implementation defined
>> >> instructions, there is no way to achieve full instruction set
>> >> coverage for all possible machines.
>> >
>> > Is the issue really implementation-defined instructions with delay
>> > slots? If so it sounds like a made-up issue. They're not going to
>> > occur in real binaries. Certainly a compiler is not going to generate
>> > implementation-defined instructions, and if you're writing the asm by
>> > hand, you just don't put floating point instructions in the delay
>> > slot.
>>
>> It is not the instruction with delay slot but rather the instruction
>> in the delay slot itself.
>
> An instruction in the delay slot for the instruction being emulated?
> How would that arise? Are there floating point instructions with delay
> slots?

Yes branches.
