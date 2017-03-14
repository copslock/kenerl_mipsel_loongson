Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 18:00:47 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37368 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993939AbdCNRAUTr52E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 18:00:20 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id A46EAC677A006;
        Tue, 14 Mar 2017 17:00:08 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 14 Mar 2017 17:00:12 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: [PATCH 0/2] KVM: MIPS/Emulate: TLBWR & TLBR fixes for T&E
Date:   Tue, 14 Mar 2017 17:00:06 +0000
Message-ID: <cover.57583f73c169e83d499329fbda19909b816c0024.1489510483.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57257
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

These two patches fix TLBWR and TLBR instruction emulation for Trap &
Emulate guests, so that wired entries are properly preserved and so that
the entries can be read back by the guest itself.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Cc: stable@vger.kernel.org

James Hogan (2):
  KVM: MIPS/Emulate: Fix TLBWR with wired for T&E
  KVM: MIPS/Emulate: Properly implement TLBR for T&E

 arch/mips/kvm/emulate.c | 103 ++++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 47 deletions(-)

-- 
git-series 0.8.10
