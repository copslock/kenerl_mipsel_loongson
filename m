Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2018 09:34:12 +0200 (CEST)
Received: from mail-ua0-f195.google.com ([209.85.217.195]:45992 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994677AbeHGHd7D8G8o convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Aug 2018 09:33:59 +0200
Received: by mail-ua0-f195.google.com with SMTP id k8-v6so15029667uaq.12
        for <linux-mips@linux-mips.org>; Tue, 07 Aug 2018 00:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RIztZSW56qlEmpFi4Woqf2wd8+YujPd82HedacZbr7A=;
        b=cgyLAm+c/6uur9u2ZVjhNj1fo5TIzeOQT3C063dU5v3dWxSkRewdUR6rNn2Fb85RUI
         9NrP5rVIABLsgOE17oIxwNY1jtyfBtinpDFR1X/bm/S6JyhFa+CnXtauRPzp4ZG1vu8X
         WMRRVkbxbbgrW+/Z6cIYJA9kSisaI7Tcjt1CzWecVhv9tEXd5YSOKoMh3ly9WG1I7zSf
         t0kCrqwlPEZGWrjXAGv2ET2e0vVVOy+h3CIMizdD/EEbWWsado+E8GRDL+Ni3PRwabIt
         lfRv6Ljx++JZZ1GJFJv7vNBsjcA2U7SnXpfX6RbWzWashEXBdfvhEE8kFFVzRbgQM9UF
         CUZg==
X-Gm-Message-State: AOUpUlEQcYxukRHmiWAq2mhpwQUREpkqzym47dyT3XPsl1x3g+uqzVpd
        HPRpCWeXqlKayn3bwNYx0bd1NQm/hiurY3kJs0Y=
X-Google-Smtp-Source: AAOMgpcae72AYYRxaexs4Jin4o9qoUM+RYscsmBy6B4OH4ZhSWRt9dfo3cto9RiF0VOn1ui1qE8nD71QwzkgNw/1vnw=
X-Received: by 2002:a9f:37c8:: with SMTP id q66-v6mr12521003uaq.180.1533627233144;
 Tue, 07 Aug 2018 00:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-15-songjun.wu@linux.intel.com> <20180803055640.GA32226@kroah.com>
 <763bba56-3701-7fe9-9b31-4710594b40d5@linux.intel.com> <20180803103023.GA6557@kroah.com>
 <3360edd2-f3d8-b860-13fa-ce680edbfd0a@hauke-m.de> <20180804124309.GB4920@kroah.com>
 <CAK8P3a3qs34LuhPeaef2wPHYEWbYO5N-4n7763BcaDyppiJ6DA@mail.gmail.com>
 <acd28f40-4342-7f67-8468-7d4578f614a1@linux.intel.com> <CAMuHMdWY9NuYOXq8sD9wmH48=vhMcSBomRY9ZbC+tGE3PGiTGg@mail.gmail.com>
 <0ab8e6e7-3cc2-8e50-b1f3-99616437f527@linux.intel.com> <CAMuHMdUJ8-bveoHWOetjrHtq2HNPnf00PidQwJ-kZD2o86KLMw@mail.gmail.com>
 <d6d0be20-aea9-cecf-1e39-3d65c0dbad5f@linux.intel.com>
In-Reply-To: <d6d0be20-aea9-cecf-1e39-3d65c0dbad5f@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Aug 2018 09:33:39 +0200
Message-ID: <CAMuHMdXADda8fuc9_oTGQFPUnYs8gX-Bp6md5fJgu=wHvM-duw@mail.gmail.com>
Subject: Re: [PATCH v2 14/18] serial: intel: Add CCF support
To:     songjun.wu@linux.intel.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Hauke Mehrtens <hauke@hauke-m.de>, hua.ma@linux.intel.com,
        yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65444
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

Hi Songjun,

On Tue, Aug 7, 2018 at 9:18 AM Wu, Songjun <songjun.wu@linux.intel.com> wrote:
> On 8/6/2018 5:29 PM, Geert Uytterhoeven wrote:
> > On Mon, Aug 6, 2018 at 10:58 AM Wu, Songjun <songjun.wu@linux.intel.com> wrote:
> >> The reason we add a new head file is also for two macros(LTQ_EARLY_ASC
> >> and CPHYSADDR)
> >> used by legacy product. We need to provide the no-op stub for these two
> >> macro for new product.
> > No you don't. The line number should not be obtained by comparing the
> > resource address with a hardcoded base address.
> This is the previous code. Now the line number is obtained from dts.

Note that obtaining line numbers from DTS has its own share of problems, when
considering DT overlays. I've replied to the patch adding the call to
of_alias_get_id().

> We keep this code for the compatibility.
>
> Referring to the conditional-compilation part in coding-style,
> We add a header file to avoid using “#ifdef” in C file.
> > Perhaps the override of port->line should just be removed, as IIRC, the serial
> > core has already filled in that field with the (next available) line number?

Gr{oetje,eeting}s,

                        Geert--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
