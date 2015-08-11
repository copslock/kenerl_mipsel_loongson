Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Aug 2015 02:58:55 +0200 (CEST)
Received: from mail-io0-f170.google.com ([209.85.223.170]:34624 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010776AbbHKA6xh29xm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Aug 2015 02:58:53 +0200
Received: by iodb91 with SMTP id b91so127412838iod.1
        for <linux-mips@linux-mips.org>; Mon, 10 Aug 2015 17:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=wEpjHjPsMykc9uCIqrPb+g+i6qML+Cq7GGYRbn6O0Vc=;
        b=X1KFqYFdZKL5rR1sAZIldxbMaiXN6Gk5VHlKLoGOQgsUqqvaQoMrjBhiblYebTsriF
         DGuWXnAqwsIZcLJDXaSRQDgU68cW7O/qwtZCJuxux+BWOa6MTDqthb1qkCMwOCCH0KaW
         JDaCovaKccKC9wjwpZXD5/E5SMrxOTmgkwUCqtLzB1D1Kh5f3UiCapiCcQHVQ9gv3vYE
         H4R3gY6DWoM6PNTRZFLYrDDCuTy0Cgg/rsQrqsziBYurz/qLW2xwuJ6Dc0ijaKeshzeg
         JhfhN9t3Cgkmg0eFL+SJ+aTWqDPAQAyuOdaGZd26X5ZhHaXk1utccYS7oz8bjIjw5pdg
         xpGA==
X-Received: by 10.107.156.200 with SMTP id f191mr29127488ioe.175.1439254727608;
        Mon, 10 Aug 2015 17:58:47 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by smtp.gmail.com with ESMTPSA id a133sm416542ioe.34.2015.08.10.17.58.45
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 10 Aug 2015 17:58:46 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id t7B0whpQ002911;
        Mon, 10 Aug 2015 17:58:44 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id t7B0weqT002909;
        Mon, 10 Aug 2015 17:58:40 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Robert Richter <rrichter@cavium.com>,
        Tomasz Nowicki <tomasz.nowicki@linaro.org>,
        Sunil Goutham <sgoutham@cavium.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>, rafael@kernel.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 0/2] net: thunder: Add ACPI support.
Date:   Mon, 10 Aug 2015 17:58:35 -0700
Message-Id: <1439254717-2875-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48759
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

Change from v1:  Drop PHY binding part, use fwnode_property* APIs.

The first patch (1/2) rearranges the existing code a little with no
functional change to get ready for the second.  The second (2/2) does
the actual work of adding support to extract the needed information
from the ACPI tables.

David Daney (1):
  net, thunder, bgx: Add support to get MAC address from ACPI.

Robert Richter (1):
  net: thunder: Factor out DT specific code in BGX

 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 134 +++++++++++++++++++---
 1 file changed, 120 insertions(+), 14 deletions(-)

-- 
1.9.1
