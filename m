Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Dec 2002 13:35:50 +0100 (CET)
Received: from p508B7FA8.dip.t-dialin.net ([80.139.127.168]:22163 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225196AbSLJMft>; Tue, 10 Dec 2002 13:35:49 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gBACZaJ23823;
	Tue, 10 Dec 2002 13:35:36 +0100
Date: Tue, 10 Dec 2002 13:35:36 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: ?? <kevin@gv.com.tw>
Cc: linux-mips@linux-mips.org
Subject: Re: enlarge KERNEL_STACK_SIZE
Message-ID: <20021210133536.A17306@linux-mips.org>
References: <011c01c29c54$7aa64c60$e20310ac@gv.com.tw> <20021205132358.A5634@linux-mips.org> <00da01c2a047$2aa9f9e0$e20310ac@gv.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <00da01c2a047$2aa9f9e0$e20310ac@gv.com.tw>; from kevin@gv.com.tw on Tue, Dec 10, 2002 at 08:25:03PM +0800
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 836
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 10, 2002 at 08:25:03PM +0800, ?? wrote:

>  how to enlarge KERNEL_STACK_SIZE?
> 
>  is it enough if i only change 
>  the definition of KERNEL_STACK_SIZE in include/asm-mips/processor.h ?

No, other changes would be needed also.  HOWEVER:  It's a very bad idea.
Stacks larger than 8kB require allocation of order 2 or even bigger
pages which will make the kernel unreliable.  I really recommend to stick
with the current 8kB stacks.

  Ralf
