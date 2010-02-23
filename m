Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Feb 2010 19:21:38 +0100 (CET)
Received: from mail-bw0-f215.google.com ([209.85.218.215]:35946 "EHLO
        mail-bw0-f215.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492398Ab0BWSVf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Feb 2010 19:21:35 +0100
Received: by bwz7 with SMTP id 7so2763982bwz.24
        for <linux-mips@linux-mips.org>; Tue, 23 Feb 2010 10:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=IVc3FI2PkNBvEf8PW4ddcYSg17ojnKgaRcjAsUrA+fU=;
        b=UPggQ6g2MtIAomAjZVPBHer2JF78Q6FkeF8WT1tZNACypBtgg+0dFpWLFAvBK7bzoO
         /Ml3OFxl6+4s5Vrm1f9sd1baRucZgoFygvPzR4dxLFyFQT0ogBZGLi9Ai8m/gpACv030
         lJ/21crN0iXhTCeVRlJUUr6YoEn3sBcmPidn4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ls4YkoxleD6+3FTue82El4TpMYtF5rxEME7YL7aXWmX7oQ/QoiJ6f6hwI7hVPTbHFz
         +wE7+pvSz7E/j9bNs3sqqmP/RRmLktfigb7KCWXbEIjOmJxgraE+2p8f1CkIh6kpwVkR
         rUx5rSqVTeAfOosbxLfkgbKf5eQplVcByXwaI=
Received: by 10.204.49.82 with SMTP id u18mr3565231bkf.74.1266949289315;
        Tue, 23 Feb 2010 10:21:29 -0800 (PST)
Received: from localhost.localdomain (p5496C184.dip.t-dialin.net [84.150.193.132])
        by mx.google.com with ESMTPS id 15sm2041976bwz.12.2010.02.23.10.21.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Feb 2010 10:21:28 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux Serial <linux-serial@vger.kernel.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: [RFC PATCH 0/2] serial 8250 platform PM hooks
Date:   Tue, 23 Feb 2010 19:22:25 +0100
Message-Id: <1266949347-12024-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.7.0
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

The following 2 patches implement a PM hook for platform 8250
UARTs and a sample PM implementation for a MIPS SoC.

Patch #1 hooks a new .pm callback in struct plat_serial8250_port to
the rest of serial_core's PM infrastructure,

Patch #2 implements uart power gating for Alchemy line of mips socs.

With these 2 patches serial console on my test system survives
suspend/resume cycles without having to resort to platform-specific
hacks in the PM code.

Thanks,
     Manuel Lauss

Manuel Lauss (2):
  8250: allow platform uarts to install PM callback.
  Alchemy: UART PM through serial framework.

 arch/mips/alchemy/common/platform.c |   17 +++++++++++++++++
 arch/mips/alchemy/common/power.c    |   35 -----------------------------------
 drivers/serial/8250.c               |   31 ++++++++++++++++++++++++++++---
 include/linux/serial_8250.h         |    6 ++++++
 4 files changed, 51 insertions(+), 38 deletions(-)
