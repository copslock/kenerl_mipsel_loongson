Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Oct 2015 16:12:43 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57426 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009661AbbJFOMlRxufk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Oct 2015 16:12:41 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id CBCBC2BAD985A;
        Tue,  6 Oct 2015 15:12:32 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 6 Oct 2015 15:12:35 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 6 Oct 2015 15:12:34 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        <linux-mips@linux-mips.org>, <stable@vger.kernel.org>
Subject: [PATCH 0/2] ttyFDC: Fix build problems due to use of module_{init,exit}
Date:   Tue, 6 Oct 2015 15:12:04 +0100
Message-ID: <1444140726-5740-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.9
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49449
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

Fix ttyFDC build breakage since v4.2-rc3, due to use of module_driver()
without including module.h (its currently a builtin only driver).

The first patch adds a macro used by second patch, so they both need to
go into stable v4.2 together.

James Hogan (2):
  MIPS: CDMM: Add builtin_mips_cdmm_driver() macro
  ttyFDC: Fix build problems due to use of module_{init,exit}

 arch/mips/include/asm/cdmm.h | 11 +++++++++++
 drivers/tty/mips_ejtag_fdc.c | 35 +----------------------------------
 2 files changed, 12 insertions(+), 34 deletions(-)

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org>
-- 
2.4.9
