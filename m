Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Mar 2006 20:33:42 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:2492 "HELO mail.dev.rtsoft.ru")
	by ftp.linux-mips.org with SMTP id S8133896AbWCXUde (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Mar 2006 20:33:34 +0000
Received: (qmail 28070 invoked from network); 25 Mar 2006 01:44:11 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 25 Mar 2006 01:44:11 -0000
Message-ID: <44245993.7040106@ru.mvista.com>
Date:	Fri, 24 Mar 2006 23:41:55 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	Jordan Crouse <jordan.crouse@amd.com>
Subject: Re: [PATCH] Fix for Au1x00 ethernet tx stats
References: <41F11AB7.3010105@corelatus.se> <441628AF.2000300@ru.mvista.com>
In-Reply-To: <441628AF.2000300@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10932
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Sergei Shtylylov wrote:

> Thomas Lange wrote:

>> With current CVS head, ethernet TX bytes always remain zero.
>>
>> The problem seems to be that when packet has been transmitted,
>> the len word in DMA buffer is zero.
>>
>> Attached is a patch against 2_4 HEAD that updates the stats when
>> DMA buffer is written to fix this.
>>
>> * Patch by Thomas Lange, 21 Jan 2005:
>>  Fix update of ethernet tx bytes stats for au1x00
> 
> 
>      More than a year ago, this is still an issue with both 2.4 and 2.6 
> driver.
> Here's the 2.6 patch...

    It's in the Linus' tree now. Will send 2.4 patch to Marcelo...

>> /Thomas

WBR, Sergei
