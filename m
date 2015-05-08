Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2015 15:00:45 +0200 (CEST)
Received: from mail-pd0-f171.google.com ([209.85.192.171]:33990 "EHLO
        mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026554AbbEHNAeAFw-r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 May 2015 15:00:34 +0200
Received: by pdbqa5 with SMTP id qa5so80250943pdb.1;
        Fri, 08 May 2015 06:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=4AYQS58yRxeSSx9Aw/CB3MEFdZn7s8QqBkrOeASsaIw=;
        b=uTOcCPuqrR37Uz/YsPyMTwDD7wPN72DWfRn93ubEES9fVnYb6W61eoWtfqiV4/RAlp
         +g4GHZOWCWgm/qT68/HGMsQmOpicADzkjiLY+mQO7KY7Kjk+GIBz0kMsjoDLMg0SILeM
         nChf/sgazlO1+NNCRajC0QzWbJ67mguhA1GoYeIbh+E+fgcLAlA/WquSL8gaHA3niONT
         bF7+dA2OzUztkG5N2inS0QZyVUTaJRcZOFlNnoU2J/2X6s0LsIMCUvfUdu/HVYFidw70
         BfqWtDUupxYw8i+CvnjNnY9/OBlmvjxY2G3pclJFzEZbj5Hfi9WauZe9m2usfdzQllwB
         Y1jw==
X-Received: by 10.70.134.198 with SMTP id pm6mr6417586pdb.17.1431089964905;
        Fri, 08 May 2015 05:59:24 -0700 (PDT)
Received: from localhost.localdomain ([59.12.167.210])
        by mx.google.com with ESMTPSA id i16sm5182237pbq.79.2015.05.08.05.59.22
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 May 2015 05:59:24 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 0/2] MIPS: BMIPS: dts: update device nodes for bcm7xxx platforms
Date:   Fri,  8 May 2015 21:59:16 +0900
Message-Id: <1431089958-2626-1-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.4.0
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47277
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

Hi all,

This patch series contain changing device nodes of the bcm7xxx platforms.

Jaedon Shin (2):
  MIPS: BMIPS: dts: remove unsupported entry for bcm7362
  MIPS: BMIPS: dts: add uart device nodes to bcm7xxx platforms

 arch/mips/boot/dts/brcm/bcm7346.dtsi      | 26 ++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7358.dtsi      | 26 ++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7360.dtsi      | 26 ++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7362.dtsi      | 26 ++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts |  8 ++++++++
 arch/mips/boot/dts/brcm/bcm97358svmb.dts  |  8 ++++++++
 arch/mips/boot/dts/brcm/bcm97360svmb.dts  |  8 ++++++++
 arch/mips/boot/dts/brcm/bcm97362svmb.dts  | 10 +++++++++-
 8 files changed, 137 insertions(+), 1 deletion(-)

-- 
2.4.0
