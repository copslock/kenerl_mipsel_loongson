Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2010 07:32:42 +0100 (CET)
Received: from mail-gx0-f224.google.com ([209.85.217.224]:50712 "EHLO
        mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492276Ab0BYGcj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Feb 2010 07:32:39 +0100
Received: by gxk24 with SMTP id 24so3739867gxk.7
        for <linux-mips@linux-mips.org>; Wed, 24 Feb 2010 22:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Na20HfBE5ExBtI8udDoqT1l9XFM1vVdJk4I35IhidPo=;
        b=TvTavlVLRohmfYWdpgNhd8YxDZEQeIcnAtkEnRx61Wl6xCh5YuerejfIqXVwbY0UWv
         9NZi3Ovl58rJhSbKNXFyItQSObUHIRq1jvwYNPETOOolaSXSzprjh0KA5fx27LWatjpC
         63OEBRmf94geqaeA+xNMvEVDu923xivA2nsds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        b=HQF4LC564ia6iX/vlJi0yavXC5li/h8UN+Zopobh4qK2zPhq4xyKtjUpwpkdo9s2Gy
         TdSZRi2Vb3IKgzyOgBfX1f68WrdqvnZDEYiW4kkCG9ARHzabqLp2N7agNd0QNtK2OHFj
         jBMJNsd8vIdL1N8EdoMD8snObJ6IUpmUVZuss=
Received: by 10.101.134.11 with SMTP id l11mr1056637ann.117.1267079552576;
        Wed, 24 Feb 2010 22:32:32 -0800 (PST)
Received: from ?10.0.0.13? (eth7090.sa.adsl.internode.on.net [150.101.58.177])
        by mx.google.com with ESMTPS id 21sm1102999yxe.2.2010.02.24.22.32.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 22:32:31 -0800 (PST)
Message-ID: <4B86191A.1050406@gmail.com>
Date:   Thu, 25 Feb 2010 17:00:50 +1030
From:   Graham Gower <graham.gower@gmail.com>
User-Agent: Thunderbird 2.0.0.23 (X11/20090820)
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: [PATCH 2/3] 8250: serial driver changes for XBurst SoCs.
References: <4B861890.6090002@gmail.com>
In-Reply-To: <4B861890.6090002@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <graham.gower@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26040
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: graham.gower@gmail.com
Precedence: bulk
X-list: linux-mips


Signed-off-by: Graham Gower <graham.gower@gmail.com>
---
 drivers/serial/8250.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index e9b15c3..dfe6640 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -199,7 +199,11 @@ static const struct serial8250_config uart_config[] = {
 	[PORT_16550A] = {
 		.name		= "16550A",
 		.fifo_size	= 16,
+#ifndef CONFIG_XBURST
 		.tx_loadsz	= 16,
+#else
+		.tx_loadsz	= 8,
+#endif
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
 		.flags		= UART_CAP_FIFO,
 	},
@@ -406,6 +410,10 @@ static unsigned int mem_serial_in(struct uart_port *p, int offset)
 static void mem_serial_out(struct uart_port *p, int offset, int value)
 {
 	offset = map_8250_out_reg(p, offset) << p->regshift;
+#if defined(CONFIG_XBURST)
+	if (offset == (UART_FCR << p->regshift))
+		value |= 0x10; /* set FCR.UUE */
+#endif
 	writeb(value, p->membase + offset);
 }
 
@@ -2354,6 +2362,10 @@ serial8250_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (up->capabilities & UART_CAP_UUE)
 		up->ier |= UART_IER_UUE | UART_IER_RTOIE;
 
+#ifdef CONFIG_XBURST
+	up->ier |= UART_IER_RTOIE; /* Set this flag, or very slow */
+#endif
+
 	serial_out(up, UART_IER, up->ier);
 
 	if (up->capabilities & UART_CAP_EFR) {
-- 
1.6.4
