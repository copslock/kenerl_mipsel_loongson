Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Oct 2017 16:29:07 +0100 (CET)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:52412
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992143AbdJ2P1tGRox7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Oct 2017 16:27:49 +0100
Received: by mail-wm0-x243.google.com with SMTP id t139so11739856wmt.1;
        Sun, 29 Oct 2017 08:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+7IN4LPsEVBHIgl0K3jidx5JPjE0rsoLXVy53pcLGq0=;
        b=GaJbymKKUExCQLjdU04fMVzyVi0cG3joVpMCfXExd4Rg20CM2xOAHk8UR7UoTRBzII
         I/0IG1ge+cOj/twYOZT4nMLUOv9Osch76QLYnH/O1wUh6poFVAweQ+OgRxI4v2g41Qc0
         0VfT0n7MWhYFNjiMeyGUp6p5mJ813wV/Oi9Qg/vp/Nwa3gyIIRTJswLOUtx6rQYrsznY
         Tztgz03ZAt6fxj5Tq7v87/rA+4fNPXHmhNIE7wBBz89UKdO7e7eFruTFKpn4LAH771hv
         hUGV9DMYEA4T7GTKChR6WHI2E4KAmrOnpoWANEvS/auM1B3bigcNTlKNpwp5H42XmVM7
         2BEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+7IN4LPsEVBHIgl0K3jidx5JPjE0rsoLXVy53pcLGq0=;
        b=agBSWVFORvsSKY4BIBpCPDEY40VrhIvwADR7fCip6WFQtyFKKrh3qRLbTzSipjdudc
         LTAu04o4ZbdwJHznOYHOUhLHwHStqkiuSSmowcLceqOw9JJKiIQihrGVUehdQLbPg5xF
         jZI5f4/MTszKAQi2iJBfHDsP8g/80eVnHrh7WVQZfUFlSTGUfwq+y+xPMRY5/u/ilGCX
         fv2rm0y1Qxad7dGWwLk49iQuk/ffdmvbSEQcrx/J9pQx72SrXRpXd5kQFM6Wsp0QEyrd
         mT7yeR7zzCozctjj/ozq9VLSRU3oyjKvjBGbhGudqcJLtAxTsTUg/AgujQ9GyDLbMnmV
         k3XQ==
X-Gm-Message-State: AMCzsaULGojv7iCSGzMRJtwgyu7HNzpIwfne5M+/eqhyUwblroO1rc6i
        T6913Io44rnAAJWHyjGiUUTD1g==
X-Google-Smtp-Source: ABhQp+QUaMBLqWYXEEt86LIXUajDzr4NzQ994JHGEtEO76IurwzgDBSuUSz7mC7kYlHs8ZIGUUqjhA==
X-Received: by 10.28.148.15 with SMTP id w15mr1606813wmd.140.1509290863667;
        Sun, 29 Oct 2017 08:27:43 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::48e])
        by smtp.gmail.com with ESMTPSA id m26sm12498532wrb.81.2017.10.29.08.27.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Oct 2017 08:27:43 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org, linux-serial@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Schichan <nschichan@freebox.fr>
Subject: [PATCH RFC 3/3] MIPS: AR7: ensure the port type's FCR value is used
Date:   Sun, 29 Oct 2017 16:27:21 +0100
Message-Id: <20171029152721.6770-4-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20171029152721.6770-1-jonas.gorski@gmail.com>
References: <20171029152721.6770-1-jonas.gorski@gmail.com>
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

Since commit aef9a7bd9b67 ("serial/uart/8250: Add tunable RX interrupt
trigger I/F of FIFO buffers"), the port's default FCR value isn't used
in serial8250_do_set_termios anymore, but copied over once in
serial8250_config_port and then modified as needed.

Unfortunately, serial8250_config_port will never be called if the port
is shared between kernel and userspace, and the port's flag doesn't have
UPF_BOOT_AUTOCONF, which would trigger a serial8250_config_port as well.

This causes garbled output from userspace:

[    5.220000] random: procd urandom read with 49 bits of entropy available
ers
   [kee

Fix this by forcing it to be configured on boot, resulting in the
expected output:

[    5.250000] random: procd urandom read with 50 bits of entropy available
Press the [f] key and hit [enter] to enter failsafe mode
Press the [1], [2], [3] or [4] key and hit [enter] to select the debug level

Fixes: aef9a7bd9b67 ("serial/uart/8250: Add tunable RX interrupt trigger I/F of FIFO buffers")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
I'm not sure if this is just AR7's issue, or if this points to a general
issue for UARTs used as kernel console and login console with the "fixed"
commit.

 arch/mips/ar7/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index 4674f1efbe7a..e1675c25d5d4 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -575,7 +575,7 @@ static int __init ar7_register_uarts(void)
 	uart_port.type		= PORT_AR7;
 	uart_port.uartclk	= clk_get_rate(bus_clk) / 2;
 	uart_port.iotype	= UPIO_MEM32;
-	uart_port.flags		= UPF_FIXED_TYPE;
+	uart_port.flags		= UPF_FIXED_TYPE | UPF_BOOT_AUTOCONF;
 	uart_port.regshift	= 2;
 
 	uart_port.line		= 0;
-- 
2.13.2
