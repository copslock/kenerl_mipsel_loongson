Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2009 16:41:33 +0100 (CET)
Received: from mail.netlogicmicro.com ([64.0.7.62]:4568 "EHLO
	orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by ftp.linux-mips.org with ESMTP id S1493381AbZKCPl1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Nov 2009 16:41:27 +0100
Received: from orion8.netlogicmicro.com ([10.1.1.7]) by 
	orion5.netlogicmicro.com with InterScan Message Security Suite; Tue, 03 Nov
	 2009 07:42:06 -0800
Received: from 12.234.128.66 ([12.234.128.66]) by orion8.netlogicmicro.com 
	([10.1.1.7]) with Microsoft Exchange Server HTTP-DAV ;Tue,  3 Nov 2009 
	15:42:06 +0000
Received: from kh-t3500 by 12.239.216.94; 03 Nov 2009 09:41:03 -0600
Subject: Re: [RFC PATCH 1/3] MIPS: Alchemy: extended DB1200 board support.
From:	Kevin Hickey <khickey@netlogicmicro.com>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
In-Reply-To: <1257193305-29996-1-git-send-email-manuel.lauss@gmail.com>
References: <1257193305-29996-1-git-send-email-manuel.lauss@gmail.com>
Content-Type: text/plain;
	charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date:	Tue, 03 Nov 2009 09:41:03 -0600
Message-ID: <1257262863.29642.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
X-imss-version:	2.054
X-imss-result: Passed
X-imss-scanInfo: M:P L:N SM:0
X-imss-tmaseResult: TT:0 TS:0.0000 TC:00 TRN:0 TV:5.6.1016(16988.000)
X-imss-scores: Clean:99.90000 C:2 M:3 S:5 R:5
X-imss-settings: Baseline:2 C:4 M:4 S:4 R:4 (0.1500 0.1500)
Return-Path: <khickey@netlogicmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24643
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@netlogicmicro.com
Precedence: bulk
X-list: linux-mips

On Mon, 2009-11-02 at 21:21 +0100, Manuel Lauss wrote:
> Create own directory for DB1200 code and update it with new features.
> 
> - SPI support:
>   - tmp121 temperature sensor
>   - SPI flash on DB1200
> - I2C support
>   - NE1619 sensor
>   - AT24 eeprom
> - I2C/SPI can be selected at boot time via switch S6.8
> - Carddetect IRQs for SD cards.
> - gen_nand based NAND support.
> - hexleds count sleep/wake transitions.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---

The code in this patch all looks good to me.  I don't understand how
much value is added by using the hex LEDs for counting sleep/wake
transitions.  In our internal builds, we use the hex LEDs for displaying
the last interrupt serviced (useful on hangs/crashes and for getting a
general sense of what the hardware is working on), the dots blink on
timer ticks (often every 100 or 1000 depending on the clock) and the
Idle state is shown on LED0.  I don't really have any strong attachment
to those usages, but they've served us well.

Otherwise this looks good to me.  Hope this isn't too late (I saw the
email saying it was queued come in as I typed this one).

=Kevin
