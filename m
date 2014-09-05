Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 03:00:43 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24319 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025887AbaIEBAm2RYAA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Sep 2014 03:00:42 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8D064EBD7A3D7;
        Fri,  5 Sep 2014 02:00:34 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 5 Sep
 2014 02:00:35 +0100
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by klmail02.kl.imgtec.org
 (10.40.60.222) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 5 Sep
 2014 02:00:35 +0100
Received: from BAMAIL02.ba.imgtec.org (192.168.66.28) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 5 Sep 2014 02:00:34 +0100
Received: from [127.0.1.1] (192.168.65.146) by bamail02.ba.imgtec.org
 (192.168.66.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 4 Sep
 2014 18:00:27 -0700
Subject: [PATCH 0/3] Series short description
To:     <linux-mips@linux-mips.org>, <hauke@hauke-m.de>, <yanh@lemote.com>,
        <zajec5@gmail.com>, <ralf@linux-mips.org>, <alex.smith@imgtec.com>,
        <taohl@lemote.com>, <chenhc@lemote.com>
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Date:   Thu, 4 Sep 2014 18:00:27 -0700
Message-ID: <20140905005807.15161.36194.stgit@linux-yegoshin>
User-Agent: StGit/0.15
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42393
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

The following series implements...

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
