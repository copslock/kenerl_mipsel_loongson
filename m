Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jan 2016 06:17:39 +0100 (CET)
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33523 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27005162AbcA3FRiJ7Amt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Jan 2016 06:17:38 +0100
Received: by mail-pa0-f65.google.com with SMTP id pv5so4500322pac.0;
        Fri, 29 Jan 2016 21:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ICXH7qkX6l0TR4XjnYXVQOF+0QGf1v4rXwDJWw2VUIU=;
        b=BzLOxZB9LsFZeiBLDPE6DZJQv3OTtQlnqEUrbHeOoMmr/oqrNUveN3NROGP+ihLDkq
         XDeOhL13N5EqOYKJYU6XjnAQ0sbiclx0jkeCE+IyHXU8ZxoQ5RlNH8niHYn8UTknop4K
         qYfBObnVPJxsaHjTOyAngufJz++OvfaJB6HdzTiREipDglxGN6+xO/L/8zOYC+M3HANV
         kSQ9pTPaCdzl42wTAMLYcQ1707AeUsuZSpbP302+OfhkQrJcYHJ3YSYhAynt1vLOMUzU
         jJYCaQqFlbwDoyEBsHdcr/Ouj+p0IIwUhPjPkU3r2wih1FPeOgxh0Lsdruq2PEp5oudQ
         u/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ICXH7qkX6l0TR4XjnYXVQOF+0QGf1v4rXwDJWw2VUIU=;
        b=DcfMZeMNEAZ1KpWh5/MwFxhTKciBHoK2KZnFTfJX9MhucNlkKQ6iIxzs34TltIWZvM
         7rLAltrL9QYAxUx4KEgUG7lCdgUd3gO5NdMWV6MEI3bRG+XdbVzRwkGMkb7dxYRAr2ok
         sd+W7QiKPkBOXcRW440lkqsOUPCIjh/2But3zi/wzt46CgD3qJdK9SpW9JyyPY4DFZP4
         kEFWXPHQwxw73OZBbsS3nCfRuCEvfD8wHL03312EbP8CDub2yNCrxMpnrcC3mY42mIQ/
         BmNoSqqT1RxxdavIMay3XDnBbaHo35MJeX2dK4W9EYBqE7NZxep0s9UA237e2p/W7xZC
         QFXg==
X-Gm-Message-State: AG10YOS3JIPrT8FW5egV9J/xxPs+Jf6XMgqo+XN5oPucZAp2qiG1pBCqo83rc1Z+reqvtg==
X-Received: by 10.66.191.195 with SMTP id ha3mr19715766pac.58.1454131052054;
        Fri, 29 Jan 2016 21:17:32 -0800 (PST)
Received: from localhost.localdomain (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id a21sm7498645pfj.40.2016.01.29.21.17.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jan 2016 21:17:31 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        jogo@openwrt.org, jaedon.shin@gmail.com, jfraser@broadcom.com,
        pgynther@google.com, dragan.stancevic@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 0/6] MIPS: BMIPS: Random fixes for BMIPS5000/5200
Date:   Fri, 29 Jan 2016 21:17:20 -0800
Message-Id: <1454131046-11124-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 1.7.1
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51537
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

Hi all,

This patch series contains a bunch of fixes for the BMIPS5000 processor class.

The first 4 patches are addressing some functional and cosmetic issues, while
the last 2 patches fix the existing code to support BMIPS5200 processors.

Kevin, Jon, Jonas, please review!

These were tested on BCM7425 and BCM7435.

BMIPS5200 SMP patches will be submitted on top of this patch series

Florian Fainelli (6):
  MIPS: BMIPS: BMIPS5000 has I cache filing from D cache
  MIPS: BMIPS: Clear MIPS_CACHE_ALIASES earlier
  BMIPS: BMIPS: local_r4k___flush_cache_all needs to blast S-cache
  MIPS: BMIPS: Add cpu-feature-overrides.h
  MIPS: BMIPS: Pretty print BMIPS5200 processor name
  MIPS: BMIPS: Fix PRID_IMP_BMIPS5000 masking for BMIPS5200

 .../include/asm/mach-bmips/cpu-feature-overrides.h |   14 ++++++++++++++
 arch/mips/kernel/bmips_vec.S                       |    9 +++++++--
 arch/mips/kernel/cpu-probe.c                       |    5 ++++-
 arch/mips/mm/c-r4k.c                               |   13 +++++++++++--
 4 files changed, 36 insertions(+), 5 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-bmips/cpu-feature-overrides.h
