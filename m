Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Nov 2010 15:01:37 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:42096 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491176Ab0KYOBe convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Nov 2010 15:01:34 +0100
Received: by fxm16 with SMTP id 16so161208fxm.36
        for <linux-mips@linux-mips.org>; Thu, 25 Nov 2010 06:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=RWZevEIIMdRug4LNNqIWKBVx2uOCMNkF7cQorEI360E=;
        b=MpVZjJb0/EW48MxFllBsL3fiS2zSsMQ8qJsLl+0nPIId5lwoEbtzKgB4qf61ULtwQ7
         lq1w74uI/88qyA6DMKOgWHbB74ePjHLwvgu1bb/NGHMpeOF+SOQEb1RkwF0kNWY/gmB3
         mTssrvExzJNglY9qpOjJwBqi5q+Kbs5flBwog=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=xz/o9ztGZI6k6MxHu127ud5lw7GSicMa3HMVoJ69BvKTqFdUSKLHo1bx311onPZRjq
         jOpjnRHYQUC8AuW6/H01AUOdLnFP34bPYaeln4Cuj4YyXZTYRtN8xTi7Ub42+MJGpuzP
         T7uGZ+5/31mFk2GMIyYWhVIOK5NsBia0pbRUU=
MIME-Version: 1.0
Received: by 10.223.78.139 with SMTP id l11mr798336fak.31.1290693687973; Thu,
 25 Nov 2010 06:01:27 -0800 (PST)
Received: by 10.223.100.7 with HTTP; Thu, 25 Nov 2010 06:01:27 -0800 (PST)
In-Reply-To: <1290692075.689.20.camel@concordia>
References: <1290607413.12457.44.camel@concordia>
        <1290692075.689.20.camel@concordia>
Date:   Thu, 25 Nov 2010 15:01:27 +0100
X-Google-Sender-Auth: Ckong4qhIcssKb7d-UbKPdNxJTs
Message-ID: <AANLkTim9fPPWO-240dmavng+j=70G8Y4P-+j3Y+OZTL0@mail.gmail.com>
Subject: Re: RFC: Mega rename of device tree routines from of_*() to dt_*()
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     michael@ellerman.id.au
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        microblaze-uclinux@itee.uq.edu.au,
        devicetree-discuss@lists.ozlabs.org,
        linuxppc-dev list <linuxppc-dev@ozlabs.org>,
        sparclinux@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28525
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 25, 2010 at 14:34, Michael Ellerman <michael@ellerman.id.au> wrote:
> I've left for_each_child_of_node(), because I read it as "of", but maybe
> it's "OF"?

I always read it as "for each child-OF-node", so I would rename it to
"dt_for_each_child_node".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
