Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Oct 2004 21:11:16 +0100 (BST)
Received: from [IPv6:::ffff:65.205.244.70] ([IPv6:::ffff:65.205.244.70]:7999
	"EHLO mail2.dmz.sj.pioneer-pra.com") by linux-mips.org with ESMTP
	id <S8225281AbUJYULJ>; Mon, 25 Oct 2004 21:11:09 +0100
Received: from localhost (localhost [127.0.0.1])
	by mail2.dmz.sj.pioneer-pra.com (Postfix) with ESMTP id A076C2340DB;
	Mon, 25 Oct 2004 13:11:01 -0700 (PDT)
Received: from mail2.dmz.sj.pioneer-pra.com ([127.0.0.1])
 by localhost (neo2 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18481-06; Mon, 25 Oct 2004 13:11:01 -0700 (PDT)
Received: from Europa (unknown [207.215.131.4])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by mail2.dmz.sj.pioneer-pra.com (Postfix) with ESMTP id DAEBD2340D8;
	Mon, 25 Oct 2004 13:11:00 -0700 (PDT)
From: "Mike C. Ward" <mike.ward@pioneer-pra.com>
To: "Linux-MIPS List" <linux-mips@linux-mips.org>,
	"uClibc List" <uclibc@uclibc.org>
Subject: remote cross GDB debugging with shared libraries on mipsel-linux with uClibc
Date: Mon, 25 Oct 2004 13:10:53 -0700
Message-ID: <EBEFKGLFAJGMOFIOAPDICECBDGAA.mike.ward@pioneer-pra.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Return-Path: <mike.ward@pioneer-pra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mike.ward@pioneer-pra.com
Precedence: bulk
X-list: linux-mips

I am having trouble with remote cross GDB debugging on mipsel-linux 
with uClibc.  

Has anyone had success remote debugging a MIPSEL program that uses 
shared libraries and uClibc?  Anyone aware of a problem with this 
configuration?

mipsel-linux-gcc (GCC) 3.3.3
uClibc-0.9.27
binutils 2.14.90.0.7 20031029
Linux 2.4.25
GDB 5.3 and GDB 6.2.1 and gdb+dejagnu-20040805
have been tried.  

Thanks,

Mike

More details follow:

GDB finds and opens
ld-uClibc.so.0, but is unable to properly load any
libraries. 
Libraries are unstripped on the host,
target contains stripped versions of the identical
libraries.
GDB gets shared library event breakpoints when libraries are loaded
if they're enabled.  The GDB function elf_locate_base()
finds DT_MIPS_RLD_MAP which "contains a pointer 
to the address of the dynamic link structure."  But that
address is read as 0.
