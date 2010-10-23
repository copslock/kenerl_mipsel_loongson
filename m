Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Oct 2010 08:03:59 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:55483 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490973Ab0JWGD4 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Oct 2010 08:03:56 +0200
Received: by wwb39 with SMTP id 39so998435wwb.24
        for <multiple recipients>; Fri, 22 Oct 2010 23:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DV7Fk1KnoQRrUCAF3BoeLloPAgXdbvpHA8Z2kfvnf5M=;
        b=MHXAGMbOUAXXF+qqEYsm6V4ZdP5v80g89dPkqZpLNMs3+sxhLq3AZlbfvObrCFXDfx
         Zbci4D+vP8h6O6qg67c7zUIPcqDJAMzTXgiY7R7Sg6p6R6K5RinSn7XXyKJtUsc5hB6L
         PGzUApbSuZ3O0HvHYrGJzv/e+LnKXURED3f98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=q/E+kbuskX1qbTGiaoBrcwUp3i7jrKYmi3H3u90OdCo2N7uM3rKVEBaBLubD6g0kSq
         6t0UJTHDhFor+yFeLETLGM+fwvii62P6JAu6c5ei88oV+POtHhnGE7E1TkcitTFoLg4T
         NcH/xnz0y0yYlPEuYjPP1t8sQNQ5OlJ65Ck6A=
MIME-Version: 1.0
Received: by 10.216.165.16 with SMTP id d16mr3608042wel.0.1287813831187; Fri,
 22 Oct 2010 23:03:51 -0700 (PDT)
Received: by 10.216.176.203 with HTTP; Fri, 22 Oct 2010 23:03:51 -0700 (PDT)
In-Reply-To: <1287783116.16971.642.camel@gandalf.stny.rr.com>
References: <cover.1287779153.git.wuzhangjin@gmail.com>
        <485f5af61fae72dc9c1f0e31b1b5f1f57a5e7ed8.1287779153.git.wuzhangjin@gmail.com>
        <4CC1FDB1.8050404@caviumnetworks.com>
        <1287783116.16971.642.camel@gandalf.stny.rr.com>
Date:   Sat, 23 Oct 2010 14:03:51 +0800
Message-ID: <AANLkTims_AE5ZwXnBntO8c12+jnoy0-_dtCyPo=1pP4M@mail.gmail.com>
Subject: Re: [RFC 2/2] MIPS: tracing/ftrace: Fixes mcount_regex for modules
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sat, Oct 23, 2010 at 5:31 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Fri, 2010-10-22 at 14:10 -0700, David Daney wrote:
>> On 10/22/2010 01:58 PM, Wu Zhangjin wrote:
>> > From: Wu Zhangjin<wuzhangjin@gmail.com>
>> >
>> > In some situations(with related kernel config and gcc options), the
>> > modules may have the same address space as the core kernel space, so
>> > mcount_regex for modules should also match R_MIPS_26.
>> >
>>
>> I think Steve is rewriting this bit to be a pure C program.

Good reminder, thanks ;-)

Just found "[GIT PULL][2.6.37] ftrace: C version of recordmcount".

>>  Is this
>> file even used anymore?  If so for how long?
>
> It's already in mainline, but is only supported for x86 for now. Until
> we verify that it works for other archs (which is up to you guys to
> verify) the script will still be used.
>

I will verify it asap.

Thanks & Regards,
Wu Zhangjin

> Also, I did not write it, John Reiser did. I just cleaned it up a bit
> and got it working with the build system.
>
> -- Steve
>
>
>
