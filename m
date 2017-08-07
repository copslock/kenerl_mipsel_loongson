Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2017 00:37:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52819 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994852AbdHGWhq4AE0I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Aug 2017 00:37:46 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id C724A5C6EE8BB;
        Mon,  7 Aug 2017 23:37:35 +0100 (IST)
Received: from localhost (10.20.1.88) by HHMAIL01.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 7 Aug 2017 23:37:40
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 0/4] MIPS: Split generic board ITS source, fix NI 169445 build
Date:   Mon, 7 Aug 2017 15:37:20 -0700
Message-ID: <20170807223724.19408-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59401
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

This series splits the generic vmlinux.its.S flattened image tree
source, allowing boards to specify their device tree & configuration
nodes in a board-specific file that gets concatenated with others to
form the final image tree source that is used to build the flattened
image tree (.itb file).

Applies atop mips-for-linux-next at 246edadb70f7.


Paul Burton (4):
  MIPS: Allow platform to specify multiple its.S files
  MIPS: generic: Move Boston FIT image source to its own file
  MIPS: generic: Move NI 169445 FIT image source to its own file
  MIPS: NI 169445: Fix lack of ITS root node

 arch/mips/Makefile                     |  3 +-
 arch/mips/boot/Makefile                | 16 +++++++----
 arch/mips/generic/Platform             |  4 +++
 arch/mips/generic/board-boston.its.S   | 22 +++++++++++++++
 arch/mips/generic/board-ni169445.its.S | 22 +++++++++++++++
 arch/mips/generic/vmlinux.its.S        | 50 ----------------------------------
 6 files changed, 61 insertions(+), 56 deletions(-)
 create mode 100644 arch/mips/generic/board-boston.its.S
 create mode 100644 arch/mips/generic/board-ni169445.its.S

-- 
2.14.0
