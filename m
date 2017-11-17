Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Nov 2017 03:20:11 +0100 (CET)
Received: from mail-pf0-x241.google.com ([IPv6:2607:f8b0:400e:c00::241]:36172
        "EHLO mail-pf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991339AbdKQCUDWQEzV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Nov 2017 03:20:03 +0100
Received: by mail-pf0-x241.google.com with SMTP id i15so809509pfa.3;
        Thu, 16 Nov 2017 18:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tkj+tU2hKdLoEGp938N69Jo8wz8o/ufCXrm+l17qSBY=;
        b=U4tKAO+iF82RKtA5x4QUQUgZlolkEbsXsFI7nVv6EBbuHBR2fKrB4/lM4lBR7CAezA
         dVj5HpJeXjADKHmoKWGdUCrq/rQLTq9RkEv01HKQKY7iaMNOJCnKJZJ0O0q+qRdGnO+T
         sop2S1t/LM87a+NK29d8dSjiNNlU5nswvdwXT7S8Le/8JOpSp2coVoJuSMmbQkl3t+EO
         TWhgWC6VP1I23iZCU3xE9YEiO4plRZciwD5rA09/gQ/67QQ9Fl1ecas51HD8vDNHHSsX
         8RSazH1UFN/XaCxmCbuvhvkZCH3JKyJYE5C9biSymOK0a5qmKWxHX9bUHsWkgLD9JkLQ
         nPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tkj+tU2hKdLoEGp938N69Jo8wz8o/ufCXrm+l17qSBY=;
        b=XckUmDHzyt75tOLMRvCFHi30uPqcnWg8QOl7jiBZaMOYdyzzTYl3IHcczVj4WG5/wT
         72g4PJoeYOnXa/K5gGJRHr9Vl76VlZCq1mk3SK0ZCDdm6XXFuU7/zvmVysD2KR4DCfKn
         LPUmmJMrtzuoqqPdbg0tHrZZL73xdcjOs12x4OQ9Kqw/tcp5cUcxpyg/Zv5fObFMZvh5
         Sg/XnwLHtgEvDzTAgH5UyhA9lrUhR9sXkNMS4Nf7W0g4QCW46FED2zCuabvc4bgDBp4K
         us9xzbx4QhfVADyFsKqwNuD9Z0cv/P4qmqCzcbRh5vclUXJv0pLa0aAbUEYUoE1utQha
         2t7w==
X-Gm-Message-State: AJaThX58YFBR5L7WJf1PgUsEOdfeuBflMPNPKHdpU9K2VCr92Q/5pJ3Q
        RZwvte3sAl8033dHkC6g9Ouo9Iva
X-Google-Smtp-Source: AGs4zMat7cGgbd0mkkf9osDco1sU89gURgjqsYKEzhgpmiXkK/1TJiA09BXbfdNOTcM/GrwOefrSgA==
X-Received: by 10.99.95.143 with SMTP id t137mr3712178pgb.442.1510885196177;
        Thu, 16 Nov 2017 18:19:56 -0800 (PST)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id s4sm5393280pgp.40.2017.11.16.18.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Nov 2017 18:19:55 -0800 (PST)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 0/3] MIPS: BMIPS: Add Broadcom STB device nodes
Date:   Fri, 17 Nov 2017 11:19:41 +0900
Message-Id: <20171117021944.894-1-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.15.0
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

This series adds power and memory management related devie tree nodes for
Broadcom STB platforms.

Jaedon Shin (3):
  MIPS: BMIPS: Add Broadcom STB power management nodes
  MIPS: BMIPS: Add Broadcom STB wake-up timer nodes
  MIPS: BMIPS: Add Broadcom STB watchdog nodes

 arch/mips/boot/dts/brcm/bcm7125.dtsi      |  7 +++
 arch/mips/boot/dts/brcm/bcm7346.dtsi      | 62 +++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7358.dtsi      | 17 ++++++
 arch/mips/boot/dts/brcm/bcm7360.dtsi      | 62 +++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7362.dtsi      | 62 +++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7420.dtsi      |  7 +++
 arch/mips/boot/dts/brcm/bcm7425.dtsi      | 89 +++++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7435.dtsi      | 89 +++++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97125cbmb.dts  |  4 ++
 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts |  8 +++
 arch/mips/boot/dts/brcm/bcm97358svmb.dts  |  8 +++
 arch/mips/boot/dts/brcm/bcm97360svmb.dts  |  8 +++
 arch/mips/boot/dts/brcm/bcm97362svmb.dts  |  8 +++
 arch/mips/boot/dts/brcm/bcm97420c.dts     |  4 ++
 arch/mips/boot/dts/brcm/bcm97425svmb.dts  |  8 +++
 arch/mips/boot/dts/brcm/bcm97435svmb.dts  |  8 +++
 16 files changed, 451 insertions(+)

-- 
2.15.0
