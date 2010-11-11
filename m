Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Nov 2010 02:23:53 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:37316 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491938Ab0KKBXu convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 11 Nov 2010 02:23:50 +0100
Received: by wyf22 with SMTP id 22so1417915wyf.36
        for <linux-mips@linux-mips.org>; Wed, 10 Nov 2010 17:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jJFUFXiYE6ovFXQTstHwjBHgbTnge0QNKnSvz1fPlXk=;
        b=ceK4aSW2dKi+8Tr+V0CbP3ZWMJJxsSyn8o4+2eMpvWwavEwlrXu/AAxLDw71vC8fo5
         58PF3G6tkrGtoBzUjXV7EZ7Z9JriT6X5zD7Fjwf14SYxpMh8AK9wBS0xeJ9mOIwoZF6c
         ZtUTO6pwiqc5aIBvRZbQCLU6VZXtA5qZOi15E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FDz80fN+bErDFfsnz+Wo3sB69u8wZ0GuEl7z9Sb8TanjberiKbonL3PLi48roxAqdv
         Kj2cU2KDNVzr400Qm7SUUrvx9ve9//8LsO4Bskso86Wf5ZHaUuZibmG+TLEFVfXyZTRg
         WYkc2ri9bIkdIFMDMKsXpsHW2jwjo9aiXa+tk=
MIME-Version: 1.0
Received: by 10.216.51.21 with SMTP id a21mr86798wec.50.1289438624715; Wed, 10
 Nov 2010 17:23:44 -0800 (PST)
Received: by 10.216.131.88 with HTTP; Wed, 10 Nov 2010 17:23:44 -0800 (PST)
In-Reply-To: <AEA634773855ED4CAD999FBB1A66D0760132BB00@CORPEXCH1.na.ads.idt.com>
References: <AEA634773855ED4CAD999FBB1A66D0760132BB00@CORPEXCH1.na.ads.idt.com>
Date:   Thu, 11 Nov 2010 09:23:44 +0800
Message-ID: <AANLkTikXc+x8Qp+oQjmytA4F6WabTN66VOmDmZWSvvuK@mail.gmail.com>
Subject: Re: Kernel is stuck in Calibrating delay loop
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28351
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, Nov 10, 2010 at 11:49 PM, Ardelean, Andrei
<Andrei.Ardelean@idt.com> wrote:
> Hi,
>
> I am porting MIPS Malta on a new platform and during the boot process
> the Kernel remains in a infinite loop in "Calibrating delay loop ..." in
> calibrate.c.
> I checked and the timer interrupt which is supposed to be wired on h/w 5
> interrupt (MIPS 7 irq) is not activated in MIPS Status.IM7 register.
> Where in the Kernel the MIPS irq wired to the timer interrupt needs to
> be enabled?  Can I use enable_irq()?
> On my platform I don't have any 8259 and I am trying to use MIPS
> Count/Compare internal timer for Kernel tick.

Did you select the r4k timer for your platform?

arch/mips/Kconfig:

config MIPS_MALTA
        [snip]
        select CEVT_R4K
        select CSRC_R4K
        [snip]

And please check if arch/mips/kernel/*r4k.c are compiled into your kernel image.

Regards,
Wu Zhangjin
