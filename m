Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Mar 2010 15:03:35 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:52998 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492230Ab0CPODb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Mar 2010 15:03:31 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o2GE3UxG031216;
        Tue, 16 Mar 2010 15:03:30 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o2GE3Thv031211;
        Tue, 16 Mar 2010 15:03:29 +0100
Date:   Tue, 16 Mar 2010 15:03:28 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     linux-mips@linux-mips.org, peter fuerst <post@pfrst.de>
Subject: Re: [PATCH v2] MIPS: make CAC_ADDR and UNCAC_ADDR account for
 PHYS_OFFSET
Message-ID: <20100316140328.GA20160@linux-mips.org>
References: <201003100951.10028.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201003100951.10028.florian@openwrt.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26240
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 10, 2010 at 09:51:09AM +0100, Florian Fainelli wrote:

> On AR7, we already redefine PHYS_OFFSET to match the system specifities, it is
> however not sufficient when unsing dma_{map,unmap}_single, specifically in the
> Ethernet driver, we must also adjust CAC_ADDR and UNCAC_ADDR for DMA to work
> correctly. This patch fixes the following issue, seen in cpmac_open:

Thanks, applied.

  Ralf
