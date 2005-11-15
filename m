Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Nov 2005 15:48:50 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:5570 "HELO mail.dev.rtsoft.ru")
	by ftp.linux-mips.org with SMTP id S8133574AbVKOPsd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 15 Nov 2005 15:48:33 +0000
Received: (qmail 10043 invoked from network); 15 Nov 2005 15:50:27 -0000
Received: from unknown (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 15 Nov 2005 15:50:27 -0000
Message-ID: <437A043B.6040604@ru.mvista.com>
Date:	Tue, 15 Nov 2005 18:52:27 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MostaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux MIPS Development <linux-mips@linux-mips.org>
CC:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: JMR3927
References: <20051114114615.GA6186@linux-mips.org>
In-Reply-To: <20051114114615.GA6186@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9495
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ralf Baechle wrote:

> Does anybody still care about the JMR3927 board?

    At least there's no 2.6 release planned for this board by Montavista.

>  The board code is pretty
> badly broken.   It's also currently the only user of the TX3927 in the tree.

   I saw you were busy with TX3927 maintenance recently... Looks like this is 
another chance to remind you of my old patch:

http://www.linux-mips.org/archives/linux-mips/2004-10/msg00300.html

>   Ralf

WBR, Sergei
