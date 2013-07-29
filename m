Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jul 2013 16:53:18 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52794 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825603Ab3G2OxNw5gGq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Jul 2013 16:53:13 +0200
Date:   Mon, 29 Jul 2013 15:53:13 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
cc:     John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: add proper set_mode() to cevt-r4k
In-Reply-To: <CAGVrzcYXyWB1bwoKyEFrSO7YEJx9Q_v2vOnnPnqVrFVKiigFrA@mail.gmail.com>
Message-ID: <alpine.LFD.2.03.1307291549400.9486@linux-mips.org>
References: <1375091743-20608-1-git-send-email-blogic@openwrt.org> <CAGVrzcYXyWB1bwoKyEFrSO7YEJx9Q_v2vOnnPnqVrFVKiigFrA@mail.gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Mon, 29 Jul 2013, Florian Fainelli wrote:

> It is not clear to me whether this secondary cevt is also a r4k-cevt
> device, or if it is something else? If the IRQ is shared, is there any
> way to differentiate the ralink cevt from the r4k cevt, such that both
> could request the same irq with the IRQF_SHARED flag?

 As from rev. 2 of the MIPS architecture processors are required to 
implement a CP0.Cause.TI bit to indicate a CP0.Count/CP0.Compare timer 
interrupt pending -- so it may all bail down to figuring out what MIPS
architecture level this SoC implements.  FWIW.  HTH.

  Maciej
