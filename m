Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 May 2016 19:24:54 +0200 (CEST)
Received: from mail-qg0-f54.google.com ([209.85.192.54]:36691 "EHLO
        mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27040035AbcE3RYv5Y2uS convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 May 2016 19:24:51 +0200
Received: by mail-qg0-f54.google.com with SMTP id q32so80721206qgq.3
        for <linux-mips@linux-mips.org>; Mon, 30 May 2016 10:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=Dagj7cZRnT8VX+UiK94uMCgHYVQNU+S9NwMl4j+suDo=;
        b=SExmeuz7xTpG/TAX9E4UtdM7UIeNE/RRLOam+ntZUDfa4dSq/gkhzStaXOTxThSR2m
         pxeVcxIRGoP7mvX21luKpdl2MGmZcN2qlZOV5cQ3qECluLupRcrYGNTwPhbHrmntezUk
         o8jp1MwTvYnu2qDzguC8LGEdIkWxwrWb6k/Rqhb8GiNRcB9okZcCfvPZ3QSk7h8lAq19
         TgC0+ud/NnXtjd2VcYPkMIYPQ0qF2g64RVAgMOfam6N9Jl9VE5yxRTE4RlJ5URo/4BCs
         ccU+QSbDqDanWd6bkS/P6L7wTVBImn02zMQT0LMCTWtJ1OBlY/hY2eYRIG4lqIw71SeA
         7TTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=Dagj7cZRnT8VX+UiK94uMCgHYVQNU+S9NwMl4j+suDo=;
        b=CxBcXhXQ5xplCKAx6kiNV/53a4VbZhUg1Rne43faGS31c2SmISwEA52rtwql0234+9
         TwfiaYsv1gmJ8qOU+TChrtN3+iLrwUNO7xfXIz9SLBQe2OMeo+n9icLZ5DHE/HW4HB2V
         I15SePDh6UgCWUJ7LO6mhg5s/PNZRNUODiracP/nCtNwLAWPYN24k1/XqslgnngBW+AU
         jJRVBuRo+N8J5Mf9fuhR0XtcCbG2ece1vIR2ztTzkhxtZd9tmmhiK9ycUs0KGWoLU4aP
         XMAwVDvhxdfPCH0jhSrtUccfyZmIuIAyQjEx/77lKfSG28freAaMfq8+Ndk/bwnEH2+1
         +mbw==
X-Gm-Message-State: ALyK8tLZlLSv/DHyde5MbOdewlu9PtRTNVdRsqd93sd0ZSmAH+fkpZLJghZ6Xuecu1EI9XK3ghZGGNKQYL9Iqw==
MIME-Version: 1.0
X-Received: by 10.140.109.198 with SMTP id l64mr26098869qgf.65.1464629086075;
 Mon, 30 May 2016 10:24:46 -0700 (PDT)
Received: by 10.55.169.22 with HTTP; Mon, 30 May 2016 10:24:45 -0700 (PDT)
In-Reply-To: <1464485020.5020.28.camel@chimera>
References: <20160524194818.9e8399a56669134de4baee1e@gmail.com>
        <1464383198-6316-1-git-send-email-daniel@gimpelevich.san-francisco.ca.us>
        <20160528133152.cc8b7fad8665b20a3519f4e0@gmail.com>
        <1464462306.5020.25.camel@chimera>
        <1464485020.5020.28.camel@chimera>
Date:   Mon, 30 May 2016 20:24:45 +0300
Message-ID: <CAA4bVAE=irtiqX5PHQBT2ZNR5xyCku2gwgkCQTZp6f-rc2wimA@mail.gmail.com>
Subject: Re: [PATCH v2] Re: Adding support for device tree and command line
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
Cc:     linux-mips@linux-mips.org, hauke@hauke-m.de, jogo@openwrt.org,
        openwrt@kresin.me
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53702
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

On 29/05/2016, Daniel Gimpelevich
<daniel@gimpelevich.san-francisco.ca.us> wrote:
> On Sat, 2016-05-28 at 12:05 -0700, Daniel Gimpelevich wrote:
>> On Sat, 2016-05-28 at 13:31 +0300, Antony Pavlov wrote:
>> >   Can we use 'if' instead of preprocessor's '#if' here?
>> >
>> >   If we use regular C 'if' operator with IS_ENABLED() instead of
>> > '#if/#ifdef'
>> >   then the compiler can check all the code.
>> >
>> >   E.g. please see this barebox patch:
>> >
>> >
>> > http://lists.infradead.org/pipermail/barebox/2014-February/017834.html
>>
>> Sigh. I guess I will resubmit again…
>
> Upon further review, no, we cannot use 'if' instead of '#if' here. The
> reference to the appended DTB would throw a linker error if the option
> to put it there is not enabled. Sorry.

Please note that modern gcc ignores 'undefined reference' errors
inside optimized out code block (e.g. 'if (0) { ... }').

Here is an example:

    $ echo <<EOF; > esymbol.c
    int main()
    {
    	if (CONFIG_ESYMBOL_STUFF) {
    		extern int esymbol;

    		esymbol = 1;
    	}
    }
    EOF

    $ gcc -DCONFIG_ESYMBOL_STUFF=1 esymbol.c
    /tmp/ccNCGFCS.o: In function `main':
    esymbol.c:(.text+0x6): undefined reference to `esymbol'
    collect2: error: ld returned 1 exit status

    $ gcc -DCONFIG_ESYMBOL_STUFF=0 esymbol.c
    $ echo $?
    0
    $

    $ gcc --version
    gcc (Debian 4.9.3-12) 4.9.3
    Copyright (C) 2015 Free Software Foundation, Inc.
    This is free software; see the source for copying conditions.  There is NO
    warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

-- 
Best regards,
  Antony Pavlov
