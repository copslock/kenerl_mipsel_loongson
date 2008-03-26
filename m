Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Mar 2008 19:19:53 +0100 (CET)
Received: from h155.mvista.com ([63.81.120.155]:33265 "EHLO imap.sh.mvista.com")
	by lappi.linux-mips.net with ESMTP id S1102900AbYCZQbC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Mar 2008 17:31:02 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id D278F3EC9; Wed, 26 Mar 2008 09:30:29 -0700 (PDT)
Message-ID: <47EA7A7B.8020602@ru.mvista.com>
Date:	Wed, 26 Mar 2008 19:31:55 +0300
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
X-archive-position: 18653
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello all.

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

    BTW, for anybody interested in Alchemy PM code, here's the interesting
link: [ftp|http]://ftp.enneenne.com/pub/misc/au1100-patches/linux/.
    It contains  a lot of unmerged PM patches by Rodolfo Giometti (and not
only that) from around 2.6.17 time.

> Nico Coesel 

WBR, Sergei
