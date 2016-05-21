Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 14:03:09 +0200 (CEST)
Received: from mail-lb0-f196.google.com ([209.85.217.196]:35784 "EHLO
        mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27029238AbcEUMA6LjhgI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2016 14:00:58 +0200
Received: by mail-lb0-f196.google.com with SMTP id mx9so6875724lbb.2;
        Sat, 21 May 2016 05:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=zdNw3k2SpBXrC9BwZ/9NF4kmRp0+5PWq2zFlBO97P/8=;
        b=K0F3NC/6BOJFoE9BTqUwnULgUqKFV3wol4J0cPbMRB25r3i5VsF4HJfogOUATpYR0D
         XJJbkmGmqE2D3dmYSolnJGm0xvG5nzfOw6fltml9vNDgplljLv0aAhO+C5LrIaD/Nsaj
         NkO+LKSOsryZ6fSVZMuTvn2tNfZ+qleUfT9MgTrTKGxmLXgJ26VNf0+/9kdeZh0qC5fL
         u13QLOEhG61cTVPLtF70qshd2RqgCNaw4nkUpq68QueCYuo2ApbK85ct3vjpoIRlxHy0
         u8AwtfRfUZFp1pxNgBd1U7YUcGe1dbKpuCPCyO5ABxI+2jIZjXCOLs6O1PORFKStASGW
         cRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=zdNw3k2SpBXrC9BwZ/9NF4kmRp0+5PWq2zFlBO97P/8=;
        b=cY2pedgjsQskvEF74ci7gdJm6t66YWyhFJOtAOw2fzQKjwninlDw5H46qF5duHQFCs
         T7Zh/RJgf1JmF4uI00VipI/D/9qovYq9DOWYY8dJfPwef1geNeujpxuQn1uL3J3Rhh3w
         rLuWiVQQhdhkhJ1zAPKZm6jit4xzrLOAp6Q8KxZc+mZFd4efcQxTFb9GAW6zHB31hBpi
         5Cw+p4Fk5LbxNp8uc7tLlrNEi/PtfJp1JnRbwW30CW42i7V1UzKhzD28dy7b7FsXb/oH
         ZOPjsWVzzkvH+/sFAnex2zUZmFxJHNpOR4qnry4ospLNKWRCe5ARX5Fa2cV2ShLR0Cv8
         G2Sw==
X-Gm-Message-State: AOPr4FWMSNa4McXoJl936+ad5BB5U9TQpERP3WLmp5NMmAoinwzRqGnnGwrlpqNrSxm7rQ==
X-Received: by 10.112.157.65 with SMTP id wk1mr2669169lbb.131.1463832052899;
        Sat, 21 May 2016 05:00:52 -0700 (PDT)
Received: from glen.ipredator.se (anon-35-25.vpn.ipredator.se. [46.246.35.25])
        by smtp.gmail.com with ESMTPSA id g10sm4153895lbc.43.2016.05.21.05.00.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 21 May 2016 05:00:51 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     trivial@kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 0189/1529] Fix typo
Date:   Sat, 21 May 2016 14:00:48 +0200
Message-Id: <20160521120048.9710-1-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 2.8.2.534.g1f66975
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53587
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrea.gelmini@gelma.net
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

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/mips/include/asm/octeon/cvmx-helper-board.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/octeon/cvmx-helper-board.h b/arch/mips/include/asm/octeon/cvmx-helper-board.h
index 8933203..cda93ae 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper-board.h
+++ b/arch/mips/include/asm/octeon/cvmx-helper-board.h
@@ -94,7 +94,7 @@ extern int cvmx_helper_board_get_mii_address(int ipd_port);
  * @phy_addr:  The address of the PHY to program
  * @link_flags:
  *		    Flags to control autonegotiation.  Bit 0 is autonegotiation
- *		    enable/disable to maintain backware compatibility.
+ *		    enable/disable to maintain backward compatibility.
  * @link_info: Link speed to program. If the speed is zero and autonegotiation
  *		    is enabled, all possible negotiation speeds are advertised.
  *
-- 
2.8.2.534.g1f66975
