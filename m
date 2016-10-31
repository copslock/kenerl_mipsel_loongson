Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2016 22:18:44 +0100 (CET)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33896 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993003AbcJaVRrAI0Q0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 Oct 2016 22:17:47 +0100
Received: by mail-pf0-f193.google.com with SMTP id y68so3794838pfb.1;
        Mon, 31 Oct 2016 14:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=gdQHXG0VZ+kMPhyqzwWw45SJ+bRmTpUvIYjEsv3yYGw=;
        b=TrLSe4oi3qvQjZY+dWAbbvzwX2MUs5rTZrjIKasikiUQulfPaCUBDUpn1PoK2BdkQ/
         W1AVT/j43V3qTd2t2LQ32gImJwqIWSsATzaYShhFTjDKDE2FK6gat4IqP9qu7kejgIIH
         0FTE1lpIWWvlzJzW9kjqJUsMLB8lgkm6UUd+xh8Cj7MDyWeEfi8iW4YoSgeHr8MFhdtr
         z7Y6FfhhNcn+I+I6L2c9F3VgWlwkRLaFlIyHT4Qaoh3TRFlxOThGJHS49/F8hn+B8nfI
         +EzIYEptSB9VxaLiccLhYz6mz/wckvsxvvK7iUtYHk14MNSCh+kXnY3KXQRXgqrwpkp4
         gCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gdQHXG0VZ+kMPhyqzwWw45SJ+bRmTpUvIYjEsv3yYGw=;
        b=EwxjNPLp1AJCGYDenuVKAvXqYVhTZDdvawZchNcDAtNIlGjPaAK/GQ5r75gSzVuVzT
         gJLE2dCTR85L7WgTggYkMJrb5ThMgkFNlCLZUMfPEA+RhJ+nwkg/nfThLtnbC1y3Gv1J
         GZwVSYTGeMNfNktY+G6N5Vp9M2YXdui/tK2TgU2oRlLXRXl3OXBmqLtnHt7RymupRJ9X
         wUxVlVi3jRUQnmYB2S45QMDo/RMgYyVNI+EWG3oi4/xBqMAEXzZmYFi5BtL0daidI7lD
         6LIBaN3xwiKZAXfYJZ+W6++7CkhIZ/6KOZnPrxKluL2e8uie8vFkFiIA2B56p2Tks/Rq
         SrtQ==
X-Gm-Message-State: ABUngvfvu4YnCYUhEZaMFU31uf1A20xwE8Pexlt+3MgHh8/ktCdktkyh2FH9XU9CX6NFAA==
X-Received: by 10.99.130.198 with SMTP id w189mr44348678pgd.172.1477948661128;
        Mon, 31 Oct 2016 14:17:41 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id w85sm25592601pfk.57.2016.10.31.14.17.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Oct 2016 14:17:40 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, cernekee@gmail.com, jaedon.shin@gmail.com,
        justinpopo6@gmail.com, tglx@linutronix.de, marc.zyngier@arm.com,
        jason@lakedaemon.net, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 0/2] MIPS: BMIPS: Fix interrupt affinity migration
Date:   Mon, 31 Oct 2016 14:17:34 -0700
Message-Id: <1477948656-12966-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55626
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Hi,

These two patches are against Thomas' irq/core branch as of today:

4cd13c21b207e80ddb1144c576500098f2d5f882 ("softirq: Let ksoftirqd do its job")

Patches can be taken indepdently or together, your call.

Florian Fainelli (2):
  irqchip/bcm7038-l1: Implement irq_cpu_offline
  MIPS: BMIPS: Migrate interrupts during bmips_cpu_disable

 arch/mips/kernel/smp-bmips.c     |  2 ++
 drivers/irqchip/irq-bcm7038-l1.c | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

-- 
2.7.4
