Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Jul 2013 00:07:28 +0200 (CEST)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:39191 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831311Ab3G2WHQthjcF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Jul 2013 00:07:16 +0200
Received: by mail-pd0-f180.google.com with SMTP id 10so5918547pdi.25
        for <multiple recipients>; Mon, 29 Jul 2013 15:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ozO4/Zf2XfLznYeMDf8q+a4n5jlDKihVzw2fn5DNFhQ=;
        b=mb22FlpcLnrwarn33fngazxROouqauwlKjuUIFK75Q8HN55Z/p6Qpmr7eR+0/O8iXS
         hswJxnqJSdnrjKrA1Y95dW7EEwMXyFHFFpt+vEzPs9jNeSKXkxxe1/gYI6e6AHIXpT+n
         cpsT3LEIXykEXR54i5SZN6nFotOLgOtHO84lyB38vxFM5LykbFG9j+DLCHN7mwp9vYBw
         H7YMk1qG5YYS49Klkh0tMEl4GzBVaEBQUJwcM8qqChf9IOsNCUlSCirJ+3mJNXvAXW1j
         SBPaY2j8mng7NIryuWtWtS/lspptV5oIJEMK9QqVF/SQjiIn4lN6lcxsw8Qxsx3FSLga
         ZySA==
X-Received: by 10.68.189.36 with SMTP id gf4mr70658389pbc.27.1375135630032;
        Mon, 29 Jul 2013 15:07:10 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id xl3sm79014951pbb.17.2013.07.29.15.07.08
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jul 2013 15:07:09 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r6TM76FX030989;
        Mon, 29 Jul 2013 15:07:07 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r6TM76o2030988;
        Mon, 29 Jul 2013 15:07:06 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 0/5] MIPS: Add support for OCTEON III based SoCs.
Date:   Mon, 29 Jul 2013 15:06:59 -0700
Message-Id: <1375135624-30950-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37394
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

These patches add minimal support for SoCs in the OCTEON III family.
In many respects, they are similar to OCTEON II, but with larger cache
and FPU.  FPU support comes later...

David Daney (5):
  MIPS: Add CPU identifiers for more OCTEON family members.
  MIPS: Probe for new OCTEON CPU/SoC types.
  MIPS: Use r4k_wait for OCTEON3 CPUs.
  MIPS: Generate OCTEON3 TLB handlers with the same features as
    OCTEON2.
  MIPS: OCTEON: Set L1 cache parameters for OCTEON3 CPUs.

 arch/mips/include/asm/cpu.h  |  5 ++++-
 arch/mips/kernel/cpu-probe.c |  7 +++++++
 arch/mips/kernel/idle.c      |  1 +
 arch/mips/mm/c-octeon.c      | 14 ++++++++++++++
 arch/mips/mm/tlbex.c         |  2 ++
 5 files changed, 28 insertions(+), 1 deletion(-)

-- 
1.7.11.7
