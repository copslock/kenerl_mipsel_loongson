Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jun 2013 02:40:47 +0200 (CEST)
Received: from mail-pb0-f45.google.com ([209.85.160.45]:52506 "EHLO
        mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835028Ab3FTAkhMnSWk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Jun 2013 02:40:37 +0200
Received: by mail-pb0-f45.google.com with SMTP id mc8so5629070pbc.18
        for <linux-mips@linux-mips.org>; Wed, 19 Jun 2013 17:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=uPMI3GMiVmNw8PtCAkuXd5fJRxer1LDyCPQIZ3IDIQQ=;
        b=iWAZeAeqs8+1bLfCD89+M1QpHRiXs5h9vq6WRnw8J6q15QSLmsZFtsJmUhgm8Thzrg
         iXkNbDT08lHqy3ktr4D4dK2fy9vvNyTbu9NwiCk0wWXzdlJRn7MvksSZl6o4JzNO/Sbj
         +yoNNkaUoajvmYOhDb785oZYe07/sQNQQvTpfJQiriswAVzPIKLfwI7aaSEUP5aoTZuh
         Z7+2LejNsd/jug9M52sZpvfjpm68ZCIuz1+pVXETgITxWXerbMX7dSIl48OfeRtQdcIh
         TE6PF2nIV755H3pXiQtv3TW3s2C4zrbw4XPeeNLE4S11MJ5ovBKPVCq/q2P4MtMvyF+7
         +CRA==
X-Received: by 10.68.164.226 with SMTP id yt2mr5079187pbb.203.1371688830744;
        Wed, 19 Jun 2013 17:40:30 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id pm7sm25173251pbb.31.2013.06.19.17.40.29
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 19 Jun 2013 17:40:29 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r5K0eRDt004620;
        Wed, 19 Jun 2013 17:40:27 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r5K0eLah004619;
        Wed, 19 Jun 2013 17:40:21 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 0/2] netdev: octeon_mgmt minor fixes.
Date:   Wed, 19 Jun 2013 17:40:18 -0700
Message-Id: <1371688820-4585-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37034
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

I have two small change here for 3.11 (I hope).

David Daney (2):
  netdev: octeon_mgmt: Correct tx IFG workaround.
  netdev: octeon_mgmt: Fix structure layout for little-endian.

 drivers/net/ethernet/octeon/octeon_mgmt.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

-- 
1.7.11.7
