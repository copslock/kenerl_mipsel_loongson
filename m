Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2006 02:33:45 +0000 (GMT)
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:31895 "EHLO
	mail8.fw-bc.sony.com") by ftp.linux-mips.org with ESMTP
	id S8133740AbWBWCdh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Feb 2006 02:33:37 +0000
Received: from mail3.sjc.in.sel.sony.com (mail3.sjc.in.sel.sony.com [43.134.1.211])
	by mail8.fw-bc.sony.com (8.12.11/8.12.11) with ESMTP id k1N2ehD7001148;
	Thu, 23 Feb 2006 02:40:43 GMT
Received: from [192.168.1.10] ([43.134.85.105])
	by mail3.sjc.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id k1N2egnr002419;
	Thu, 23 Feb 2006 02:40:42 GMT
Message-ID: <43FD20F7.4090401@am.sony.com>
Date:	Wed, 22 Feb 2006 18:41:59 -0800
From:	Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	anemo@mba.ocn.ne.jp
CC:	linux-mips@linux-mips.org
Subject: SERIAL_TXX9 && BROKEN
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <geoffrey.levand@am.sony.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10608
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoffrey.levand@am.sony.com
Precedence: bulk
X-list: linux-mips

Nemoto-san,

I see this in the 2.6.15 drivers/serial/Kconfig:

config SERIAL_TXX9
	bool "TMPTX39XX/49XX SIO support"
	depends HAS_TXX9_SERIAL && BROKEN

What's needed to get this to work?

-Geoff
