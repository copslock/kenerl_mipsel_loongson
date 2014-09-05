Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 03:03:49 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17151 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008171AbaIEBDshWgHl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Sep 2014 03:03:48 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D6630CBA108A9;
        Fri,  5 Sep 2014 02:03:40 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 5 Sep
 2014 02:03:41 +0100
Received: from BAMAIL02.ba.imgtec.org (192.168.66.28) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 5 Sep 2014 02:03:41 +0100
Received: from [127.0.1.1] (192.168.65.146) by bamail02.ba.imgtec.org
 (192.168.66.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 4 Sep
 2014 18:03:39 -0700
Subject: [PATCH 0/3] PTE formats changes
To:     <linux-mips@linux-mips.org>, <hauke@hauke-m.de>, <yanh@lemote.com>,
        <zajec5@gmail.com>, <ralf@linux-mips.org>, <alex.smith@imgtec.com>,
        <taohl@lemote.com>, <chenhc@lemote.com>
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Date:   Thu, 4 Sep 2014 18:03:39 -0700
Message-ID: <20140905010124.15448.53707.stgit@linux-yegoshin>
User-Agent: StGit/0.15
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42394
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

The following series implements bugfix of PTE formats for swap and file entries
and changes PTE bit position to fixed, which is more better for analysing of
tracer and HW debugger logs.

Hardcoded bits positions and offsets in PTE effectively causes a miss of
relationship between PTE format for TLB and PTE formats for swap and file
entries. This patch series introduces a symbolic relation between both and
also fixes a current mismatch of formats. It can crash kernel or application
in heavy paging environment.

Fixed bit positions helps much in analysing of tracer and HW debugger logs and
improves performance and code size a little due to absence of variable masks
in kernel.

---

Leonid Yegoshin (3):
      MIPS: rearrange PTE bits into fixed positions
      MIPS: PTE bit positions slightly changed to prepare a more simple swap/file presentation
      MIPS: bugfix of PTE formats for swap and file entries


 arch/mips/include/asm/pgtable-32.h   |  107 ++++++++-----------
 arch/mips/include/asm/pgtable-64.h   |   25 +++-
 arch/mips/include/asm/pgtable-bits.h |  189 ++++++++++++++++++++++++++++++----
 3 files changed, 232 insertions(+), 89 deletions(-)

-- 
Signature
