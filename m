Received:  by oss.sgi.com id <S305156AbQDUCFF>;
	Thu, 20 Apr 2000 19:05:05 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:19491 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305155AbQDUCEt>;
	Thu, 20 Apr 2000 19:04:49 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id TAA13154; Thu, 20 Apr 2000 19:00:04 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA29413
	for linux-list;
	Thu, 20 Apr 2000 18:53:36 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA22214
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 20 Apr 2000 18:53:33 -0700 (PDT)
	mail_from (machida@sm.sony.co.jp)
Received: from ns4.sony.co.jp (ns4.Sony.CO.JP [202.238.80.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA07573
	for <linux@cthulhu.engr.sgi.com>; Thu, 20 Apr 2000 18:53:31 -0700 (PDT)
	mail_from (machida@sm.sony.co.jp)
Received: from mail2.sony.co.jp (gatekeeper7.Sony.CO.JP [202.238.80.21])
	by ns4.sony.co.jp (04/18/00) with ESMTP id KAB11051;
	Fri, 21 Apr 2000 10:53:23 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
	by mail2.sony.co.jp (3.7W99040614b) with ESMTP id KAA08404;
	Fri, 21 Apr 2000 10:53:21 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.27.209.5]) by smail1.sm.sony.co.jp (8.8.8/3.6W) with ESMTP id KAA12121; Fri, 21 Apr 2000 10:52:15 +0900 (JST)
Received: from mach0.sm.sony.co.jp (mach0.sm.sony.co.jp [43.27.210.135]) by imail.sm.sony.co.jp (8.8.8/3.7W) with ESMTP id KAA00633; Fri, 21 Apr 2000 10:52:26 +0900 (JST)
Received: from localhost by mach0.sm.sony.co.jp (8.8.8/FreeBSD) with ESMTP id KAA09369; Fri, 21 Apr 2000 10:52:25 +0900 (JST)
To:     kk@ddeorg.soft.net, flo@rfc822.org, ian@zembu.com
Cc:     binutils@sourceware.cygnus.com, linux@cthulhu.engr.sgi.com,
        debian-mips@lists.debian.org
Subject: Re: MIPS gas problem
In-Reply-To: <20000420164812.17210.qmail@daffy.airs.com>
References: <200004201207.RAA07021@madras.ddeorg.soft.net>
	<20000420164812.17210.qmail@daffy.airs.com>
X-Mailer: Mew version 1.94.1 on Emacs 19.34 / Mule 2.3 (SUETSUMUHANA)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20000421105225J.machida@sm.sony.co.jp>
Date:   Fri, 21 Apr 2000 10:52:25 +0900
From:   Hiroyuki Machida <machida@sm.sony.co.jp>
X-Dispatcher: imput version 990905(IM130)
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing



I rewrite the test program which is not depending your gcc version
or config. Please try this.


#define P1  10
#define P2  12
#define P1STR  "10"
#define P2STR  "12"
#define AL1 (2<<(P1-1))
#define AL2 (2<<(P2-1))

asm( 
"	.globl	globalc;\n"
"	.rdata;\n"
"	.type	 globalc,@object;\n"
"	.size	 globalc,1;\n"
"globalc:\n"
"	.byte	97;\n"
);

asm( 
"	.globl	global1;\n"
"	.align	" P1STR ";\n"
"	.type	 global1,@object;\n"
"	.size	 global1,4;\n"
"global1:\n"
"	.word	0;\n"
);

asm( 
"	.globl	global2;\n"
"	.align	" P2STR ";\n"
"	.type	 global2,@object;\n"
"	.size	 global2,4;\n"
"global2:\n"
"	.word	1;\n"
);


int total_ng=0;

void check(char *addr, unsigned long al)
{
        unsigned long mask = (al -1);
        if ((unsigned long) addr & mask){
                total_ng ++;
                printf("err:%x expected:%x\n", addr, 
				(unsigned long) addr & ~mask);
        }
}


int
main(void)
{
	extern int global1, global2;
	extern char globalc;

        printf("* readonly gloabl\n");
        printf("chcking align:%x\n",AL1);
        check((char *)&global1,AL1); 
        printf("%x\n", &global1);

        printf("chcking align:%x\n",AL2);
        check((char *)&global2,AL2); 
        printf("%x\n", &global2);

        printf("\n");
        if (total_ng) {
                printf("NG:%d\n",total_ng);
        } else {
                printf("OK\n");
        }
        printf("\n");
        return total_ng;

}
