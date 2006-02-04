Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Feb 2006 00:17:39 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:54463 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133516AbWBDARW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 4 Feb 2006 00:17:22 +0000
Received: (qmail 10590 invoked from network); 4 Feb 2006 00:22:38 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 4 Feb 2006 00:22:38 -0000
Message-ID: <43E3F492.8010909@ru.mvista.com>
Date:	Sat, 04 Feb 2006 03:25:54 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	David Sanchez <david.sanchez@lexbox.fr>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Au1xx0: really set KSEG0 to uncached on reboot
References: <17AB476A04B7C842887E0EB1F268111E02740C@xpserver.intra.lexbox.org>
In-Reply-To: <17AB476A04B7C842887E0EB1F268111E02740C@xpserver.intra.lexbox.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

David Sanchez wrote:

> The patch doesn't work for Au1550. Since I apply it my DbAu1550 frees on
> restart.

    Just tried 'reboot' command on a fresh kernel with this patch and NFP 
userland -- it worked well.

> David

WBR, Sergei
