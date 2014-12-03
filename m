Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Dec 2014 00:44:33 +0100 (CET)
Received: from mail-ig0-f178.google.com ([209.85.213.178]:57119 "EHLO
        mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007947AbaLCXocI2Jm3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Dec 2014 00:44:32 +0100
Received: by mail-ig0-f178.google.com with SMTP id hl2so13736477igb.11
        for <multiple recipients>; Wed, 03 Dec 2014 15:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=qLMh27YdKiMkmS5KFdNh1Z/OkqzvSvH2DARV5Lylg7s=;
        b=z5X59IOblAxY4xoqm9zvbVA/ZNxRkLvM/BGlhosgijJ+LquvCYdTOaa3qBq7UBp4vb
         w2jqnDk6wvy5E0LQMwq5eKSucjwVA99t/p/TmHYboXNN2XH1s9/ShTKicdliCoHVlMA6
         Ov0FnTjhlMWdG1amU96SJoTCVzZFzKz71LHXOl7wlaRNFdblrbRtH8ICUX0DkHtV/Dux
         Ngp9D8x7pZkasDqtLTLH960vfaGjV40nCuLPHW1IyY8So+fsudaNYImDlijV9FrlCVLg
         L4M2h83fpdvDH33qo1W8U7614yeiFHVSURmU8qy/T5yp9Gln9rGk+iBQyvOu71GNjUKi
         rK3g==
X-Received: by 10.42.29.6 with SMTP id p6mr9155930icc.85.1417650266325;
        Wed, 03 Dec 2014 15:44:26 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id ck1sm5341104igb.0.2014.12.03.15.44.25
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 03 Dec 2014 15:44:25 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id sB3NiOgg002849;
        Wed, 3 Dec 2014 15:44:24 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id sB3NiJqP002846;
        Wed, 3 Dec 2014 15:44:19 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Zubair.Kakakhel@imgtec.com, geert+renesas@glider.be,
        peterz@infradead.org, paul.gortmaker@windriver.com,
        macro@linux-mips.org, chenhc@lemote.com, cl@linux.com,
        mingo@kernel.org, richard@nod.at, zajec5@gmail.com,
        james.hogan@imgtec.com, keescook@chromium.org, tj@kernel.org,
        alex@alex-smith.me.uk, pbonzini@redhat.com, blogic@openwrt.org,
        paul.burton@imgtec.com, qais.yousef@imgtec.com,
        linux-kernel@vger.kernel.org, markos.chandras@imgtec.com,
        dengcheng.zhu@imgtec.com, manuel.lauss@gmail.com,
        lars.persson@axis.com, David Daney <david.daney@cavium.com>
Subject: [PATCH 0/3] MIPS: Get ready for non-executable stack.
Date:   Wed,  3 Dec 2014 15:44:15 -0800
Message-Id: <1417650258-2811-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

Currently the MIPS FPU emulator uses eXecute Out of Line (XOL) on the
stack to handle instructions in the delay slots of FPU branches.
Because of this MIPS cannot have a non-executable stack.

A previous patch set from Leonid Yegoshin attempts to address the
problem by moving the XOL location to a thread private mapping of a
dedicated page.

I present here an alternative: Add an instruction set emulator and use
it to execute the FPU delay slot instructions.  The benefit of this
approach is that we don't have to allocate a page per user-space
thread for XOL, and we keep the TLB handling code slightly simpler as
a result.

Currently this is a proof of concept, as it doesn't yet handle MIPS64
nor microMIPS instructions.  But it is sufficient to run the entire
Debian distribution on a FPU-less CPU.

Comments welcome.

David Daney (3):
  MIPS: Add FPU emulator counter for non-FPU instructions emulated.
  MIPS: Add full ISA emulator.
  MIPS: Use full instruction emulation for FPU emulator delay slot
    emulation.

 arch/mips/include/asm/fpu_emulator.h |   1 +
 arch/mips/kernel/Makefile            |   3 +-
 arch/mips/kernel/insn-emul.c         | 815 +++++++++++++++++++++++++++++++++++
 arch/mips/math-emu/cp1emu.c          |  13 +-
 arch/mips/math-emu/me-debugfs.c      |   1 +
 5 files changed, 830 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/kernel/insn-emul.c

-- 
1.7.11.7
