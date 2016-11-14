Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Nov 2016 19:51:37 +0100 (CET)
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33869 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993043AbcKNSvatBXI7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Nov 2016 19:51:30 +0100
Received: by mail-wm0-f66.google.com with SMTP id g23so17943026wme.1
        for <linux-mips@linux-mips.org>; Mon, 14 Nov 2016 10:51:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TlQ7U9VS9c984AIax4BwudiM6/zy9g+I7f6PMwFpa7g=;
        b=WkIjGjP6NZRKUqW2PE4UbJyA6M0AaLtPJL9rWSuUcdzW9ufWiDO6Vpu+4qy3wtD98L
         tDWdoY5t/KNZ7eCzbygVIlpDVw8L09HyQvf2aVYG3LjoI/ZsvmTg/gLDJY+mIhkFCqoG
         u3z9gxgmJnnqX0rzKlG1kaNqfVMf51892qm8TtG1uPWS5ktA/zNzeqCUB4unGLEu6s5T
         0s27towPiK7PIR+PMF+3vjNG2g2LsL9xYeWfOfa+2tvbdNGjyB93BwFRr6bbfHp5Lx0m
         kTCj84f/0OosUEzrTsfOzqTmAtHhc3sdD3hTz11aZSOsuMAOBOwCKaRGLZfNFwaYCoS2
         bSrQ==
X-Gm-Message-State: ABUngvfH+eKxeDCRkaa/dv8zdUSwAFJYMXlCNNiD4t+uGLsu9CbFNa53ORCHsxN2Dw8wNA==
X-Received: by 10.194.115.168 with SMTP id jp8mr20953394wjb.27.1479149485507;
        Mon, 14 Nov 2016 10:51:25 -0800 (PST)
Received: from wintermute.fritz.box (HSI-KBW-109-193-043-099.hsi7.kabel-badenwuerttemberg.de. [109.193.43.99])
        by smtp.gmail.com with ESMTPSA id k74sm30942198wmd.18.2016.11.14.10.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Nov 2016 10:51:24 -0800 (PST)
From:   Jan Glauber <jglauber@cavium.com>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, linux-mips@linux-mips.org,
        Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v2 0/3] i2c: octeon: thunder: Fix i2c not working on Octeon
Date:   Mon, 14 Nov 2016 19:50:42 +0100
Message-Id: <1479149445-4663-1-git-send-email-jglauber@cavium.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <jan.glauber@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jglauber@cavium.com
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

Hi Wolfram,

Since time is running out for 4.9 (or might have already if you're not
going to send another pull request) I'm going for the safe option
to fix the Octeon i2c problems, which is:

1. Reverting the readq_poll_timeout patch since it is broken
2. Apply Patch #2 from Paul
3. Add a small fix for the recovery that makes Paul's patch
   work on ThunderX

I'll try to come up with a better solution for 4.10. My plan is to get rid
of the polling-around-interrupt thing completely, but for that we need more
time to make it work on Octeon.

Please consider for 4.9.

thanks,
Jan

------------

Jan Glauber (2):
  Revert "i2c: octeon: thunderx: Limit register access retries"
  i2c: octeon: thunderx: TWSI software reset in recovery

Paul Burton (1):
  i2c: octeon: Fix waiting for operation completion

 drivers/i2c/busses/i2c-octeon-core.c | 66 +++++++++++-------------------------
 drivers/i2c/busses/i2c-octeon-core.h | 27 ++++++---------
 2 files changed, 30 insertions(+), 63 deletions(-)

-- 
1.9.1
