Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Feb 2006 17:32:53 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:55991 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S3458530AbWBFRc2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 6 Feb 2006 17:32:28 +0000
Received: (qmail 11102 invoked from network); 6 Feb 2006 17:37:41 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 6 Feb 2006 17:37:41 -0000
Message-ID: <43E78A2C.2000104@ru.mvista.com>
Date:	Mon, 06 Feb 2006 20:41:00 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	Jordan Crouse <jordan.crouse@amd.com>,
	David Sanchez <david.sanchez@lexbox.fr>,
	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Subject: Re: Au1xx0: really set KSEG0 to uncached on reboot
References: <17AB476A04B7C842887E0EB1F268111E027447@xpserver.intra.lexbox.org> <20060206152516.GA10615@cosmic.amd.com>
In-Reply-To: <20060206152516.GA10615@cosmic.amd.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Jordan Crouse wrote:
> On 06/02/06 09:10 +0100, David Sanchez wrote:
> 
>>Hi,
>>
>>This is exactly what I did...
>>But I notice that sometimes it works and sometimes the kernel frees when 

    You mean "freezes" probably? :-)

>>"** Resetting Integrated Peripherals"

    This is not kernel's msg, but YAMON's one...

> We'll need to nail this down before we go any further.  Can we get a trace
> of what happens when it crashes?

    David, do you have BCSR fix from:

http://www.linux-mips.org/archives/linux-mips/2005-10/msg00236.html

applied (the recent kernel has it but which one are you using?)?
DBAu1550 reset may not work as expeceted otherwise indeed...

> Jordan

WBR, Sergei
