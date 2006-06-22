Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jun 2006 16:30:40 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:39070 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133898AbWFVPab (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 22 Jun 2006 16:30:31 +0100
Received: (qmail 21203 invoked from network); 22 Jun 2006 19:41:44 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 22 Jun 2006 19:41:44 -0000
Message-ID: <449AB731.40301@ru.mvista.com>
Date:	Thu, 22 Jun 2006 19:28:49 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Domen Puncer <domen.puncer@ultra.si>
CC:	linux-mips@linux-mips.org
Subject: Re: [patch] au1550_ac97: spin_unlock in error path
References: <20060622092913.GA18607@domen.ultra.si>
In-Reply-To: <20060622092913.GA18607@domen.ultra.si>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Domen Puncer wrote:

> Error paths didn't spin_unlock.

    Dang, we missed it while fixing the spinlocks in that driver. Thank you 
for noticing. Not sure if Ralf would be eaegr to apply though. :-)

WBR, Sergei
