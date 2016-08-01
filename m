Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Aug 2016 16:24:16 +0200 (CEST)
Received: from mogw1122.ocn.ad.jp ([153.149.229.23]:52451 "EHLO
        mogw1122.ocn.ad.jp" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992854AbcHAOYI14SfH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Aug 2016 16:24:08 +0200
Received: from mf-smf-ucb008.ocn.ad.jp (mf-smf-ucb008.ocn.ad.jp [153.149.227.68])
        by mogw1122.ocn.ad.jp (Postfix) with ESMTP id D2FA4B8002A;
        Mon,  1 Aug 2016 23:24:04 +0900 (JST)
Received: from ntt.pod01.mv-mta-ucb019 ([mv-mta-ucb019.ocn.ad.jp [153.128.50.2]]) by mf-smf-ucb008.ocn.ad.jp with RELAY id u71ENCBI005314 ;
          Mon, 1 Aug 2016 23:24:04 +0900
Received: from smtp.ocn.ne.jp ([153.149.227.166])
        by ntt.pod01.mv-mta-ucb019 with 
        id RqQ41t0013c2f7501qQ4L2; Mon, 01 Aug 2016 14:24:04 +0000
Received: from localhost (p994239-ipngn803funabasi.chiba.ocn.ne.jp [180.34.224.239])
        by smtp.ocn.ne.jp (Postfix) with ESMTPA;
        Mon,  1 Aug 2016 23:24:04 +0900 (JST)
Date:   Mon, 01 Aug 2016 23:23:59 +0900 (JST)
Message-Id: <20160801.232359.1867350514422089320.anemo@mba.ocn.ne.jp>
To:     geert@linux-m68k.org
Cc:     linux-mips@linux-mips.org, linux-gpio@vger.kernel.org
Subject: Re: Revisiting rbtx4927: gpiod_direction_output_raw: invalid GPIO
From:   Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <CAMuHMdUARn_SxhkWiTsGdSixFv9a=VjKLLgQMfPTtxufrjepCg@mail.gmail.com>
References: <CAMuHMdUARn_SxhkWiTsGdSixFv9a=VjKLLgQMfPTtxufrjepCg@mail.gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 6.5 on Emacs 24.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
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

Hi Geert, sorry for loooong delay ...

On Thu, 14 Apr 2016 21:06:05 +0200, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> I've just updated my old rbtx4927 from v3.13-rc3 to v4.6-rc3.
> Surprisingly, it boots to nfsroot without any kernel changes.

Good news!  I'm happy to hear that.

> However, there's an annoying warning in the boot log:
> 
>         gpiod_direction_output_raw: invalid GPIO
> 
> This is caused by the following code in arch/mips/txx9/rbtx4927/setup.c:
> 
>         static void __init rbtx4927_mem_setup(void)
>         {
> 
>                 /* TX4927-SIO DTR on (PIO[15]) */
>                 gpio_request(15, "sio-dtr");
> 
> returns -EPROBE_DEFER
> 
>                 gpio_direction_output(15, 1);
> 
> VALIDATE_DESC triggers the warning.
> 
> Probably a silly GPIO conversion was missed during the last 2+ years?

Maybe txx9_gpio_init() failed to add gpio_chip since it was called too
early on startup.

Nowadays gpiochip_add_data calls kzalloc so cannot be called from
plat_mem_setup context.

Could you try moving these txx9_gpio_init(), gpio_request() and
gpio_direction_output() calls to rbtx4927_arch_init() or
rbtx4927_device_init()?

---
Atsushi Nemoto
