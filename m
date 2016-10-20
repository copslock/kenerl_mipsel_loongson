Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2016 15:53:01 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33121 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993008AbcJTNwzIKBER (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Oct 2016 15:52:55 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 9E8593FD881CE;
        Thu, 20 Oct 2016 14:52:45 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 20 Oct 2016 14:52:48 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [GIT PULL] MIPS KVM fix for v4.9-rc2
Date:   Thu, 20 Oct 2016 14:52:33 +0100
Message-ID: <1476971554-1215-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.7.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55522
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

Hi Radim, Paolo,

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/kvm-mips.git tags/kvm_mips_4.9_2

for you to fetch changes up to d852b5f35e84e60c930589eeb14a6df21ea9b1cb:

  KVM: MIPS: Add missing uaccess.h include (2016-10-19 00:37:05 +0100)

I'd already based this on v4.9-rc1 rather than the kvm next branch which
isn't up to v4.9-rc1 yet. If thats a problem I can easily rebase, or
feel free to apply the patch directly.

Cheers
James

----------------------------------------------------------------
MIPS KVM fix for v4.9-rc2

- Fix build error introduced during the 4.9 merge window when
  tracepoints are disabled.

----------------------------------------------------------------
James Hogan (1):
      KVM: MIPS: Add missing uaccess.h include

 arch/mips/kvm/mips.c | 1 +
 1 file changed, 1 insertion(+)

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
-- 
2.7.3
