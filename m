Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2015 17:53:06 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40443 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010210AbbGJPxExCUh1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jul 2015 17:53:04 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 746DCC41E9F2E;
        Fri, 10 Jul 2015 16:52:56 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 10 Jul 2015 16:52:59 +0100
Received: from localhost (10.100.200.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 10 Jul
 2015 16:52:58 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Ard Biesheuvel" <ard.biesheuvel@linaro.org>
Subject: [PATCH 0/2] Default platform MAAR implementation
Date:   Fri, 10 Jul 2015 16:52:37 +0100
Message-ID: <1436543559-26886-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48193
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

The kernel has previously required platforms making use of MAARs (Memory
Accessibility Attribute Registers) to configure the MAARs in a
platform_maar_init function. This series provides a default/weak
implementation of that function which reuses the data platforms already
provide to the bootmem allocator, and switches Malta to use it. The
result is a reduction in the duplication of data provided by the
platform about the memory map, and a corresponding reduction in the
amount of code needed to support a platform.

Paul Burton (2):
  MIPS: mm: default platform_maar_init using bootmem data
  MIPS: malta: use generic platform_maar_init

 arch/mips/mm/init.c                | 36 ++++++++++++++++++++++++++++++++++--
 arch/mips/mti-malta/malta-memory.c | 25 -------------------------
 2 files changed, 34 insertions(+), 27 deletions(-)

-- 
2.4.4
