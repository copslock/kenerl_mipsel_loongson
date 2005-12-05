Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Dec 2005 11:50:28 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:55197 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133653AbVLELtq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Dec 2005 11:49:46 +0000
Received: (qmail 16586 invoked from network); 5 Dec 2005 11:49:16 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 5 Dec 2005 11:49:16 -0000
Message-ID: <439429C8.1000402@ru.mvista.com>
Date:	Mon, 05 Dec 2005 14:51:36 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MostaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	David Sanchez <david.sanchez@lexbox.fr>,
	Linux MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Au1550 system bus masters issue
References: <17AB476A04B7C842887E0EB1F268111E0271B7@xpserver.intra.lexbox.org> <43942625.2070609@ru.mvista.com>
In-Reply-To: <43942625.2070609@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Sergei Shtylylov wrote:

> coherency in Ethernet driver however makes the kernel non-bootable. USB 
> host controller (and probably not only it, I'm too lazy to re-check ;-) 
> is still prone to other errata on stepping AB though, see this thread:
> 
> http://www.linux-mips.org/archives/linux-mips/2005-11/msg00137.html
> 
> I'm gonna rework the patch and resubmit.

    Oops, I was talking of Au1500 step AB, Au1550 doesn't have CONFIG.OD bit 
errata...

WBR, Sergei
