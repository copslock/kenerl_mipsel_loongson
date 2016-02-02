Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2016 02:47:07 +0100 (CET)
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33543 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012024AbcBBBrGIjZ1u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Feb 2016 02:47:06 +0100
Received: by mail-pa0-f68.google.com with SMTP id pv5so7878176pac.0;
        Mon, 01 Feb 2016 17:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=0tH0DV1Jmahjzjd7zBmgLxLOoZO0jwtr/D1IZrc7TnU=;
        b=aWeUf3UwDAm5RdV0tCHklZ57Tv5to9opdph4rnb2aGy/8LhhSCLZ1sC6CURpXr3yCQ
         qW9oB/zDm8Vl6c43j6A5jajq0/x1o2dOH150+MkvalQ1r66YyaywPIZqDJDU2QgeZC57
         nIMqLlba46FUCO2p08oqRiuzshNAfCIxTXkex1HPIbgExfRW+cpF6eCWKxQPwldb71bk
         MaM1t1CASeqnO3o/fcGgMzxiKVb8ga5Lce6WlO3jDbGaJfjS9ZJb/c8Sxw3EqQwUEuDI
         EKLVlq/2s26Wz+rXxcOEgxgZXNjCn/wI1ZqlUBpkUvs9xWp/zbmG+KAyuMiSScxarEHZ
         7XVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0tH0DV1Jmahjzjd7zBmgLxLOoZO0jwtr/D1IZrc7TnU=;
        b=SVxduQ7GvmY05laEcUKl2HiFBkzh5JAcdjC2uMC9DuW6FkB63/UJkgih8VwuDgFmzx
         Tp84PCebuxevAP6fSlCFyVCPEzC6a8BJ2d8RE9SYk1BQeG9jbosMl+Bi3xhTIsuoL36Y
         V4Czou59f4sc9NGKlGSJjesv69DTFzRp+GNn0hncCpAJ0gl7WCGlmVWVwi7w698Nd2SK
         ubQAhZPkeQR5fGPDbW29elvouwgWrw4oL8loZXAV0FsrMBHH44guE8njsUvN4sE0N/1K
         NO1DP8C9qYzBWdPYnIqzQU6vgBodp525009dO8iNLbwnu4WHrktKAdc7LTXuvQ6qLatR
         sMKQ==
X-Gm-Message-State: AG10YORzm4fMLOYpEqNEeMP9mDvHL7DUYLFzyOzVWuCK9UgGLuD4skKpnC5mNk3ZrTXkuw==
X-Received: by 10.66.182.202 with SMTP id eg10mr43560434pac.50.1454377620142;
        Mon, 01 Feb 2016 17:47:00 -0800 (PST)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.gmail.com with ESMTPSA id s65sm36514264pfi.12.2016.02.01.17.46.58
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 01 Feb 2016 17:46:58 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id u121kuUX014951;
        Mon, 1 Feb 2016 17:46:56 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id u121ktxj014950;
        Mon, 1 Feb 2016 17:46:55 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 0/2] MIPS: Support more than 32 CPUs on OCTEON
Date:   Mon,  1 Feb 2016 17:46:52 -0800
Message-Id: <1454377614-14915-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51610
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

OCTEON systems can support 2-node NUMA configurations with 48 CPUs per
node.  The first step to handling these systems is to extend the
coremask information passed from the bootloader.  Internally to the
kernel we carry a mask capable of holding 1024 CPUs.  The bootloader
structure version is probed at runtime to populate the internal mask.
This in turn is used to initialize the SMP structures.

David Daney (2):
  MIPS: OCTEON: Remove dead code from cvmx-sysinfo.
  MIPS: OCTEON: Extend number of supported CPUs past 32

 arch/mips/cavium-octeon/executive/cvmx-sysinfo.c | 72 ++-----------------
 arch/mips/cavium-octeon/setup.c                  | 19 ++++-
 arch/mips/cavium-octeon/smp.c                    |  4 +-
 arch/mips/include/asm/octeon/cvmx-bootinfo.h     | 14 +++-
 arch/mips/include/asm/octeon/cvmx-coremask.h     | 89 ++++++++++++++++++++++++
 arch/mips/include/asm/octeon/cvmx-sysinfo.h      | 37 ++--------
 6 files changed, 130 insertions(+), 105 deletions(-)
 create mode 100644 arch/mips/include/asm/octeon/cvmx-coremask.h

-- 
1.7.11.7
