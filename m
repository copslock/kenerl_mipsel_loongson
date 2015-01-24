Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jan 2015 18:52:21 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:59514 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010967AbbAXRwTwCvOb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Jan 2015 18:52:19 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1YF4sY-0005xR-Jo; Sat, 24 Jan 2015 18:52:14 +0100
Date:   Sat, 24 Jan 2015 18:51:56 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH V4 01/14] sh: Eliminate unused irq_reg_{readl,writel}
 accessors
In-Reply-To: <CAMuHMdUpxURV4ztpa3x0TORsSWtxiKxe6_EDO5QsO_vhedip0A@mail.gmail.com>
Message-ID: <alpine.DEB.2.11.1501241851090.5526@nanos>
References: <1415342669-30640-1-git-send-email-cernekee@gmail.com> <1415342669-30640-2-git-send-email-cernekee@gmail.com> <CAMuHMdW+L8YbE8Z8jrtnm8xWk63sRGaFdM7TPM6MmrDg9XwHuQ@mail.gmail.com> <20141114163843.GH29662@linux-mips.org> <20141114170525.GL3698@titan.lakedaemon.net>
 <CAMuHMdXMsxhcD9C079YPc6Toxdo0e23oqM_9KeSG=NrFa4auRQ@mail.gmail.com> <CAMuHMdUpxURV4ztpa3x0TORsSWtxiKxe6_EDO5QsO_vhedip0A@mail.gmail.com>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
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

On Mon, 19 Jan 2015, Geert Uytterhoeven wrote:
> Will you still do so, or shall I forward the patch to Andrew Morton?

akpm please.
