Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jan 2016 10:11:50 +0100 (CET)
Received: from mail-lf0-f48.google.com ([209.85.215.48]:36747 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008977AbcAUJLtHxlBe convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Jan 2016 10:11:49 +0100
Received: by mail-lf0-f48.google.com with SMTP id h129so22660161lfh.3
        for <linux-mips@linux-mips.org>; Thu, 21 Jan 2016 01:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=8/Sd+yGVuz8Ju16jjwRMtwCE0ol/r4uts9CD6xuI0cQ=;
        b=R3cUmqIfQhaAsNuOazNemJONPXZ8D9grx8rCq/54inyWuqNorrksAFCZgSkdeDLO+0
         A95LDmuDX5OL7gyylJoQkS3tGn44ocOMP4Lyn75sqy3Du182tKaJWCQI8h+oNEmg8hFD
         wacT7/ZOyLi2sDWuIuvEsAzxUt8tXnC0CWgsKQL0N/wWnNRflX1fxukUuRUj8BPzd+FO
         lDK3irtGJU+bO6SdlhmfMwD6AEDGDo7RxHndx5Y8XTF/DNjyhU91T5Mr/tJWy61F7Nir
         HTfKueUEpv2ngO9PGPjwPybOPcT0N5aHPhYcAEZrrG7s2FsNMEIRIRP68a6bJzNzDl5M
         G2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=8/Sd+yGVuz8Ju16jjwRMtwCE0ol/r4uts9CD6xuI0cQ=;
        b=iiTOQ1ExEbVTeGz0NzQSXetdD9pfBzC508YoZ7D99eqSsN1qlTrkOGoy8iOGsPIMg+
         WwJsa3uAsEQ3pHPhVn8CVeoaSKvpHI8vtpscV8AAoGsqjl2xbAEIB/wxrxbtzusKVvtI
         JpZxHKiMvezTlOyYqBZ08BpsRHlp4+7V92hwyaro3yDfz5LGUYydGqDVASAMSlronKte
         yyzuowLZE/QWCba7MFbCChjUbI0bKrEvYcZBjD9Nnm/the2Axl9V4zHZMO8NkSw9kmbc
         qU28U+Mm9Nh/3/WIykEJalmxVHrlfNYLnu2ohthppIi+AGrO3pS+ugacBUOIV89CoFZC
         Kuzw==
X-Gm-Message-State: ALoCoQnbruqsgjyWnuw8fikCtJJpQ7K3UZQVtwYoGc4qoFGc9t8fLrbRZ22d47OH07FRLWSRDATpukgsGYBNOPeE1gMT6x2Hww==
X-Received: by 10.25.148.141 with SMTP id w135mr12313288lfd.137.1453367503690;
        Thu, 21 Jan 2016 01:11:43 -0800 (PST)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id p66sm52973lfe.42.2016.01.21.01.11.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Jan 2016 01:11:42 -0800 (PST)
Date:   Thu, 21 Jan 2016 12:36:47 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Alban Bedel <albeu@free.fr>
Cc:     linux-mips@linux-mips.org
Subject: MIPS: ath79: TP-LINK WR1043ND: uart clk issue
Message-Id: <20160121123647.5b08e7360103768755488433@gmail.com>
X-Mailer: Sylpheed 3.5.0beta3 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

Hi!

I have tried to run linux on TP-LINK WR1043ND v1.8.

I use branch master from git://git.linux-mips.org/pub/scm/ralf/linux

I see a problem with UART speed setup. There is no UART output after
serial port initialization. Here is the last correct linux output:

  Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
  console [ttyS0] disabled
  18020000.uart: ttyS0 at MMIO 0x18020000 (irq = 11, base_baud = 12500000) is a 8250


I can disable UART speed setup in 8250 driver:

--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2208,6 +2208,8 @@ static void serial8250_set_divisor(struct uart_port *port, unsigned int baud,
 {
        struct uart_8250_port *up = up_to_u8250p(port);
 
+       return;
+
        /* Workaround to enable 115200 baud on OMAP1510 internal ports */
        if (is_omap1510_8250(up)) {
                if (baud == 115200) {

With this very very dirty hack linux works fine.

I suppose there is a problem in arch/mips/ath79/clock.c

I have tryed to cherry-pick your 'MIPS: ath79: Fix the ar913x reference clock rate'
and 'MIPS: ath79: Fix the ar724x clock calculation' commits from
your github ath79 branch at https://github.com/AlbanBedel/linux/tree/ath79
but these patches don't help me.

Could you please try to reproduce the problem?

-- 
Best regards,
  Antony Pavlov
