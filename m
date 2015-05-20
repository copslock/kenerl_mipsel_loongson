Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2015 16:52:12 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:34203 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026232AbbETOwKzh8m8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2015 16:52:10 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1Yv5Jj-0007JQ-VK; Wed, 20 May 2015 16:49:56 +0200
Date:   Wed, 20 May 2015 16:50:03 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jiang Liu <jiang.liu@linux.intel.com>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
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
        Russell King <linux@arm.linux.org.uk>,
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
        Russell King <rmk+kernel@arm.linux.org.uk>,
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
In-Reply-To: <1432114845-24304-9-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <alpine.DEB.2.11.1505201648490.4225@nanos>
References: <1432114845-24304-1-git-send-email-jiang.liu@linux.intel.com> <1432114845-24304-9-git-send-email-jiang.liu@linux.intel.com>
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
X-archive-position: 47498
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

On Wed, 20 May 2015, Jiang Liu wrote:

> Introduce helper function irq_data_get_affinity_mask() and
> irq_get_affinity_mask() to hide implementation details,

That patch does way more than introducing the functions. Again:

Patch 1: Introduce helpers

Patch 2-n: Convert users subsystem wise

Thanks,

	tglx
