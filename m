Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Nov 2002 12:19:27 +0100 (CET)
Received: from ftp.mips.com ([206.31.31.227]:15757 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1121744AbSKTLT1>;
	Wed, 20 Nov 2002 12:19:27 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gAKBJENf014636;
	Wed, 20 Nov 2002 03:19:14 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id DAA24136;
	Wed, 20 Nov 2002 03:19:12 -0800 (PST)
Message-ID: <00dc01c29087$319a3690$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "atul srivastava" <atulsrivastava9@rediffmail.com>
Cc: <linux-mips@linux-mips.org>
References: <20021120104638.23926.qmail@webmail36.rediffmail.com>
Subject: Re: epc status cause all are reported zero?
Date: Wed, 20 Nov 2002 12:23:02 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 679
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> During exec there is a page fault of 4000b0 but immediately after 
> that i get another page fault 0f 0x0fc01788 and following register 
> dump after it
> fails to get a fixup address.
> 
> Unable to handle kernel paging request at virtual address 
> 0fc01788, epc == 00000Oops in fault.c:do_page_fault, line 230:
> $0 : 00000000 00000000 00000000 00000000
> $4 : 00007340 800f0474 00000000 801fa000
> $8 : 00000000 00000000 00000000 4c696e75
> $12: 78000000 00000000 00000000 00000000
> $16: 00000000 00000000 00000000 00000000
> $20: 00000000 00000000 00000000 00000000
> $24: 00000000 00000000
> $28: 6e652900 00000000 00000000 00000000
> epc   : 00000000
> Status: 00000000
> Cause : 00000000
> Process sh (pid: 1, stackpage=801fa000)
> 
> 
> i am confused how come the epc status and cause register all are 
> reported zero.
> whether my regs ( pointer to struct pt_regs) is pointing somewhere 
> else..?

When you see a register dump like that, it's a safe
bet that your regs pointer is trashed.

> secondly Is this a problem with shell or kernel..? may be 
> somewhere the kernel is not checking the
> validity of user space address and hence this problem.

By definition, it would be a kernel problem even if
the shell *had* made a bogus reference.  Worst
case, an error in user mode should cause a core
dump (of course, if it's init that dumps core, you
aren't likely to get to a system login).

You seem to be pretty new to this, so let me recommend
that you first read the FAQ and related information at
http://www.linux-mips.org/, and if you want further
help from the mailing list, please specify what CPU and
board/system you are targeting, which kernel sources you used, 
and what tools you used to build it,  all of which are pretty 
important.

            Kevin K.
