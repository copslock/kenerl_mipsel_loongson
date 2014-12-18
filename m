Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Dec 2014 00:34:01 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:42236 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008199AbaLRXd7eeen9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Dec 2014 00:33:59 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1Y1kZv-0000OY-1q; Fri, 19 Dec 2014 00:33:55 +0100
Date:   Fri, 19 Dec 2014 00:33:49 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Joe Perches <joe@perches.com>
cc:     linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Steven Miao <realmz6@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: rfc: remove early_printk from a few arches? (blackfin, m68k,
 mips)
In-Reply-To: <1418849927.28384.1.camel@perches.com>
Message-ID: <alpine.DEB.2.11.1412190031530.17382@nanos>
References: <1418849927.28384.1.camel@perches.com>
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
X-archive-position: 44820
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

On Wed, 17 Dec 2014, Joe Perches wrote:
> It seems like early_printk can be configured into
> a few architectures but also appear not to be used.
> 
> $ git grep -w "early_printk"
...
> These seem to the only uses:
... 
> So blackfin, m68k, and mips seems to have it possible to enable,
> but also don't appear at first glance to use it,

Hint: CONFIG_EARLY_PRINTK covers far more than early_printk()
 
> Is early_printk really used by these architectures?
> Should it be removed?

Sure, if you have a good reason to remove working functionality.

Thanks,

	tglx
