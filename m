Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Mar 2017 02:47:01 +0100 (CET)
Received: from mail-qk0-x242.google.com ([IPv6:2607:f8b0:400d:c09::242]:36111
        "EHLO mail-qk0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993897AbdCHBqyHhYEG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Mar 2017 02:46:54 +0100
Received: by mail-qk0-x242.google.com with SMTP id n141so6581448qke.3;
        Tue, 07 Mar 2017 17:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9iseGk7bFC6VaqB+IO1zuB4T6M6pnmBOTZLp6OmDmyk=;
        b=dJVaP6ZETQAwE0bFj7HkjA/nx5uvOJuCmQldNNnd8g/hdIDCTIuc6gcdHRkrp0+6/s
         /mCrL4eG5kWG3fM9HM3B2E340+ZaustrdYD9UJdPtyobEOtLx4STvRhv50rvZMb/shEZ
         gdkRa+zYOzjzdC/ksRM+tI16pwE/QZM9/Zik2+rbL+fa04r4etcBl8tTMIo0y+F0X751
         tSeVYik2Zi+EVCySRd0z7K+IllRplC7quwSyCozJWre8pDt0o2iy9cHkrouXNr1TECLx
         Joc/O/v8Teaz8gjmwc0oec6efPZwgiMh23yKJYGgP/3rV8MDj2V2ecWNy/7ZUQPYKWih
         Hy3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9iseGk7bFC6VaqB+IO1zuB4T6M6pnmBOTZLp6OmDmyk=;
        b=IqfL3xqpAuU+lxUNIfHg9y3jNQPlKRdQv/HYneexPwOCNMhCWFJWWQQcCs/htS4LYU
         kM510JvaxrJMYHF6hi33MmKyGkOLIBioq3lZ6BViYzdExXJp1Y8KojjOGqP0vnFkqR10
         nbmWADBaFPWPlnjOYGjzoT7bG4EikYYBt9xMA0n8/7UH1RaiSKKCHHwwBzj4Z0EcZOay
         BW0qdg/k5+QiW6t/4cw7LgnJC7MS2Wc3hTkXnFE19H9DqZnMmj2ID1Mq65F4nyj0zRRK
         1T/DkxWLx0NK10TFbf+Ff6B35vjPM7WbS6G0F9bD6/mHjGt5alZ9KcsHyn/mlfNfT+zd
         kQhA==
X-Gm-Message-State: AFeK/H3l+a+QF/Q09gikI4P9MNIs85fwAXImwOK3uHsp/EaWDM0tDAiGaqo9RsPpNEVGRQ==
X-Received: by 10.233.239.140 with SMTP id d134mr4170031qkg.313.1488937608028;
        Tue, 07 Mar 2017 17:46:48 -0800 (PST)
Received: from fainelli-desktop.irv.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id h27sm1198892qtf.24.2017.03.07.17.46.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Mar 2017 17:46:47 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, james.hogan@imgtec.com,
        paul.burton@imgtec.com, marcin.nowakowski@imgtec.com,
        justinpopo6@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 0/2] MIPS: Couple kexec related fixes
Date:   Tue,  7 Mar 2017 17:46:39 -0800
Message-Id: <20170308014641.16267-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.9.3
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57076
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

This small patch series fixes two obvious issues encountered on a R4k-style
system (BMIPS) where attemping a system kexec was just not going to work
without these two fixes.

This really makes me wonder if there is anybody really using kexec besides
octeon?

Florian Fainelli (2):
  MIPS: kexec: Provide bootloader arguments by default
  MIPS: c-r4k: Do not SMP function call during kexec

 arch/mips/kernel/machine_kexec.c | 9 ++++++++-
 arch/mips/mm/c-r4k.c             | 6 +++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.9.3
