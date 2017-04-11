Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Apr 2017 09:00:56 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56044 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993912AbdDKHAt57Si6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Apr 2017 09:00:49 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 00F41AA1F1814;
        Tue, 11 Apr 2017 08:00:42 +0100 (IST)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 11 Apr 2017 08:00:43 +0100
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Subject: [PATCH 0/3] mips highmem fixes
Date:   Tue, 11 Apr 2017 09:00:33 +0200
Message-ID: <1491894036-5440-1-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57660
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

There are currently a few incorrect assumptions made about the location
and alignment of fixed memory mappings that lead to random crashes when
using highmem with large (>4k) pages

Marcin Nowakowski (3):
  MIPS: mm: fixed mappings: correct initialisation
  MIPS: highmem: ensure that we don't use more than one page for PTEs
  MIPS: mm: adjust PKMAP location

 arch/mips/include/asm/highmem.h    | 5 +++++
 arch/mips/include/asm/pgtable-32.h | 7 ++++++-
 arch/mips/mm/pgtable-32.c          | 6 +++---
 3 files changed, 14 insertions(+), 4 deletions(-)

-- 
2.7.4
