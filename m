Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Mar 2010 18:15:21 +0100 (CET)
Received: from fg-out-1718.google.com ([72.14.220.154]:54681 "EHLO
        fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492594Ab0CXRPR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Mar 2010 18:15:17 +0100
Received: by fg-out-1718.google.com with SMTP id e12so1853570fga.6
        for <linux-mips@linux-mips.org>; Wed, 24 Mar 2010 10:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=in/ruWvw+8iw6SlXsUaZcaYqI6LV/Ybf9HYYrWK/BLo=;
        b=VRngnOIdwHRFPblf1fuAriMHQgtS84prk6ipRJLW6Ph/JlPA6mwcWgmw/p8quvbtHC
         j7iCqratTfLqx4fjRj01FuaEf3IFOOrz07KagPO66CkoPp6GoD3EbNvaSlZrsyIFTfI+
         zysQghgbtHrqrfP3d6LaIKfWelsdKnIo5RygY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=paVqpx+mTCu4Kgj6xDWtUzSwJ36D7xT/R7lm2Ewn3XY0V8bpIKoIINcYtUPT9qbLxT
         kOCtpROtAeATkiM6IFz8mml5ACQGWFGYP05FEI3dk8IRVjG7dKHuH0lEz1n1k+fr7ZzI
         FX975bGCc7iPIJvPrZUhVCsvuKe+2OmqXZwvY=
Received: by 10.86.22.2 with SMTP id 2mr227970fgv.17.1269450915287;
        Wed, 24 Mar 2010 10:15:15 -0700 (PDT)
Received: from localhost.localdomain (p5496E06D.dip.t-dialin.net [84.150.224.109])
        by mx.google.com with ESMTPS id 3sm1874576fge.20.2010.03.24.10.15.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Mar 2010 10:15:14 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Manuel Lauss <manuel.lauss@gmail.com>
Subject: [RFC PATCH 0/2] serial 8250 platform PM hooks
Date:   Wed, 24 Mar 2010 18:16:24 +0100
Message-Id: <1269450986-3714-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.7.0.2
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26304
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

Patch #2 implements uart power gating for Alchemy line of mips socs
using the new hook.

With these 2 patches serial console on my test system survives
suspend/resume cycles without having to resort to platform-specific
hacks in the PM code.

Thanks,
     Manuel Lauss

Manuel Lauss (2):
  8250: allow platform uarts to install PM callback.
  Alchemy: UART PM through serial framework.

 arch/mips/alchemy/common/platform.c |   17 +++++++++++++++++
 arch/mips/alchemy/common/power.c    |   32 --------------------------------
 drivers/serial/8250.c               |   31 ++++++++++++++++++++++++++++---
 include/linux/serial_8250.h         |    6 ++++++
 4 files changed, 51 insertions(+), 35 deletions(-)
