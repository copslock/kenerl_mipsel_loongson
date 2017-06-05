Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jun 2017 19:32:19 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47556 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991512AbdFERcLoiizR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Jun 2017 19:32:11 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 86DB46C0BA64;
        Mon,  5 Jun 2017 18:32:01 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 5 Jun 2017 18:32:05
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <netdev@vger.kernel.org>
CC:     "David S . Miller" <davem@davemloft.net>,
        <linux-mips@linux-mips.org>, Eric Dumazet <edumazet@google.com>,
        Jarod Wilson <jarod@redhat.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v4 0/7] net: pch_gbe: Fixes & MIPS support
Date:   Mon, 5 Jun 2017 10:31:29 -0700
Message-ID: <20170605173136.10795-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170602234042.22782-1-paul.burton@imgtec.com>
References: <20170602234042.22782-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The Intel EG20T Platform Controller Hub is used on the MIPS Boston
development board to provide various peripherals including ethernet.
This series fixes some issues with the pch_gbe driver discovered whilst
in use on the Boston board, and implements support for device tree which
we use to provide the PHY reset GPIO.

Applies atop v4.12-rc4.

Paul Burton (7):
  net: pch_gbe: Mark Minnow PHY reset GPIO active low
  net: pch_gbe: Pull PHY GPIO handling out of Minnow code
  dt-bindings: net: Document Intel pch_gbe binding
  net: pch_gbe: Add device tree support
  net: pch_gbe: Always reset PHY along with MAC
  net: pch_gbe: Allow longer for resets
  net: pch_gbe: Allow build on MIPS platforms

 Documentation/devicetree/bindings/net/pch_gbe.txt  | 25 +++++++
 drivers/net/ethernet/oki-semi/pch_gbe/Kconfig      |  2 +-
 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h    |  4 +-
 .../net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c   | 79 +++++++++++++++++-----
 4 files changed, 91 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/pch_gbe.txt

-- 
2.13.0
