Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Jul 2013 18:33:53 +0200 (CEST)
Received: from mail.free-electrons.com ([94.23.35.102]:35920 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823081Ab3GFQduherT8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 6 Jul 2013 18:33:50 +0200
Received: by mail.free-electrons.com (Postfix, from userid 106)
        id 150047D2; Sat,  6 Jul 2013 18:33:43 +0200 (CEST)
Received: from skate (AToulouse-651-1-103-169.w109-222.abo.wanadoo.fr [109.222.70.169])
        by mail.free-electrons.com (Postfix) with ESMTPSA id C0ED57A6;
        Sat,  6 Jul 2013 18:33:41 +0200 (CEST)
Date:   Sat, 6 Jul 2013 18:33:41 +0200
From:   Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To:     Jason Cooper <jason@lakedaemon.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lior Amsalem <alior@marvell.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Grant Likely <grant.likely@secretlab.ca>,
        Thierry Reding <thierry.reding@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
        linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
        "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Rob Herring <rob.herring@calxeda.com>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maen Suleiman <maen@marvell.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux390@de.ibm.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCHv4 03/11] pci: remove ARCH_SUPPORTS_MSI kconfig option
Message-ID: <20130706183341.379d2fea@skate>
In-Reply-To: <20130706161743.GM2569@titan.lakedaemon.net>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
        <1372686136-1370-4-git-send-email-thomas.petazzoni@free-electrons.com>
        <CAErSpo73iSBg+SYwZLea0qdXD1uVc3+Vacd8Tg4CU92vLG=2AQ@mail.gmail.com>
        <20130705234501.1341f52e@skate>
        <20130706135433.GL2569@titan.lakedaemon.net>
        <CAErSpo4uN2MifYHbFiUfQ+6TE-hBkbWYdnAvabj8jCTOd5g+1A@mail.gmail.com>
        <20130706161743.GM2569@titan.lakedaemon.net>
Organization: Free Electrons
X-Mailer: Claws Mail 3.9.1 (GTK+ 2.24.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <thomas.petazzoni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37277
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

Dear Jason Cooper,

On Sat, 6 Jul 2013 12:17:43 -0400, Jason Cooper wrote:

> > > If we end up handling this the same as the of/pci & mvebu-pcie series
> > > (whole series through mvebu -> arm-soc) I can have it up in -next within
> > > a few days of -rc1.  Just let me know.
> > 
> > That sounds fine with me.  I don't think it's worth trying to split
> > out the drivers/pci stuff and trying to coordinate it going through
> > different trees.
> 
> Ok, will do.
> 
> Thomas, I assume there will be one more version to address Bjorn's last
> comments?

Yes, indeed. I was waiting to see if Thierry Redding would give some
additional feedback on Bjorn's comment, but if he doesn't, I'll resend
an updated version, most likely next week.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
