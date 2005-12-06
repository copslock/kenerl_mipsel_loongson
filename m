Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Dec 2005 18:22:54 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:31031 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S8133583AbVLFSWh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Dec 2005 18:22:37 +0000
Received: from [192.168.12.17] ([10.149.0.1])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id jB6IMIt19511;
	Tue, 6 Dec 2005 22:22:18 +0400
Message-ID: <4395D6D9.2020105@ru.mvista.com>
Date:	Tue, 06 Dec 2005 21:22:17 +0300
From:	"Vladimir A. Barinov" <vbarinov@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	ralf@linux-mips.org, ppopov@embeddedalley.com
Subject: [PATCH] Philips PNX8550 USB Host driver compile fix
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <vbarinov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9617
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vbarinov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, Ralf, Pete,

The current ohci-hcd driver is a littel defective.
It's unable to use usb-ohci as modules in the case when PCI and on-chip 
USB are enabled.
It just willn't be compiled since there are two calls if module_init in 
ohci-hcd.

Please look at the patch attached.
I 'm not sure is this patch well for this situation.
Any suggestions are very appretiated.

TIA,
Vladimir
