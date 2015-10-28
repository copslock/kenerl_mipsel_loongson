Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2015 11:20:14 +0100 (CET)
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33239 "EHLO
        mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009740AbbJ1KUMf1J4F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Oct 2015 11:20:12 +0100
Received: by wijp11 with SMTP id p11so249119370wij.0
        for <linux-mips@linux-mips.org>; Wed, 28 Oct 2015 03:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alex-smith_me_uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zrpCIURtmK0bz21hjdeVooxMBV9kDwnjEbRdjrP/IFY=;
        b=d86E/haE2riTnHCselWMuo3Hg75aXCNsX+fDSTn7hYmVbir5z0lJOyG8xgFLVl6wlf
         /mn9u8XYFlFHEt6Fr0VUsM3metCHXMEFTxDdgpWed2c1wWhrVk35yBPqoEOxHdTPol/9
         KpVxS60isb9nb/TMgfYSTweueb976dy5S6h3N7C4bAkzQ3Y89lr6Z+g1a7Dnt13GGPfU
         bbYep2gYhRm4xs0V7vFXUnxol0ma2zTbnZqvHOTALnHmjQL1a2Ge3AVpWf4qXfH98rMu
         B370wA7usouhJysj2sgm7tKlm7ZBrnrAjmp3LB9Pn1riUaTLkw7uFhIIfuIwIOCwUyUp
         /r3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=zrpCIURtmK0bz21hjdeVooxMBV9kDwnjEbRdjrP/IFY=;
        b=TojlubGHdHn11dMMIkDZsN1vXFrSn3SQqJNSRDKyhE5gfD4C4WZtAmrI2ZxKlk/8nH
         +KgP7yDkmPqZ7wdIp8umBxzdbydWDJMqevMnnJXvP9cZvpbLy8jo7xa6EaS9VH5zXQLa
         ju0rJZiTEl7TRK5Of+tuI7zmxNSy39E37FfKDYf7+UiOG5tfY6coZ8i6B5DlL5m4a4J/
         GLnlhLBJn+yqZCurVQA1xefkCpySdH2ZN94nwgFBU4S+NX1k7fi4HJIk7VYyHkxpDLeK
         fBDz+UhWtVPw0jPU5zq6KOLBzUPlcc88IDJaBiv6DBwVlueNRqBwcHlebipwl9iZj87y
         1Lgg==
X-Gm-Message-State: ALoCoQm5yAjmRBl8watMyOrow0E5up3JmZXAu6UmzwaIqoc197kPSLkTZl538ZLEziP8mNw4cOUF
MIME-Version: 1.0
X-Received: by 10.194.57.171 with SMTP id j11mr22365969wjq.94.1446027607065;
 Wed, 28 Oct 2015 03:20:07 -0700 (PDT)
Received: by 10.27.11.144 with HTTP; Wed, 28 Oct 2015 03:20:06 -0700 (PDT)
In-Reply-To: <562FF15A.1050507@imgtec.com>
References: <1445417864-31453-1-git-send-email-markos.chandras@imgtec.com>
        <5629904A.2070400@imgtec.com>
        <20151027144748.GA23785@linux-mips.org>
        <562FE29C.8040106@imgtec.com>
        <562FE678.2030307@gmail.com>
        <562FE96C.3070002@imgtec.com>
        <562FF05A.508@gmail.com>
        <562FF15A.1050507@imgtec.com>
Date:   Wed, 28 Oct 2015 10:20:06 +0000
Message-ID: <CAOFt0_AFnR0MF2e8rRXhz_wkiGbL2VTFy=AXpcmWTZ9_bYA=VQ@mail.gmail.com>
Subject: Re: [v3, 3/3] MIPS: VDSO: Add implementations of gettimeofday() and clock_gettime()
From:   Alex Smith <alex@alex-smith.me.uk>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        David Daney <ddaney.cavm@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Alex Smith <alex.smith@imgtec.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <alex@alex-smith.me.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49729
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@alex-smith.me.uk
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

On 27 October 2015 at 20:46, Leonid Yegoshin <Leonid.Yegoshin@imgtec.com> wrote:
> I doesn't work in this way - a standard CP0_counter synchronization code
> takes up to hundred milliseconds to complete with running some loop cycles
> on two CPUs. It is clearly seen in Malta FPGA board.
>
> Non-standard (one way sync, write CP0_counter value to memory in CPU0 before
> CPU1 wakeup) is not precise because it can't predict how much time the CPU1
> can spent in wakeup. Just because of HW, for exam, and SW next.
>
> I believe, until this issue is fixed the R4K only CPU should be excluded
> from VDSO timing acceleration.

The VDSO code will currently use the CP0 count whenever the kernel is
using it as its primary clocksource, aside from the case where RDHWR
is broken as it is on old QEMUs.

Maybe I'm missing something but I don't see anything in the generic
timekeeping code that handles the same clocksource being
unsynchronised or running at a different rate on different CPUs.

Given that, if you think there is an issue that prevents the VDSO from
using it then that would surely affect the kernel as well and needs to
be fixed separately?

If it really is necessary to prevent the VDSO from using a certain
clocksource even though the kernel is using it, it should be a simple
matter of setting clocksource.archdata.vdso_clock_mode to
VDSO_CLOCK_NONE. This is how this patch stops it using the CP0 count
when RDHWR is broken.

Alex
