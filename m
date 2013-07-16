Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jul 2013 09:13:15 +0200 (CEST)
Received: from mail-ee0-f47.google.com ([74.125.83.47]:37481 "EHLO
        mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835056Ab3GPVhkpqvEJ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Jul 2013 23:37:40 +0200
Received: by mail-ee0-f47.google.com with SMTP id e49so641113eek.34
        for <multiple recipients>; Tue, 16 Jul 2013 14:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:organization:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :content-type;
        bh=6Ciq+dPUd57ZMNBg6C7lTgzqqaC1KBlyqsZiS0dONdI=;
        b=jpeTV6F0j5+tfDs1035FPaXvAb1StPfTLPj4jlxZGJIwsD1GZGEjP2Nq9jxtYvSa9r
         8A7QN8PrEB9g01Gt7wpJoBib/YZO7Zl5k5eq40+0sDM+WP87ZR1xXLfUvZdgfTMw9fC3
         pYh/0lNKxd/wMUmcJfe28gEIPbibfpkTgP+gwCugJ7QzGlYOOE7Jvlnr58trJhD1/RFb
         P+w8RBnb/91UWz8/JFk5Uedz915onz46AYCOoz1eiAfDRQ7KCwA4mtiq7ePjtSt7sQgY
         qPT0n/Ksr2mviGdcnJry76+HKywOuX0GhCVPYL57TZTwYpn57VP3g8xqkcCKK48CEnjc
         hw+w==
X-Received: by 10.15.61.67 with SMTP id h43mr3354967eex.102.1374010654977;
        Tue, 16 Jul 2013 14:37:34 -0700 (PDT)
Received: from lenovo.localnet (cpc24-aztw25-2-0-cust938.aztw.cable.virginmedia.com. [92.233.35.171])
        by mx.google.com with ESMTPSA id l42sm5763008eeo.14.2013.07.16.14.37.32
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 16 Jul 2013 14:37:33 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH 00/10] MIPS: BCM63XX: improve BMIPS support
Date:   Tue, 16 Jul 2013 22:37:30 +0100
Message-ID: <3411491.V9mU8AUdtK@lenovo>
Organization: OpenWrt
User-Agent: KMail/4.10.4 (Linux/3.8.0-26-generic; KDE/4.10.4; x86_64; ; )
In-Reply-To: <CAGVrzcbJ1N=Tr8jUpk1YHjMUZ1+psDRYj8edb3JKbb6EBkozWg@mail.gmail.com>
References: <1372537073-27370-1-git-send-email-jogo@openwrt.org> <CAGVrzcbJ1N=Tr8jUpk1YHjMUZ1+psDRYj8edb3JKbb6EBkozWg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37305
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

Le mardi 16 juillet 2013 14:06:36 Florian Fainelli a écrit :
> Hello Jonas,
> 
> 2013/6/29 Jonas Gorski <jogo@openwrt.org>:
> > This patchset aims at unifying the different BMIPS support code to allow
> > building a kernel that runs on multiple BCM63XX SoCs which might have
> > different BMIPS flavours on them, regardless of SMP support enabled in
> > the kernel.
> > 
> > The first few patches clean up BMIPS itself and prepare it for multi-cpu
> > support, while the latter add support to BCM63XX for running a SMP kernel
> > with support for all SoCs, even those that do not have a SMP capable
> > CPU.
> > 
> > This patchset is runtime tested on BCM6348, BCM6328 and BCM6368, to
> > verify that it actually does what it claims it does.
> > 
> > Lacking hardware, it is only build tested for BMIPS4380 and BMIPS5000.
> > 
> > Jonas Gorski (10):
> >   MIPS: bmips: fix compilation for BMIPS5000
> >   MIPS: allow asm/cpu.h to be included from assembly
> >   MIPS: bmips: add macros for testing the current bmips CPU
> >   MIPS: bmips: change compile time checks to runtime checks
> >   MIPS: bmips: merge CPU options into one option
> >   MIPS: BCM63XX: let the individual SoCs select the appropriate CPUs
> >   MIPS: bmips: add a helper function for registering smp ops
> >   MIPS: BCM63XX: always register bmips smp ops
> >   MIPS: BCM63XX: change the guard to a BMIPS4350 check
> >   MIPS: BCM63XX: disable SMP also on BCM3368
> 
> After fixing the typo on BMIPS4350 vs BMIPS4380 and fixing the
> following (which I will submit just in a few minutes)

I just gave this patchset a try on a BMIPS5000 system, but unfortunately the 
kernel crashes early on due to a change in smp-bmips.c. It crashed in 
mem_init(), and adding a printk in bmips_ebase_setup() in the final else clause 
before the return did no longer make the kernel crash. This could be some 
nasty cache issue and simply changing the kernel size did help. Will 
investigate this more.
-- 
Florian
