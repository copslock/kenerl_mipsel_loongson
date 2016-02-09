Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 20:03:18 +0100 (CET)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33489 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012379AbcBITBMOLO8R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 20:01:12 +0100
Received: by mail-pf0-f194.google.com with SMTP id c10so9972310pfc.0;
        Tue, 09 Feb 2016 11:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mT0aGN0+TGRYmhfnCg7xzu2rqOp4Z+DM72fWVyCAjWQ=;
        b=gedTP6kn1HZ6zt/1sv2gAWSdFWi83NUj7Q2C5pfBWi0qF1kMc72yIgOTOZtWI/4AAK
         YzY+TqoJVKhikK2ol+gZR9S/xfGm3PLtHIA4bq39b2UHejEqy+irVhk0zNG7cjv1Zdyu
         J/RMl06hU3AptQBzWt+U479Ea96C0PM75vB650gX/ahaBTOdiC3yeb0yrOS/tKsUEEeT
         wbCxYiM/+4tP6va+NasSSiQU8MA+HLWETYwdbm5pPoEiuFIXN6qLTcRcNw+NBrYkYEhk
         8X8TlAOFlO9Ew5wgWQ4w+JkydJdpLsXpl+gqELlpsRqkb+/tP3YsyzSfZaGOW8Q+qyOv
         cciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mT0aGN0+TGRYmhfnCg7xzu2rqOp4Z+DM72fWVyCAjWQ=;
        b=RNdPtLswzyWOOzJ9mM1zE/1q8B/ikE+Nd6Fuhr8cSFLEfAY85y/1mppUMm+TEyGdpd
         S1Cn4yaFUMGAaIBQTlP1s2wk2uXv0QCukOJHVau6WtrXaovys33IGlwheISULiugnKdg
         qDXRWov9gTO/sg1L7iHl3fyhtYtddxRn0a8qQ6VTBNrG/1pC6fq/NApe44oCysuqAgHc
         BFD292zOVLYWMWoOh4xXCEmbH0gdW5WH2qxwW+I3hOVDtrb7hS/h4QM/r6n87rlHhNkV
         UTU9JfTF+TsSbN8rqCAR3n9DaukHB/eEkQRdwPXsduQzi+V1tOlvuyOAY5N3wXQXGxIR
         AukQ==
X-Gm-Message-State: AG10YOSPfoixm8ix2raK6KlGyjOns0gTaNoa1I0SuONWQaCV93lQOz80EmwybNAMgF46eQ==
X-Received: by 10.98.16.69 with SMTP id y66mr53216034pfi.86.1455044466581;
        Tue, 09 Feb 2016 11:01:06 -0800 (PST)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.gmail.com with ESMTPSA id i15sm43146551pfi.55.2016.02.09.11.00.55
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 11:00:58 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id u19J0tPe009902;
        Tue, 9 Feb 2016 11:00:55 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id u19J0t30009901;
        Tue, 9 Feb 2016 11:00:55 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v2 8/8] MIPS: OCTEON: Simplify code in octeon_irq_ciu_gpio_set_type()
Date:   Tue,  9 Feb 2016 11:00:13 -0800
Message-Id: <1455044413-9823-9-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1455044413-9823-1-git-send-email-ddaney.cavm@gmail.com>
References: <1455044413-9823-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51914
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

Use the trigger type passed in to the function instead of reading it
back out of the irq_data.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/octeon-irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 9b6a65b..368eb49 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -713,7 +713,7 @@ static int octeon_irq_ciu_gpio_set_type(struct irq_data *data, unsigned int t)
 	irqd_set_trigger_type(data, t);
 	octeon_irq_gpio_setup(data);
 
-	if (irqd_get_trigger_type(data) & IRQ_TYPE_EDGE_BOTH)
+	if (t & IRQ_TYPE_EDGE_BOTH)
 		irq_set_handler_locked(data, handle_edge_irq);
 	else
 		irq_set_handler_locked(data, handle_level_irq);
-- 
1.7.11.7
