Received:  by oss.sgi.com id <S553881AbQJ3TKh>;
	Mon, 30 Oct 2000 11:10:37 -0800
Received: from gateway-490.mvista.com ([63.192.220.206]:42999 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553878AbQJ3TKI>;
	Mon, 30 Oct 2000 11:10:08 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e9UJ8O304861;
	Mon, 30 Oct 2000 11:08:24 -0800
Message-ID: <39FDC7E6.BFEBFA08@mvista.com>
Date:   Mon, 30 Oct 2000 11:11:34 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: state of kernel CVS tree
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Ralf,

It appears you have already introduced some of the interrupt controller
changes in the CVS tree.  However I am trouble to compile the kernel. 
See the error message below for arch/mips/kernelirq.c file.

irq.c:109: macro `irq_enter' used with too many (2) args
irq.c:125: macro `irq_exit' used with too many (2) args
irq.c:175: redefinition of `disable_irq'
irq.c:149: `disable_irq' previously defined here
irq.c: In function `enable_irq':
irq.c:207: warning: implicit declaration of function `hw_resend_irq'

BTW, it would be nice to annouce this kind of breaking change a couple
of days ahead of time.

Jun
