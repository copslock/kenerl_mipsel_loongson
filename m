Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 May 2018 15:11:50 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:60812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994703AbeEVNLoLBGpk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 May 2018 15:11:44 +0200
Received: from localhost (173-24-227-115.client.mchsi.com [173.24.227.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28E5320853;
        Tue, 22 May 2018 13:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1526994697;
        bh=aG3cfGzT/z/nLrQkKfDcpC1kalR7DeHr6ZU3TLVJWqQ=;
        h=Subject:From:To:Cc:Date:From;
        b=GO2FdPPWQlBk7TJ8ZUoM8Ppy+Egka36SLU8+YrVQnkQr0Vgd60UyWGHzGP4tui/Dr
         i7WTa24WtmzhvQcG2/PDWe3kl+Ozet46R5X4DLskGOfukcrzxk89IS2+13utt5Sggj
         oBdcFLnsFmYwLpCC8IoccggjO6sACbcXk42/IKsk=
Subject: [PATCH v1] MIPS: PCI: Use dev_printk()
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 22 May 2018 08:11:36 -0500
Message-ID: <152699466671.162686.1029992586935534102.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <helgaas@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: helgaas@kernel.org
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

Use dev_printk() to follow style of other arches.

I'll merge via the PCI tree unless there are objections.

---

Bjorn Helgaas (1):
      MIPS: PCI: Use dev_printk() when possible


 arch/mips/pci/pci-legacy.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)
