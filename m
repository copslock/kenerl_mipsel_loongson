Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jun 2013 23:37:44 +0200 (CEST)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:58581 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835001Ab3FSVhnAKV8i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Jun 2013 23:37:43 +0200
Received: by mail-pd0-f180.google.com with SMTP id 10so5508062pdi.11
        for <multiple recipients>; Wed, 19 Jun 2013 14:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=wH9492+sEusJY3bo61Glki+BeziV16+AQyAzwQFmuuU=;
        b=yTUcoTxw9X4iSqcna5q1fbUFZzVUvVWzEmaGrt2wNjcBIiQe0e1MHw/vf9sZqfzSU0
         GOEqoC6kTmAAsS5eGPkFsFrqrtq2OuVvuqiqUGFFfSuNO0SOJdLg/XpuwRY2EnNIHcvl
         uqWdJFtJ2g9QvQl7ToEicEGa3LjimbnT2lTldp+77yxS66tKD5pT2mg+vvGn74d0STq0
         WkOxHPwMCPJYHo8B+1vuEXFDlNQJbUdOCVCMC5iCdlOGTDzGhKQhmXsJMgzDVaywkJ92
         RjVa47NT7IAlmwFJKCK8CICfclYSk1WQ8lTlcQPiVig0mdhzgBjwJFp47zq2ZJZJoPWA
         MIRQ==
X-Received: by 10.68.197.33 with SMTP id ir1mr4521485pbc.197.1371677856460;
        Wed, 19 Jun 2013 14:37:36 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id fm2sm26392749pab.13.2013.06.19.14.37.34
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 19 Jun 2013 14:37:35 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r5JLbXeQ023951;
        Wed, 19 Jun 2013 14:37:33 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r5JLbUsZ023948;
        Wed, 19 Jun 2013 14:37:30 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Jamie Iles <jamie@jamieiles.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v2 0/4] MIPS/tty/8250: Use standard 8250 drivers for OCTEON
Date:   Wed, 19 Jun 2013 14:37:25 -0700
Message-Id: <1371677849-23912-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37020
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

Changes from v1: Fix breakage in non-OCTEON builds of 8250_dw.c

1) Fix OCTEON's UART clock rate.

2) Make minor patches to 8250_dw so it can be used by OCTEON

3) Rip out the OCTEON serial code.

4) Update defconfig so we default to having a usable serial port.

Since the patches are all interdependent, we might want to merge them
via a single tree (perhaps Ralf's MIPS tree as OKed by Greg K-H).

David Daney (4):
  MIPS: OCTEON: Set proper UART clock in internal device trees.
  tty/8250_dw: Add support for OCTEON UARTS.
  MIPS: OCTEON: Remove custom serial setup code.
  MIPS: Update cavium_octeon_defconfig

 arch/mips/cavium-octeon/Makefile          |   2 +-
 arch/mips/cavium-octeon/octeon-platform.c |   9 ++-
 arch/mips/cavium-octeon/serial.c          | 109 ------------------------------
 arch/mips/configs/cavium_octeon_defconfig |   4 +-
 drivers/tty/serial/8250/8250_dw.c         | 108 ++++++++++++++++++-----------
 5 files changed, 79 insertions(+), 153 deletions(-)
 delete mode 100644 arch/mips/cavium-octeon/serial.c

-- 
1.7.11.7
