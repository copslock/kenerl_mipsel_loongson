Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2007 13:32:54 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:32994 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039250AbXBMNcx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Feb 2007 13:32:53 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1DDWqWT018662;
	Tue, 13 Feb 2007 13:32:52 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1DDWpTI018661;
	Tue, 13 Feb 2007 13:32:51 GMT
Date:	Tue, 13 Feb 2007 13:32:51 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: More __get_user_asm_ll32 ...
Message-ID: <20070213133251.GA7518@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14069
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

__get_user_asm_ll32 contains a junk move %0, $0 left over from an older
version of the code.  Ignoring fixups code and data this instruction
inflates the normal path in __get_user() by 50% which may explain much of
the size and performance you have meassures.  It also always clears
the error return, iow. __get_user_asm_ll32(..., &<something 64-bit>)
would never have returned an error.  ARGH.

  Ralf
