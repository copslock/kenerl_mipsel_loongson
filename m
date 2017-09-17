Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Sep 2017 11:40:15 +0200 (CEST)
Received: from mail-lf0-x22e.google.com ([IPv6:2a00:1450:4010:c07::22e]:44447
        "EHLO mail-lf0-x22e.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992864AbdIQJj3R6u9P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Sep 2017 11:39:29 +0200
Received: by mail-lf0-x22e.google.com with SMTP id l196so5598229lfl.1
        for <linux-mips@linux-mips.org>; Sun, 17 Sep 2017 02:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3OzOMaHhrE0eXAmi4wMrtmLcwMGHbnzFG+tb1ouVSTM=;
        b=h9o1eW8jpHAdZRteNgk3OksD3HJWw663mjRBWmmNyIHff5s+xBarw9TE+HFb5b1x1w
         WyzpyrXB+qKN2yZeCDuYhY5nCMd2SGlj/rZ+DIIdmwPJmuHeGo7i/auorH5GcF7F+66e
         aL5vmIk4L+ZXCv5Wp/qU1RJetRj52flGYPYU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3OzOMaHhrE0eXAmi4wMrtmLcwMGHbnzFG+tb1ouVSTM=;
        b=Z7nwn6V+hIpNmI56hCMXSTiJGV+gtHbWgx9Abj01B4qHqDy8KWc6nQZ/kOHjQodBu4
         KyJ9mLBoT2Wt1y78zKECE1jbUIpUA7CvMfgKSXu7JLeI5illU3ja5Eu9Wyt2eb0OqGL6
         HmOBN5o825bHNBLU5hkJbWEITuiswhq8XkdFsjXpiTLVXBvF8RcbhbD8XZuCfLt7kTrW
         TUxpdAD+YzKCJfXDbKkwDfIlHK14YePxsL8oqQIKq9ojLWGNbw9NmxLHnv2kYgMrwbjP
         uJv4/BFPy/x2lJ0Uwsm4KAV9SB9jhDnKojAjmubFvGUFKpY8fANxz/Q//C2Yjmnq/dKk
         RLAA==
X-Gm-Message-State: AHPjjUg1N131ES9sCvSSsKzqVbykXNlehrlf43Eb4aerKOSPW4zEYzI+
        y/PpU/PsICalRn1U
X-Google-Smtp-Source: ADKCNb5Brd7VoUyl0ngq6CMN/j7kCfCH46P0c10w9FdvCkcHeSgEskHY4h6tl/MKq05hEom4EkVa3g==
X-Received: by 10.46.70.10 with SMTP id t10mr11890246lja.30.1505641163837;
        Sun, 17 Sep 2017 02:39:23 -0700 (PDT)
Received: from fabina.bredbandsbolaget.se (c-2209e055.014-348-6c756e10.cust.bredbandsbolaget.se. [85.224.9.34])
        by smtp.gmail.com with ESMTPSA id t84sm974559lfi.21.2017.09.17.02.39.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Sep 2017 02:39:23 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        adi-buildroot-devel@lists.sourceforge.net,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Subject: [PATCH 2/7] gpio: Make it possible for consumers to enforce open drain
Date:   Sun, 17 Sep 2017 11:39:01 +0200
Message-Id: <20170917093906.16325-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20170917093906.16325-1-linus.walleij@linaro.org>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60039
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

Some busses, like I2C, strictly need to have the line handled
as open drain, i.e. not actively driven high. For this reason
the i2c-gpio.c bit-banged I2C driver is reimplementing open
drain handling outside of gpiolib.

This is not very optimal. Instead make it possible for a
consumer to explcitly express that the line must be handled
as open drain instead of allowing local hacks papering over
this issue.

The descriptor tables, whether DT, ACPI or board files, should
of course have flagged these lines as open drain. E.g.:
enum gpio_lookup_flags GPIO_OPEN_DRAIN for a board file, or
gpios = <&foo 42 GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN>; in a
device tree using <dt-bindings/gpio/gpio.h>

But more often than not, these descriptors are wrong. So
we need to make it possible for consumers to enforce this
open drain behaviour.

We now have two new enumerated GPIO descriptor config flags:
GPIOD_OUT_LOW_OPEN_DRAIN and GPIOD_OUT_HIGH_OPEN_DRAIN
that will set up the lined enforced as open drain as output
low or high, using open drain (if the driver supports it)
or using open drain emulation (setting the line as input
to drive it high) from the gpiolib core.

Cc: linux-gpio@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Obviously I authorize this patch to be applied directly
to the I2C tree as part of the refactorings.
---
 drivers/gpio/gpiolib.c        | 13 +++++++++++++
 include/linux/gpio/consumer.h |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index cd003b74512f..cb73a50a5d5d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3228,8 +3228,21 @@ int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
 
 	if (lflags & GPIO_ACTIVE_LOW)
 		set_bit(FLAG_ACTIVE_LOW, &desc->flags);
+
 	if (lflags & GPIO_OPEN_DRAIN)
 		set_bit(FLAG_OPEN_DRAIN, &desc->flags);
+	else if (dflags & GPIOD_FLAGS_BIT_OPEN_DRAIN) {
+		/*
+		 * This enforces open drain mode from the consumer side.
+		 * This is necessary for some busses like I2C, but the lookup
+		 * should *REALLY* have specified them as open drain in the
+		 * first place, so print a little warning here.
+		 */
+		set_bit(FLAG_OPEN_DRAIN, &desc->flags);
+		gpiod_warn(desc,
+			   "enforced open drain please flag it properly in DT/ACPI DSDT/board file\n");
+	}
+
 	if (lflags & GPIO_OPEN_SOURCE)
 		set_bit(FLAG_OPEN_SOURCE, &desc->flags);
 	if (lflags & GPIO_SLEEP_MAY_LOOSE_VALUE)
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 8f702fcbe485..5f72a49d1aa3 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -28,6 +28,7 @@ struct gpio_descs {
 #define GPIOD_FLAGS_BIT_DIR_SET		BIT(0)
 #define GPIOD_FLAGS_BIT_DIR_OUT		BIT(1)
 #define GPIOD_FLAGS_BIT_DIR_VAL		BIT(2)
+#define GPIOD_FLAGS_BIT_OPEN_DRAIN	BIT(3)
 
 /**
  * Optional flags that can be passed to one of gpiod_* to configure direction
@@ -39,6 +40,11 @@ enum gpiod_flags {
 	GPIOD_OUT_LOW	= GPIOD_FLAGS_BIT_DIR_SET | GPIOD_FLAGS_BIT_DIR_OUT,
 	GPIOD_OUT_HIGH	= GPIOD_FLAGS_BIT_DIR_SET | GPIOD_FLAGS_BIT_DIR_OUT |
 			  GPIOD_FLAGS_BIT_DIR_VAL,
+	GPIOD_OUT_LOW_OPEN_DRAIN = GPIOD_FLAGS_BIT_DIR_SET |
+			  GPIOD_FLAGS_BIT_DIR_OUT | GPIOD_FLAGS_BIT_OPEN_DRAIN,
+	GPIOD_OUT_HIGH_OPEN_DRAIN = GPIOD_FLAGS_BIT_DIR_SET |
+			  GPIOD_FLAGS_BIT_DIR_OUT | GPIOD_FLAGS_BIT_DIR_VAL |
+			  GPIOD_FLAGS_BIT_OPEN_DRAIN,
 };
 
 #ifdef CONFIG_GPIOLIB
-- 
2.13.5
