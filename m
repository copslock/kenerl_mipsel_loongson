Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2016 10:32:38 +0100 (CET)
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33416 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992221AbcLIJcbzzfSt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Dec 2016 10:32:31 +0100
Received: by mail-wm0-f66.google.com with SMTP id u144so2763958wmu.0
        for <linux-mips@linux-mips.org>; Fri, 09 Dec 2016 01:32:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nJN0OALxp3/wojwu3c41ZdWw/YO3osSK2lSx9JWVVDY=;
        b=nMx5ePh+wTPxOWHfIPC5ZPZkVdKfSPpx8vS9Oa5Z2gTBPFyn7IA1jYtVGssABVlZFE
         g3DxmLw4XKo4txwDwDyFY4X99BAsQhlt86VyReghRWOgToIuD4MvCL4iOoI9abejqKup
         NCB1u14Wa58f9b5uuYdxBZl8o6VM0Y80yREa4QcDVleWJ9LiZ8VMwFa1TNtPYQmcFUzJ
         9QGcDv0hp51P8+Yw7DP1YLJcIMUDxEzi8z9co6FBsf+fmq3Tp6u6HbQl7YEeb1JTTdz3
         kFwyHathwNjZesrS3ZX3IgFIIhry9nqfHN9No8i4xcPLQxX388o625KkxFAWftC79s28
         /nkg==
X-Gm-Message-State: AKaTC01Pdt8GRclmMXMlxl4ZxKpT31R9qSZ/0L6VzOFfc3y5FQzYQiRlV+7NjVNj61Ci6w==
X-Received: by 10.28.149.79 with SMTP id x76mr5767735wmd.27.1481275946567;
        Fri, 09 Dec 2016 01:32:26 -0800 (PST)
Received: from localhost.localdomain (HSI-KBW-046-005-206-247.hsi8.kabel-badenwuerttemberg.de. [46.5.206.247])
        by smtp.gmail.com with ESMTPSA id k11sm19529619wmf.24.2016.12.09.01.32.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Dec 2016 01:32:26 -0800 (PST)
From:   Jan Glauber <jglauber@cavium.com>
To:     Wolfram Sang <wsa-dev@sang-engineering.com>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-i2c@vger.kernel.org, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>,
        Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 0/4] i2c octeon & thunderx bug fixes
Date:   Fri,  9 Dec 2016 10:31:54 +0100
Message-Id: <20161209093158.3161-1-jglauber@cavium.com>
X-Mailer: git-send-email 2.9.0.rc0.21.g7777322
Return-Path: <jan.glauber@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jglauber@cavium.com
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

Hi Wolfram,

Patches #1 & #2 contain the fixes that didn't make 4.9.
We've double-checked that they are working on Octeon MIPS cn71xx,
so I hope there are no surprises this time.

Patch #3 is my original attempt on limiting the number of
retries for the i2c device register access. As I found out we
need to keep this simple, because these functions are called
very early in the i2c driver and also from all types of context.

Patch #4 addresses a bug report I got. I haven't seen this myself,
but apparently depending on probing method and/or hardware type
ipmi_ssif can fail to detect the IPMI device. Setting the class
in the adapter solves the problem and seems harmless.

Tested on MIPS Octeon CN71xx and ARM64 ThunderX on 4.9-rc8.

thanks,
Jan

-----------------------

Jan Glauber (4):
  i2c: octeon: thunderx: TWSI software reset in recovery
  i2c: octeon: thunderx: Remove double-check after interrupt
  i2c: octeon: thunderx: Limit register access retries
  i2c: octeon: thunderx: Add I2C_CLASS_HWMON

 drivers/i2c/busses/i2c-octeon-core.c     | 50 +++++---------------------------
 drivers/i2c/busses/i2c-octeon-core.h     | 21 ++++++++++----
 drivers/i2c/busses/i2c-octeon-platdrv.c  |  1 +
 drivers/i2c/busses/i2c-thunderx-pcidrv.c |  1 +
 4 files changed, 26 insertions(+), 47 deletions(-)

-- 
2.9.0.rc0.21.g7777322
