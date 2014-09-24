Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2014 19:55:39 +0200 (CEST)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:49053 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009673AbaIXRzilB2r2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Sep 2014 19:55:38 +0200
Received: by mail-pa0-f54.google.com with SMTP id fb1so9201764pad.13
        for <linux-mips@linux-mips.org>; Wed, 24 Sep 2014 10:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=R/spdxsttxLYTriGKG4X7/KZjAr5rlimONWPvGwcDn8=;
        b=FJIdC0uHbX53QnXslywjlVOa9NDWdbPWJN0Geb5otIgVfRDRVeP33vSa/4lepn2QuH
         hm5dE6BlrjX909AiDwx3rK92LvYuyoPSP3vu0AV38zoNwS9tgCN87+x/eifvqwyg/hGV
         uTu4npfXLmy1XmuQFyNl8g8lR7VMeu+YuQz6cg3i2yC/+qoabtb1sEK6turYLWomPkol
         tVY6B/V5LYA16TW7XrJ+0X5VWzcagDC078xxQkCpY3N9Un3aWYYtwPR4zrhcDRPqyIy+
         Bt9Eo7AkEnXfZ8j7paDCPTKml//t/WSEN3wU/s6GXlFNPBpz18+YXsbHTsnje3ONjEwX
         LL4Q==
X-Received: by 10.70.89.108 with SMTP id bn12mr12529861pdb.146.1411581332012;
        Wed, 24 Sep 2014 10:55:32 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id iu1sm15303768pbc.53.2014.09.24.10.55.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Sep 2014 10:55:30 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ganesanr@broadcom.com, jchandra@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 0/2] MIPS: Netlogic: modular build fixes
Date:   Wed, 24 Sep 2014 10:55:09 -0700
Message-Id: <1411581311-6458-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Hello Ralf, Jayachandran, Ganesan

Here are two small fixes for modular USB and AHCI builds that I encountered
while playing with a FVP board.

These are based off upstream-sfr/mips-for-linux-next

Thanks!

Florian Fainelli (2):
  MIPS: Netlogic: handle modular USB case
  MIPS: Netlogic: handle modular AHCI builds

 arch/mips/netlogic/xlp/Makefile | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
1.9.1
