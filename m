Received:  by oss.sgi.com id <S553849AbQJ3KdW>;
	Mon, 30 Oct 2000 02:33:22 -0800
Received: from router.isratech.ro ([193.226.114.69]:6922 "EHLO
        router.isratech.ro") by oss.sgi.com with ESMTP id <S553846AbQJ3KdS>;
	Mon, 30 Oct 2000 02:33:18 -0800
Received: from isratech.ro (calin.cs.tuiasi.ro [193.231.15.163])
	by router.isratech.ro (8.10.2/8.10.2) with ESMTP id e9UAUQZ18113
	for <linux-mips@oss.sgi.com>; Mon, 30 Oct 2000 08:30:35 -0200
Message-ID: <39FDAE22.7626E6E@isratech.ro>
Date:   Mon, 30 Oct 2000 12:21:38 -0500
From:   Nicu Popovici <octavp@isratech.ro>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.15-2.5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: Still cannot compile the KERNEL!!!
Content-Type: multipart/mixed;
 boundary="------------41664DF7B61187D49DBEE838"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------41664DF7B61187D49DBEE838
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello you all,

I have a problem. I've built a crosscompiler for MIPS on my intel
machine but until now I could not compile any mips kernel. I tried with
version from CVS site  and now I an trying with
linux-2.2.12.mips-src.01.04.tar.gz and I an running into errors from the
beggining.( are in the attached file )

I still succeded to compile a test.c file on my intel machine with my
crosscompiler and then to run the resulted file on the mips machine and
it worked.
When I tried with the g++ and with the test.cpp ( a simple class ) the
crosscompiler made a file but when I executed on the mips machine it
says
a.out error in loading shared libraries
undefined simbol : _deregister_frame_info

I hope that anyone will help me on that . I am running out of time .

Regards,
Nicu

--------------41664DF7B61187D49DBEE838
Content-Type: text/plain; charset=us-ascii;
 name="error"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="error"

n file included from /usr/src/atlas_linux/include/linux/timex.h:138,
                 from /usr/src/atlas_linux/include/linux/sched.h:14,
		                  from /usr/src/atlas_linux/include/linux/mm.h:4,
				                   from /usr/src/atlas_linux/include/linux/slab.h:14,
						                    from /usr/src/atlas_linux/include/linux/malloc.h:4,
								                     from /usr/src/atlas_linux/include/linux/proc_fs.h:5,
										                      from init/main.c:23:
												      /usr/src/atlas_linux/include/asm/timex.h:36: warning: implicit declaration of function `read_32bit_cp0_register'
												      /usr/src/atlas_linux/include/asm/timex.h:36: `CP0_COUNT' undeclared (first use this function)
												      /usr/src/atlas_linux/include/asm/timex.h:36: (Each undeclared identifier is reported only once
												      /usr/src/atlas_linux/include/asm/timex.h:36: for each function it appears in.)
												      make: *** [init/main.o] Error 1


--------------41664DF7B61187D49DBEE838
Content-Type: text/x-vcard; charset=us-ascii;
 name="octavp.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Nicu Popovici
Content-Disposition: attachment;
 filename="octavp.vcf"

begin:vcard 
n:POPOVICI;Nicolae Octavian 
tel;cell:+40 93 605020
x-mozilla-html:FALSE
org:SC Silicon Service SRL;Software
adr:;;;;;;
version:2.1
email;internet:octavp@isratech.ro
title:Software engineer
x-mozilla-cpt:;0
fn:Nicolae Octavian POPOVICI
end:vcard

--------------41664DF7B61187D49DBEE838--
