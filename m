Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2015 00:44:22 +0100 (CET)
Received: from mail-wg0-f41.google.com ([74.125.82.41]:41024 "EHLO
        mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011579AbbA2XoUW68je (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2015 00:44:20 +0100
Received: by mail-wg0-f41.google.com with SMTP id a1so24063936wgh.0
        for <linux-mips@linux-mips.org>; Thu, 29 Jan 2015 15:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=l6vyQEc0+NVessDSKZNJci8KMqTVjt90u1TdjW5BI5k=;
        b=oQLHo01e7+d02897iUOn5yZtGvT4T9//n0ETclTtGaG7bPHS1TdrMkAYYH1XgvfA3N
         d/ukGA/ojKL3jamlqCAbdmEPGUoY0hbfQTcFucwa9fLx9AxFXK+DdNL7zCqHuFNnn5k6
         fYvEYQgS+XWK3eEDuZVuAfMTSmWHlqnfarVOvVKUiXU1ti0iQChMMDaGRZeDdd4Tt7SJ
         l2bnlaMMyhkBUGobAPfNKAfV0YXLt6VjCRskkKsx1wjAuRoFKoYWeJy8hMBE2aHf1cJ0
         fXdDQ4ygXDX9yQ0r8cth+YZjXi898/GCP5xGBRVkFkUq3Htc62l+uOPi26dCFbhIKgWL
         TwtA==
X-Received: by 10.181.29.201 with SMTP id jy9mr5912791wid.17.1422575055242;
 Thu, 29 Jan 2015 15:44:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.194.85.49 with HTTP; Thu, 29 Jan 2015 15:43:55 -0800 (PST)
In-Reply-To: <54CABBC3.6000006@gmail.com>
References: <CAKRnqN+Js_zDn==T0+-EGzyTSW4P-dpvB7jKsLmFJEbKhxifJw@mail.gmail.com>
 <54CABBC3.6000006@gmail.com>
From:   Bruce Korb <bruce.korb@gmail.com>
Date:   Thu, 29 Jan 2015 15:43:55 -0800
Message-ID: <CAKRnqNKBCOF0toKNDc8=Y-geA18bzM_7_Mc5HN6jgb40H5OfaA@mail.gmail.com>
Subject: Re: Hardware breakpoints on MIPS
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <bruce.korb@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bruce.korb@gmail.com
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

Thank you!

On Thu, Jan 29, 2015 at 3:01 PM, David Daney <ddaney.cavm@gmail.com> wrote:
>> Anyway, I need to set a hardware breakpoint on a Mips CPU on a "Cavium"
>> platform
>> in a kernel module.
>
> This would appear to be for the most part, completely independent of GDB,

I had guessed as much, but did not have a better guess, either.

> Since many years ago, WatchLo and WatchHi have been under the control of the
> Linux kernel.  If you set these registers and a Watch Exception is
> triggered, it will cause the registers to be cleared and the exception will
> be ignored, unless they were configured via ptrace(2) for userspace
> addresses.

Can a hacked ptrace set it up to panic instead?
All I need is a stack trace once this one single spot in memory gets written.

> For debugging kernel space with watchpoint registers on OCTEON it is
> probably best to use the facilities in the EJTAG unit.

Which, I'll hazard a guess, requires physical access.
I'll have to go begging and pleading for special access to the Hardware Lab.
Please don't ask me why we software types are kept out.
I've not gotten a straight answer, so I could only answer with speculation.


*sigh*.  Thank you.
