Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 19:44:13 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10786 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012049AbcBHSoKzSibb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2016 19:44:10 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 70CF6DAAE2F5;
        Mon,  8 Feb 2016 18:44:01 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 8 Feb 2016 18:44:04 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 8 Feb 2016 18:44:04 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        Christopher Ferris <cferris@google.com>,
        James Hogan <james.hogan@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>, "Petr Malat" <oss@malat.biz>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, <linux-mips@linux-mips.org>,
        <linux-arch@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: [PATCH 0/3] MIPS: Fix exported asm/siginfo.h breakage
Date:   Mon, 8 Feb 2016 18:43:48 +0000
Message-ID: <1454957031-20138-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51864
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

These patches fix some issues with the asm/siginfo.h that MIPS exports
in its headers. Primarily the include of another uapi/ header since
v4.0 (patches 2 & 3), and also the continued use of non-strict posix
types since they were removed from the generic siginfo.h (patch 1).

James Hogan (3):
  MIPS: Fix siginfo.h to use strict posix types
  signal: Move generic copy_siginfo() to signal.h
  MIPS: Fix uapi include in exported asm/siginfo.h

 arch/mips/include/uapi/asm/siginfo.h | 22 ++++++++++------------
 include/asm-generic/siginfo.h        | 15 ---------------
 include/linux/signal.h               | 15 +++++++++++++++
 3 files changed, 25 insertions(+), 27 deletions(-)

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Petr Malat <oss@malat.biz>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-mips@linux-mips.org
Cc: linux-arch@vger.kernel.org
Cc: linux-ia64@vger.kernel.org
Cc: <stable@vger.kernel.org>
-- 
2.4.10
