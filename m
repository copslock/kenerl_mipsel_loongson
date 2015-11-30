Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 22:29:36 +0100 (CET)
Received: from mail-wm0-f49.google.com ([74.125.82.49]:33759 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008054AbbK3V3eIiseY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2015 22:29:34 +0100
Received: by wmec201 with SMTP id c201so176693241wme.0
        for <linux-mips@linux-mips.org>; Mon, 30 Nov 2015 13:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        bh=fLkpOzbKylI+Jwjc3Fsbpq2AFt0gQ8oSdRzTb64YjMA=;
        b=Z1/h2fA8bUwM1c6dcVNOzNCvADQCo/1J7NZB1HdU1bhW0ktTjOw3p+y5UagtT7D9T6
         MfplfhZawKk2t6Tz/54v0Jke5GR7MuGr+YcP+Sqr+6oQTJNOo37hiTSwD/lLM2dMb8eW
         zpaxcic0nZBK8O8XKrzGYIb/VRDV9pKieuH1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version:content-type;
        bh=fLkpOzbKylI+Jwjc3Fsbpq2AFt0gQ8oSdRzTb64YjMA=;
        b=C0Ql+vfyQGl0laDWgDK5p+yIYo5PFO6QBUUjvzcyMkN93cKD8HZlLjLqUWagxvK+1A
         8fRZJWYvSBFrB0497eyhYODpWZZhk0fFwexn7/cv6wwjL+Ctq7jbYSatfNEpzFrZqyyA
         pr40k06mIb9CGwKI7NGXAXYsgJAZbYlycbq6Cm45cLOKnrI1tW+Jpgg0wd1ELIjICeN9
         h7eEC0Lu4o+04iP+Zgk2ZS/np5WWND68xUdIWZ6Ih0LrBHp/QVmJK1l+5No2bWC2wT0a
         x22mg+Ezg0uKSBT4ouB4x8czl3GpP610RX98yzHz7GlERYOYEhM5Y1kccr/fUUGm352D
         oTTw==
X-Gm-Message-State: ALoCoQldIRi4oXe7P6hSJ0rrpaDsvz+WDfNk3BWSgdwexm8vbM8JrpW62mgmko54jpstBQdioxUE
X-Received: by 10.28.7.8 with SMTP id 8mr29184837wmh.45.1448918968866;
        Mon, 30 Nov 2015 13:29:28 -0800 (PST)
Received: from morgan.rasmusvillemoes.dk ([84.238.70.226])
        by smtp.gmail.com with ESMTPSA id k133sm23229228wmg.18.2015.11.30.13.29.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Nov 2015 13:29:28 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: no-op delay loops
Organization: D03
References: <87si3rbz6p.fsf@rasmusvillemoes.dk> <3228673.rOyW85ILiP@wuerfel>
X-Hashcash: 1:20:151130:arnd@arndb.de::fsmk3dVuvg4JKscc:00002Fd6
X-Hashcash: 1:20:151130:ralf@linux-mips.org::VqlaVvjPrwVrQp4S:00000000000000000000000000000000000000000022Bd
X-Hashcash: 1:20:151130:linux-kernel@vger.kernel.org::FOmyDZWl2kPl8Mt5:0000000000000000000000000000000005LtZ
X-Hashcash: 1:20:151130:linux-mips@linux-mips.org::MpBK8/PK76BMW7Lb:0000000000000000000000000000000000005kvb
Date:   Mon, 30 Nov 2015 22:29:26 +0100
In-Reply-To: <3228673.rOyW85ILiP@wuerfel> (Arnd Bergmann's message of "Fri, 27
        Nov 2015 12:17:54 +0100")
Message-ID: <874mg3b2h5.fsf@rasmusvillemoes.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <linux@rasmusvillemoes.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@rasmusvillemoes.dk
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

On Fri, Nov 27 2015, Arnd Bergmann <arnd@arndb.de> wrote:

> On Friday 27 November 2015 09:53:50 Rasmus Villemoes wrote:
>> 
>> It seems that gcc happily compiles
>> 
>> for (i = 0; i < 1000000000; ++i) ;
>> 
>> into simply
>> 
>> i = 1000000000;
>> 
>> (which is then usually eliminated as a dead store). At least at -O2, and
>> when i is not declared volatile. So it would seem that the loops at
>> 
>> arch/mips/pci/pci-rt2880.c:235
>> arch/mips/pmcs-msp71xx/msp_setup.c:80
>> arch/mips/sni/reset.c:35
>> 
>> actually don't do anything. (In the middle one, i is 'register', but
>> that doesn't change anything.) Is mips compiled with some special flags
>> that would make gcc actually emit code for the above?
>> 
>
> I remember that gcc used to not optimize code that looked like a
> delay loop such as the above, and my tests show that this was still
> the case in gcc-4.0.3, but starting with gcc-4.1 it opimtized away
> that loop.

OK, thanks. That's a very very long time ago.

FWIW, the remaining instances that my trivial coccinelle script found
are

./arch/alpha/boot/main.c:187:1-4: no-op delay loop
./arch/m68k/68000/m68VZ328.c:86:10-13: no-op delay loop
./arch/m68k/bvme6000/config.c:338:2-5: no-op delay loop
./arch/m68k/coldfire/m53xx.c:533:1-4: no-op delay loop
./drivers/cpufreq/cris-artpec3-cpufreq.c:85:3-6: no-op delay loop
./drivers/cpufreq/cris-etraxfs-cpufreq.c:85:3-6: no-op delay loop
./drivers/tty/hvc/hvc_opal.c:313:3-6: no-op delay loop
./drivers/tty/hvc/hvc_vio.c:289:3-6: no-op delay loop

(cc += a few people). The tty ones use volatile, so they probably work,
though one might still want to use the *delay API.

Rasmus
