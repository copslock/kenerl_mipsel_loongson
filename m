Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2008 16:43:55 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:27268 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S28583266AbYCMQnx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 13 Mar 2008 16:43:53 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 02D553EC9; Thu, 13 Mar 2008 09:43:50 -0700 (PDT)
Message-ID: <47D95A16.7090708@ru.mvista.com>
Date:	Thu, 13 Mar 2008 19:45:10 +0300
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
X-archive-position: 18394
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

    BTW, if you look at sleeper.S you'll find that save_and_sleep() trashes 
registers $1 and $2 because of reusing their stackframe slots to save Status 
and Context CP0 registers:

         sw      $1, PT_R1(sp)
         sw      $2, PT_R2(sp)

         mfc0    k0, CP0_STATUS
         sw      k0, 0x20(sp)		# equals PT_R2
         mfc0    k0, CP0_CONTEXT
         sw      k0, 0x1c(sp)		# equals PT_R1

> Nico Coesel 

WBR, Sergei
