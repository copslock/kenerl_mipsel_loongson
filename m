Return-Path: <SRS0=BTV6=SC=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7DDC43381
	for <linux-mips@archiver.kernel.org>; Sun, 31 Mar 2019 07:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C8A2085A
	for <linux-mips@archiver.kernel.org>; Sun, 31 Mar 2019 07:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uzDoldXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfCaHcB (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 31 Mar 2019 03:32:01 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32786 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfCaHcA (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 31 Mar 2019 03:32:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id i19so3017893pfd.0;
        Sun, 31 Mar 2019 00:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kbgq3ANCgctQrbpot9JH9Mtc6IvpMssREYVwWC4D/rY=;
        b=uzDoldXcIzbM3GaOBUOp0Hl3vcljKpNeli5+Q+47y9xKYcJTW3zrzu5S73xPKNPjYC
         cBKwH5b6i9mmKSJOLVeECAoZWPEDrFIUqxYUpg1VjTBKn+ut9PTxuNfZ9UC63h/+yKNn
         I4flrZylko6c6X7QQubo22kDJERUBI3W0ij/Ws5T4+R+gfWi4n0OVAc+Vm4onhvz0CTP
         V8xEBIg+2THetmf0cFqCs/bCsRRsL07s0PLHmiDcojMyOZ1tR9P0SgQxLsruh9Kvy5AY
         2Xeq8Bgr2S5Ng0geHr7WZVU4vS6ZxaI58sSWztfQ1yg0j+OMj5KPshF/F+SMa0BuX3+1
         a3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kbgq3ANCgctQrbpot9JH9Mtc6IvpMssREYVwWC4D/rY=;
        b=MqqllwIz0nL3fIDQuCCnV6uYLNa6YQwSEFhTa+g1glLAp7o1+R1dUcY2Q07ZwGffA6
         UXSLeCogBdPJLqp4/ZrNwj8gkho1fbzLwDiK62cMCACOJg2/BUPQdTew8f55JLcCftoP
         jqxijkH0atPiyH+SLWAe1FPdNetYkdHzCsJjuV91XG2Uie/HlXQph1YQy7VMAF9oW8jq
         TsS+rTW6bNmc70GHZS15IuB7ZWCJFyFO/zqtzYzRvdb/N3FRt4Og4tyrb05LQay5+vmr
         hKzxmXCk7rxq2PPgZa8JxWkaEUpGZmTlxo0YSmX2aKczegplKJj0iPLmYMaiZD760/VY
         vCgQ==
X-Gm-Message-State: APjAAAWWGqToV/nZj+9tmTk8WJ8VITpEHjokNtkQR8VhFJoUHxnyanbP
        uENVOR1wB3uKkGxaNWxS0+8=
X-Google-Smtp-Source: APXvYqy7pgfx1lwrb9l+A2nLXOqynuW875yb9ikCapoT3URmqvNlU9kjXbu0cYXA87BNxxvCfejLRw==
X-Received: by 2002:a63:7117:: with SMTP id m23mr47684796pgc.271.1554017519480;
        Sun, 31 Mar 2019 00:31:59 -0700 (PDT)
Received: from localhost.localdomain ([2409:251:20c0:100:fe80:8e59:9ae1:e028])
        by smtp.gmail.com with ESMTPSA id x9sm11235503pfn.60.2019.03.31.00.31.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 00:31:58 -0700 (PDT)
From:   NOGUCHI Hiroshi <drvlabo@gmail.com>
To:     John Crispin <john@phrozen.org>
Cc:     devel@driverdev.osuosl.org, linux-mips@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, NOGUCHI Hiroshi <drvlabo@gmail.com>
Subject: [PATCH] mips: ralink: allow to choose function which belongs with multiple groups
Date:   Sun, 31 Mar 2019 16:31:20 +0900
Message-Id: <20190331073120.23071-1-drvlabo@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

This allows the signals which can be assigned from multiple GPIO pins
to be really assigned as expected.

That one case is "refclk" signal in MT76x8.
It was forcibily assigned to the pin matched by signal name at first.
Eventually it always appears as GPIO #37. We cannot use refclk with the other pin.

Signed-off-by: NOGUCHI Hiroshi <drvlabo@gmail.com>
---
 arch/mips/include/asm/mach-ralink/pinmux.h    |   3 +-
 .../staging/mt7621-pinctrl/pinctrl-rt2880.c   | 164 ++++++++++++++----
 2 files changed, 136 insertions(+), 31 deletions(-)

diff --git a/arch/mips/include/asm/mach-ralink/pinmux.h b/arch/mips/include/asm/mach-ralink/pinmux.h
index ba8ac331af0c..e2974a04ff61 100644
--- a/arch/mips/include/asm/mach-ralink/pinmux.h
+++ b/arch/mips/include/asm/mach-ralink/pinmux.h
@@ -32,8 +32,7 @@ struct rt2880_pmx_func {
 	int pin_count;
 	int *pins;
 
-	int *groups;
-	int group_count;
+	int group_idx;
 
 	int enabled;
 };
diff --git a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
index 9b52d44abef1..bdfd93dba02c 100644
--- a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
+++ b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
@@ -26,6 +26,12 @@
 #define SYSC_REG_GPIO_MODE	0x60
 #define SYSC_REG_GPIO_MODE2	0x64
 
+struct rt2880_func_group_map {
+	const char *func_name;
+	const char **group_names;
+	int num_groups;
+};
+
 struct rt2880_priv {
 	struct device *dev;
 
@@ -39,6 +45,10 @@ struct rt2880_priv {
 	const char **group_names;
 	int group_count;
 
+	struct rt2880_func_group_map *func_to_group_map;
+	s16 *group_to_func_map;
+	int func_to_group_count;
+
 	u8 *gpio;
 	int max_pins;
 };
@@ -86,7 +96,7 @@ static int rt2880_pmx_func_count(struct pinctrl_dev *pctrldev)
 {
 	struct rt2880_priv *p = pinctrl_dev_get_drvdata(pctrldev);
 
-	return p->func_count;
+	return p->func_to_group_count;
 }
 
 static const char *rt2880_pmx_func_name(struct pinctrl_dev *pctrldev,
@@ -94,7 +104,7 @@ static const char *rt2880_pmx_func_name(struct pinctrl_dev *pctrldev,
 {
 	struct rt2880_priv *p = pinctrl_dev_get_drvdata(pctrldev);
 
-	return p->func[func]->name;
+	return p->func_to_group_map[func].func_name;
 }
 
 static int rt2880_pmx_group_get_groups(struct pinctrl_dev *pctrldev,
@@ -104,12 +114,8 @@ static int rt2880_pmx_group_get_groups(struct pinctrl_dev *pctrldev,
 {
 	struct rt2880_priv *p = pinctrl_dev_get_drvdata(pctrldev);
 
-	if (p->func[func]->group_count == 1)
-		*groups = &p->group_names[p->func[func]->groups[0]];
-	else
-		*groups = p->group_names;
-
-	*num_groups = p->func[func]->group_count;
+	*groups = p->func_to_group_map[func].group_names;
+	*num_groups = p->func_to_group_map[func].num_groups;
 
 	return 0;
 }
@@ -122,6 +128,7 @@ static int rt2880_pmx_group_enable(struct pinctrl_dev *pctrldev,
 	u32 reg = SYSC_REG_GPIO_MODE;
 	int i;
 	int shift;
+	int func_in_grp;
 
 	/* dont allow double use */
 	if (p->groups[group].enabled) {
@@ -130,8 +137,13 @@ static int rt2880_pmx_group_enable(struct pinctrl_dev *pctrldev,
 		return -EBUSY;
 	}
 
+	func_in_grp =
+		p->group_to_func_map[(group * p->func_to_group_count) + func];
+	if (func_in_grp < 0)
+		return -EINVAL;
+
 	p->groups[group].enabled = 1;
-	p->func[func]->enabled = 1;
+	p->func[func_in_grp]->enabled = 1;
 
 	shift = p->groups[group].shift;
 	if (shift >= 32) {
@@ -149,9 +161,9 @@ static int rt2880_pmx_group_enable(struct pinctrl_dev *pctrldev,
 	if (func == 0) {
 		mode |= p->groups[group].gpio << shift;
 	} else {
-		for (i = 0; i < p->func[func]->pin_count; i++)
-			p->gpio[p->func[func]->pins[i]] = 0;
-		mode |= p->func[func]->value << shift;
+		for (i = 0; i < p->func[func_in_grp]->pin_count; i++)
+			p->gpio[p->func[func_in_grp]->pins[i]] = 0;
+		mode |= p->func[func_in_grp]->value << shift;
 	}
 	rt_sysc_w32(mode, reg);
 
@@ -191,6 +203,111 @@ static struct rt2880_pmx_func gpio_func = {
 	.name = "gpio",
 };
 
+static int rt2880_build_internal_map(struct rt2880_priv *p)
+{
+	int i, j;
+	struct rt2880_func_group_map *f_g;
+	struct rt2880_func_group_map *f_g_tmp;
+	int16_t *g_f;
+	int c = 0;
+	int ret = 0;
+
+	/* func_to_group_map[0] is used for gpio */
+	f_g = devm_kzalloc(p->dev, sizeof(f_g[0]) * 1, GFP_KERNEL);
+	if (!f_g) {
+		ret = -ENOMEM;
+		goto l_exit;
+	}
+	f_g[0].func_name = p->func[0]->name;
+	f_g[0].group_names = p->group_names;
+	f_g[0].num_groups = p->group_count;
+	c = 1;
+
+	/* parse function list which has entries with same function name */
+	/* (skip the "gpio" function entry) */
+	for (i = 1; i < p->func_count; i++) {
+		if (!strcmp(p->func[i]->name, "gpio"))
+			continue;
+
+		for (j = 1; j < c; j++)
+			if (!strcmp(f_g[j].func_name, p->func[i]->name))
+				break;
+		if (j < c) {
+			int n;
+			const char **names_tmp;
+
+			n = f_g[j].num_groups;
+			names_tmp = devm_kzalloc(p->dev,
+					sizeof(char *) * (n + 1), GFP_KERNEL);
+			if (!names_tmp) {
+				ret = -ENOMEM;
+				goto l_exit;
+			}
+			memcpy(names_tmp,
+				f_g[j].group_names, sizeof(char *) * n);
+			devm_kfree(p->dev, f_g[j].group_names);
+			f_g[j].group_names = names_tmp;
+
+			f_g[j].group_names[n] =
+				p->group_names[p->func[i]->group_idx];
+			f_g[j].num_groups++;
+		} else{
+			/* add a new entry */
+			f_g_tmp = f_g;
+			f_g = devm_kzalloc(p->dev,
+					sizeof(f_g[0]) * (c + 1), GFP_KERNEL);
+			if (!f_g) {
+				ret = -ENOMEM;
+				goto l_exit;
+			}
+			memcpy(f_g, f_g_tmp, sizeof(f_g[0]) * c);
+			devm_kfree(p->dev, f_g_tmp);
+
+			f_g[c].group_names = devm_kzalloc(p->dev,
+					sizeof(char *) * 1, GFP_KERNEL);
+			if (!f_g[c].group_names) {
+				ret = -ENOMEM;
+				goto l_exit;
+			}
+
+			f_g[c].func_name = p->func[i]->name;
+			f_g[c].group_names[0] =
+					p->group_names[p->func[i]->group_idx];
+			f_g[c].num_groups = 1;
+
+			c++;
+		}
+	}
+
+	g_f = devm_kzalloc(p->dev,
+			sizeof(int16_t) * p->group_count * c, GFP_KERNEL);
+	if (!g_f) {
+		ret = -ENOMEM;
+		goto l_exit;
+	}
+	for (i = 0; i < p->group_count; i++) {
+		g_f[(i * c) + 0] = 0;	/* always map as "gpio" */
+
+		for (j = 1; j < c; j++)
+			g_f[(i * c) + j] = -1;
+	}
+
+	for (i = 1 ; i < p->func_count; i++) {
+		for (j = 1; j < c; j++)
+			if (!strcmp(f_g[j].func_name, p->func[i]->name))
+				break;
+		if (j < c)
+			g_f[(p->func[i]->group_idx * c) + j] = i;
+	}
+
+	p->group_to_func_map = g_f;
+	p->func_to_group_map = f_g;
+	p->func_to_group_count = c;
+
+l_exit:
+	return ret;
+}
+
 static int rt2880_pinmux_index(struct rt2880_priv *p)
 {
 	struct rt2880_pmx_func **f;
@@ -218,20 +335,11 @@ static int rt2880_pinmux_index(struct rt2880_priv *p)
 	p->func_count++;
 
 	/* allocate our function and group mapping index buffers */
-	f = p->func = devm_kcalloc(p->dev,
-				   p->func_count,
-				   sizeof(struct rt2880_pmx_func),
-				   GFP_KERNEL);
-	gpio_func.groups = devm_kcalloc(p->dev, p->group_count, sizeof(int),
-					GFP_KERNEL);
-	if (!f || !gpio_func.groups)
+	f = p->func = devm_kcalloc(p->dev, p->func_count,
+					sizeof(*f), GFP_KERNEL);
+	if (!f)
 		return -1;
 
-	/* add a backpointer to the function so it knows its group */
-	gpio_func.group_count = p->group_count;
-	for (i = 0; i < gpio_func.group_count; i++)
-		gpio_func.groups[i] = i;
-
 	f[c] = &gpio_func;
 	c++;
 
@@ -239,14 +347,12 @@ static int rt2880_pinmux_index(struct rt2880_priv *p)
 	for (i = 0; i < p->group_count; i++) {
 		for (j = 0; j < p->groups[i].func_count; j++) {
 			f[c] = &p->groups[i].func[j];
-			f[c]->groups = devm_kzalloc(p->dev, sizeof(int),
-						    GFP_KERNEL);
-			f[c]->groups[0] = i;
-			f[c]->group_count = 1;
+			f[c]->group_idx = i;
 			c++;
 		}
 	}
-	return 0;
+
+	return rt2880_build_internal_map(p);
 }
 
 static int rt2880_pinmux_pins(struct rt2880_priv *p)
-- 
2.20.1

