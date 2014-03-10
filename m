Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Mar 2014 20:21:35 +0100 (CET)
Received: from 0.mx.nanl.de ([217.115.11.12]:49620 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6868511AbaCJTVdFEssJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Mar 2014 20:21:33 +0100
Received: from mail-qc0-f176.google.com (mail-qc0-f176.google.com [209.85.216.176])
        by mail.nanl.de (Postfix) with ESMTPSA id 200044602C;
        Mon, 10 Mar 2014 19:21:15 +0000 (UTC)
Received: by mail-qc0-f176.google.com with SMTP id m20so8220893qcx.7
        for <multiple recipients>; Mon, 10 Mar 2014 12:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DOvOB8Stv3ZEIZlE640x6SG5fhXif5iw5+PkmhAaWn4=;
        b=AiBaYWhuH7GGgYES0rK6KmvX0PsYSjptunvw2t88KXsXVypb4cIhLfHg7TDfOTkM/I
         fpl89FCaLVKEA76qqlQJ4Oe+Ww7/6lIQpm1hMlRjsgrSvypXY7Utv74iMpJl9GraU+xF
         q1w/Qrtt1DjL+yEJtoWiyP7eBmPdWHulGbaHU1SJLC4evMnEGSM0e4GBUOPvCwYZqaY9
         R85rV9YwyD8XFE9sz7Xg7XYmogfZTeDrCawHaZ7Sn0NX15U/hGa7Ii6HewmR9n4GXiLE
         0iQ4oaeAF8F9qWvFThR6yFXrAQk5ofTva3RQjTaUCch/g5JVHhR4WVz9ipK/QI1yzIdK
         qaFg==
X-Received: by 10.224.13.142 with SMTP id c14mr10172419qaa.76.1394479287361;
 Mon, 10 Mar 2014 12:21:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.24.81 with HTTP; Mon, 10 Mar 2014 12:21:07 -0700 (PDT)
In-Reply-To: <CAP=VYLribDoh9LyQuNr-RxmRdaVxqNqzCCSAgMxKoZKWd2b1YA@mail.gmail.com>
References: <1393940084-29518-1-git-send-email-markos.chandras@imgtec.com> <CAP=VYLribDoh9LyQuNr-RxmRdaVxqNqzCCSAgMxKoZKWd2b1YA@mail.gmail.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Mon, 10 Mar 2014 20:21:07 +0100
Message-ID: <CAOiHx=mNtTv01CyjC=rXKzTeF79sbBqnZBQWbWXAkKnrGeZrng@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add support for the M5150 processor
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Mon, Mar 10, 2014 at 6:43 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> On Tue, Mar 4, 2014 at 8:34 AM, Markos Chandras
> <markos.chandras@imgtec.com> wrote:
>> Hi,
>>
>> This patchset adds support for the recently announced M5150 processor
>> http://imgtec.com/mips/mips-series5-mclass-m51xx.asp?NewsID=804
>
> I'm going to skip the bisect, and make a guess that this patchset causes
> the following build failures on all pre-existing mips boards:
>
> arch/mips/kernel/cpu-probe.c:856:7: error: 'PRID_IMP_M5150' undeclared
> (first use in this function)
> arch/mips/kernel/cpu-probe.c:857:16: error: 'CPU_M5150' undeclared
> (first use in this function)
> make[3]: *** [arch/mips/kernel/cpu-probe.o] Error 1
>
> See this link as one of the many linux-next mips failures:
>
> http://kisskb.ellerman.id.au/kisskb/buildresult/10701712/


Looking at mips-next and patchwork, the problem isn't the patchset
itself, but rather that only the third patch was applied.

Ralf, I think you missed the following two patches :)

http://patchwork.linux-mips.org/patch/6595/
http://patchwork.linux-mips.org/patch/6596/


Regards
Jonas
