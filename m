Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jul 2004 23:22:46 +0100 (BST)
Received: from web40007.mail.yahoo.com ([IPv6:::ffff:66.218.78.25]:44198 "HELO
	web40007.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8224949AbUGOWWl>; Thu, 15 Jul 2004 23:22:41 +0100
Message-ID: <20040715222234.16094.qmail@web40007.mail.yahoo.com>
Received: from [63.87.1.243] by web40007.mail.yahoo.com via HTTP; Thu, 15 Jul 2004 15:22:34 PDT
Date: Thu, 15 Jul 2004 15:22:34 -0700 (PDT)
From: Song Wang <wsonguci@yahoo.com>
Subject: asm-mips/processor.h breaks compiling user applications such as iptables
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <wsonguci@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wsonguci@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi, Ralf

I am building the latest iptables-1.2.11 against
linux-mips kernel 2.6.6.

When compiling extensions/libipt_state.c

#mips-linux-uclibc-gcc -s -Os -Wall -Wunused
-I/mipslinux2.6.6/linux/include -Iinclude/
-DIPTABLES_VERSION=\"1.2.11\"  -DNO_SHARED_LIBS=1
-D_INIT=ipt_state_init -c -o extensions/libipt_state.o
extensions/libipt_state.c

I got error

In file included from
/mipslinux2.6.6/linux/include/linux/spinlock.h:16,
                 from
/mipslinux2.6.6/linux/include/asm/atomic.h:21,
                 from
/mipslinux2.6.6/linux/include/linux/netfilter_ipv4/ip_conntrack.h:11,
                 from extensions/libipt_state.c:8:
/mipslinux2.6.6/linux/include/asm/processor.h:146:
error: parse error before "fpureg_t"
/mipslinux2.6.6/linux/include/asm/processor.h:146:
warning: type defaults to `int' in declaration of
`fpureg_t'
/mipslinux2.6.6/linux/include/asm/processor.h:146:
warning: data definition has no type or storage class
/mipslinux2.6.6/linux/include/asm/processor.h:149:
error: parse error before "fpureg_t"
/mipslinux2.6.6/linux/include/asm/processor.h:149:
warning: no semicolon at end of struct or union
/mipslinux2.6.6/linux/include/asm/processor.h:151:
error: parse error before '}' token
/mipslinux2.6.6/linux/include/asm/processor.h:161:
error: parse error before "fpureg_t"
/mipslinux2.6.6/linux/include/asm/processor.h:161:
warning: no semicolon at end of struct or union
/mipslinux2.6.6/linux/include/asm/processor.h:163:
error: parse error before '}' token
/mipslinux2.6.6/linux/include/asm/processor.h:166:
error: field `hard' has incomplete type
/mipslinux2.6.6/linux/include/asm/processor.h:167:
error: field `soft' has incomplete type
make[1]: *** [extensions/libipt_state.o] Error 1


I think the error is due to the line 146

typedef u64 fpureg_t;

The type 'u64' is defined in asm-mips/types.h, but
wrapped by #ifdef __KERNEL__, so when the compiler
compiles the user-level application, it cannot
recognize u64.

-Song





		
__________________________________
Do you Yahoo!?
Yahoo! Mail Address AutoComplete - You start. We finish.
http://promotions.yahoo.com/new_mail 
