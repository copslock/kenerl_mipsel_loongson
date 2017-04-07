Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Apr 2017 05:22:07 +0200 (CEST)
Received: from mail-it0-x233.google.com ([IPv6:2607:f8b0:4001:c0b::233]:37309
        "EHLO mail-it0-x233.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993869AbdDGDWAsB0G4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Apr 2017 05:22:00 +0200
Received: by mail-it0-x233.google.com with SMTP id a140so36847149ita.0
        for <linux-mips@linux-mips.org>; Thu, 06 Apr 2017 20:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=BhF1Q+frHIFwlvJRU+yiM2LGzEOxS26+HzczynmF1Gw=;
        b=Iv/MVA1KODlc9qbIf+qpgNoyF9JdRqfVMZC4/VvBqqpM1c3LCWieNaQdMw2xrPjKuD
         Vj4/djYISO6zObmCLISxKIng+6t02iISZkq9ZjfeKajWbcuyjl8Rhmpga5pXCgZAluJm
         QI8sGBsmRBNbCJS/QeyYPv0nClChTLn+fvmsj6QUt9CTkCDNLPsudoAzotPOntBWFZKM
         vRsWnulyOT2dmmHDBi2SGgS5H1PJ+v1Vt76HsvtmJkjT/hpQuXzxutPHjanoExDXLHcw
         faUVaWXUrMJhG4yItSJH1eekfqFqbE4qdKUzYiBO+KLsCslfiqD0cg6F+JNcPIHIe27X
         rKBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=BhF1Q+frHIFwlvJRU+yiM2LGzEOxS26+HzczynmF1Gw=;
        b=WjwAwpj2J8RuQsWOMqw1V8hmg1vvR1UEBA3d4eEI6WSp8izKEibAUnShcQGcLQguiZ
         plplAkuMaMvPYJrOSd2xbdBq+3plpSIfOkLSpkbV2nD/XzjU7/QZqHgd2zD5qF2F7ZvH
         iVKCi3/gWlBcKkXpYAkvIU8ofLlJdC8XDiv94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=BhF1Q+frHIFwlvJRU+yiM2LGzEOxS26+HzczynmF1Gw=;
        b=RG12obiUbnh88/Q2PPy4p1aTtdkl8j41PkObnmgXiHT40TRXp0x0aa91DnI+drCWL9
         7CHstz+JQSO8jKqa/dJEWNLj499ui8lycFrih8UXiXCUSnTa0S/px2sMwG/4XQ6iQg8j
         X/tOFHae6cRGHSZ4qoQF2mPSTdF/QLELiLRB3YMiQ4dohDzlHStPt7sQWA6Mz0B2h0e1
         W0xv5fDA/NXCnmlKiP1y04JhvO2WWe1jSF9KkuNrNGAMKCN21Lv+qYNHHFDZnsWSodI9
         /uvfWqK1tpoV+kWjJTYscMRLcWS6K1oyQLzs7oLyxbn84aWHmw+DN9YMqM+SVkq6p7WC
         5iqw==
X-Gm-Message-State: AFeK/H1dNV+l+7cDfd684ItK6vwD7jNeqnXX0FMObK+X9+BGOEmTrzYzGkeVpY1OISFCDRkPX/+Z37QUDD8l/wL8
X-Received: by 10.36.152.196 with SMTP id n187mr30808689itd.28.1491535314788;
 Thu, 06 Apr 2017 20:21:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.131.155 with HTTP; Thu, 6 Apr 2017 20:21:54 -0700 (PDT)
In-Reply-To: <87mvbtzztb.fsf@intel.com>
References: <20170405214711.GA5711@beast> <87mvbtzztb.fsf@intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 6 Apr 2017 20:21:54 -0700
X-Google-Sender-Auth: RihyneBE1TdhNn8r-TSTBWmsWyU
Message-ID: <CAGXu5j+ms4KMy1Uh473r+2veTKnuHN4OuozS92WWwnycH-LGLw@mail.gmail.com>
Subject: Re: [PATCH] format-security: move static strings to const
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jes Sorensen <jes@trained-monkey.org>,
        Jiri Slaby <jslaby@suse.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        "David S. Miller" <davem@davemloft.net>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Mugunthan V N <mugunthanvnm@ti.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Jarod Wilson <jarod@redhat.com>,
        Florian Westphal <fw@strlen.de>,
        Antonio Quartulli <a@unstable.cc>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kejian Yan <yankejian@huawei.com>,
        Daode Huang <huangdaode@hisilicon.com>,
        Philippe Reynes <tremyfr@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Eric Dumazet <edumazet@google.com>,
        Christian Gromm <christian.gromm@microchip.com>,
        Andrey Shvetsov <andrey.shvetsov@k2l.de>,
        Jason Litzinger <jlitzingerdev@gmail.com>,
        WANG Cong <xiyou.wangcong@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Network Development <netdev@vger.kernel.org>,
        devel@driverdev.osuosl.org, linux-serial@vger.kernel.org,
        linux-decnet-user@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

On Thu, Apr 6, 2017 at 1:48 AM, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Thu, 06 Apr 2017, Kees Cook <keescook@chromium.org> wrote:
>> While examining output from trial builds with -Wformat-security enabled,
>> many strings were found that should be defined as "const", or as a char
>> array instead of char pointer. This makes some static analysis easier,
>> by producing fewer false positives.
>>
>> As these are all trivial changes, it seemed best to put them all in
>> a single patch rather than chopping them up per maintainer.
>
>> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
>> index f6d4d9700734..1ff9d5912b83 100644
>> --- a/drivers/gpu/drm/drm_fb_helper.c
>> +++ b/drivers/gpu/drm/drm_fb_helper.c
>> @@ -2331,7 +2331,7 @@ EXPORT_SYMBOL(drm_fb_helper_hotplug_event);
>>  int __init drm_fb_helper_modinit(void)
>>  {
>>  #if defined(CONFIG_FRAMEBUFFER_CONSOLE_MODULE) && !defined(CONFIG_EXPERT)
>> -     const char *name = "fbcon";
>> +     const char name[] = "fbcon";
>
> I'd always write the former out of habit. Why should I start using the
> latter? What makes it better?

For me, it's mainly two reasons: sizeof() and -Wformat-security behavior.

The compiler treats "sizeof" differently. E.g. "sizeof(var)" shows the
allocation size for the array, and pointer size for the char pointer.
When doing things like snprintf(buf, sizeof(buf), ...) will do the
right thing, etc. (This is a poor example for a _const_ string, but
the point is that some calculations still work better with the array
over the pointer.)

The other situation (which is why I noted this to change them) is that
gcc's handling of them is different when faced with -Wformat-security
since it doesn't like to believe that const char pointers are actually
const for the purposes of being a format string.

> What keeps the kernel from accumulating tons more of the former?

Right now, nothing. The good news is that they're relatively rare, and
I notice them when they're added (since I have a -Wformat-security
tree). We could add a warning to checkpatch for suggesting const char
var[] over const char *var, perhaps?

> Here's an interesting comparison of the generated code. I'm a bit
> surprised by what gcc does, I would have expected no difference, like
> clang. https://godbolt.org/g/OdqUvN

Here's your example with sizeof() added, if you're curious...
https://godbolt.org/g/U1zIZK

> The other changes adding const in this patch are, of course, good.

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
