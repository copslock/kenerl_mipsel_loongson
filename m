Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 14:06:27 +0200 (CEST)
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33082 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27032256AbcEUMCOf-vFI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2016 14:02:14 +0200
Received: by mail-lf0-f67.google.com with SMTP id z203so640695lfd.0;
        Sat, 21 May 2016 05:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=lt7GtqmD9QfNWgPCGU/Qg6PVKTad3yUouUKMe1zMxos=;
        b=oQ2W2sndyUsx22LUmQTIYMxdZIfmX81GavtZmkk/+GWhq7iyg4sXm43CxflLAPUC0h
         baleQzG9N7tZevu9e18hPh53o1Ro4DKBwb8S80sWoxzTsagsYqQy1sjh0jcPfqRFJgce
         iasEyXmnT2GQ7pFRVWfu0vr5cXGEuu0On6HejnKTd9mWDYKSB9FcQs0u6L6E7qd+IM/b
         nBYhPhQ5mZu0BmGb+TAu+hQpvq01krgS7TUZ/DfrOO4pjcCCKG4VypSwY0AKxYQqO0pt
         kB9aw44vdAPtcgjZinMvMW3rc9NofjVwsQVYeTxu25NfQnsAVSKoVeJgAlztPOEinQNG
         jOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=lt7GtqmD9QfNWgPCGU/Qg6PVKTad3yUouUKMe1zMxos=;
        b=PsZyKOVhCq14kkevGCmQh/vr+hb3hlX9SBahFZjz+Ij4KfF/rjta685/cAzyzOEYkh
         G9zKjBDkfZDYlP1yaBBW45LEVe5cW+elgTOgQRwIu1kUlmWlCrHMSMILTirEWXyOyw3z
         8FqEc3rg0DYMhN2/HnAuYaTSfJZ5av+NWPQngoXpgMLkmce/6270QYBTm/u80RfIoXHC
         qzBu7ZYhlObRtdUQNUUHb0bkyhjpmic20PwKv8sU6D/mSAATOyEDwhUeoRsSWdFR8mhJ
         yFKRe92vAqKeISrVi5qbXh/0sGEHty9xPyBriz2U0IZBG3jXjacCtxZuOtZuN4PuV9xu
         kSaQ==
X-Gm-Message-State: AOPr4FUl50NyeFYtJwZGZfHD9WhL0dZrVt3njV0aXs0MpPvSW8ze8NNyyK6GoVLGPl7POw==
X-Received: by 10.25.150.8 with SMTP id y8mr2676531lfd.163.1463832128884;
        Sat, 21 May 2016 05:02:08 -0700 (PDT)
Received: from glen.ipredator.se (anon-35-25.vpn.ipredator.se. [46.246.35.25])
        by smtp.gmail.com with ESMTPSA id r16sm4148796lfd.35.2016.05.21.05.02.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 21 May 2016 05:02:07 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     trivial@kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 0199/1529] Fix typo
Date:   Sat, 21 May 2016 14:02:04 +0200
Message-Id: <20160521120204.10300-1-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 2.8.2.534.g1f66975
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrea.gelmini@gelma.net
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

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/mips/pci/ops-bridge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pci/ops-bridge.c b/arch/mips/pci/ops-bridge.c
index 4383194..57e1463 100644
--- a/arch/mips/pci/ops-bridge.c
+++ b/arch/mips/pci/ops-bridge.c
@@ -33,9 +33,9 @@ static u32 emulate_ioc3_cfg(int where, int size)
  * The Bridge ASIC supports both type 0 and type 1 access.  Type 1 is
  * not really documented, so right now I can't write code which uses it.
  * Therefore we use type 0 accesses for now even though they won't work
- * correcly for PCI-to-PCI bridges.
+ * correctly for PCI-to-PCI bridges.
  *
- * The function is complicated by the ultimate brokeness of the IOC3 chip
+ * The function is complicated by the ultimate brokenness of the IOC3 chip
  * which is used in SGI systems.  The IOC3 can only handle 32-bit PCI
  * accesses and does only decode parts of it's address space.
  */
-- 
2.8.2.534.g1f66975
