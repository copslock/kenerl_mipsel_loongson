Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f487bk304704
	for linux-mips-outgoing; Tue, 8 May 2001 00:37:46 -0700
Received: from mailgw2.netvision.net.il (mailgw2.netvision.net.il [194.90.1.9])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f487beF04697;
	Tue, 8 May 2001 00:37:41 -0700
Received: from jungo.com ([194.90.113.98])
	by mailgw2.netvision.net.il (8.9.3/8.9.3) with ESMTP id KAA18759;
	Tue, 8 May 2001 10:39:16 +0300 (IDT)
Message-ID: <3AF7A202.6060705@jungo.com>
Date: Tue, 08 May 2001 10:36:34 +0300
From: Michael Shmulevich <michaels@jungo.com>
Organization: Jungo LTD
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-21mdk i686; en-US; 0.8.1) Gecko/20010326
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: Ian Thompson <iant@palmchip.com>, linux-mips@oss.sgi.com
Subject: Re: binutils 2.8.1 problems
References: <3AF098B7.F111B230@palmchip.com> <20010505145344.B1252@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> So then is a binutils and not a compiler problem.  What binutils are you
> using?  Binutils 2.8.1 which I'm still recommending (mostly to avoid
> sending people into a maze of version dependencies) is getting dated and
> the bug may well have been fixed in the meantime.

I have met a weird bug in binutils 2.8.1 on mips lately: when using 
".weak" directive in some module which make use of the same asliased 
symbol, during linkage the symbol doesn't get relocated to a "strong" 
symbol:

----------------------
in foo.c:
----------------------
extern void bar();

void foo(){
  printf("A\n");
}
__asm__(".weak bar; bar = foo");

void f1(){
   bar();
}

-----------------------
in bar.c:
----------------------
void bar(){
   printf("B\n");
}
----------------------
in main.c:
----------------------
extern void bar();
extern void f1();

int main(){
  f1();
  bar();
}
-----------------------

This code produce printout of
A
B
since f1() always calls foo() no matter that bar() is defined outside.
AFIAIK, there is no ".weakext" macro in 2.8.1.

Using objdump on foo.o I see there is no relocation entry for bar, 
however using gas-2.10 on exactly same assembly does produce relocation 
entry. So it must definitely be a "gas" problem.

Sincerely yours,
Michael Shmulevich
______________________________________
Software Developer
Jungo - R&D
email: michaels@jungo.com
web: http://www.jungo.com
Phone: 1-877-514-0537(USA)  +972-9-8859365(Worldwide) ext. 233
Fax:   1-877-514-0538(USA)  +972-9-8859366(Worldwide)
