Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Aug 2008 05:59:07 +0100 (BST)
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:26035 "EHLO
	fed1rmmtao105.cox.net") by ftp.linux-mips.org with ESMTP
	id S20022506AbYHGE67 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Aug 2008 05:58:59 +0100
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20080807045852.OIFZ774.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 7 Aug 2008 00:58:52 -0400
Received: from [192.168.1.100] ([68.13.125.212])
	by fed1rmimpo01.cox.net with bizsmtp
	id zGyq1Z00M4b4U6U03GyruM; Thu, 07 Aug 2008 00:58:51 -0400
Message-ID: <489A810B.8030301@paralogos.com>
Date:	Wed, 06 Aug 2008 23:58:51 -0500
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	Chung-Chi Lo <linolo@gmail.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Config7.WII and IPI mechanism in SMTC linux
References: <3f696b20807302341n39d53172q39adf8e10c6249bb@mail.gmail.com>
In-Reply-To: <3f696b20807302341n39d53172q39adf8e10c6249bb@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20141
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

The original SMTC code was written for MIPS kernels which guaranteed
that interrupts were never disabled when the WAIT instruction is executed.
It was later noted that going into WAIT with interrupts disabled is 
desirable
in most MIPS implementations, and a patch was propagated which did this,
but also broke SMTC.  There is a way to make SMTC work in spite of this,
and I had thought that it had been implemented, at least internally to MIPS,
but it may be that the necessary patch hasn't yet been written or 
published. 
The last time I checked, the WAIT-with-interrupts-off behavior was a 
configuration
option.  If that's true in the sources you're using, turn it off if 
you're building
for SMTC.  If you want further assistance, contact me by direct email.

          Regards,

          Kevin K.

Chung-Chi Lo wrote:
> Hello,
>
> My platform is MIPS 34K cpu core and Config7.WII=1.
>
> If Config7.WII=1 and a TC is idle, the TC will execute "wait"
> instruction with TCSTATUS.IXMT=1
> to disable interrupt.
>
> But in 34K, interrupts are not TC-specific. So some TCs will not get
> real interrupts to break "wait"
> instruction. Even in SMTC's IPI mechanism, the IPI mechanism is to
> program TCRestart if target
> TC is in the same VPE.
>
> In function smtc_send_ipi, it detects if TC's interrupt is disabled,
> then enqueue IPI message to
> target TC's queue. So some TCs are always idle and cannot break "wait"
> instruction. I don't know
> if I miss something and please comment on this problem. Thanks.
>
>                 if ((tcstatus & TCSTATUS_IXMT) != 0) {
>                         /*
>                          * Spin-waiting here can deadlock,
>                          * so we queue the message for the target TC.
>                          */
>                         write_tc_c0_tchalt(0);
>                         UNLOCK_CORE_PRA();
>                         .....
>                         smtc_ipi_nq(&IPIQ[cpu], pipi);
>                 }
>
> --
> Lino, Chung-Chi Lo
>
>
>   
