Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jul 2010 17:11:06 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:54015 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491814Ab0GZPK7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 26 Jul 2010 17:10:59 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o6QF9Rgs016276;
        Mon, 26 Jul 2010 16:09:27 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o6QF9QmT016274;
        Mon, 26 Jul 2010 16:09:26 +0100
Date:   Mon, 26 Jul 2010 16:09:25 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     linux-mips@linux-mips.org, Martin Michlmayr <tbm@cyrius.com>,
        Aurelien Jarno <aurelien@aurel32.net>, 584784@bugs.debian.org
Subject: Re: [PATCH] mips: Set io_map_base for several PCI bridges lacking it
Message-ID: <20100726150925.GA31805@linux-mips.org>
References: <1276464179.14011.218.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1276464179.14011.218.camel@localhost>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jun 13, 2010 at 10:22:59PM +0100, Ben Hutchings wrote:

> Several MIPS platforms don't set pci_controller::io_map_base for their
> PCI bridges.  This results in a panic in pci_iomap().  (The panic is
> conditional on CONFIG_PCI_DOMAINS, but that is now enabled for all PCI
> MIPS systems.)
> 
> I have tested the change to Malta in qemu; the other platforms not at
> all.

Thanks, applied.

  Ralf
