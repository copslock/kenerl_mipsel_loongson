Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 May 2012 14:08:49 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:50748 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903591Ab2EMMIn convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 13 May 2012 14:08:43 +0200
Received: by obqv19 with SMTP id v19so7800034obq.36
        for <multiple recipients>; Sun, 13 May 2012 05:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ytdRRn7pEuKBGQzNJZ319PZvoLwhT8DZVb1hT8DWvKs=;
        b=Rw1L87avCdV9FS4rpNKqKxY9zrYkPYyIUYzGhMM1cYeptUrcMbkJNqmqbOlDF0pmfQ
         LkFuw6XU5L+cHk/J2u0zFAbZvvbU6iExDsXZM/dqWk57nnnLxNkhLOE3gIXFDAMSqyBp
         x018QGKEq7I43+a0OmWIyrUVanwSpENg1cBlyltev8atTR7vlROZoLEfcwKYBWpCUH7H
         EbHE5pKqAsjsqT7Ww8QM4y1czgBnX6Rhfi/OLNchxQsTcKUD6Qhb35QPAy4a3qDxt42V
         EW2cBwIeaoWgxLyw/p32HUFVlu3Un5T+ELj8hziarQut5s48MqWGrWckusaKpPcBpHik
         MR5g==
Received: by 10.60.19.129 with SMTP id f1mr6704575oee.1.1336910916836; Sun, 13
 May 2012 05:08:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.169.138 with HTTP; Sun, 13 May 2012 05:08:16 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1205060950090.3701@eddie.linux-mips.org>
References: <1335534510-12573-1-git-send-email-dedekind1@gmail.com>
 <4F9AD14E.9060008@gmail.com> <alpine.LFD.2.00.1205060754390.19691@eddie.linux-mips.org>
 <1336289676.1996.3.camel@koala> <alpine.LFD.2.00.1205060925070.3701@eddie.linux-mips.org>
 <1336293478.2801.4.camel@brekeke> <alpine.LFD.2.00.1205060950090.3701@eddie.linux-mips.org>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Sun, 13 May 2012 14:08:16 +0200
Message-ID: <CAOiHx=k75NsRWSsDNBd+1CVBwGYK6xHMZV_hrcfrs44OM_dFRg@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: Kbuild: remove -Werror
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 33287
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi,
On 6 May 2012 11:14, Maciej W. Rozycki <macro@linux-mips.org> wrote:
> On Sun, 6 May 2012, Artem Bityutskiy wrote:
>
>> >  And my opinion is based on experience.  Please check the LMO archives for
>> > why Ralf added this option in the first place -- many years ago.  It's
>> > probably recorded in the git repository too (I'm not sure if the option
>> > was added before or after we moved away from CVS, but in any case old
>> > change logs have been imported when our current repo was created).
>>
>> We need to figure out how to make -Werror be applied only when we do not
>> have W=[123].
>
>  Hmm, that sounds better, however has the counter-intuitive side-effect of
> lowering the severity of the warnings that are enabled even without
> W=[123].
>
>  Modern versions of GCC have that selective -Wno-error=foo option and I
> think it should be possible to build the precise list of warnings not to
> choke on locally in arch/mips/Kbuild with little Makefile magic, falling
> back to something sane for older GCC versions (I'm not sure exactly when
> these selective options were added, certainly sometime between 4.1 and
> 4.3).
>
>  This will be a bit imperfect if any of these additional -Wfoo options
> duplicate ones already added to KBUILD_CFLAGS in our top-level Makefile
> (either explicitly or via -Wall), but that's about the best we can do.
> I'll see if I can cook up something quickly.

Hm, how about doing it the other way round, i.e. explicitly enable
which warnings we want to treat as errors with -Werror=foo? That way
we don't lower the severity when W=[123] and new default enabled
warnings in gcc can't break the build any more, just better (or worse
;-) heuristics can.


Jonas
