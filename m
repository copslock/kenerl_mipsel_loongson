Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jun 2014 09:17:07 +0200 (CEST)
Received: from mail-lb0-f172.google.com ([209.85.217.172]:45356 "EHLO
        mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816207AbaFFHREvg4w6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Jun 2014 09:17:04 +0200
Received: by mail-lb0-f172.google.com with SMTP id l4so1280537lbv.31
        for <multiple recipients>; Fri, 06 Jun 2014 00:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=g6KGZtNFvG0LIWzds7cCtXeg2geiNb9/FgBephkTSz8=;
        b=rSQ7yeU0SGmiNvykwrKS44WthPHz/NHh7bjrx+bTl7uNTrJyYUdL65x3cvBqPyIPpY
         Bj0pxZzCpC9HHg6CJSsHOBJ4IOsug+MLEUkzOtl/n9Z+q9zEDUHKYWi+Y0WPujRbFifY
         T9Xa36D0nZESioX4YDY8H6ce1Qdra4G1vMp3Mpamx+hDZMyoYEdfDgpgI2giVBcaUYmR
         1iGpPkaaVMSmfA75bz8Lcafxs4OyE1J9WKQ5vWvUhmBbV7WLbWmSs6KCGzDUj0A2LRXt
         UVspbqWc2oZQ23l8x1E4vs/3Ojd7DaMf2o8v/IrwqQdc1xRPgVxnP96PrOqa5Pxiukd0
         HyKw==
MIME-Version: 1.0
X-Received: by 10.152.87.80 with SMTP id v16mr278062laz.77.1402039019141; Fri,
 06 Jun 2014 00:16:59 -0700 (PDT)
Received: by 10.152.43.4 with HTTP; Fri, 6 Jun 2014 00:16:59 -0700 (PDT)
In-Reply-To: <5390E788.2030702@gmail.com>
References: <20140605121204.18ee5f2d@gandalf.local.home>
        <5390A4F0.3000601@gmail.com>
        <20140605133500.190eb31d@gandalf.local.home>
        <5390BA9D.3090402@gmail.com>
        <20140605145339.57c5be79@gandalf.local.home>
        <5390E788.2030702@gmail.com>
Date:   Fri, 6 Jun 2014 09:16:59 +0200
X-Google-Sender-Auth: MSub2SCWi-i37BvC1jiZNwQvk2w
Message-ID: <CAMuHMdVYftu=nhYvhq9_gMVqs_dufgziW+dTMZAK_8QnfKjqug@mail.gmail.com>
Subject: Re: gcc warning in my trace_benchmark() code
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

On Thu, Jun 5, 2014 at 11:56 PM, David Daney <ddaney.cavm@gmail.com> wrote:
>> I don't
>> see it in the comments, and I don't see anything in the Documentation
>> directory. It only states that n must be 64bit. It doesn't say unsigned
>> 64 bit.
>
> The handful of call sites I examined, seem to all use u64 or unsigned long
> long.

And the ones that don't, cause warnings, and are being fixed:

https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg78445.html

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
