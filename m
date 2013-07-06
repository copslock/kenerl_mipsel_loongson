Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Jul 2013 15:54:57 +0200 (CEST)
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:23948 "EHLO
        mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6817419Ab3GFNyzD0xAE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 6 Jul 2013 15:54:55 +0200
Received: from pool-72-84-113-162.nrflva.fios.verizon.net ([72.84.113.162] helo=titan)
        by mho-01-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.72)
        (envelope-from <jason@lakedaemon.net>)
        id 1UvSwk-000DfJ-US; Sat, 06 Jul 2013 13:54:42 +0000
Received: from titan.lakedaemon.net (localhost [127.0.0.1])
        by titan (Postfix) with ESMTP id BA88945F529;
        Sat,  6 Jul 2013 09:54:33 -0400 (EDT)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Originating-IP: 72.84.113.162
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX180+krwpg+c/bjrcZ7VudixnPD3IILOvY0=
Date:   Sat, 6 Jul 2013 09:54:33 -0400
From:   Jason Cooper <jason@lakedaemon.net>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
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
        Rob Herring <rob.herring@calxeda.com>,
        Chris Metcalf <cmetcalf@tilera.com>,
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
Message-ID: <20130706135433.GL2569@titan.lakedaemon.net>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372686136-1370-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo73iSBg+SYwZLea0qdXD1uVc3+Vacd8Tg4CU92vLG=2AQ@mail.gmail.com>
 <20130705234501.1341f52e@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130705234501.1341f52e@skate>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <jason@lakedaemon.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37274
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

On Fri, Jul 05, 2013 at 11:45:01PM +0200, Thomas Petazzoni wrote:
> Dear Bjorn Helgaas,
> 
> On Fri, 5 Jul 2013 15:37:33 -0600, Bjorn Helgaas wrote:
> 
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Again, please update the subject line to "PCI: Remove ..."
> > 
> > I doubt that you'll get explicit acks from all the arches you touched,
> > but I think it's reasonable to put at least patches 2 & 3 in -next
> > soon after v3.11-rc1, so we should have time to shake out issues.
> 
> Sure. Which merge strategy do you suggest for this patch series, which
> touches a number of different areas, and has some build-time
> dependencies between the patches (if needed, I can detail those build
> time dependencies to help figuring out the best strategy).

If we end up handling this the same as the of/pci & mvebu-pcie series
(whole series through mvebu -> arm-soc) I can have it up in -next within
a few days of -rc1.  Just let me know.

hth,

Jason.
