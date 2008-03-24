Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Mar 2008 14:22:20 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:64739 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S20027184AbYCXOWS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 24 Mar 2008 14:22:18 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 796728814; Mon, 24 Mar 2008 19:22:35 +0400 (SAMT)
Message-ID: <47E7B970.30105@ru.mvista.com>
Date:	Mon, 24 Mar 2008 17:23:44 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Nico Coesel <ncoesel@DEALogic.nl>
Cc:	linux-mips@linux-mips.org
Subject: Re: FW: Alchemy power managment code.
References: <19CA9E279FDA5246B7D7A1C91A4AF7F40EF804@dealogicserver.DEALogic.nl>
In-Reply-To: <19CA9E279FDA5246B7D7A1C91A4AF7F40EF804@dealogicserver.DEALogic.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18474
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Nico Coesel wrote:

> Ralf,
> Funny you ask because I tried this yesterday on a AU1100 system with the
> 2.6.24 kernel (from kernel.org). I'm afraid I must say the kernel
> crashes when I enable power management. The reason I want to use power
> management is because I need to send the CPU to sleep when the system
> shuts down. I hacked power.c and reset.c a bit so au_sleep() is called
> when the system is shut down. Perhaps someone can confirm the
> powermanagement can be made to work with some fixes (it didn't work with
> 2.6.21-rc4 either).

    The TOY cpunter 0 clockevent driver is also need to be written for the 
recent kernel as CP0 timer stops ticking after wait insn is executed -- see 
arch/mips/au1000/common/time.c...

WBR, Sergei
