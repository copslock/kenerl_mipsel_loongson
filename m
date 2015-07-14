Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 11:58:39 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:60113 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009266AbbGNJ6hVEHJ2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jul 2015 11:58:37 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZEwyw-00044Y-9d; Tue, 14 Jul 2015 11:58:34 +0200
Date:   Tue, 14 Jul 2015 11:58:27 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Manuel Lauss <manuel.lauss@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [patch 08/12] MIPS/alchemy: Remove pointless irqdisable/enable
In-Reply-To: <20150714090239.GO21180@linux-mips.org>
Message-ID: <alpine.DEB.2.11.1507141158020.20072@nanos>
References: <20150713200602.799079101@linutronix.de> <20150713200715.113667554@linutronix.de> <CAOLZvyEEzWRU2RoMODPg13TMgi9jLGOUmp=AuBUA230KmgKODQ@mail.gmail.com> <alpine.DEB.2.11.1507141012360.20072@nanos> <CAOLZvyHxZdphtT6rw73=J-_HnFueNcmtxMCHZ-K=JsJt+UHKkg@mail.gmail.com>
 <20150714090239.GO21180@linux-mips.org>
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
X-archive-position: 48266
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

On Tue, 14 Jul 2015, Ralf Baechle wrote:
> On Tue, Jul 14, 2015 at 10:55:08AM +0200, Manuel Lauss wrote:
> > Yes.  Add #include <linux/irqchip/chained_irq.h> on top and it works again.
> > This hardware is problematic, an older variant with identical verilog
> > code in the cpld's
> > irq unit works fine without this.
> 
> So shall I merge both patches and the header file change together or?

Yes please.
