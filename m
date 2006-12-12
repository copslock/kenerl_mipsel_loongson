Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Dec 2006 19:56:05 +0000 (GMT)
Received: from [69.90.147.196] ([69.90.147.196]:2972 "EHLO mail.kenati.com")
	by ftp.linux-mips.org with ESMTP id S20039625AbWLLTz7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 12 Dec 2006 19:55:59 +0000
Received: from [192.168.1.169] (adsl-71-130-109-177.dsl.snfc21.pacbell.net [71.130.109.177])
	by mail.kenati.com (Postfix) with ESMTP id 981F1E404D
	for <linux-mips@linux-mips.org>; Tue, 12 Dec 2006 13:22:25 -0800 (PST)
Subject: 8250 Flag definitions
From:	Ashlesha Shintre <ashlesha@kenati.com>
Reply-To: ashlesha@kenati.com
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Tue, 12 Dec 2006 12:09:02 -0800
Message-Id: <1165954142.6539.1.camel@sandbar.kenati.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ashlesha@kenati.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13436
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashlesha@kenati.com
Precedence: bulk
X-list: linux-mips

Hi,

Is there a document that outlines the meaning of these flags in the 8250
serial driver?


> 	#define UPF_FOURPORT            (1 << 1)
> 232 #define UPF_SAK                 (1 << 2)
> 233 #define UPF_SPD_MASK            (0x1030)
> 234 #define UPF_SPD_HI              (0x0010)
> 235 #define UPF_SPD_VHI             (0x0020)
> 236 #define UPF_SPD_CUST            (0x0030)
> 237 #define UPF_SPD_SHI             (0x1000)
> 238 #define UPF_SPD_WARP            (0x1010)
> 239 #define UPF_SKIP_TEST           (1 << 6)
> 240 #define UPF_AUTO_IRQ            (1 << 7)
> 241 #define UPF_HARDPPS_CD          (1 << 11)
> 242 #define UPF_LOW_LATENCY         (1 << 13)
> 243 #define UPF_BUGGY_UART          (1 << 14)
> 244 #define UPF_AUTOPROBE           (1 << 15)
> 245 #define UPF_MAGIC_MULTIPLIER    (1 << 16)
> 246 #define UPF_BOOT_ONLYMCA        (1 << 22)
> 247 #define UPF_CONS_FLOW           (1 << 23)
> 248 #define UPF_SHARE_IRQ           (1 << 24)
> 249 #define UPF_BOOT_AUTOCONF       (1 << 28)
> 250 #define UPF_IOREMAP             (1 << 31)


Thanks,
Ashlesha.
