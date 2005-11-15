Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Nov 2005 21:28:29 +0000 (GMT)
Received: from web31513.mail.mud.yahoo.com ([68.142.198.142]:62616 "HELO
	web31513.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133613AbVKOV2K (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Nov 2005 21:28:10 +0000
Received: (qmail 79458 invoked by uid 60001); 15 Nov 2005 21:30:05 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=4Rf9eQMRj63Ca5dzJdr1K0d7EjOe+K7n6JZT/u08TlslwJYRKbHUpZcuhmGJPy2bUk1tYlVx5eQSbYPnxCWflqC54zeCY+sXu2Efot8dHlVrHZejdkZM0Tp6s0AILgGDtgUugBMgFOZFvjrZiEvWAAkPjBvDipl36amhzL9Br3Y=  ;
Message-ID: <20051115213005.79456.qmail@web31513.mail.mud.yahoo.com>
Received: from [208.187.37.98] by web31513.mail.mud.yahoo.com via HTTP; Tue, 15 Nov 2005 13:30:05 PST
Date:	Tue, 15 Nov 2005 13:30:05 -0800 (PST)
From:	Jonathan Day <imipak@yahoo.com>
Subject: Another problem with compiling Linux kernel
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9500
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi again,

Using GCC 4.0.0 on the Broadcom SB1 MIPS64 board, the
compilation crashes at the final link phase with the
following errors:

`.exit.text' referenced in section `.pdr.78' of
arch/mips/kernel/built-in.o: defined in discarded
section `.exit.text' of arch/mips/kernel/built-in.o
`.exit.text' referenced in section `.pdr.37' of
fs/built-in.o: defined in discarded section
`.exit.text' of fs/built-in.o
`.exit.text' referenced in section `.pdr.17' of
crypto/built-in.o: defined in discarded section
`.exit.text' of crypto/built-in.o
`.exit.text' referenced in section `.pdr.17' of
block/built-in.o: defined in discarded section
`.exit.text' of block/built-in.o
`.exit.text' referenced in section `.pdr.10' of
drivers/built-in.o: defined in discarded section
`.exit.text' of drivers/built-in.o
`.exit.data' referenced in section `.exit.text.403' of
net/built-in.o: defined in discarded section
`.exit.data' of net/built-in.o
`.exit.data' referenced in section `.exit.text.403' of
net/built-in.o: defined in discarded section
`.exit.data' of net/built-in.o
`.exit.data' referenced in section `.exit.text.403' of
net/built-in.o: defined in discarded section
`.exit.data' of net/built-in.o
`.exit.data' referenced in section `.exit.text.403' of
net/built-in.o: defined in discarded section
`.exit.data' of net/built-in.o
`.exit.text' referenced in section `.pdr.20' of
net/built-in.o: defined in discarded section
`.exit.text' of net/built-in.o

My first thought was "ah, might be because I'm using
an old GCC, so I'll try something more recent and see
what happens". When trying GCC 4.1.0 (snapshot from
20051017), I get the following error:

In file included from include/linux/nfs_fs.h:15,
                 from init/do_mounts.c:12:
include/linux/pagemap.h: In function
'fault_in_pages_readable':
include/linux/pagemap.h:237: error: read-only variable
'__gu_val' used as 'asm' output
include/linux/pagemap.h:237: error: read-only variable
'__gu_val' used as 'asm' output
include/linux/pagemap.h:237: error: read-only variable
'__gu_val' used as 'asm' output
include/linux/pagemap.h:237: error: read-only variable
'__gu_val' used as 'asm' output
include/linux/pagemap.h:243: error: read-only variable
'__gu_val' used as 'asm' output
include/linux/pagemap.h:243: error: read-only variable
'__gu_val' used as 'asm' output
include/linux/pagemap.h:243: error: read-only variable
'__gu_val' used as 'asm' output
include/linux/pagemap.h:243: error: read-only variable
'__gu_val' used as 'asm' output
make[1]: *** [init/do_mounts.o] Error 1
make: *** [init] Error 2

This one may be a compiler bug (experimental GCCs are,
well, experimental!) but it makes it somewhat harder
to know if the later issue is resolved by using a
different toolchain.

Any suggestions on how to fix either/both problems?

Thanks,

Jonathan Day



		
__________________________________ 
Start your day with Yahoo! - Make it your home page! 
http://www.yahoo.com/r/hs
