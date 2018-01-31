Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Jan 2018 16:33:57 +0100 (CET)
Received: from mail-lf0-x244.google.com ([IPv6:2a00:1450:4010:c07::244]:42652
        "EHLO mail-lf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994792AbeAaPdriRxtN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Jan 2018 16:33:47 +0100
Received: by mail-lf0-x244.google.com with SMTP id q17so21320688lfa.9;
        Wed, 31 Jan 2018 07:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4dt2I760prjdF/kV97mOFnsfoB37qLgB7juYKgENUnI=;
        b=r1T6AbBng6reYAGruvMQrTG1hvUxXM8cs5IVzEamgaFUFnfz5LQCVe5044kdP0uEjv
         yrTg8Iu7JV8fASibjcxHFKouxquHsB++embOuw8vY7tE4MBIwhTU71qnSrIfQNgdlxu9
         btfAGsyAzwQiKHcpjiAC+749+FTm+LvQylEIGV9UaYj2iVZgvoDLyYQyATHMbEz/0AQg
         wcsP4Rv+A9acvBLmbqMzNwv6ZowHkZ7Fi5eKXcuoj74HqbtH7EPU+8v78MNTBS55dkUX
         hPHE1VkMJ71Ky0K2L0VLOKrbExP4+oDIYhas33Gru66QkW2J38P8/m1pV/so5yAZPJC3
         ekDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4dt2I760prjdF/kV97mOFnsfoB37qLgB7juYKgENUnI=;
        b=tRsZ6eqmp+SfxssEsy7wGNeuegvB7x+k9tL++fAe03X+7KYnZPRVSri0vF4K6qt5f6
         kuDZkRRibi/R87JB8mk7DwwJaUZowZoNfE61FAOYGJHsrEEjAf1hz5soc/CNe7czQTlM
         sDC5BnKp7aLDSQ23qU8KwAocQ34zT7IamwZTxDg51D2VOEOrUJOn9lKxlnHmMHSOeCxL
         xRiPikhEhdqn/W/a14pQzqGjkYb3hBVTpwEZW3qjJmJOKVymDHzeZkYDWHrJDlNRV85E
         uqxrFye/brY9pOkf4YPsIX9mih0fCnuZpO42A3wqvIpqr5jDSPZuz9IsegSfCuw1gmA3
         NlHA==
X-Gm-Message-State: AKwxytcFII8YL3N4j00pCXeCW0bXOsD3g2YZwPBaDcv5Z20A01mK0i5O
        er1L1kz1EApfYqkqBoild3V0QA==
X-Google-Smtp-Source: AH8x224sGZbhhPq+khhBMj90lWYW6cJIMvbOX9abwajre8Z1B/LAxTN8NfJxM5ssQ/CxPmpeCnSQzQ==
X-Received: by 10.25.181.155 with SMTP id g27mr21201526lfk.47.1517412821612;
        Wed, 31 Jan 2018 07:33:41 -0800 (PST)
Received: from localhost.localdomain (t109.niisi.ras.ru. [193.232.173.109])
        by smtp.gmail.com with ESMTPSA id u72sm3952454lfi.64.2018.01.31.07.33.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 07:33:40 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] MIPS: use generic GCC library routines from lib/
Date:   Wed, 31 Jan 2018 18:33:35 +0300
Message-Id: <20180131153337.29021-1-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.15.1
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

Changes since v2 patch series (https://www.linux-mips.org/archives/linux-mips/2018-01/msg00567.html):

  * sort the CONFIG_GENERIC_* options in arch/mips/Kconfig alphabetically (v2).

Changes since v1 patch series (https://www.linux-mips.org/archives/linux-mips/2018-01/msg00394.html):

  * sort the CONFIG_* options in arch/mips/Kconfig alphabetically;
  * add notrace to lib/ucmpdi2.c.

Antony Pavlov (1):
  MIPS: use generic GCC library routines from lib/

Palmer Dabbelt (1):
  Add notrace to lib/ucmpdi2.c

 arch/mips/Kconfig       |  5 +++++
 arch/mips/lib/Makefile  |  2 +-
 arch/mips/lib/ashldi3.c | 30 ------------------------------
 arch/mips/lib/ashrdi3.c | 32 --------------------------------
 arch/mips/lib/cmpdi2.c  | 28 ----------------------------
 arch/mips/lib/lshrdi3.c | 30 ------------------------------
 arch/mips/lib/ucmpdi2.c | 22 ----------------------
 lib/ucmpdi2.c           |  2 +-
 8 files changed, 7 insertions(+), 144 deletions(-)
 delete mode 100644 arch/mips/lib/ashldi3.c
 delete mode 100644 arch/mips/lib/ashrdi3.c
 delete mode 100644 arch/mips/lib/cmpdi2.c
 delete mode 100644 arch/mips/lib/lshrdi3.c
 delete mode 100644 arch/mips/lib/ucmpdi2.c

-- 
2.15.1
