Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 May 2010 15:25:31 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:58879 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491193Ab0EPNZ2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 May 2010 15:25:28 +0200
Received: by wyf28 with SMTP id 28so200085wyf.36
        for <multiple recipients>; Sun, 16 May 2010 06:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=WtIfv6SZwknq0AQlqf3pLl5IP76GbS53SjHV1SZw55U=;
        b=PPpJ6eRCOYs2xAMMrJfNrjrVKUorA0KPYZvNVTnTiiyz2WD8ShVUTTOt3m0v6PMIPS
         39g70lQgp1/oLx5aAlotFJqrrd/XoRtIUF7SnuwcwOB1awJfaG1Ax0Z/TikEkMq5t04Z
         pXERXoyx8hryc+ggT9Y0zkOw3/jNAbvX3Iib8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:mime-version
         :content-type:content-transfer-encoding:message-id;
        b=cr1YSzi1Fc49rbDazbbmGCBu74q7q9i2aLa1OFieLfrrJisDojJV+H7QV3xwXnegYu
         mTTZQv7V7SGO2TyRZnlWWJg/vM2MSXEABZuSIbUZKOvzc6t8YM/ClHV5owyi8CxDkC6w
         lurfGDgCky6C4itkdE5PYZc9wE18coYznZQRM=
Received: by 10.227.154.142 with SMTP id o14mr1329012wbw.49.1274016320142;
        Sun, 16 May 2010 06:25:20 -0700 (PDT)
Received: from lenovo.localnet (208.59.76-86.rev.gaoland.net [86.76.59.208])
        by mx.google.com with ESMTPS id l23sm32695919wbb.20.2010.05.16.06.25.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 May 2010 06:25:19 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Reply-To: Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 1/2] AR7: use correct UART port type
Date:   Sun, 16 May 2010 15:25:17 +0200
User-Agent: KMail/1.12.4 (Linux/2.6.33-2-686; KDE/4.3.4; i686; ; )
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201005161525.17404.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26739
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

PORT_AR7 has the correct TRIG flag (UART_FCR_R_TRIG_00) as well as UART_CAP_AFE
being set. This fixes UART on TNETD7300 revision 0x02, which would otherwise
mangle some characters, no side effects on other revisions.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/ar7/platform.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index 566f2d7..8f31d1d 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -542,7 +542,7 @@ static int __init ar7_register_uarts(void)
 	if (IS_ERR(bus_clk))
 		panic("unable to get bus clk\n");
 
-	uart_port.type		= PORT_16550A;
+	uart_port.type		= PORT_AR7;
 	uart_port.uartclk	= clk_get_rate(bus_clk) / 2;
 	uart_port.iotype	= UPIO_MEM32;
 	uart_port.regshift	= 2;
-- 
1.7.1
