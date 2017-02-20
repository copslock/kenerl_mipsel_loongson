Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2017 10:29:53 +0100 (CET)
Received: from nbd.name ([IPv6:2a01:4f8:131:30e2::2]:56143 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992244AbdBTJ3q5DHF4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 20 Feb 2017 10:29:46 +0100
From:   John Crispin <john@phrozen.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <john@phrozen.org>
Subject: [PATCH 0/3] arch: mips: pci: cleanups and fixes for mt7620 driver
Date:   Mon, 20 Feb 2017 10:29:41 +0100
Message-Id: <1487582984-40143-1-git-send-email-john@phrozen.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

While updating the LEDE kernel to v4.9 i stumbled across a fw compile
warnings. While fixing these warnings I also noticed that the BIT() macro
was not used.

John Crispin (3):
  arch: mips: pci: remove duplicate define in mt7620 driver
  arch: mips: pci: remove KERN_WARN instance inside the mt7620 driver
  arch: mips: pci: make use of the BIT() macro inside the mt7620 driver

 arch/mips/pci/pci-mt7620.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

-- 
1.7.10.4
