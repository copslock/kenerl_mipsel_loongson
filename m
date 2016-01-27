Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 22:06:26 +0100 (CET)
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33434 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011828AbcA0VGYUXd0N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 22:06:24 +0100
Received: by mail-pf0-f177.google.com with SMTP id x125so10982991pfb.0
        for <linux-mips@linux-mips.org>; Wed, 27 Jan 2016 13:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=gBUxTT/jVn1q8BvM3sbBM6HgyV+vfIDRB7+JxguiY/E=;
        b=D4W9+fZKyscMZx7ua1bMt0l1Y1f7Q3Owzusgrw+xahTler8l4cxvZGk0yIuA8SWmmX
         gYc2oS1arH4Y29lmS1mAIRh12DUDNbbfYAbS+um30S7c4s3ValrKzW3emUa9f8cW/dET
         H2bEApU3qY3EZqGz5DjdHC9fqTqnwEVBAjqDvTfRhzCO76ktu7qs9/fcGWIsfF4eLoRl
         u44LZIA0EGGY/AB/bKq/3sW6GOnkCaYYPmAxMBjGMTtiloydc7YS7zPA7fyrxNnspX25
         GKBmHQBQGUqI0VCeN2xs3vR9buZkfYcvV9hC7WR3iMHgueilAVkGc6518yK+Ld5om1Nc
         a8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=gBUxTT/jVn1q8BvM3sbBM6HgyV+vfIDRB7+JxguiY/E=;
        b=d672aJPdkKWjkrL0qEIhB48bidNgsMN++b3W6wz0u99xxLoOBgF4nB18T+2f9bXcnK
         gdPtVoF6/TFB0vN3vs5kDRU9eXpXdF7NeN2trMyvQZaeyruTx28hzyVYJ2XcE49MRJZc
         KgzSmlB++oPfQXvvtjLTdKoHflGLso1l06C0XZYYd4juUK3FjHlGefEww2/X97NjB0dC
         BKzDd4bTaTI8ijoy+hSJDQXBQBAcif4xtXnvu+0yb7aPNDpl/NrwAIgaKIP6+ufcBneM
         rMZW8chMJujfmsDBegCLdNX4Cwc8eL/HxQKHQ3ung61GfAzjNRQsHWljnJwoUdq9pYqL
         nP5Q==
X-Gm-Message-State: AG10YOTut280e6rVvBjEh2gYB+Khv3M93k8MVbRhQG+JxSt5v9bYrTcZZHd+6s5qFFWXcg==
X-Received: by 10.98.87.204 with SMTP id i73mr45310411pfj.63.1453928776900;
        Wed, 27 Jan 2016 13:06:16 -0800 (PST)
Received: from dtor-ws ([2620:0:1000:1301:702e:ee06:f118:7e37])
        by smtp.gmail.com with ESMTPSA id n8sm11097393pfj.46.2016.01.27.13.06.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 27 Jan 2016 13:06:13 -0800 (PST)
Date:   Wed, 27 Jan 2016 13:06:10 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        linux-parisc@vger.kernel.org,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 14/16] input: Redefine INPUT_COMPAT_TEST as
 in_compat_syscall()
Message-ID: <20160127210610.GB28687@dtor-ws>
References: <cover.1453759363.git.luto@kernel.org>
 <64480084bc652d5fa91bf5cd4be979e2f1e4cf11.1453759363.git.luto@kernel.org>
 <CAKdAkRQm6ADz5aCYAFxXcoGZ2zNFwTUXjMzZdNj-D2-YrYQtrg@mail.gmail.com>
 <CALCETrUUNM1Qoqna1e7qmEqNUwo99PJe9fSuXG4fzPdSBLfPuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUUNM1Qoqna1e7qmEqNUwo99PJe9fSuXG4fzPdSBLfPuA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dmitry.torokhov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitry.torokhov@gmail.com
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

On Wed, Jan 27, 2016 at 12:29:14PM -0800, Andy Lutomirski wrote:
> On Wed, Jan 27, 2016 at 11:17 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Hi Andy,
> >
> > On Mon, Jan 25, 2016 at 2:24 PM, Andy Lutomirski <luto@kernel.org> wrote:
> >> The input compat code should work like all other compat code: for
> >> 32-bit syscalls, use the 32-bit ABI and for 64-bit syscalls, use the
> >> 64-bit ABI.  We have a helper for that (in_compat_syscall()): just
> >> use it.
> >>
> >> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> >> ---
> >>  drivers/input/input-compat.h | 12 +-----------
> >>  1 file changed, 1 insertion(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/input/input-compat.h b/drivers/input/input-compat.h
> >> index 148f66fe3205..0f25878d5fa2 100644
> >> --- a/drivers/input/input-compat.h
> >> +++ b/drivers/input/input-compat.h
> >> @@ -17,17 +17,7 @@
> >>
> >>  #ifdef CONFIG_COMPAT
> >>
> >> -/* Note to the author of this code: did it ever occur to
> >> -   you why the ifdefs are needed? Think about it again. -AK */
> >> -#if defined(CONFIG_X86_64) || defined(CONFIG_TILE)
> >> -#  define INPUT_COMPAT_TEST is_compat_task()
> >> -#elif defined(CONFIG_S390)
> >> -#  define INPUT_COMPAT_TEST test_thread_flag(TIF_31BIT)
> >> -#elif defined(CONFIG_MIPS)
> >> -#  define INPUT_COMPAT_TEST test_thread_flag(TIF_32BIT_ADDR)
> >> -#else
> >> -#  define INPUT_COMPAT_TEST test_thread_flag(TIF_32BIT)
> >> -#endif
> >> +#define INPUT_COMPAT_TEST in_compat_syscall()
> >>
> >
> >
> > If we now have function that works on all arches I'd prefer if we used
> > it directly instead of continuing using INPUT_COMPAT_TEST.
> 
> I'll write a followup patch for that if you don't beat me to it.

I promise I wont ;)

-- 
Dmitry
