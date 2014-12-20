Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Dec 2014 02:52:52 +0100 (CET)
Received: from mail-ie0-f181.google.com ([209.85.223.181]:59620 "EHLO
        mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009080AbaLTBwvVYh74 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Dec 2014 02:52:51 +0100
Received: by mail-ie0-f181.google.com with SMTP id rl12so27831iec.26;
        Fri, 19 Dec 2014 17:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=McNR9DflkJHUZTJHlVIy323aUxYyB/OUPcbf9GKidr4=;
        b=D1N+9zJ0y74dHwCc0OeRpeaJ/NECYIRQsWkc1dHxlcCQ4Zu5QQoJaXMG8lSgljGbqJ
         I0fXi9w4FRvWPUhuyQgBf7VirE999CEnbFSfh4xYAORZCIex96Yo5ekqP2vRoxgNHac6
         p78oezGJCS65wADbHOWNvdYqicKfIGJ4EoGZs7jeA0RgiHoBSFoipjgXq4P+g6OhLoVI
         OlLGvESqfzzTQgvf9M576xL2T1LQ+nRIKcTWwG7TJAPNAZVoQezWRNQ3q83ugrv9SX09
         QVwaFh/S2AlctTBoeAeaEgrLgcY5IxulcjStyq+zxUGbUPMGnNHxEpw4Q8wlzBhrqWpM
         nnYg==
X-Received: by 10.50.124.133 with SMTP id mi5mr6302217igb.13.1419040365200;
        Fri, 19 Dec 2014 17:52:45 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id kt1sm1689481igb.20.2014.12.19.17.52.44
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 19 Dec 2014 17:52:44 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id sBK1qhF9008541;
        Fri, 19 Dec 2014 17:52:43 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id sBK1qg9K008540;
        Fri, 19 Dec 2014 17:52:42 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [RFC PATCH v2 0/5] MIPS: Full ISA emulation for FPU emulation of delay slots
Date:   Fri, 19 Dec 2014 17:52:35 -0800
Message-Id: <1419040360-8502-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44865
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

I have been improving my emulator little by little.  It is still not
quite complete, but I am on vacation for the next several weeks, so I
thought I would send it as-is for your comments and general enjoyment.

David Daney (5):
  MIPS: Add FPU emulator counter for emulated delay slots.
  MIPS: Add FPU emulator counter for non-FPU instructions emulated.
  MIPS: Add instruction coding for SYNCI and add trap formats.
  MIPS: Add full ISA emulator.
  MIPS: Use full instruction emulation for FPU emulator delay slot
    emulation.

 arch/mips/include/asm/fpu_emulator.h |    2 +
 arch/mips/include/uapi/asm/inst.h    |   13 +-
 arch/mips/kernel/Makefile            |    2 +-
 arch/mips/kernel/insn-emul.c         | 1543 ++++++++++++++++++++++++++++++++++
 arch/mips/math-emu/cp1emu.c          |   13 +-
 arch/mips/math-emu/dsemul.c          |    2 +-
 arch/mips/math-emu/me-debugfs.c      |    2 +
 7 files changed, 1572 insertions(+), 5 deletions(-)
 create mode 100644 arch/mips/kernel/insn-emul.c

-- 
1.7.11.7
