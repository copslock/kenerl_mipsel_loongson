Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Dec 2005 16:28:28 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:62683 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133454AbVLPQ2L (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Dec 2005 16:28:11 +0000
Received: (qmail 14785 invoked from network); 16 Dec 2005 16:28:47 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 16 Dec 2005 16:28:47 -0000
Message-ID: <43A2EBC9.5040502@ru.mvista.com>
Date:	Fri, 16 Dec 2005 19:31:05 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MostaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux MIPS <linux-mips@linux-mips.org>
CC:	Rodolfo Giometti <giometti@linux.it>
Subject: Re: Freezing & Unfreezing the au11000
References: <20051216153203.GK14341@gundam.enneenne.com>
In-Reply-To: <20051216153203.GK14341@gundam.enneenne.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Rodolfo Giometti wrote:

> in order to restore the scratch registers contents as descibed into
> file "linux/arch/mips/au1000/common/sleeper.S":

    If you're talking about 2.6, the code in that file seems very incorrect in 
regard to how it deals wiht the stack frame, since it effectively trashes regs 
$1 and $2 reusing their slots for saving CP0 Status and Context regs. 2.4 
branch has more sane variant.

> Thanks in advance,
> 
> Rodolfo

WBR, Sergei
