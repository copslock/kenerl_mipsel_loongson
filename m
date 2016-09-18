Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Sep 2016 02:47:14 +0200 (CEST)
Received: from omzsmtpe03.verizonbusiness.com ([199.249.25.208]:7920 "EHLO
        omzsmtpe03.verizonbusiness.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992249AbcIRArIFC7F8 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 18 Sep 2016 02:47:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1474159627; x=1505695627;
  h=from:to:cc:date:subject:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/0wSc/+7Ei0A5FQt7RE2EUbdNh+UaMhrW4SjixbGV50=;
  b=H/ayW1VN59m8969Bvu7IhphE3BnMET0ad5peL+o6k9H8FVJpuEj4DNbP
   cyGQxJIC1doGYToEcF9srzJCRCaBFInHIIghZcYNl4S/hKtb1ULvsab+j
   hw+ypMqa+De+CCIe17Hx0HGUUD5QWCm5OlxIZKwL8uEbMOw5F/DBOuazG
   c=;
X-IronPort-Anti-Spam-Filtered: false
Received: from omzsmtpi01.vzbi.com ([165.122.46.171])
  by omzsmtpe03.verizonbusiness.com with ESMTP; 18 Sep 2016 00:47:00 +0000
From:   "Levin, Alexander" <alexander.levin@verizon.com>
X-IronPort-AV: E=Sophos;i="5.30,353,1470700800"; 
   d="scan'208";a="764534938"
Received: from fhdp1lumxc7hb01.verizon.com (HELO FHDP1LUMXC7HB01.us.one.verizon.com) ([166.68.59.188])
  by omzsmtpi01.vzbi.com with ESMTP; 18 Sep 2016 00:46:59 +0000
Received: from FHDP1LUMXC7V93.us.one.verizon.com ([166.68.240.160]) by
 FHDP1LUMXC7HB01.us.one.verizon.com ([166.68.59.188]) with mapi; Sat, 17 Sep
 2016 20:46:58 -0400
To:     Willy Tarreau <w@1wt.eu>
CC:     James Hogan <james.hogan@imgtec.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?iso-8859-1?Q?Radim_Kr=3F=3Fm=E1=3F=3F?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Date:   Sat, 17 Sep 2016 20:46:55 -0400
Subject: Re: [PATCH BACKPORT 3.10-3.16] MIPS: KVM: Check for pfn noslot case
Thread-Topic: [PATCH BACKPORT 3.10-3.16] MIPS: KVM: Check for pfn noslot case
Thread-Index: AdIRRij6XTD6iCuuQHqcbYwNw2SKzw==
Message-ID: <20160918004655.GB16340@sasha-lappy>
References: <8d00898f91834454a4daf5c4944ddace9c6866f4.1473975914.git-series.james.hogan@imgtec.com>
 <20160915220829.GB17443@1wt.eu>
In-Reply-To: <20160915220829.GB17443@1wt.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.5.24 (2015-08-30)
acceptlanguage: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <alexander.levin@verizon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.levin@verizon.com
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

On Fri, Sep 16, 2016 at 12:08:29AM +0200, Willy Tarreau wrote:
> On Thu, Sep 15, 2016 at 10:51:27PM +0100, James Hogan wrote:
> > commit ba913e4f72fc9cfd03dad968dfb110eb49211d80 upstream.
> (...)
> 
> Queued for 3.10, thank you James.

And 3.18 + 4.1. Thanks James!

-- 

Thanks,
Sasha
From geert.uytterhoeven@gmail.com Sun Sep 18 12:26:59 2016
Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Sep 2016 12:27:05 +0200 (CEST)
Received: from mail-io0-f194.google.com ([209.85.223.194]:34297 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991957AbcIRK06yzrgV convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 18 Sep 2016 12:26:58 +0200
Received: by mail-io0-f194.google.com with SMTP id y139so3689484ioy.1
        for <linux-mips@linux-mips.org>; Sun, 18 Sep 2016 03:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=bvWvd73bJMSyp4bJ+5NNjIUyusx4SWQnGRwbVgnpHlw=;
        b=mJDxRi5ZUauDUgxGsAAxWEhh4qTP7BaX4iG03gqpzKWfmJKxWW92p9YurGAjYb158A
         ElWft4O/vLQRF7P3ioa4soTZfYTmbWPY3zU/5cfs98aiJV8MWUljQ1s1Wf8hS0I8OaUi
         8EEok4DBH9+XgNBdh0+kfRSxQycNcvStXaCDdICieXn7zYNAD3SQetASiwyhhH/9bBUY
         TwY0vzrqYjZTQPexxuHaV6qCG6WovxSa9CplNdjvUilI9XkAaXYPU24i+ntxqZ0CyfIh
         4Q0XldHX2eOLVZprLlGFDIRTBwRJ65135kozFBTIj30rijAuPxUj2u3psMJx6H2u+MeL
         M1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=bvWvd73bJMSyp4bJ+5NNjIUyusx4SWQnGRwbVgnpHlw=;
        b=ftBGsIRm2jz7QmXEuLLUxCniwoM9MyTzndquCkSdDC7T4T29FinXIUucW2AcwL5JA1
         8w7R8v6NeDc8acDted83VdSrvcsKmyXoBa6lFIWf+JbjKvkUx4CNZPGhWn+JfNiCQVsV
         0qqQZvK4vV7Bey0fqRaQnCgbJ/jmWFi//xI0BIUuw8uTSX83TmddGqlmypIZwzDV089o
         ERm0Rif7Arr67xeq4HX1gf8Dms9x/WjvN7Cszul4CIS7RcwYnlslPMmHHnBLgrb5ogDW
         LGbRioEU4loRLZuOeqhp2pUt78rAN81iZo2fXI7UQyzPlMowpVenyREdKuMG8vWiDl6W
         Ca5A==
X-Gm-Message-State: AE9vXwN82c7+ROhMIs/q5Lv5n7LQrWp0mrP+C/YUskfrbUSzhXhrnPBDuMEVIYy5hZ2DmGoipVCeo8F9yVR6gQ==
X-Received: by 10.107.164.228 with SMTP id d97mr30663239ioj.185.1474194412984;
 Sun, 18 Sep 2016 03:26:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.91 with HTTP; Sun, 18 Sep 2016 03:26:52 -0700 (PDT)
In-Reply-To: <57DBA464.9010506@arm.com>
References: <CAMuHMdVW1eTn20=EtYcJ8hkVwohaSuH_yQXrY2MGBEvZ8fpFOg@mail.gmail.com>
 <1473980577.17787.21.camel@gmail.com> <57DBA464.9010506@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 18 Sep 2016 12:26:52 +0200
X-Google-Sender-Auth: toovJ76NTBZ7F2P26USsIGMX2us
Message-ID: <CAMuHMdW+MdtdcdD=7J3BFobaUBnFhfUdyUD8g8u6hx5TuqyHPA@mail.gmail.com>
Subject: Re: genirq: Setting trigger mode 0 for irq 11 failed (txx9_irq_set_type+0x0/0xb8)
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Alban Browaeys <alban.browaeys@gmail.com>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55158
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

Hi Marc,

On Fri, Sep 16, 2016 at 9:51 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 16/09/16 00:02, Alban Browaeys wrote:
>> Le mercredi 14 septembre 2016 à 21:25 +0200, Geert Uytterhoeven a
>> écrit :
>>> JFYI, with v4.8-rc6 I'm seeing
>>>
>>>     genirq: Setting trigger mode 0 for irq 11 failed
>>> (txx9_irq_set_type+0x0/0xb8)
>>>
>>> on rbtx4927. This did not happen with v4.8-rc3.
>>
>> txx9_irq_set_type receives a type IRQ_TYPE_NONE from the call to
>> __irq_set_trigger added in:
>> 1e12c4a939 ("genirq: Correctly configure the trigger on chained interrupts")

Yep, that's the commit that introduced the issue.

>> This patch is a regression fix for :
>>
>> Desc: irqdomain: Don't set type when mapping an IRQ breaks nexus7 gpio buttons
>> Repo: 2016-07-30 https://marc.info/?l=linux-kernel&m=146985356305280&w=2
>>
>> I am seeing this on arm odroid u2 devicetree :
>> genirq: Setting trigger mode 0 for irq 16 failed (gic_set_type+0x0/0x64)
>
> Passing IRQ_TYPE_NONE to a cascading interrupt is risky at best...
> Can you point me to the various DTs and their failing interrupts?

Rbtx4927 does not use DT. The issue is triggered during:

    irq_set_chained_handler(RBTX4927_IRQ_IOCINT, handle_simple_irq);

in arch/mips/txx9/rbtx4927/irq.c:toshiba_rbtx4927_irq_ioc_init(),
which is inlined into rbtx4927_irq_setup().

> Also, can you please give the following patch a go and let me know
> if that fixes the issue (I'm interested in the potential warning here).
>
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 6373890..8422779 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -820,6 +820,8 @@ __irq_do_set_handler(struct irq_desc *desc, irq_flow_handler_t handle,
>         desc->name = name;
>
>         if (handle != handle_bad_irq && is_chained) {
> +               unsigned int type = irqd_get_trigger_type(&desc->irq_data);
> +
>                 /*
>                  * We're about to start this interrupt immediately,
>                  * hence the need to set the trigger configuration.
> @@ -828,8 +830,10 @@ __irq_do_set_handler(struct irq_desc *desc, irq_flow_handler_t handle,
>                  * chained interrupt. Reset it immediately because we
>                  * do know better.
>                  */
> -               __irq_set_trigger(desc, irqd_get_trigger_type(&desc->irq_data));
> -               desc->handle_irq = handle;
> +               if (!(WARN_ON(type == IRQ_TYPE_NONE))) {
> +                       __irq_set_trigger(desc, type);
> +                       desc->handle_irq = handle;
> +               }
>
>                 irq_settings_set_noprobe(desc);
>                 irq_settings_set_norequest(desc);

This indeed makes the issue go away:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at kernel/irq/chip.c:833 __irq_do_set_handler+0x144/0x1b4
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted
4.8.0-rc6-rbtx4927-01162-g1596ef0280a363ac-dirty #50
Stack : 00000000 10000000 0000000b 00000004 80453f47 804542d8 80429ff8 00000000
         804a36c8 00000341 80789384 000001e0 803c70b0 8014a19c 80460ac8 80460acc
         804314ec 00000000 8042f408 80451d94 80789384 80173624 803c70b0 8014a19c
         00000007 000009e0 00000000 00000000 00000000 00000000 00000000 0000000

         00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
         ...
Call Trace:
[<8010abf0>] show_stack+0x50/0x84
[<8012100c>] __warn+0xe4/0x118
[<80121098>] warn_slowpath_null+0x1c/0x28
[<8014f7a0>] __irq_do_set_handler+0x144/0x1b4
[<8014f860>] __irq_set_handler+0x50/0x7c
[<804740ac>] tx4927_irq_init+0x34/0xa8
[<80475e9c>] rbtx4927_irq_setup+0x30/0xd0
[<8046e9c0>] start_kernel+0x288/0x450

---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at kernel/irq/chip.c:833 __irq_do_set_handler+0x144/0x1b4
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Tainted: G        W
4.8.0-rc6-rbtx4927-01162-g1596ef0280a363ac-dirty #50
Stack : 00000000 10000400 00000009 00000004 80453f47 804542d8 80429ff8 00000000
         804a36c8 00000341 80789384 000001e0 803c70b0 8014a19c 80460ac8 80460acc
         804314ec 00000000 8042f408 80451dac 80789384 80173624 803c70b0 8014a19c
         00000000 00000f00 00000000 00000000 00000000 00000000 00000000 00000000
         00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
         ...
Call Trace:
[<8010abf0>] show_stack+0x50/0x84
[<8012100c>] __warn+0xe4/0x118
[<80121098>] warn_slowpath_null+0x1c/0x28
[<8014f7a0>] __irq_do_set_handler+0x144/0x1b4
[<8014f860>] __irq_set_handler+0x50/0x7c
[<80475f18>] rbtx4927_irq_setup+0xac/0xd0
[<8046e9c0>] start_kernel+0x288/0x450

---[ end trace f68728a0d3053b52 ]---

/proc/interrupts says:

               CPU0
      7:      11977      MIPS   7  timer
     13:      30586      TXX9  RBHMA4X00-RTL8019
     16:        293      TXX9  serial_txx9
     30:          0      TXX9  PCI error
    ERR:          3

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
