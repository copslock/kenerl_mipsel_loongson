Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 May 2003 06:40:31 +0100 (BST)
Received: from [IPv6:::ffff:159.226.39.4] ([IPv6:::ffff:159.226.39.4]:33515
	"HELO mail.ict.ac.cn") by linux-mips.org with SMTP
	id <S8225196AbTEAFk3>; Thu, 1 May 2003 06:40:29 +0100
Received: (qmail 8814 invoked from network); 1 May 2003 05:14:39 -0000
Received: from unknown (HELO ict.ac.cn) (159.226.40.150)
  by 159.226.39.4 with SMTP; 1 May 2003 05:14:39 -0000
Message-ID: <3EB0B329.9030603@ict.ac.cn>
Date: Thu, 01 May 2003 13:39:53 +0800
From: Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030206
X-Accept-Language: zh-cn, en-us, en
MIME-Version: 1.0
To: MAKE FUN PRANK CALLS <linux-mips@linux-mips.org>, gcc@gcc.gnu.org
Subject: GCC -O2 failure for mipsel
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2239
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

Hello,
I've met a case where mipsel-linux-gcc -O2 fails,for both
2.96 and the fresh new 3.2.3. Maybe someone can tell me
what's wrong.

I've reduced the problem to the test case below,compile it
with mipsel-linux-gcc -O2(FROM H.J.Lu's redhat miniport,all version,
and 3.2.3 is tested too)


#define PUT_CODE(x,code) ((x)->code = (code))
union test_union {
struct test *t;
int a;
};

struct test {
unsigned short code;
union test_union u[1];
};

char memory[2000];

struct test *test_alloc(int code)
{
struct test *t;
int length=sizeof(struct test);

t = (struct test*)memory;
length = (sizeof(struct test) - sizeof(union test_union)-1)/sizeof(int);
for (;length>=0;length--)
((int*)t)[length] = 0;

PUT_CODE(t,code);

return t;
}

int main()
{
struct test *t;

t = test_alloc(4);

printf("t->code=%d\n",t->code);
}


Problem happens in test_alloc:

00400890 <test_alloc>:
400890: 3c1c0fc0 lui gp,0xfc0
400894: 279c77b0 addiu gp,gp,30640
400898: 0399e021 addu gp,gp,t9
40089c: 8f828054 lw v0,-32684(gp)
4008a0: 8f818054 lw at,-32684(gp)
4008a4: 00000000 nop
4008a8: a4240000 sh a0,0(at)
4008ac: 03e00008 jr ra
4008b0: ac400000 sw zero,0(v0)
--->the last sw is wrong,it should not be reorder to run later than 4008a8.

And gcc experts will find this is a simplfied case of rtx_alloc:).
Yes,the failure
shows up when i try to compile SPEC CPU2000 176.gcc with -O2. The const0_rtx
's code will be set to zero like above.

Thank you in advance.


Regards
