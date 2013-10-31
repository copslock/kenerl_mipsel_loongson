Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Oct 2013 12:09:46 +0100 (CET)
Received: from mail-pd0-f181.google.com ([209.85.192.181]:34938 "EHLO
        mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816022Ab3JaLJjvseHX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Oct 2013 12:09:39 +0100
Received: by mail-pd0-f181.google.com with SMTP id x10so2271066pdj.12
        for <linux-mips@linux-mips.org>; Thu, 31 Oct 2013 04:09:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G8jrRXQByJbgTmgMtYB7N+AVc7fakTsJU5BFJBo4pmM=;
        b=XHqjxIW7Xy7YcACDuvwqQ/CCoUlLHXPL3k69Z33FsmwIach8SbxlYCp1m0hSJYE0Hp
         z5xP0Iq0vmZ4jt6AdcmgWxnXf2rFHeYFiZWSq9lcTgykus4NGyPTIzcpYmV3w5joCTMe
         wPmlvvRD+5RVUctUWlAqvc+rpyHyDAoPREHp5+cEf45fbKK+Kbs4rv4VQjsE5mb+Km78
         pg/mX0Y1ffl1lp7qX2jvKwHKTO9OqjNr6KZea/NfKaXAfJhnz5qbCBXKrQ56KJvKu9UX
         VGkJGXenxUZnIYFCGygOX/ybRz1Nyz/Lnum456zV26Z2v144hmwgd4qeM7esZDrGT2xq
         D+aA==
X-Gm-Message-State: ALoCoQk2aBazPpo7IuITEqCw2FpB9zK3OMKs8rEWkycWyvV+8hcUSQYYRb1OsjPZUY/z2Avvpo+L
X-Received: by 10.68.4.232 with SMTP id n8mr2497434pbn.9.1383217773011;
        Thu, 31 Oct 2013 04:09:33 -0700 (PDT)
Received: from linaro.sisodomain.com ([115.113.119.130])
        by mx.google.com with ESMTPSA id hz10sm3446333pbc.36.2013.10.31.04.09.27
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 31 Oct 2013 04:09:32 -0700 (PDT)
From:   Tushar Behera <tushar.behera@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     patches@linaro.org, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Landley <rob@landley.net>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 0/5] Remove remaining instances of devm_request_and_ioremap
Date:   Thu, 31 Oct 2013 16:38:02 +0530
Message-Id: <1383217687-12037-1-git-send-email-tushar.behera@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <tushar.behera@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tushar.behera@linaro.org
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

devm_request_and_ioremap is now obsolete and is replaced by
devm_ioremap_resource. Update the remaining places where
devm_request_and_ioremap is still used and remove its definition.

The patches are based on next-20131030.

Tushar Behera (5):
  MIPS: ralink: Use devm_ioremap_resource
  DRM: Armada: Use devm_ioremap_resource
  iommu/arm-smmu: Use devm_ioremap_resource
  watchdog: ralink: Use devm_ioremap_resource
  lib: devres: Remove deprecated devm_request_and_ioremap

 Documentation/driver-model/devres.txt |    1 -
 arch/mips/ralink/timer.c              |    2 +-
 drivers/gpu/drm/armada/armada_crtc.c  |    8 +++-----
 drivers/iommu/arm-smmu.c              |    6 +++---
 drivers/watchdog/rt2880_wdt.c         |    2 +-
 include/linux/device.h                |    2 --
 lib/devres.c                          |   28 ----------------------------
 7 files changed, 8 insertions(+), 41 deletions(-)

CC: dri-devel@lists.freedesktop.org
CC: iommu@lists.linux-foundation.org
CC: linux-arm-kernel@lists.infradead.org
CC: linux-doc@vger.kernel.org
CC: linux-mips@linux-mips.org
CC: linux-watchdog@vger.kernel.org
CC: David Airlie <airlied@linux.ie>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Joerg Roedel <joro@8bytes.org>
CC: John Crispin <blogic@openwrt.org>
CC: Ralf Baechle <ralf@linux-mips.org>
CC: Rob Landley <rob@landley.net>
CC: Russell King <rmk+kernel@arm.linux.org.uk>
CC: Will Deacon <will.deacon@arm.com>
CC: Wim Van Sebroeck <wim@iguana.be>

-- 
1.7.9.5
