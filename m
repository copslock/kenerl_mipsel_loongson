Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Nov 2012 13:14:12 +0100 (CET)
Received: from mail-oa0-f49.google.com ([209.85.219.49]:38951 "EHLO
        mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823910Ab2KNMOLTNWlM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Nov 2012 13:14:11 +0100
Received: by mail-oa0-f49.google.com with SMTP id l10so289822oag.36
        for <multiple recipients>; Wed, 14 Nov 2012 04:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yM97CpowIwU6VOs1KvM/kmWIv8Eb1fNGPPpJl9D7ZCU=;
        b=xgUCaixJ7p6rUos+JBmiBLoG/Yzb+NBNdHJPNHsz7vA3OANX5ia/VqMQxkSlfATlxG
         CRL+zlnSPk85nfFLYmpiFrdT15CWuLrVhYNNqFeD87YUmWLuCF0ygGrGnIhzKJorX9PA
         nwWDHko4181tRCjxcF7e+iLcb9Dl6mAMPMHzfUy7trHRQ9U+4uajPCnKvl6d4oEQQZxg
         sgZm4UIMUQUnjYVp1xfO2zTyG9uSeATFIIlhedtalhF5WSXEiDJMRPP/2gCHRFu+EXkC
         JxtzEPGP5/T7XWgf3cORWq1LWI1LSDI//0Y8l0AcA078/1vxihDh1nqFx76tvsB3kqNe
         pnQQ==
Received: by 10.60.27.166 with SMTP id u6mr19652179oeg.86.1352895244957; Wed,
 14 Nov 2012 04:14:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.76.28.70 with HTTP; Wed, 14 Nov 2012 04:13:44 -0800 (PST)
In-Reply-To: <50A1D54E.2090406@wwwdotorg.org>
References: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com>
 <1352638249-29298-12-git-send-email-jonas.gorski@gmail.com> <50A1D54E.2090406@wwwdotorg.org>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Wed, 14 Nov 2012 13:13:44 +0100
Message-ID: <CAOiHx=n7kqnnu51ObiPMeBtVYNX0n+xiBkk8FOJ0EQ5nQRbD9A@mail.gmail.com>
Subject: Re: [RFC] MIPS: BCM63XX: register GPIO controller through Device Tree
To:     Stephen Warren <swarren@wwwdotorg.org>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 35001
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 13 November 2012 06:06, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 11/11/2012 05:50 AM, Jonas Gorski wrote:
>> Register the GPIO controller through Device Tree and add the
>> appropriate values in the include files.
>>
>> Since we can't register a platform driver at this early stage move the
>> direct call to bcm63xx_gpio_init from prom_init to an arch initcall.
>
>> diff --git a/Documentation/devicetree/bindings/gpio/bcm63xx-gpio.txt b/Documentation/devicetree/bindings/gpio/bcm63xx-gpio.txt
>
>> +- #gpio-cells: Must be <2>. The first cell is the GPIO pin, and
>> +  the second one the standard linux flags.
>
> Also here, I think you want to explicitly document the flag values here
> so the bindings don't rely on the Linux kernel code. I don't think
> there's a standard central file which documents them though, although I
> vaguely recall some discussion to create add them to gpio.txt?

I'll add some more description. And yes there isn't, and I can't
comment about that since I just joined devicetree-discuss a few days
ago. It would be nice to have them there. Maybe I'll add a reference
to gpio.txt and see if I can come up with an acceptable description
for the flags.


Jonas
