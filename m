Received:  by oss.sgi.com id <S42205AbQGKWoE>;
	Tue, 11 Jul 2000 15:44:04 -0700
Received: from inet-tsb.toshiba.co.jp ([202.33.96.40]:57254 "EHLO
        inet-tsb.toshiba.co.jp") by oss.sgi.com with ESMTP
	id <S42190AbQGKWnn>; Tue, 11 Jul 2000 15:43:43 -0700
Received: from tis2.tis.toshiba.co.jp (tis2 [133.199.160.66])
	by inet-tsb.toshiba.co.jp (3.7W:TOSHIBA-ISC-2000030918) with ESMTP id VAA00445;
	Tue, 11 Jul 2000 21:58:54 +0900 (JST)
Received: from mx.toshiba.co.jp by tis2.tis.toshiba.co.jp (8.8.4+2.7Wbeta4/3.3W9-95082317)
	id VAA09717; Tue, 11 Jul 2000 21:58:53 +0900 (JST)
Received: by toshiba.co.jp (8.7.1+2.6Wbeta4/3.3W9-TOSHIBA-GLOBAL SERVER) id VAA23473; Tue, 11 Jul 2000 21:58:52 +0900 (JST)
To:     linux-mips@oss.sgi.com, linux-mips@vger.rutgers.edu,
        linux-mips@fnet.fr
Subject: div overflow
X-Mailer: Mew version 1.94.2 on Emacs 20.6 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <200007111258.VAA23473@toshiba.co.jp>
Date:   Tue, 11 Jul 2000 21:58:47 +0900
From:   Hiroo HAYASHI <hiroo.hayashi@toshiba.co.jp>
X-Dispatcher: imput version 20000228(IM140)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

In MIPS architecture, is the result of 0x80000000/-1 undefined?

The operands of DIV instruction 32bit signed int.

	 0x7fff_ffff =  2,147,483,647 (INT_MAX)
	 0x8000_0000 = -2,147,483,648 (INT_MIN)

limits.h defines them as;

> /* Minimum and maximum values a `signed int' can hold.  */
> #  define INT_MIN       (- INT_MAX - 1)
> #  define INT_MAX       2147483647

0x8000_0000 / 0xffff_ffff = -2,147,483,648 / -1 = 2,147,483,648 > INT_MAX

But the description of the DIV instruction of MIPS RISC Architecture
(Kane and Heinrich) says;

	No overflow exception occurs under any circumstances, and the
	result of this operation is undefined when the divisor is zero.

According to 'See MIPS Run', P.186, MIPS assembler expands a div
instruction to an instruction sequence in which these condition are
checked.  Do all MIPS assemblers do this?

Any information is welcome.

Thank you.
-------------
Hiroo Hayashi	System LSI Architecture Dept.
		Computer on Silicon Development Center
		TOSHIBA Corporation
