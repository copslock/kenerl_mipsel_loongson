Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jan 2016 09:01:38 +0100 (CET)
Received: from mail-io0-f176.google.com ([209.85.223.176]:33210 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008419AbcA2IBhA4rsN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Jan 2016 09:01:37 +0100
Received: by mail-io0-f176.google.com with SMTP id f81so81307059iof.0;
        Fri, 29 Jan 2016 00:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=1+5B1oHZVh7/BtXRf2it0qtduhAVF+QyGzQFb1v3aoY=;
        b=OCO+Bw30PhQ27dxZchv5BreEYFzAmsq9xGdJnt1/bcEO5d/x67rZHsmG+CFLbwsNFg
         MuG6FqqMqTFlL2ybnsYqlQ1df4/+jDWA37tYc5dA7IP5gLzHQeKRV70fZ5BZxD4no+ea
         UTERS6TMNnqn95CfMMfIL4bQLhyqUVuZL30Kw9UtkEGcxwJMlnoAZTiKEUIknpskVxTg
         sgfxxscYvy3w1fjVpzNMl9LWWhWNe9VrQ5LI06ztVwFy8r2TxwgoWl8yBXUrsG6tabHk
         +9oN323HgsSsS3amhZ8cr+HSk0LbbKkuM8lx5eRkFFT3RO8UZN9OzA93e9ySOIuRke3m
         RMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=1+5B1oHZVh7/BtXRf2it0qtduhAVF+QyGzQFb1v3aoY=;
        b=gJhr6uTPGvAVGK8OjrELRBA3d0DGa+kx5cynpE0tOmL/+MSBHO3HvmYbQn6cdv4df+
         v+f92wCjsQbRDiuTsPqfJmWjrV1LWO1pwB/+wjPyl1EP5Z7WEYiN0OTI9XhsGJAUqtag
         8zgjKDYro+7zjfok4MyzOUzlnHnADjRVqfoeMxBYjC99GmCU7aHC8TTsc4LxZOsew4kC
         5kl4BiCEvt8+y/1D0YlhfehOyH/7vNVnPPv41XTrmG2KbgT+AcpiEdEDJ6Raw8NHzMlD
         2Stv+SONy9Q0PNulhXkQNW8HJe/iKsYNw19/H+AkBBL+ptakGaXEpadI/XOFMIE8Sio2
         dXsw==
X-Gm-Message-State: AG10YORK/au7nx5VszrLSjB5hhbVkTKDEoOFdUsmngQcsRmuD8SRZfv1cQu1VrjEUSmqjZcKUGJrd6KMiIYM8g==
MIME-Version: 1.0
X-Received: by 10.107.158.81 with SMTP id h78mr8361834ioe.174.1454054491124;
 Fri, 29 Jan 2016 00:01:31 -0800 (PST)
Received: by 10.107.9.97 with HTTP; Fri, 29 Jan 2016 00:01:31 -0800 (PST)
In-Reply-To: <7619136.niuXthzi6R@wuerfel>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com>
        <20160128031435.GA25625@wfg-t540p.sh.intel.com>
        <20160128174241.GN10826@n2100.arm.linux.org.uk>
        <7619136.niuXthzi6R@wuerfel>
Date:   Fri, 29 Jan 2016 09:01:31 +0100
X-Google-Sender-Auth: MXewm4WnSvFDn5h8i2svsEyjXhc
Message-ID: <CAMuHMdX33SQe8n7SRda0TjQV05yP1zbuw129Jqjknt8=CY=LjA@mail.gmail.com>
Subject: Re: [linux-review:James-Hogan/kbuild-Remove-stale-asm-generic-wrappers/20160119-183642]
 d979f99e9cc14e2667e9b6e268db695977e4197a BUILD DONE
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michal Marek <mmarek@suse.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51517
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

Hi Arnd,

On Fri, Jan 29, 2016 at 12:07 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> The other related issue is the DEBUG_UART_{VIRT,PHYS} setting,
> where there is no safe platform-specific default. I have two
> ideas for working around that, maybe one of them sounds ok to
> you:
>
> a) find a way to warn and/or disable DEBUG_LL when no address
>    is set, rather than failing the build
>
> b) add 'default 0 if COMPILE_TEST' to make it harder to get this
>    wrong by accident (hopefully nobody tries to run a COMPILE_TEST
>    kernel). Also maybe add a #warning if DEBUG_UART_VIRT is

Make sure to add it at the end of the list, so enabling COMPILE_TEST in a
working .config should give another working .config.

Perhaps you can use 0xdeadbeef instead of 0, and add

    #if DEBUG_UART_PHYS == 0xdeadbeed
    #warning Broken value of DEBUG_UART_PHYS.
    #endif

somewhere?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
