Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jul 2013 07:30:49 +0200 (CEST)
Received: from mail.free-electrons.com ([94.23.35.102]:35288 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817667Ab3GBFaq0N6y1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jul 2013 07:30:46 +0200
Received: by mail.free-electrons.com (Postfix, from userid 106)
        id C38DC753; Tue,  2 Jul 2013 07:30:41 +0200 (CEST)
Received: from skate (AToulouse-651-1-103-169.w109-222.abo.wanadoo.fr [109.222.70.169])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 772AA753;
        Tue,  2 Jul 2013 07:30:40 +0200 (CEST)
Date:   Tue, 2 Jul 2013 07:30:37 +0200
From:   Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To:     Michael Ellerman <michael@ellerman.id.au>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        Lior Amsalem <alior@marvell.com>, linux-mips@linux-mips.org,
        linux-ia64@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
        linux-s390@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Chris Metcalf <cmetcalf@tilera.com>,
        linux-arm-kernel@lists.infradead.org,
        Tony Luck <tony.luck@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maen Suleiman <maen@marvell.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux390@de.ibm.com, linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCHv4 02/11] pci: use weak functions for MSI arch-specific
 functions
Message-ID: <20130702073037.55a53642@skate>
In-Reply-To: <1372726396.17904.1.camel@concordia>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
        <1372686136-1370-3-git-send-email-thomas.petazzoni@free-electrons.com>
        <1372726396.17904.1.camel@concordia>
Organization: Free Electrons
X-Mailer: Claws Mail 3.9.1 (GTK+ 2.24.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <thomas.petazzoni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37251
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@free-electrons.com
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

Dear Michael Ellerman,

On Tue, 02 Jul 2013 10:53:16 +1000, Michael Ellerman wrote:
> On Mon, 2013-07-01 at 15:42 +0200, Thomas Petazzoni wrote:
> > Until now, the MSI architecture-specific functions could be overloaded
> > using a fairly complex set of #define and compile-time
> > conditionals. In order to prepare for the introduction of the msi_chip
> > infrastructure, it is desirable to switch all those functions to use
> > the 'weak' mechanism. This commit converts all the architectures that
> > were overidding those MSI functions to use the new strategy.
> 
> The MSI code used to use weak functions, until we discovered they were
> being miscompiled on some toolchains (11df1f0). I assume these days
> we're confident they work correctly.

Hum, interesting. I see from your commit that gcc 4.3.2 was apparently
affected, and gcc 4.3.x is not /that/ old. Bjorn, what's your point of
view on this?

Another option would be to have architecture register some msi_arch_ops
structure, with a set of operations, which I believe is a pattern that
is more widespread in the kernel than weak functions.

Thoughts?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
