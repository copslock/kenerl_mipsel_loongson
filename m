Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Oct 2006 02:05:36 +0100 (BST)
Received: from web32213.mail.mud.yahoo.com ([68.142.207.144]:9838 "HELO
	web32213.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20037799AbWJRBFe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Oct 2006 02:05:34 +0100
Received: (qmail 49863 invoked by uid 60001); 18 Oct 2006 01:05:24 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=aTY9SFpj0JtiBnmW0oiNhTEyxohfqaa50Xt+7d2LAuC3cDEKcSpH7Z3sCB6qpxOrpf4z2BM0joIb6Kd17mPsDVt5Ldq6YlLu4rUhc9tUx3PKhrZ1TCa01ywhGbiPy3wpDxnpRtnbSHzs0v31nYioAADn6IEDfXUIAqmdnoFHXUU=  ;
Message-ID: <20061018010524.49858.qmail@web32213.mail.mud.yahoo.com>
Received: from [70.91.7.10] by web32213.mail.mud.yahoo.com via HTTP; Tue, 17 Oct 2006 18:05:24 PDT
Date:	Tue, 17 Oct 2006 18:05:24 -0700 (PDT)
From:	kas turi <inox_kas@yahoo.com>
Subject: insmod -m gives segmentation fault
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <inox_kas@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: inox_kas@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi
  I am having a loadable module driver_mod.o If I load
it without -m then the driver loads successfully. But
if I load it with -m I get Segmentation fault:
root@172.16.1.155:/home/modutils-2.4.27/insmod#
./insmod -m ../../driver_mod.o
Sections:       Size      Address   Align
.this           00000060  12340000  2**2
.text           00005570  12340060  2**4
.fixup          00000034  123455d0  2**0
.reginfo        00000018  12345604  2**2
.rodata         00001a90  12345620  2**4
__ex_table      00000028  123470b0  2**2
.kstrtab        0000067d  123470d8  2**0
__ksymtab       000003a8  12347758  2**2
__archdata      00000000  12347b00  2**4
.data           00000080  12347b00  2**4
.sbss           00002c58  12347b80  2**4
.bss            00000170  1234a7e0  2**4

Symbols:
Segmentation fault

I am using 2.4.27 version of insmod utility. The
loadable module is compiled with following options:
-mtune=r4600 -mips2 -fno-pic -mno-abicalls
-mlong-calls -fno-strict-aliasing  -D__KERNEL__
-DMODULE  -DLINUX -D_REENTRANT -g -O2 -fno-builtin
-Werror -Wall -Wpointer-arith -Wwrite-strings
-Wstrict-prototypes -Wuninitialized -Wswitch -Wcomment
-Wformat

Any idea why it is dumping core?

Thanks in advance
Kasturi



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
