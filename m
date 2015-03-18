Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Mar 2015 14:11:18 +0100 (CET)
Received: from cantor2.suse.de ([195.135.220.15]:56813 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007238AbbCRNLQxYih9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Mar 2015 14:11:16 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BA5EAAD56;
        Wed, 18 Mar 2015 13:11:16 +0000 (UTC)
Date:   Wed, 18 Mar 2015 14:11:15 +0100 (CET)
From:   Jiri Kosina <jkosina@suse.cz>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        David Daney <ddaney@cavium.com>, ddaney.cavm@gmail.com,
        "ext Daney, David" <David.Daney@caviumnetworks.com>,
        Rob Herring <robh@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masanari Iida <standby24x7@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rulf, Mathias (Nokia - DE/Ulm)" <mathias.rulf@nokia.com>
Subject: Re: [PATCH] pci: octeon: Remove udelay() causing huge IRQ latency
In-Reply-To: <55097811.8050003@nokia.com>
Message-ID: <alpine.LNX.2.00.1503181409110.6781@pobox.suse.cz>
References: <55097811.8050003@nokia.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <jkosina@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jkosina@suse.cz
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

On Wed, 18 Mar 2015, Alexander Sverdlin wrote:

> udelay() in PCI/PCIe read/write callbacks cause 30ms IRQ latency on Octeon
> platforms because these operations are called from PCI_OP_READ() and
> PCI_OP_WRITE() under raw_spin_lock_irqsave().
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

I have no idea about the octeon platform, but how do you deal with the 
fact that is stated by the comment you are removing? I.e.

	/* Some PCI cards require delays when accessing config space. */

Is that not the case any more for some reason? If not, it really needs to 
be explained in the changelog.

-- 
Jiri Kosina
SUSE Labs
