Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 May 2003 09:42:19 +0100 (BST)
Received: from [IPv6:::ffff:159.226.39.4] ([IPv6:::ffff:159.226.39.4]:23168
	"HELO mail.ict.ac.cn") by linux-mips.org with SMTP
	id <S8225196AbTEAImR>; Thu, 1 May 2003 09:42:17 +0100
Received: (qmail 4954 invoked from network); 1 May 2003 08:16:27 -0000
Received: from unknown (HELO ict.ac.cn) (159.226.40.150)
  by 159.226.39.4 with SMTP; 1 May 2003 08:16:27 -0000
Message-ID: <3EB0DDC6.5080108@ict.ac.cn>
Date: Thu, 01 May 2003 16:41:42 +0800
From: Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030206
X-Accept-Language: zh-cn, en-us, en
MIME-Version: 1.0
To: Andrew Haley <aph@redhat.com>
CC: MAKE FUN PRANK CALLS <linux-mips@linux-mips.org>, gcc@gcc.gnu.org
Subject: Re: GCC -O2 failure for mipsel
References: <3EB0B329.9030603@ict.ac.cn> <16048.55936.346808.522687@cuddles.redhat.com>
In-Reply-To: <16048.55936.346808.522687@cuddles.redhat.com>
Content-Type: text/plain; charset=gb18030; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2241
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

 Thanks, -fno-strict-aliasing works.
--The actual code can't be changed: because it is part of spec cpu2000:)

Andrew Haley wrote:

>Fuxin Zhang writes:
> > Hello,
> > I've met a case where mipsel-linux-gcc -O2 fails,for both
> > 2.96 and the fresh new 3.2.3. Maybe someone can tell me
> > what's wrong.
>
>Your code is incorrect.
>
> > I've reduced the problem to the test case below,compile it
> > with mipsel-linux-gcc -O2(FROM H.J.Lu's redhat miniport,all version,
> > and 3.2.3 is tested too)
> > 
> > 
> > #define PUT_CODE(x,code) ((x)->code = (code))
> > union test_union {
> > struct test *t;
> > int a;
> > };
> > 
> > struct test {
> > unsigned short code;
> > union test_union u[1];
> > };
> > 
> > char memory[2000];
> > 
> > struct test *test_alloc(int code)
> > {
> > struct test *t;
> > int length=sizeof(struct test);
> > 
> > t = (struct test*)memory;
> > length = (sizeof(struct test) - sizeof(union test_union)-1)/sizeof(int);
> > for (;length>=0;length--)
>
>This is the errant line:
>
> > ((int*)t)[length] = 0;
>
>You have declared t as a pointer to struct test, but you're using it
>as a pointer to int.  If you look at Pointers, Section 6.2.2.3 in ISO
>9899-1990 you'll see that this results in undefined behaviour.
>
>-fno-strict-aliasing should generate the code you want, but it's
>better to fix your source.  If you want to use a pointer as a
>different type, put it in a union.
>
>Andrew.
>
>
>  
>
