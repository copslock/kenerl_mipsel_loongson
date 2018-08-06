Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Aug 2018 09:20:41 +0200 (CEST)
Received: from mail-ua0-f196.google.com ([209.85.217.196]:43849 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990418AbeHFHUfE0fiJ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 6 Aug 2018 09:20:35 +0200
Received: by mail-ua0-f196.google.com with SMTP id f4-v6so7880725uao.10
        for <linux-mips@linux-mips.org>; Mon, 06 Aug 2018 00:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DohhdhNdYx1xCcqKXqA43hzO51+Lbpw7JXsn2JAyp4k=;
        b=REsVl5RbMN6H2fOQ0guWzAOSiQNixOwUeJ9x6TBctXIwSfPGgPqQazCP2OGWsASpQQ
         4GYl0CT+AV/BtOxdrDGwtX/dIFsSgAprkr3QnbaVbXet/CxZOETCLsM0rjAj5RRBDlWi
         LPsoqaDq/IL86WtG3/DmVXEy2pUF4aCD2q3JLXQwvKmRhdTGpjw1q3WRLyT9IkRn1RJw
         mHRaLiv+vj+Gy3T2kSepUVnZQqbnXB6D6Ah4Lr6NBGnm/HJGuSGYqBm94OIRRs3CVADs
         vM9oNs+WTq3vPhDn8/8etFFHkRwlpqLAj4N0+tRGidqSMhALHZ1Pg6NjZorgm2L3vneF
         ksZw==
X-Gm-Message-State: AOUpUlHE25CrPglpMeoTx1u8VzCCIthx948Xil9OklZ/6Dzkd6Yw0WiB
        AfoNji6HkbJYk1NuKHfsLpGWNuEeD6NzfTj/wno=
X-Google-Smtp-Source: AAOMgpcaPsXFxCh8BKcRlZeYm0qCS5QzFNmeOyHrzmAD0Koezfcot81vR8RO2d/OhqXXCubKRHQ9mIv8y9TPKEZpg70=
X-Received: by 2002:ab0:4025:: with SMTP id h34-v6mr9637868uad.12.1533540029022;
 Mon, 06 Aug 2018 00:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-15-songjun.wu@linux.intel.com> <20180803055640.GA32226@kroah.com>
 <763bba56-3701-7fe9-9b31-4710594b40d5@linux.intel.com> <20180803103023.GA6557@kroah.com>
 <3360edd2-f3d8-b860-13fa-ce680edbfd0a@hauke-m.de> <20180804124309.GB4920@kroah.com>
 <CAK8P3a3qs34LuhPeaef2wPHYEWbYO5N-4n7763BcaDyppiJ6DA@mail.gmail.com> <acd28f40-4342-7f67-8468-7d4578f614a1@linux.intel.com>
In-Reply-To: <acd28f40-4342-7f67-8468-7d4578f614a1@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Aug 2018 09:20:16 +0200
Message-ID: <CAMuHMdWY9NuYOXq8sD9wmH48=vhMcSBomRY9ZbC+tGE3PGiTGg@mail.gmail.com>
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
X-archive-position: 65400
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

On Mon, Aug 6, 2018 at 9:15 AM Wu, Songjun <songjun.wu@linux.intel.com> wrote:
> On 8/5/2018 5:03 AM, Arnd Bergmann wrote:
> > On Sat, Aug 4, 2018 at 2:43 PM, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >> On Sat, Aug 04, 2018 at 12:54:22PM +0200, Hauke Mehrtens wrote:
> >>> On 08/03/2018 12:30 PM, Greg Kroah-Hartman wrote:
> >>>> On Fri, Aug 03, 2018 at 03:33:38PM +0800, Wu, Songjun wrote:
> >>> This patch makes it possible to use it with the legacy lantiq code and
> >>> also with the common clock framework. I see multiple options to fix this
> >>> problem.
> >>>
> >>> 1. The current approach to have it as a compile variant for a) legacy
> >>> lantiq arch code without common clock framework and b) support for SoCs
> >>> using the common clock framework.
> >>> 2. Convert the lantiq arch code to the common clock framework. This
> >>> would be a good approach, but it need some efforts.
> >>> 3. Remove the arch/mips/lantiq code. There are still users of this code.
> >>> 4. Use the old APIs also for the new xRX500 SoC, I do not like this
> >>> approach.
> >>> 5. Move lantiq_soc.h to somewhere in include/linux/ so it is globally
> >>> available and provide some better wrapper code.
> >> I don't really care what you do at this point in time, but you all
> >> should know better than the crazy #ifdef is not allowed to try to
> >> prevent/allow the inclusion of a .h file.  Checkpatch might have even
> >> warned you about it, right?
> >>
> >> So do it correctly, odds are #5 is correct, as that makes it work like
> >> any other device in the kernel.  You are not unique here.
> > The best approach here would clearly be 2. We don't want platform
> > specific header files for doing things that should be completely generic.
> >
> > Converting lantiq to the common-clk framework obviously requires
> > some work, but then again the whole arch/mips/lantiq/clk.c file
> > is fairly short and maybe not that hard to convert.
> >
> > >From looking at arch/mips/lantiq/xway/sysctrl.c, it appears that you
> > already use the clkdev lookup mechanism for some devices without
> > using COMMON_CLK, so I would assume that you can also use those
> > for the remaining clks, which would be much simpler. It registers
> > one anonymous clk there as
> >
> >          clkdev_add_pmu("1e100c00.serial", NULL, 0, 0, PMU_ASC1);
> >
> > so why not add replace that with two named clocks and just use
> > the same names in the DT for the newer chip?
> >
> >        Arnd
> We discussed internally and have another solution for this issue.
> Add one lantiq.h in the serial folder, and use "#ifdef preprocessor" in
> lantiq.h,
> also providing no-op stub functions in the #else case, then call those
> functions
> unconditionally from lantiq.c to avoid #ifdef in C file.
>
> To support CCF in legacy product is another topic, is not included in
> this patch.
>
> The implementation is as following：
> #ifdef CONFIG_LANTIQ
> #include <lantiq_soc.h>
> #else
> #define LTQ_EARLY_ASC 0
> #define CPHYSADDR(_val) 0
>
> static inline struct clk *clk_get_fpi(void)
> {
>      return NULL;
> }
> #endif

Why not use clkdev_add(), as Arnd suggested?
That would be a 3-line patch without introducing a new header file and an ugly
#ifdef, which complicates compile coverage testing?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
