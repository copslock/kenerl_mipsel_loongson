Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Nov 2017 18:20:22 +0100 (CET)
Received: from mail-pf0-x241.google.com ([IPv6:2607:f8b0:400e:c00::241]:52244
        "EHLO mail-pf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990590AbdKKRUOEJviC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Nov 2017 18:20:14 +0100
Received: by mail-pf0-x241.google.com with SMTP id m88so1648829pfi.9
        for <linux-mips@linux-mips.org>; Sat, 11 Nov 2017 09:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gimpelevich-san-francisco-ca-us.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=0v2G6P/+uWwa1Mw4LXxQ/fWON4mum34q565/8gss9pY=;
        b=m20yWyPrZF+ieU1Fd75gTVjo3EVV6CTzh8soOuKu57U7vDG1tVgmQD8LgXzJJbgyLA
         9awehV8+/jPi1zP6nSK9X++vn+QzMasyfpCDwprboFccI6EWHBXYrV7ljneUih09Tmnb
         Nd5B6E1fD0nVWY1CEmfUyEMzT71i12aRhDMJY3up9eoWiPOcn42M2su2hfjzdkDyahPP
         oYHa8SzvdxZPQUuvEcKhM/cMm4aJdQT3L3+N3mS31FXYCC3rnuvfqYf+k2F4NWIfaydV
         HcVJjz+BCdl3KIh3srExCrE/SQRq27dqqE8GrZUEAWANvV6pdKCP72Mx2ZkPp56iW4WL
         BQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=0v2G6P/+uWwa1Mw4LXxQ/fWON4mum34q565/8gss9pY=;
        b=Wxn+Bq/6CRfhq/n7poI5JVbYGCDjIcGrStS9+nixYn2AN2k6ZunBH9WdKVVkVH21tw
         iSiwD/H6wwjWapIJTDh5oiu9GlKr0LMP4aXWUKf4tKu0CtQx0KhpYZz4pF+K8XbV9AoF
         dAhbdyRirYkxe5b45OVMBAvg5ATESaF5HAJSpoKupeY9ujOdwP/8Garv7ovue9s23rn7
         heeJ7qU9aLvvupj513udzqqy/y4+SEEZrE5KOwxxJrENZT6aTfjqRG8HFJ4VMFi0DiAs
         WxPGpSjGFz41Zme5w1xNjolx8Y/bE4P40Vb9QKv2IwbfF+g74vQMCJH6TZ2+OuG3nsZw
         NzyQ==
X-Gm-Message-State: AJaThX51I7SS5LZPYME4PgfUVejYyphH97iVxRdymvGI/szkJEq0mcnQ
        f0q51XTG/sPz4ZKC+wCMqLeVU3CW
X-Google-Smtp-Source: AGs4zMadJKMHQqoxqhxETYR2F/jT2zvigDN5P+3d1IratAQX+G9Pb5qJhFCoBoUc9ytFlurxEdyLHQ==
X-Received: by 10.159.244.4 with SMTP id x4mr4071785plr.31.1510420805773;
        Sat, 11 Nov 2017 09:20:05 -0800 (PST)
Received: from localhost.localdomain (12.sub-75-208-200.myvzw.com. [75.208.200.12])
        by smtp.gmail.com with ESMTPSA id c1sm22853795pfa.12.2017.11.11.09.20.04
        for <linux-mips@linux-mips.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 11 Nov 2017 09:20:04 -0800 (PST)
From:   Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
To:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: implement a "bootargs-append" DT property
Date:   Sat, 11 Nov 2017 09:19:48 -0800
Message-Id: <1510420788-25184-1-git-send-email-daniel@gimpelevich.san-francisco.ca.us>
X-Mailer: git-send-email 1.9.1
Return-Path: <daniel@gimpelevich.san-francisco.ca.us>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@gimpelevich.san-francisco.ca.us
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

There are two uses for this:

1) It may be useful to split a device-specific kernel command line between
a .dts file and a .dtsi file, with "bootargs" in one and "bootargs-append"
in the other, such as for variations of a reference board.

2) There are kernel configuration options for prepending "bootargs" to the
kernel command line that the bootloader has passed, but not for appending.
A new option for this would be a less future-proof solution, since things
like this should be in the dtb.

This is tested on MIPS, but it can be useful on other architectures also.

Signed-off-by: Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
---
 arch/mips/kernel/setup.c | 3 +++
 drivers/of/fdt.c         | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index fe39397..95e9bf2 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -826,7 +826,10 @@ static void __init arch_mem_init(char **cmdline_p)
 	extern void plat_mem_setup(void);
 
 	/* call board setup routine */
+	strlcpy(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
 	plat_mem_setup();
+	if (strncmp(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE) == 0)
+		boot_command_line[0] = '\0';
 
 	/*
 	 * Make sure all kernel memory is in the maps.  The "UP" and
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index ce30c9a..65dbda6 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1127,6 +1127,10 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 	p = of_get_flat_dt_prop(node, "bootargs", &l);
 	if (p != NULL && l > 0)
 		strlcpy(data, p, min((int)l, COMMAND_LINE_SIZE));
+	p = of_get_flat_dt_prop(node, "bootargs-append", &l);
+	if (p != NULL && l > 0)
+		strlcat(data, p, min_t(int, strlen(data) + l,
+					COMMAND_LINE_SIZE));
 
 	/*
 	 * CONFIG_CMDLINE is meant to be a default in case nothing else
-- 
1.9.1
