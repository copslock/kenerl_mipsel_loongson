Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2012 17:25:29 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:50320 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903613Ab2APQZZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 Jan 2012 17:25:25 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id q0GGPMZR020151;
        Mon, 16 Jan 2012 17:25:22 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id q0GGPKPF020147;
        Mon, 16 Jan 2012 17:25:20 +0100
Date:   Mon, 16 Jan 2012 17:25:20 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 2/6] MIPS: PCI: use list_for_each_entry() for
 bus->devices traversal
Message-ID: <20120116162520.GF12896@linux-mips.org>
References: <20111216223043.5963.87534.stgit@bhelgaas.mtv.corp.google.com>
 <20111216223139.5963.51460.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20111216223139.5963.51460.stgit@bhelgaas.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 32252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Thanks, applied.

  Ralf
