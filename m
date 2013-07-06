Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Jul 2013 18:18:06 +0200 (CEST)
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:43516 "EHLO
        mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6817419Ab3GFQSE57O3Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 6 Jul 2013 18:18:04 +0200
Received: from pool-72-84-113-162.nrflva.fios.verizon.net ([72.84.113.162] helo=titan)
        by mho-01-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.72)
        (envelope-from <jason@lakedaemon.net>)
        id 1UvVBH-0008Cn-11; Sat, 06 Jul 2013 16:17:51 +0000
Received: from titan.lakedaemon.net (localhost [127.0.0.1])
        by titan (Postfix) with ESMTP id 4F1B645F64F;
        Sat,  6 Jul 2013 12:17:43 -0400 (EDT)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Originating-IP: 72.84.113.162
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+2OC/xE6UIElSscpZbWdcHGfw5Q4UAc70=
Date:   Sat, 6 Jul 2013 12:17:43 -0400
From:   Jason Cooper <jason@lakedaemon.net>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lior Amsalem <alior@marvell.com>,
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
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Tony Luck <tony.luck@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maen Suleiman <maen@marvell.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux390@de.ibm.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCHv4 03/11] pci: remove ARCH_SUPPORTS_MSI kconfig option
Message-ID: <20130706161743.GM2569@titan.lakedaemon.net>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372686136-1370-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo73iSBg+SYwZLea0qdXD1uVc3+Vacd8Tg4CU92vLG=2AQ@mail.gmail.com>
 <20130705234501.1341f52e@skate>
 <20130706135433.GL2569@titan.lakedaemon.net>
 <CAErSpo4uN2MifYHbFiUfQ+6TE-hBkbWYdnAvabj8jCTOd5g+1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAErSpo4uN2MifYHbFiUfQ+6TE-hBkbWYdnAvabj8jCTOd5g+1A@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <jason@lakedaemon.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37276
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jason@lakedaemon.net
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

On Sat, Jul 06, 2013 at 09:40:55AM -0600, Bjorn Helgaas wrote:
> On Sat, Jul 6, 2013 at 7:54 AM, Jason Cooper <jason@lakedaemon.net> wrote:
> > On Fri, Jul 05, 2013 at 11:45:01PM +0200, Thomas Petazzoni wrote:
> >> Dear Bjorn Helgaas,
> >>
> >> On Fri, 5 Jul 2013 15:37:33 -0600, Bjorn Helgaas wrote:
> >>
> >> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> >> >
> >> > Again, please update the subject line to "PCI: Remove ..."
> >> >
> >> > I doubt that you'll get explicit acks from all the arches you touched,
> >> > but I think it's reasonable to put at least patches 2 & 3 in -next
> >> > soon after v3.11-rc1, so we should have time to shake out issues.
> >>
> >> Sure. Which merge strategy do you suggest for this patch series, which
> >> touches a number of different areas, and has some build-time
> >> dependencies between the patches (if needed, I can detail those build
> >> time dependencies to help figuring out the best strategy).
> >
> > If we end up handling this the same as the of/pci & mvebu-pcie series
> > (whole series through mvebu -> arm-soc) I can have it up in -next within
> > a few days of -rc1.  Just let me know.
> 
> That sounds fine with me.  I don't think it's worth trying to split
> out the drivers/pci stuff and trying to coordinate it going through
> different trees.

Ok, will do.

Thomas, I assume there will be one more version to address Bjorn's last
comments?

thx,

Jason.
