Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jul 2011 13:53:47 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:52970 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491113Ab1G1Lxo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Jul 2011 13:53:44 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p6SBrWQx031707;
        Thu, 28 Jul 2011 12:53:32 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p6SBrUZf031704;
        Thu, 28 Jul 2011 12:53:30 +0100
Date:   Thu, 28 Jul 2011 12:53:30 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Cc:     jbarnes@virtuousgeek.org, torvalds@linux-foundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, eyal@mips.com, zenon@mips.com
Subject: Re: [PATCH 1/2] PCI: make pci_claim_resource() work with conflict
 resources as appropriate
Message-ID: <20110728115330.GA29899@linux-mips.org>
References: <1311852512-7340-1-git-send-email-dengcheng.zhu@gmail.com>
 <1311852512-7340-2-git-send-email-dengcheng.zhu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1311852512-7340-2-git-send-email-dengcheng.zhu@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20675

On Thu, Jul 28, 2011 at 07:28:31PM +0800, Deng-Cheng Zhu wrote:

> In resolving a network driver issue with the MIPS Malta platform, the root
> cause was traced into pci_claim_resource():
> 
> MIPS System Controller's PCI I/O resources stay in 0x1000-0xffffff. When
> PCI quirks start claiming resources using request_resource_conflict(),
> collisions happen and -EBUSY is returned, thereby rendering the onboard AMD
> PCnet32 NIC unaware of quirks' region and preventing the NIC from functioning.
> For PCI quirks, PIIX4 ACPI is expected to claim 0x1000-0x103f, and PIIX4 SMB to
> claim 0x1100-0x110f, both of which fall into the MSC I/O range. Certainly, we
> can increase the start point of this range in arch/mips/mti-malta/malta-pci.c to
> avoid the collisions. But a fix in here looks more justified, though it seems to
> have a wider impact. Using insert_xxx as opposed to request_xxx will register
> PCI quirks' resources as children of MSC I/O and return OK, instead of seeing
> collisions which are actually resolvable.

This used to work in the past; do you know which commit broke the resource
handling for the NIC?

  Ralf
