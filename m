Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Mar 2015 19:06:49 +0100 (CET)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:45545 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008820AbbCRSGo174Ct (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Mar 2015 19:06:44 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id C650E19BDD6;
        Wed, 18 Mar 2015 20:06:44 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id gENYSQCDff9W; Wed, 18 Mar 2015 20:06:39 +0200 (EET)
Received: from fuloong-minipc (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp6.welho.com (Postfix) with ESMTP id AC42D5BC004;
        Wed, 18 Mar 2015 20:06:39 +0200 (EET)
Date:   Wed, 18 Mar 2015 20:06:38 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc:     ext David Daney <ddaney@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        David Daney <ddaney@cavium.com>, ddaney.cavm@gmail.com,
        "ext Daney, David" <David.Daney@caviumnetworks.com>,
        Rob Herring <robh@kernel.org>, Jiri Kosina <jkosina@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masanari Iida <standby24x7@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rulf, Mathias (Nokia - DE/Ulm)" <mathias.rulf@nokia.com>
Subject: Re: [PATCH] pci: octeon: Remove udelay() causing huge IRQ latency
Message-ID: <20150318180638.GA10043@fuloong-minipc.musicnaut.iki.fi>
References: <55097811.8050003@nokia.com>
 <5509A39C.6010707@caviumnetworks.com>
 <5509A500.7020109@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5509A500.7020109@nokia.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Wed, Mar 18, 2015 at 05:17:04PM +0100, Alexander Sverdlin wrote:
> On 18/03/15 17:11, ext David Daney wrote:
> >> udelay() in PCI/PCIe read/write callbacks cause 30ms IRQ latency on Octeon
> >> platforms because these operations are called from PCI_OP_READ() and
> >> PCI_OP_WRITE() under raw_spin_lock_irqsave().
> >>
> >> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> > 
> > Can you say how it was tested.  In principle I have no objections, but it
> > would be nice to know how it was validated.
> 
> What do you want to know, how we've debugged IRQ latency and found the
> root cause or how we figured out that delay is not necessary?

You could at least say on which OCTEON platforms (e.g. OCTEON II
or older) you tested the patch on, and tell about tested PCI bus
topology and devices.

> I'm pretty sure that there is HW which requires it. Maybe it's
> even Octeon itself... But putting udelay() in this callbacks is
> wrong wrong wrong.

Still, you should not break HW that works with current kernel.

A.
