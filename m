Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2014 09:12:35 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:18839 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817327AbaDNHMcdndXD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Apr 2014 09:12:32 +0200
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3E7CR7r013833
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Apr 2014 03:12:27 -0400
Received: from dhcp-26-207.brq.redhat.com (dhcp-26-119.brq.redhat.com [10.34.26.119])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s3E7CMOV004048;
        Mon, 14 Apr 2014 03:12:23 -0400
From:   Alexander Gordeev <agordeev@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Gordeev <agordeev@redhat.com>,
        Frank Haverkamp <haver@linux.vnet.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, x86@kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 0/2] Phase out pci_enable_msi_block()
Date:   Mon, 14 Apr 2014 09:14:05 +0200
Message-Id: <cover.1397458024.git.agordeev@redhat.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Return-Path: <agordeev@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agordeev@redhat.com
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

Hello,

This series is against 3.15-rc1.

This update obsoletes pci_enable_msi_block() function in
favor of pci_enable_msi_range() and pci_enable_msi_exact().


Cc: Frank Haverkamp <haver@linux.vnet.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-mips@linux-mips.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: x86@kernel.org
Cc: linux-pci@vger.kernel.org


Alexander Gordeev (2):
  GenWQE: Use pci_enable_msi_exact() instead of pci_enable_msi_block()
  PCI/MSI: Phase out pci_enable_msi_block()

 drivers/misc/genwqe/card_utils.c |    2 +-
 drivers/pci/msi.c                |   79 ++++++++++++++++----------------------
 include/linux/pci.h              |    5 +--
 3 files changed, 35 insertions(+), 51 deletions(-)

-- 
1.7.7.6
