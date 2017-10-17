Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Oct 2017 02:37:51 +0200 (CEST)
Received: from mail-pf0-x232.google.com ([IPv6:2607:f8b0:400e:c00::232]:45729
        "EHLO mail-pf0-x232.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991258AbdJQAhoeizD6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Oct 2017 02:37:44 +0200
Received: by mail-pf0-x232.google.com with SMTP id d28so62466pfe.2
        for <linux-mips@linux-mips.org>; Mon, 16 Oct 2017 17:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aVO8+cW0bl9raX6DMOXQqoxYsbG2zR7pfgz83vo62Mw=;
        b=Vd9ABskACFMiKBkQ4GV34/gls8NMUf06gaKzbP4gD5i8cfGNJNhAEYYZN7Rc1WhCWQ
         arQSCGc78l9nAsIS2xxRtZzetBMYnKsbvncVH3nnLtrQHnNY2WEKexXDcx8sY6XIiQ7y
         NBvgFRhjELRIuyuahkEqVHUISTMdm1yHe3zE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aVO8+cW0bl9raX6DMOXQqoxYsbG2zR7pfgz83vo62Mw=;
        b=CE36wH3YBHI3PhFUSJENdWtVo2SFhCyXtXRhcAdSJ1iZfG/B7cpUFwsckL1Y1A9q8d
         xwi0LK3thDp4X2pKTNnhHYIwLV4TddJocsrbvQIYm+GzaOS4ITmEQoQHZOZylzaQPQxB
         66MFiL0bwebqTXSmGbXnE4sY9waEQm0o0+JOOWvUKilbem65alJzq7n6UFZlPsUueMBc
         8AFTL0HBE+xZ4yDyBS3yl5HS+CAuxaTamFjmGw0mGMZoVFtpf3McwDVRTJ1kLR7K8FGc
         UOdCn/7GwhRiZ9enxItwIaGZwaj7SV+0fE6cgEGawQsfFR4eoFRSvNg0fykpM+RDjIod
         81Ig==
X-Gm-Message-State: AMCzsaWMJeNZPPYRXAuLDISyDpLQQXBj4m12IlooduI1ShRMn1w4CR02
        M4VRFaM8qIZtkyHt/9JpP+QDjQ==
X-Google-Smtp-Source: AOwi7QBUiYuBlP8cUNa+moOHA4sE/NVs+7QWAkKg3Dn0wzl0EFVkxiUUtdF6gDUivO5GkgQlgc486w==
X-Received: by 10.98.8.88 with SMTP id c85mr10042506pfd.330.1508200658558;
        Mon, 16 Oct 2017 17:37:38 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id e4sm16484902pfa.80.2017.10.16.17.37.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Oct 2017 17:37:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 47/58] net/ethernet/sgi: Convert timers to use timer_setup()
Date:   Mon, 16 Oct 2017 17:29:31 -0700
Message-Id: <1508200182-104605-48-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1508200182-104605-1-git-send-email-keescook@chromium.org>
References: <1508200182-104605-1-git-send-email-keescook@chromium.org>
Return-Path: <keescook@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/sgi/ioc3-eth.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index 9c0488e0f08e..18d533fdf14c 100644
--- a/drivers/net/ethernet/sgi/ioc3-eth.c
+++ b/drivers/net/ethernet/sgi/ioc3-eth.c
@@ -764,9 +764,9 @@ static inline void ioc3_setup_duplex(struct ioc3_private *ip)
 	ioc3_w_emcr(ip->emcr);
 }
 
-static void ioc3_timer(unsigned long data)
+static void ioc3_timer(struct timer_list *t)
 {
-	struct ioc3_private *ip = (struct ioc3_private *) data;
+	struct ioc3_private *ip = from_timer(ip, t, ioc3_timer);
 
 	/* Print the link status if it has changed */
 	mii_check_media(&ip->mii, 1, 0);
@@ -818,8 +818,6 @@ static int ioc3_mii_init(struct ioc3_private *ip)
 static void ioc3_mii_start(struct ioc3_private *ip)
 {
 	ip->ioc3_timer.expires = jiffies + (12 * HZ)/10;  /* 1.2 sec. */
-	ip->ioc3_timer.data = (unsigned long) ip;
-	ip->ioc3_timer.function = ioc3_timer;
 	add_timer(&ip->ioc3_timer);
 }
 
@@ -1291,7 +1289,7 @@ static int ioc3_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 #endif
 
 	spin_lock_init(&ip->ioc3_lock);
-	init_timer(&ip->ioc3_timer);
+	timer_setup(&ip->ioc3_timer, ioc3_timer, 0);
 
 	ioc3_stop(ip);
 	ioc3_init(dev);
-- 
2.7.4
