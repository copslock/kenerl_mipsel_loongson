Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Mar 2008 14:30:15 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:4068 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S20027526AbYCXOaN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 24 Mar 2008 14:30:13 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id BDD2F8814; Mon, 24 Mar 2008 19:30:30 +0400 (SAMT)
Message-ID: <47E7BB4B.3080507@ru.mvista.com>
Date:	Mon, 24 Mar 2008 17:31:39 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Cc:	Nico Coesel <ncoesel@DEALogic.nl>
Subject: Re: FW: Alchemy power managment code.
References: <19CA9E279FDA5246B7D7A1C91A4AF7F40EF804@dealogicserver.DEALogic.nl> <47E7B970.30105@ru.mvista.com>
In-Reply-To: <47E7B970.30105@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18475
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

I just wrote:

  >    The TOY cpunter 0 clockevent driver is also need to be written for
> the recent kernel as CP0 timer stops ticking after wait insn is executed 
> -- see arch/mips/au1000/common/time.c...

    And here's found another possible issue with Alchemy PM -- the CP0 counter 
counts at unpredictable frequency in idle state (after executing "wait"), so 
the MIPS clocksource will probably be unstable?

WBR, Sergei
