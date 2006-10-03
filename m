Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2006 20:46:20 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:13736 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20038883AbWJCTqS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 3 Oct 2006 20:46:18 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 28CF43ED3; Tue,  3 Oct 2006 12:46:01 -0700 (PDT)
Message-ID: <4522BDFC.5040701@ru.mvista.com>
Date:	Tue, 03 Oct 2006 23:46:04 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [MIPS] Fix wreckage after removal of tickadj; convert to GENERIC_TIME.
References: <S20038910AbWJCTjS/20061003193918Z+2409@ftp.linux-mips.org>
In-Reply-To: <S20038910AbWJCTjS/20061003193918Z+2409@ftp.linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

linux-mips@linux-mips.org wrote:
> Author: Ralf Baechle <ralf@linux-mips.org> Mon Oct 2 16:54:48 2006 +0100
> Commit: 452dce20d066a17a85bc3fb5a9d1c9fed610e328
> Gitweb: http://www.linux-mips.org/g/linux/452dce20
> Branch: master

> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

> ---

>  arch/mips/Kconfig       |    4 +++
>  arch/mips/dec/time.c    |    2 -
>  arch/mips/kernel/time.c |   74 -----------------------------------------------
>  3 files changed, 4 insertions(+), 76 deletions(-)

    Well, be forewarned that with this patch, MIPS kernel now only has 
jiffy-precise time resolution. I.e. you could have killed all gettimeoffset 
handlers I suppose since there's nothing to call them from anymore. We need a 
clocksource patch added now to restore the old functionality (it's currently a 
part of the RT patch)...

WBR, Sergei
