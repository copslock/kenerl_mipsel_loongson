Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 May 2003 09:28:41 +0100 (BST)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:36358 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8225196AbTEAI2j>;
	Thu, 1 May 2003 09:28:39 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.11.6/8.11.6) with ESMTP id h418RoD29377;
	Thu, 1 May 2003 04:27:50 -0400
Received: from redhat.com (IDENT:y6RMD+R7Tdq3XkYrX2sKatLSNiJ11hpr@vpn50-7.rdu.redhat.com [172.16.50.7])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id h418Rnq19269;
	Thu, 1 May 2003 04:27:49 -0400
Received: (from aph@localhost)
	by redhat.com (8.11.6/8.11.0) id h418Rid05801;
	Thu, 1 May 2003 09:27:44 +0100
From: Andrew Haley <aph@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16048.55936.346808.522687@cuddles.redhat.com>
Date: Thu, 1 May 2003 09:27:44 +0100
To: Fuxin Zhang <fxzhang@ict.ac.cn>
Cc: MAKE FUN PRANK CALLS <linux-mips@linux-mips.org>, gcc@gcc.gnu.org
Subject: GCC -O2 failure for mipsel
In-Reply-To: <3EB0B329.9030603@ict.ac.cn>
References: <3EB0B329.9030603@ict.ac.cn>
X-Mailer: VM 7.14 under Emacs 21.2.1
Return-Path: <aph@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2240
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aph@redhat.com
Precedence: bulk
X-list: linux-mips

Fuxin Zhang writes:
 > Hello,
 > I've met a case where mipsel-linux-gcc -O2 fails,for both
 > 2.96 and the fresh new 3.2.3. Maybe someone can tell me
 > what's wrong.

Your code is incorrect.

 > I've reduced the problem to the test case below,compile it
 > with mipsel-linux-gcc -O2(FROM H.J.Lu's redhat miniport,all version,
 > and 3.2.3 is tested too)
 > 
 > 
 > #define PUT_CODE(x,code) ((x)->code = (code))
 > union test_union {
 > struct test *t;
 > int a;
 > };
 > 
 > struct test {
 > unsigned short code;
 > union test_union u[1];
 > };
 > 
 > char memory[2000];
 > 
 > struct test *test_alloc(int code)
 > {
 > struct test *t;
 > int length=sizeof(struct test);
 > 
 > t = (struct test*)memory;
 > length = (sizeof(struct test) - sizeof(union test_union)-1)/sizeof(int);
 > for (;length>=0;length--)

This is the errant line:

 > ((int*)t)[length] = 0;

You have declared t as a pointer to struct test, but you're using it
as a pointer to int.  If you look at Pointers, Section 6.2.2.3 in ISO
9899-1990 you'll see that this results in undefined behaviour.

-fno-strict-aliasing should generate the code you want, but it's
better to fix your source.  If you want to use a pointer as a
different type, put it in a union.

Andrew.
