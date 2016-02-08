Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 11:39:58 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:33919 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010210AbcBHKj4pBjRu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2016 11:39:56 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1aSjEW-0008LA-A9; Mon, 08 Feb 2016 11:39:52 +0100
Date:   Mon, 8 Feb 2016 11:38:43 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     David Daney <ddaney@caviumnetworks.com>
cc:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 6/7] [PATCH] MIPS: OCTEON: Add support for OCTEON III
 interrupt controller.
In-Reply-To: <56B4DA3B.40607@caviumnetworks.com>
Message-ID: <alpine.DEB.2.11.1602081137460.25254@nanos>
References: <1454632974-7686-1-git-send-email-ddaney.cavm@gmail.com> <1454632974-7686-7-git-send-email-ddaney.cavm@gmail.com> <alpine.DEB.2.11.1602050954480.25254@nanos> <56B4DA3B.40607@caviumnetworks.com>
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
X-archive-position: 51844
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

On Fri, 5 Feb 2016, David Daney wrote:
> On 02/05/2016 01:06 AM, Thomas Gleixner wrote:
> > > +int octeon_irq_ciu3_xlat(struct irq_domain *d,
> > 
> > static ?
> 
> To be used in follow-on patch for MSI-X irq_chip driver residing in a separate
> file.
> 
> The idea was to not be changing the to/from static multiple times as the new
> patches were merged.  If you think it preferable, I can make them all static
> and then remove the static later, when needed.

Nah. It was just not clear from reading this patch. A hint in the changelog
might be helpful.
 
Thanks,

	tglx
