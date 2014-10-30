Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 10:10:17 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.17.24]:61824 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012246AbaJ3JKL3DwVw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 10:10:11 +0100
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue104) with ESMTP (Nemesis)
        id 0LiUpQ-1YMPwW0wm4-00cku2; Thu, 30 Oct 2014 10:10:04 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH 10/11] irqchip: bcm7120-l2: Extend driver to support 64+ bit controllers
Date:   Thu, 30 Oct 2014 10:10:03 +0100
Message-ID: <1819614.RKinL4RR5c@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <CAJiQ=7D+QhFjg7mR49KE2Lu1SC72djBLhbv4sC37tSTga+BVCQ@mail.gmail.com>
References: <1414555138-6500-1-git-send-email-cernekee@gmail.com> <7518897.LmfE2WsusV@wuerfel> <CAJiQ=7D+QhFjg7mR49KE2Lu1SC72djBLhbv4sC37tSTga+BVCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:jbNa0XWXVSPjIKP3903oQzg6yEIckIBIV4MJOoTZtVn
 cwRqT8a80s0LlcZTh1p/xhYJnVshA2ppI409oUm3ChjTkC7sA7
 znKEQg3XYqDjXnpzk18M/4ncemMuHTjVEdwj/PaSX8zg1EAxcM
 8ExSp4hDYX+1qQj139wTWGXyxySTTGbb5HliewO7LH+54fJPZX
 tW5Uuw2FttQ9cFvKMRrwZDIB/s4N/1YvsNZhYEbmo1jKHZem2m
 SP6hP61ugZx1/1HF5q1e/sFbQ6TXaMbcXD+ZlZGI87PP0lZ7K7
 j5dCWsIsLCYn4YCsGp56neiV3/f1J0KLk5NfhoDhi2lVBwrlQT
 qTfJKQPkett+DPz33EvQ=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43761
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Wednesday 29 October 2014 16:22:31 Kevin Cernekee wrote:
> 
> This uses one domain per bcm7120-l2 DT node.  If the DT node defines
> multiple enable/status pairs (i.e. >=64 IRQs) then the driver will
> create a single IRQ domain with 2+ generic chips.
> 
> Multiple generic chips are required because the generic-chip code can
> only handle one enable/status register pair per instance.
> 

Makes sense. Just make sure you have that explanation in the patch
description.

	Arnd
