Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jun 2013 21:13:14 +0200 (CEST)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:54985 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827424Ab3FRTNLkJMCQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Jun 2013 21:13:11 +0200
Received: by mail-pa0-f41.google.com with SMTP id bj3so4318563pad.14
        for <multiple recipients>; Tue, 18 Jun 2013 12:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=6nObJ53VNzbIg9/2xt6ehQejghKIy+X17uxFd6UFGOQ=;
        b=SvCtKmBSYzcHee99Wtolyb+0k38VVTmszOSa/ry/a1V2ksKExYLYoDGBsLkTcKCppt
         6E6FV6ALJUI/XGmGu2KvYysqhlULHU3fMgpiD3q+lh796zOihD+ecSrm43Fp2wOg6yZR
         aVOkqAg6D6NKmbC90fSIuk2FzTOhGdwqrN1vWsxo2TWe1kJi4/+Y6pHoDaToApyX5ce0
         vQxxwyE0/w6KvIcxa4Y/soUwo4n8SJXUORgWZfInNpViGUhzKSlQTOmHh+igGtYc2V/v
         NPOvTZZDXVQ1Eellmja7dM1bq0nI7SlnQ7DtzPHMARv2eJ3FNHzE0XoWEaip+grCasRT
         oKFA==
X-Received: by 10.66.150.40 with SMTP id uf8mr3402145pab.66.1371582784549;
        Tue, 18 Jun 2013 12:13:04 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ib9sm19444828pbc.43.2013.06.18.12.13.02
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 12:13:03 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r5IJD081012179;
        Tue, 18 Jun 2013 12:13:01 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r5IJCv27012178;
        Tue, 18 Jun 2013 12:12:57 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Jamie Iles <jamie@jamieiles.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 0/5] MIPS/tty/8250: Use standard 8250 drivers for OCTEON
Date:   Tue, 18 Jun 2013 12:12:50 -0700
Message-Id: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36989
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

Get rid of the custom OCTEON UART probe code and use 8250_dw instead.

The first patch just gets rid of Ralf's Kconfig workarounds for the
real problem, which is OCTEON's inclomplete serial support.

Then we just make minor patches to 8250_dw, and rip out all this
OCTEON code.

Since the patches are all interdependent, we might want to merge them
via a single tree (perhaps Ralf's MIPS tree).

David Daney (5):
  Revert "MIPS: Octeon: Fix build error if CONFIG_SERIAL_8250=n"
  MIPS: OCTEON: Set proper UART clock in internal device trees.
  tty/8250_dw: Add support for OCTEON UARTS.
  MIPS: OCTEON: Remove custom serial setup code.
  MIPS: Update cavium_octeon_defconfig

 arch/mips/cavium-octeon/Makefile          |   1 -
 arch/mips/cavium-octeon/octeon-platform.c |   9 ++-
 arch/mips/cavium-octeon/serial.c          | 109 ------------------------------
 arch/mips/configs/cavium_octeon_defconfig |   4 +-
 drivers/tty/serial/8250/8250_dw.c         |  45 ++++++++++--
 5 files changed, 48 insertions(+), 120 deletions(-)
 delete mode 100644 arch/mips/cavium-octeon/serial.c

-- 
1.7.11.7
