Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2006 15:23:34 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:45449 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133369AbWBGPXZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 7 Feb 2006 15:23:25 +0000
Received: (qmail 1995 invoked from network); 7 Feb 2006 15:29:01 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 7 Feb 2006 15:29:01 -0000
Message-ID: <43E8BD84.60308@ru.mvista.com>
Date:	Tue, 07 Feb 2006 18:32:20 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
CC:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] TX49 MFC0 bug workaround
References: <43E25381.4060309@ru.mvista.com>	<20060203.101705.41198541.nemoto@toshiba-tops.co.jp>	<43E2BC1F.7080505@ru.mvista.com> <20060203.112253.104030567.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20060203.112253.104030567.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To:	unlisted-recipients:; (no To-header on input)
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:
>>>>>>On Fri, 03 Feb 2006 05:12:47 +0300, Sergei Shtylylov <sshtylyov@ru.mvista.com> said:
> 
> sshtylyov>     If I don't mistake, the offending code is in
> sshtylyov> local_irq_disable, local_irq_save, and local_irq_restore
> sshtylyov> macros. The effect would be a crash on any exception taken
> sshtylyov> once interrupts get disabled in a module (*and* that code
> sshtylyov> happens to fall on a page boundary)... nasty. :-(

    ... and yet worse: any external interrupts actually blocked from CPU 
forever by Status.EXL set (which then will never be cleared after the errata 
triggers).

> Right.  And it can really happen.

> ---
> Atsushi Nemoto

WBR, Sergei
