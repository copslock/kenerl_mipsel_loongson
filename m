Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Aug 2013 21:11:03 +0200 (CEST)
Received: from mail-oa0-f43.google.com ([209.85.219.43]:44051 "EHLO
        mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824758Ab3HSTKsO92ZL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Aug 2013 21:10:48 +0200
Received: by mail-oa0-f43.google.com with SMTP id i10so6704489oag.16
        for <multiple recipients>; Mon, 19 Aug 2013 12:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=v3rmX6cK7L7w1ZPc5K5u8YaM1FG0098LbAUDN830vFU=;
        b=ad7/wu4fjLcpIRFdBIKMdPl+MbnEVTulQYcVsH8l+zMuL2RjqTB2CSgHpphX+z79II
         WnucdfnUwX+CFaxXliIKXn9FNolwdoe1PoFeq9+N0IrIpG+kzJ3Ed03wJh3bUXOCgnur
         Ak9pBwT3lNVVp5PuthfmHleQHHYi4/OAm6NASPoGYeTAcLc4ZAnqSifpFhLFInX7JYTb
         bN3Y9F5uaTH0J2d+dvcDrVbV8/v/2pvpoBNVcH5rf/kMKwvi14HMebGYFSu7DQBYerl6
         cDsaIcG7kXTYgt2U+eDSPSv+nEbZOZUqaQqjdEMYZdMDYpHWol8gtVfE6tBxV4qtEn+O
         GhKg==
X-Received: by 10.182.101.198 with SMTP id fi6mr3294556obb.79.1376939441606;
        Mon, 19 Aug 2013 12:10:41 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id tz10sm18687887obc.10.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 19 Aug 2013 12:10:40 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r7JJAcTf019797;
        Mon, 19 Aug 2013 12:10:38 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r7JJAaNp019796;
        Mon, 19 Aug 2013 12:10:36 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 0/2] MIPS: FPU Emulator fixes
Date:   Mon, 19 Aug 2013 12:10:33 -0700
Message-Id: <1376939435-19761-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37587
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

Here are a couple of MIPS FPU Emulator fixes.

The first fixes a real problem where code compiled specifically for
OCTEON erroneously gets SIGILL.

The second is a clean up I noticed along the way.

David Daney (2):
  MIPS: Handle OCTEON BBIT instructions in FPU emulator.
  MIPS: Remove unreachable break statements from cp1emu.c

 arch/mips/math-emu/cp1emu.c | 53 ++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 27 deletions(-)

-- 
1.7.11.7
