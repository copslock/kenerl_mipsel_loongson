Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2006 17:59:28 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:21906 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133553AbWFWQ7T (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Jun 2006 17:59:19 +0100
Received: (qmail 8331 invoked from network); 23 Jun 2006 21:10:54 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 23 Jun 2006 21:10:54 -0000
Message-ID: <449C1DA8.9090800@ru.mvista.com>
Date:	Fri, 23 Jun 2006 20:58:16 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Domen Puncer <domen.puncer@ultra.si>
CC:	linux-mips@linux-mips.org
Subject: Re: u-boot problem: Au1xx0: fix prom_getenv() to handle YAMON style
 environment
References: <20060623082348.GB18607@domen.ultra.si>
In-Reply-To: <20060623082348.GB18607@domen.ultra.si>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Domen Puncer wrote:

> I need to revert $SUBJECT patch for kernel to boot on au1200,
> u-boot 1.1.3.

> And I could swear it worked booted yesterday without reverting (??)

    Hm, it sort of worked with YAMON before that patch (just not quite 
correctly) due to the fact the name strings seem to be followed by the value 
strings (just not '='but '\0' being between them). But obviously, the variable 
values could be taken for the names the way it was written. If the purpose was 
to support both YAMON and U-Boot, that should've been marked in the comments I 
think...

> Could we support yamon and u-boot style environment?

    Is there a way to distinguish them?

> 	Domen

WBR, Sergei
