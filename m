Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Mar 2008 20:46:44 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:44777 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S28575553AbYCTUqm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Mar 2008 20:46:42 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id D6A303ECA; Thu, 20 Mar 2008 13:46:38 -0700 (PDT)
Message-ID: <47E2CD81.3050107@ru.mvista.com>
Date:	Thu, 20 Mar 2008 23:48:01 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Make KGDB compile on UP
References: <200803202059.37857.sshtylyov@ru.mvista.com>
In-Reply-To: <200803202059.37857.sshtylyov@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hi, I wrote:

> Building UP kernel with KGDB enabled produces the following errors and warning
> (fatal due to -Werror in arch/mips/kernel/Makefile):
> 
> In file included from arch/mips/kernel/gdb-stub.c:142:
> include/asm/smp.h:25:1: "raw_smp_processor_id" redefined
> In file included from include/linux/sched.h:69,
>                  from arch/mips/kernel/gdb-stub.c:126:
> include/linux/smp.h:88:1: this is the location of the previous definition
> In file included from arch/mips/kernel/gdb-stub.c:142:
> include/asm/smp.h:62: error: redefinition of 'smp_send_reschedule'
> include/linux/smp.h:102: error: previous definition of 'smp_send_reschedule' was here
> include/asm/smp.h: In function `smp_send_reschedule':
> include/asm/smp.h:65: error: dereferencing pointer to incomplete type
> arch/mips/kernel/gdb-stub.c: At top level:
> arch/mips/kernel/gdb-stub.c:660: warning: 'kgdb_wait' defined but not used
> 
> Fix the errors by not directly including <asm/smp.h> (which is already included
> by <linux/smp.h>) and the warning by enclosing kgdb_wait() in #ifdef CONFIG_SMP.

    As usual, forgot to stamp:

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

WBR, Sergei
