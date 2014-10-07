Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 02:11:45 +0200 (CEST)
Received: from mail-la0-f44.google.com ([209.85.215.44]:40878 "EHLO
        mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010553AbaJGALoEKh-q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 02:11:44 +0200
Received: by mail-la0-f44.google.com with SMTP id gb8so5401402lab.31
        for <linux-mips@linux-mips.org>; Mon, 06 Oct 2014 17:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ov/lKbYSjHb27Kt8sR3h7FnPXHwZxHdoj7A63lShRdw=;
        b=ydKecSzJfz+tEcWtcsiuH8OwysdprAtIk+dAzEPjaSCD4CBls7+R5gD8GPIcEtPtjb
         mOPL78wzTELdNwcIKO3zJ6dtTqtGFwxtZYdFgD9WKZYBZoF7LeZaCS3HwwsQFS8RUm40
         mSuLbieNudg264JNWJpOwk1ILNzrgpeIuH+kBHtMzlu7asgzcvixNADZQWzAKFRXqHaj
         H1BMpzON67FMVvS3ADxfqb9mWEgyTEAF47m6qcioQNgIKHfwRwxPLorThwf5WoS4DlN1
         NPasZd4JJuSZCMqSeKFVZvbpV0na8GQ3rz3oznVCXeLpbPbcDkzXWFtwZNQdJzb9v5Ja
         mKBg==
MIME-Version: 1.0
X-Received: by 10.112.13.10 with SMTP id d10mr179034lbc.10.1412640698499; Mon,
 06 Oct 2014 17:11:38 -0700 (PDT)
Received: by 10.25.213.80 with HTTP; Mon, 6 Oct 2014 17:11:38 -0700 (PDT)
In-Reply-To: <20141007000514.GD23797@brightrain.aerifal.cx>
References: <1412627010-4311-1-git-send-email-ddaney.cavm@gmail.com>
        <20141006205459.GZ23797@brightrain.aerifal.cx>
        <5433071B.4050606@caviumnetworks.com>
        <20141006213101.GA23797@brightrain.aerifal.cx>
        <54330D79.80102@caviumnetworks.com>
        <20141006215813.GB23797@brightrain.aerifal.cx>
        <543327E7.4020608@amacapital.net>
        <54332A64.5020605@caviumnetworks.com>
        <20141007000514.GD23797@brightrain.aerifal.cx>
Date:   Mon, 6 Oct 2014 17:11:38 -0700
Message-ID: <CA+=Sn1nR2ugXUf=V9F9O6VLAP1d6WhBDioZzu0G05-8z6KMMuA@mail.gmail.com>
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
X-archive-position: 42980
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

On Mon, Oct 6, 2014 at 5:05 PM, Rich Felker <dalias@libc.org> wrote:
> On Mon, Oct 06, 2014 at 04:48:52PM -0700, David Daney wrote:
>> On 10/06/2014 04:38 PM, Andy Lutomirski wrote:
>> >On 10/06/2014 02:58 PM, Rich Felker wrote:
>> >>On Mon, Oct 06, 2014 at 02:45:29PM -0700, David Daney wrote:
>> [...]
>> >>This is a huge ill-designed mess.
>> >
>> >Amen.
>> >
>> >Can the kernel not just emulate the instructions directly?
>>
>> In theory it could, but since there can be implementation defined
>> instructions, there is no way to achieve full instruction set
>> coverage for all possible machines.
>
> Is the issue really implementation-defined instructions with delay
> slots? If so it sounds like a made-up issue. They're not going to
> occur in real binaries. Certainly a compiler is not going to generate
> implementation-defined instructions, and if you're writing the asm by
> hand, you just don't put floating point instructions in the delay
> slot.

It is not the instruction with delay slot but rather the instruction
in the delay slot itself.

Thanks,
Andrew
