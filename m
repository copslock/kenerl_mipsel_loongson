Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jun 2015 10:08:41 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:49835 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007354AbbFEIIj03SoU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 5 Jun 2015 10:08:39 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t5588be9030145;
        Fri, 5 Jun 2015 10:08:37 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t5588aOA030144;
        Fri, 5 Jun 2015 10:08:36 +0200
Date:   Fri, 5 Jun 2015 10:08:36 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-alpha@vger.kernel.org
Subject: Re: [PATCH 5/7] PCI: Remove unnecessary #includes of <asm/pci.h>
Message-ID: <20150605080836.GR26432@linux-mips.org>
References: <20150604214614.2399.5142.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150604214957.2399.66129.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150604214957.2399.66129.stgit@bhelgaas-glaptop2.roam.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

Acked-by: Ralf Baechle <ralf@linux-mips.org>
