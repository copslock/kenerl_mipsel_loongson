Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 May 2013 04:42:50 +0200 (CEST)
Received: from gate.crashing.org ([63.228.1.57]:35374 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816285Ab3EECmrapBNW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 5 May 2013 04:42:47 +0200
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r452fnu1012510;
        Sat, 4 May 2013 21:41:50 -0500
Message-ID: <1367721709.11982.37.camel@pasglop>
Subject: Re: [PATCH v8 1/3] of/pci: Unify pci_process_bridge_OF_ranges from
 Microblaze and PowerPC
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Andrew Murray <Andrew.Murray@arm.com>
Cc:     linux-mips@linux-mips.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        jgunthorpe@obsidianresearch.com, linux@arm.linux.org.uk,
        siva.kallam@samsung.com, linux-pci@vger.kernel.org,
        devicetree-discuss@lists.ozlabs.org, jg1.han@samsung.com,
        Liviu.Dudau@arm.com, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com,
        bhelgaas@google.com, suren.reddy@samsung.com,
        linux-arm-kernel@lists.infradead.org, monstr@monstr.eu,
        paulus@samba.org, thomas.petazzoni@free-electrons.com,
        thierry.reding@avionic-design.de, thomas.abraham@linaro.org,
        arnd@arndb.de, linus.walleij@linaro.org, juhosg@openwrt.org,
        grant.likely@linaro.org, Rob Herring <robherring2@gmail.com>
Date:   Sun, 05 May 2013 12:41:49 +1000
In-Reply-To: <1366627295-16964-2-git-send-email-Andrew.Murray@arm.com>
References: <1366627295-16964-1-git-send-email-Andrew.Murray@arm.com>
         <1366627295-16964-2-git-send-email-Andrew.Murray@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <benh@kernel.crashing.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benh@kernel.crashing.org
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

On Mon, 2013-04-22 at 11:41 +0100, Andrew Murray wrote:
> The pci_process_bridge_OF_ranges function, used to parse the "ranges"
> property of a PCI host device, is found in both Microblaze and PowerPC
> architectures. These implementations are nearly identical. This patch
> moves this common code to a common place.

What's happening with this ? I'd like to avoid that patch for now
as I'm doing some changes to pci_process_bridge_OF_ranges
which are fairly urgent (I might even stick them in the current
merge window) to deal with memory windows having separate offsets.

There's also a few hacks in there that are really ppc specific...

I think the right long term approach is to change the way powerpc
(and microblaze ?) initializes PCI host bridges. Move it away from
setup_arch() (which is a PITA anyway since it's way too early) to
an early init call of some sort, and encapsulate the new struct
pci_host_bridge.

We can then directly configure the host bridge windows rather
than having this "intermediary" set of resources in our pci_controller
and in fact move most of the fields from pci_controller to
pci_host_bridge to the point where the former can remain as a
simple platform specific wrapper if needed.

So for new stuff (hint: DT based ARM PCI) or stuff that has to deal with
a lot less archaic platforms (hint: Microblaze), I'd recommend going
straight for that approach rather than perpetuating the PowerPC code
which I'll try to deal with in the next few monthes.

Cheers,
Ben.
 
