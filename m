Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jul 2013 02:53:25 +0200 (CEST)
Received: from ozlabs.org ([203.10.76.45]:56355 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835049Ab3GBAxX3BqbM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Jul 2013 02:53:23 +0200
Received: from [192.168.1.2] (124-171-102-126.dyn.iinet.net.au [124.171.102.126])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by ozlabs.org (Postfix) with ESMTPSA id 641002C0079;
        Tue,  2 Jul 2013 10:53:17 +1000 (EST)
Message-ID: <1372726396.17904.1.camel@concordia>
Subject: Re: [PATCHv4 02/11] pci: use weak functions for MSI arch-specific
 functions
From:   Michael Ellerman <michael@ellerman.id.au>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
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
Date:   Tue, 02 Jul 2013 10:53:16 +1000
In-Reply-To: <1372686136-1370-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
         <1372686136-1370-3-git-send-email-thomas.petazzoni@free-electrons.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <michael@ellerman.id.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael@ellerman.id.au
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

On Mon, 2013-07-01 at 15:42 +0200, Thomas Petazzoni wrote:
> Until now, the MSI architecture-specific functions could be overloaded
> using a fairly complex set of #define and compile-time
> conditionals. In order to prepare for the introduction of the msi_chip
> infrastructure, it is desirable to switch all those functions to use
> the 'weak' mechanism. This commit converts all the architectures that
> were overidding those MSI functions to use the new strategy.

The MSI code used to use weak functions, until we discovered they were
being miscompiled on some toolchains (11df1f0). I assume these days
we're confident they work correctly.

cheers
