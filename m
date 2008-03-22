Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Mar 2008 19:09:30 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:32043 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S28581274AbYCVTJ2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 22 Mar 2008 19:09:28 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 5E1AD3ECA; Sat, 22 Mar 2008 12:09:24 -0700 (PDT)
Message-ID: <47E559B6.9010001@ru.mvista.com>
Date:	Sat, 22 Mar 2008 22:10:46 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Where's C0 count/.compare IRQ is unmasked??
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

    I'm dazed and confused -- please forget my ignorance but I fail to see 
where the count/compare interrupt is enabled by the most platforms but Alchemy 
(which does it in arch_init_irq() -- which is causing me trouble). I'd 
expected this to happev in cevr-r4k.c but no, it doesn't (unlike cevt-sb1250.c 
for example). I'd expected this to happen in the platform code but most 
platforms disable (or ignore) this IRQ in arch_init_irq() and ignore it in 
plat_time_init() (probably correctly)? Could anyone shed some light on this? 
Where is a proper place to do it?

WBR, Sergei
