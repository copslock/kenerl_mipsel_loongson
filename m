Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Apr 2013 12:57:40 +0200 (CEST)
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:33620 "EHLO
        cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6835024Ab3DVK5jmZFNt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Apr 2013 12:57:39 +0200
Received: from arm.com (e106165-lin.cambridge.arm.com [10.1.197.23])
        by cam-smtp0.cambridge.arm.com (8.13.8/8.13.8) with ESMTP id r3MAvOVs029000;
        Mon, 22 Apr 2013 11:57:24 +0100
Date:   Mon, 22 Apr 2013 11:57:24 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Grant Likely <grant.likely@secretlab.ca>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
        "jgunthorpe@obsidianresearch.com" <jgunthorpe@obsidianresearch.com>,
        "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
        "siva.kallam@samsung.com" <siva.kallam@samsung.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree-discuss@lists.ozlabs.org" 
        <devicetree-discuss@lists.ozlabs.org>,
        "jg1.han@samsung.com" <jg1.han@samsung.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "kgene.kim@samsung.com" <kgene.kim@samsung.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "suren.reddy@samsung.com" <suren.reddy@samsung.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "thomas.petazzoni@free-electrons.com" 
        <thomas.petazzoni@free-electrons.com>,
        "thierry.reding@avionic-design.de" <thierry.reding@avionic-design.de>,
        "thomas.abraham@linaro.org" <thomas.abraham@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
Subject: Re: [PATCH v7 2/3] of/pci: Provide support for parsing PCI DT
 ranges property
Message-ID: <20130422105724.GB17007@arm.com>
References: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com>
 <1366107508-12672-3-git-send-email-Andrew.Murray@arm.com>
 <20130418134401.84AEE3E1319@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130418134401.84AEE3E1319@localhost>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <andrew.murray@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrew.murray@arm.com
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

On Thu, Apr 18, 2013 at 02:44:01PM +0100, Grant Likely wrote:
> On Tue, 16 Apr 2013 11:18:27 +0100, Andrew Murray <Andrew.Murray@arm.com> wrote:

> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 
> But comments below...
> 

I've updated the patchset (now v8) to reflect your feedback, after a closer
look...

> > -
> > -		pr_debug("pci_space: 0x%08x pci_addr:0x%016llx ",
> > -				pci_space, pci_addr);
> > -		pr_debug("cpu_addr:0x%016llx size:0x%016llx\n",
> > -					cpu_addr, size);
> > -
> > -		ranges += np;
> > +		pr_debug("pci_space: 0x%08x pci_addr: 0x%016llx ",
> > +				range.pci_space, range.pci_addr);
> > +		pr_debug("cpu_addr: 0x%016llx size: 0x%016llx\n",
> > +				range.cpu_addr, range.size);
> 
> Nit: the patch changed whitespace on the pr_debug() statements, so even
> though the first line of each is identical, they look different in the
> patch.
> 

Actually the first line isn't identical, the original file was inconsistent
with its use of spaces between ':' and '0x%0' - my patch ensured that there
was always a space. I guess this could have been done as a separate patch.

> >  
> >  		/* If we failed translation or got a zero-sized region
> >  		 * (some FW try to feed us with non sensical zero sized regions
> >  		 * such as power3 which look like some kind of attempt
> >  		 * at exposing the VGA memory hole)
> >  		 */
> > -		if (cpu_addr == OF_BAD_ADDR || size == 0)
> > +		if (range.cpu_addr == OF_BAD_ADDR || range.size == 0)
> >  			continue;
> 
> Can this also be rolled into the parsing iterator?
> 

I decided not to do this. Mainly because ARM drivers use the parser directly
(instead of pci_process_bridge_OF_ranges function) and it seemed perfectly
valid for the parser to return a range of size 0 if that is what was present in
the DT.

> >  
> > -		/* Now consume following elements while they are contiguous */
> > -		for (; rlen >= np * sizeof(u32);
> > -		     ranges += np, rlen -= np * 4) {
> > -			if (ranges[0] != pci_space)
> > -				break;
> > -			pci_next = of_read_number(ranges + 1, 2);
> > -			cpu_next = of_translate_address(dev, ranges + 3);
> > -			if (pci_next != pci_addr + size ||
> > -			    cpu_next != cpu_addr + size)
> > -				break;
> > -			size += of_read_number(ranges + pna + 3, 2);
> > -		}
> > -
> >  		/* Act based on address space type */
> >  		res = NULL;
> > -		switch ((pci_space >> 24) & 0x3) {
> > -		case 1:		/* PCI IO space */
> > +		res_type = range.flags & IORESOURCE_TYPE_BITS;
> > +		if (res_type == IORESOURCE_IO) {
> 
> Why the change from switch() to an if/else if sequence?

I think this was an artifact of the patches evolution, I've reverted back to
the switch.

> 
> But those are mostly nitpicks. If this is deferred to v3.10 then I would
> suggest fixing them up and posting for another round of review.

Andrew Murray
