Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Dec 2005 20:28:58 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:2516 "HELO mail.dev.rtsoft.ru")
	by ftp.linux-mips.org with SMTP id S3457351AbVLHU2k (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Dec 2005 20:28:40 +0000
Received: (qmail 19845 invoked from network); 8 Dec 2005 20:28:32 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 8 Dec 2005 20:28:32 -0000
Message-ID: <439897FC.5050008@ru.mvista.com>
Date:	Thu, 08 Dec 2005 23:30:52 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MostaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	Jordan Crouse <jordan.crouse@amd.com>
Subject: [PATCH] Enable DBAu1550 soft-off
References: <1133342401.24526.25.camel@localhost.localdomain> <43988FA6.5080209@ru.mvista.com>
In-Reply-To: <43988FA6.5080209@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9638
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, I wrote.

> Matej Kupljen wrote:
> 
>> Hi
>>
>> Please, find the attached patch which enables
>> powering off the DBAU1200 board.
> 
> 
>     As a follow up to this one, here's the patch which does the same 
> thing for
> DBAu1550 by just reusing Pb1550 code. I added #else because #if renders the
> rest of the au1000_halt() code unreachable on DBAu1550/PB1550 anyway.

    Failed to chenge the subject to a proper one. :-/

WBR, Sergei
