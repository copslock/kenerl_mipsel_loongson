Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2006 18:36:43 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:51098 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133506AbWFWRge (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Jun 2006 18:36:34 +0100
Received: (qmail 8563 invoked from network); 23 Jun 2006 21:48:09 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 23 Jun 2006 21:48:09 -0000
Message-ID: <449C2663.4060501@ru.mvista.com>
Date:	Fri, 23 Jun 2006 21:35:31 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Domen Puncer <domen.puncer@ultra.si>
CC:	linux-mips@linux-mips.org
Subject: Re: u-boot problem: Au1xx0: fix prom_getenv() to handle YAMON style
 environment
References: <20060623082348.GB18607@domen.ultra.si> <449C1DA8.9090800@ru.mvista.com>
In-Reply-To: <449C1DA8.9090800@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11836
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, I wrote:

>> I need to revert $SUBJECT patch for kernel to boot on au1200,
>> u-boot 1.1.3.

>> And I could swear it worked booted yesterday without reverting (??)

>    Hm, it sort of worked with YAMON before that patch (just not quite 
> correctly) due to the fact the name strings seem to be followed by the 
> value strings (just not '='but '\0' being between them). But obviously, 
> the variable values could be taken for the names the way it was written. 
> If the purpose was to support both YAMON and U-Boot, that should've been 
> marked in the comments I think...

>> Could we support yamon and u-boot style environment?

>    Is there a way to distinguish them?

   Well, I think some adaptive alogrithm using strchr(env, '=') should be 
possible...

>>     Domen

WBR, Sergei
