Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2015 21:37:44 +0200 (CEST)
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:53711 "EHLO
        pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013073AbbETThmmCO1t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2015 21:37:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=bsCq3ygpoZHvRFo7OZqofcWGuX8p4fLIfKDPcNJnAjo=;
        b=OL+zzLPYaMy9fejRiic2vNNBH9n8nhgOE1kb0q3nwikwfil7FO+8tJIiEkk90IzUvKBMtax7H/U9u4Ct5oyg7pvyhIDQ52eiSIuX0vLE6g76Wl+RhbBDdiDtLdtJAv4qOGfUPt0Dsv1xepH9fVAr3W5R+EZ4CL4LKQM91bv3Ohg=;
Received: from n2100.arm.linux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:36515)
        by pandora.arm.linux.org.uk with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1Yv9l8-0003lY-FS; Wed, 20 May 2015 20:34:30 +0100
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1Yv9l4-0004jj-Ke; Wed, 20 May 2015 20:34:26 +0100
Date:   Wed, 20 May 2015 20:34:26 +0100
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Jiang Liu <jiang.liu@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Yinghai Lu <yinghai@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Steven Miao <realmz6@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>,
        Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S. Miller" <davem@davemloft.net>, x86@kernel.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        David Vrabel <david.vrabel@citrix.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Jonas Gorski <jogo@openwrt.org>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        David Daney <david.daney@cavium.com>,
        Anton Blanchard <anton@samba.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>, bob picco <bpicco@meloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-ia64@vger.kernel.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org
Subject: Re: [Patch v2 08/14] genirq: Introduce helper function
 irq_data_get_affinity_mask()
Message-ID: <20150520193426.GT2067@n2100.arm.linux.org.uk>
References: <1432114845-24304-1-git-send-email-jiang.liu@linux.intel.com>
 <1432114845-24304-9-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1432114845-24304-9-git-send-email-jiang.liu@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47502
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@arm.linux.org.uk
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

On Wed, May 20, 2015 at 05:40:39PM +0800, Jiang Liu wrote:
> diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
> index 350f188c92d2..baf8edebe26f 100644
> --- a/arch/arm/kernel/irq.c
> +++ b/arch/arm/kernel/irq.c
> @@ -140,7 +140,7 @@ int __init arch_probe_nr_irqs(void)
>  static bool migrate_one_irq(struct irq_desc *desc)
>  {
>  	struct irq_data *d = irq_desc_get_irq_data(desc);
> -	const struct cpumask *affinity = d->affinity;
> +	const struct cpumask *affinity = irq_data_get_affinity_mask(d);
>  	struct irq_chip *c;
>  	bool ret = false;
>  
> @@ -160,7 +160,7 @@ static bool migrate_one_irq(struct irq_desc *desc)
>  	if (!c->irq_set_affinity)
>  		pr_debug("IRQ%u: unable to set affinity\n", d->irq);
>  	else if (c->irq_set_affinity(d, affinity, false) == IRQ_SET_MASK_OK && ret)
> -		cpumask_copy(d->affinity, affinity);
> +		cpumask_copy(irq_data_get_affinity_mask(d), affinity);
>  
>  	return ret;
>  }

> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index 43581e166298..2eb82257aaee 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -650,6 +650,18 @@ static inline int irq_data_get_node(struct irq_data *d)
>  	return irq_common_data_get_node(d->common);
>  }
>  
> +static inline struct cpumask *irq_get_affinity_mask(int irq)
> +{
> +	struct irq_data *d = irq_get_irq_data(irq);
> +
> +	return d ? d->affinity : NULL;
> +}
> +
> +static inline struct cpumask *irq_data_get_affinity_mask(struct irq_data *d)
> +{
> +	return d->affinity;
> +}
> +
>  unsigned int arch_dynirq_lower_bound(unsigned int from);
>  
>  int __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,

For the above only,

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
