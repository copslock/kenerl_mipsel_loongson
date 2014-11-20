Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Nov 2014 04:55:42 +0100 (CET)
Received: from mail-qa0-f49.google.com ([209.85.216.49]:59979 "EHLO
        mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009417AbaKTDzlWc0xK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Nov 2014 04:55:41 +0100
Received: by mail-qa0-f49.google.com with SMTP id s7so1413189qap.36
        for <multiple recipients>; Wed, 19 Nov 2014 19:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xDBEI6YMjFG25TEx/sC31dLjOXVC423Nh6ucA/SaHzA=;
        b=OlPAV4v8jU6C40m2Q5n34mwHM/1SyytaE0V1bOakEfVHowfEkG3i9/bpEXtB2CFXtu
         0LF5JgSBM+sx1EAKb1+g19vUEY4nzL0MCjRjHPD8aupuasDPiK/eLmC9R9qKbDUc2mSs
         g0GaXuGI/KItyxKgnW2aQorxFvrEJxqBZHdH5rFxU7+K6Cn29Ffb3cDPFsMcUz22HUap
         90xvWfHqHJqaJ67hYqrSMMifF5f1Zd9C7MFwxv9dJKWR8harrtQaFcRYNydtk4d1O/7k
         KfYY4TYmoY98PoNrvEJ2hKAjmY8D/tLPaurZ7Cbm3NsoXoNJwZJa63hxQCePJRmq5oR+
         E63g==
X-Received: by 10.224.35.205 with SMTP id q13mr38356627qad.39.1416455735512;
 Wed, 19 Nov 2014 19:55:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.89.113 with HTTP; Wed, 19 Nov 2014 19:55:15 -0800 (PST)
In-Reply-To: <20141120030434.GE24364@ld-irv-0074>
References: <1416097066-20452-1-git-send-email-cernekee@gmail.com> <20141120030434.GE24364@ld-irv-0074>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Wed, 19 Nov 2014 19:55:15 -0800
Message-ID: <CAJiQ=7C8h-MAuRdgzZqx2=bg8bvy7v9pv7e7tGXWmA9ghYJiqQ@mail.gmail.com>
Subject: Re: [PATCH V2 00/22] Multiplatform BMIPS kernel
To:     Brian Norris <computersforpeace@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jon Fraser <jfraser@broadcom.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Wed, Nov 19, 2014 at 7:04 PM, Brian Norris
<computersforpeace@gmail.com> wrote:
> On Sat, Nov 15, 2014 at 04:17:24PM -0800, Kevin Cernekee wrote:
>> The lack of a reboot handler is annoying; syscon-reboot probably won't work
>> on STB (because it requires two writes).
>
> Can't you reuse drivers/power/reset/brcmstb-reboot.c ?

Oops, I ran a quick check earlier by grepping for "sun-top-ctrl" and
looking under drivers/reset, but assumed this driver wasn't merged yet
when nothing came up in the code.  Thanks for the pointer.

It looks like the current driver will work for 40nm, but 65nm uses
different bit positions: RESET_CTRL bit 3 to arm, and SW_RESET bit 31
to trigger.  I'll add a new "brcm,brcmstb-reboot-65nm" compatible
string to make this work.

Also, we'll need to take Guenter Roeck's register_restart_handler()
patch in order to build on MIPS.
