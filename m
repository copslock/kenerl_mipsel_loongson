Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Nov 2005 17:30:08 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:52352 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133847AbVK3R3u (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 30 Nov 2005 17:29:50 +0000
Received: (qmail 20157 invoked from network); 30 Nov 2005 17:33:10 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 30 Nov 2005 17:33:10 -0000
Message-ID: <438DE2DC.2030500@ru.mvista.com>
Date:	Wed, 30 Nov 2005 20:35:24 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MostaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: DbAu1550 copy file corruption
References: <17AB476A04B7C842887E0EB1F268111E027190@xpserver.intra.lexbox.org> <cf72b856706166dfcfc3de18af976400@embeddedalley.com>
In-Reply-To: <cf72b856706166dfcfc3de18af976400@embeddedalley.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9570
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Dan Malek wrote:

> Have you tested this on an NFS partition?  Does
> the on-board HPT371 work?  I know the latter two
> used to work, but I don't remember testing a 2.6.10
> kernel, I've been using newer ones.

   Do you mean HPT371N? It shouldn't work (and does not work for us) since the
current driver has severe clocking problems with anything but HPT370/374 on a
66 MHz PCI. So with the default 64 MHz Au1550 PCI clock the driver just locks
up; it can only work if you plug in a 33 MHz PCI card to get Au1550 PCI
clocked at 32 MHz. I was in the process of fixing this but this work is
currently preempted by more urgent stuff... :-(

WBR, Sergei
