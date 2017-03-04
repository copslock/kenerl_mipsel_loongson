Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Mar 2017 03:57:11 +0100 (CET)
Received: from mail-qk0-x242.google.com ([IPv6:2607:f8b0:400d:c09::242]:34020
        "EHLO mail-qk0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993420AbdCDC44fWWul (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Mar 2017 03:56:56 +0100
Received: by mail-qk0-x242.google.com with SMTP id g129so3413084qkd.1
        for <linux-mips@linux-mips.org>; Fri, 03 Mar 2017 18:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xiUllCDuNWp17g3WYn0ox5lBn+ARoOnfgCEjZHoWH6k=;
        b=SS/AaaF8SkURqbk7GkEjOA4lAQugGfNdnfUrbYPWqD/z1a8S/mWm9m3NPHqlQLw5cR
         yyNFC9Ue+Y+4UE/PHHwmyHdc4coDcv1zG9YcewVthrR8KhLRGZZuXomAfA/0W/nfRjjt
         Oz4Os3mqdOZJUwsH5GETcIPBtJzuolkuKToipYIZBLisib4njbs+1+uPv4VvAmMNKKiP
         DjuHZri9wAic8gVnyxwLVu8TpR0RfhtXPZYACfGaJeB7gBaHsDHknqzXxvk7SljV2U/q
         Hr2q0uGQaNJd/f2wbZ0QtqIkJri8KjlOvgnDuJWtS/AnNwjSjU3euU9C/YXCAiHEHmab
         LK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xiUllCDuNWp17g3WYn0ox5lBn+ARoOnfgCEjZHoWH6k=;
        b=Z723NAY3RyNClUWQRpxkIyM40gKlOu9bCf3wlK6TOM0Z9jea4CPIAZAsS0xuAGI67A
         rPshtMLkxrOOYcmWykOwejQkIry5lG1WV7XvogNcZ+Dyn6GdMSV0GgVpfXG3wc0o1YEu
         YOWGdjTs+flynmR6lp9nAPuVLBw0JSeKVOyCbfMcuufZ6XtB/wuC5ptDJesm+k227bjz
         cuTlka9rIi4UFKn76Ntfzawwatjtvk9CfDcpjWUUY8C2MAA+YxAj9t3Iz+TW95AMpTL1
         yj5MDMVjdq3zMrlhCoCYHzDWRJRBJOBSIQzFjrZ20h0O1aKsyuA5alVyYF1MHUup5vgh
         W0ug==
X-Gm-Message-State: AMke39mCHwm0JUk/BZsFNxEjSKOC9BiNEL3u6BxY7/6Yw8h1Wukgd/9xPL02nm2lyMgtgSbI1rhWKdzca2Lgwg==
X-Received: by 10.55.212.199 with SMTP id s68mr5810571qks.245.1488596209145;
 Fri, 03 Mar 2017 18:56:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.153.113 with HTTP; Fri, 3 Mar 2017 18:56:48 -0800 (PST)
In-Reply-To: <20170303232305.GU996@jhogan-linux.le.imgtec.org>
References: <1484164100-9805-1-git-send-email-jason.uy@broadcom.com>
 <1484164100-9805-2-git-send-email-jason.uy@broadcom.com> <CAAG0J9-n0toSJL8Ze8Esq81dYnpfrTd42bMiR94zw_btBLjsww@mail.gmail.com>
 <1488394220.20145.68.camel@linux.intel.com> <20170303002129.GS996@jhogan-linux.le.imgtec.org>
 <1488547866.20145.74.camel@linux.intel.com> <20170303232305.GU996@jhogan-linux.le.imgtec.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 4 Mar 2017 04:56:48 +0200
Message-ID: <CAHp75Ved2h2WyWBokEOsDmAyB3w3iM=uh-9Bq01mU1ST4FapWQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] serial: 8250_dw: Allow hardware flow control to be used
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jason Uy <jason.uy@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Noam Camus <noamc@ezchip.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wang Hongcheng <annie.wang@amd.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-clk@vger.kernel.org, Viresh Kumar <viresh.kumar@st.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <andy.shevchenko@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57030
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.shevchenko@gmail.com
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

On Sat, Mar 4, 2017 at 1:23 AM, James Hogan <james.hogan@imgtec.com> wrote:
> On Fri, Mar 03, 2017 at 03:31:06PM +0200, Andy Shevchenko wrote:
>> On Fri, 2017-03-03 at 00:21 +0000, James Hogan wrote:
>> > The CONFIG_HAVE_CLK=n implementation of devm_clk_get() in particular
>> > seems highly questionable to me, given that commit 93abe8e4b13a ("clk:
>> > add non CONFIG_HAVE_CLK routines") which added it 5 years ago says:

>> Btw, I hope you also noticed this one:
>>
>> http://www.spinics.net/lists/linux-serial/msg25314.html
>
> Interesting.
>
> Following Russel's past advise[1], the following patch on top of Heiko's
> patch also fixes things for me on Octeon:
>
> [1] https://lists.gt.net/linux/kernel/2102623
>
> If thats an acceptable fix I'll post it properly. Thoughts?

Fine by me. Looks definitely better than IS_ERR_OR_NULL().

Please, submit as usual with your SoB tag.

> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 223ac234ddb2..e65808c482f1 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -267,6 +267,8 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
>         rate = clk_round_rate(d->clk, baud * 16);
>         if (rate < 0)
>                 ret = rate;
> +       else if (rate == 0)
> +               ret = -ENOENT;
>         else
>                 ret = clk_set_rate(d->clk, rate);
>         clk_prepare_enable(d->clk);

-- 
With Best Regards,
Andy Shevchenko
