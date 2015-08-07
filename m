Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2015 02:33:51 +0200 (CEST)
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37649 "EHLO
        mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012992AbbHGAdajq0ge (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Aug 2015 02:33:30 +0200
Received: by igbpg9 with SMTP id pg9so22513188igb.0
        for <linux-mips@linux-mips.org>; Thu, 06 Aug 2015 17:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Dl/jLRZPJ9nfei14i/ArFo29c5K/uE0Eq1xMNKPUo28=;
        b=yHJYw7I46vyQi/ueLqW0r6+E1vyld+h4EjPz63R3m3MTuw9jhLfbbGialMMjTc6cET
         uxZEgPtOKTVNKRg99EIEGogggXaPGrEtI8I1zZ+m3K4brsGDnvb45PWE0SR/IaEbLWxc
         BeJrNRnBKvq7LGvKQE+Ivln4P3oMc0s9WAIinZy1Y232tJH8/+YK5JJRdkF30O3zGfCv
         oSM5af4CIgxNEsjkNSxsFtg+5r4ai2urJnjBoqmtj2dWcJ5QGSwSQ1aiB1l38KJhVBWR
         0ySzkv/rtPL33Cj2hIl8xA4tShVJVWO49b0Xvr+eOA9/+PA5ugDyzSIpyIGI4PZyLkN0
         6uOA==
X-Received: by 10.50.60.68 with SMTP id f4mr620766igr.94.1438907604718;
        Thu, 06 Aug 2015 17:33:24 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by smtp.gmail.com with ESMTPSA id ns7sm2594613igb.0.2015.08.06.17.33.22
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 06 Aug 2015 17:33:23 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id t770XKN5029685;
        Thu, 6 Aug 2015 17:33:20 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id t770XGdU029684;
        Thu, 6 Aug 2015 17:33:16 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Robert Richter <rrichter@cavium.com>,
        Tomasz Nowicki <tomasz.nowicki@linaro.org>,
        Sunil Goutham <sgoutham@cavium.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 0/2] net: thunder: Add ACPI support.
Date:   Thu,  6 Aug 2015 17:33:08 -0700
Message-Id: <1438907590-29649-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48697
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

Hook up PHYs, and get MAC address from ACPI for the thunder driver.

The first patch (1/2) rearranges the existing code a little with no
functional change to get ready for the second.  The second (2/2) does
the actual work of adding support to extract the needed information
from the ACPI tables.

David Daney (1):
  net, thunder, bgx: Add support for ACPI binding.

Robert Richter (1):
  net: thunder: Factor out DT specific code in BGX

 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 183 ++++++++++++++++++++--
 1 file changed, 169 insertions(+), 14 deletions(-)

-- 
1.9.1
