Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA58A7111917
	for linux-mips-outgoing; Mon, 5 Nov 2001 00:10:07 -0800
Received: from smtp.huawei.com ([61.144.161.21])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA58A0011903
	for <linux-mips@oss.sgi.com>; Mon, 5 Nov 2001 00:10:00 -0800
Received: from hcdong11752a ([10.105.28.74]) by smtp.huawei.com
          (Netscape Messaging Server 4.15) with SMTP id GMBGV800.C8L for
          <linux-mips@oss.sgi.com>; Mon, 5 Nov 2001 15:30:45 +0800 
Message-ID: <013301c165cc$5d030fa0$4a1c690a@huawei.com>
From: "machael" <dony.he@huawei.com>
To: <linux-mips@oss.sgi.com>
Subject: vmalloc bugs in 2.4.5???
Date: Mon, 5 Nov 2001 15:34:44 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hello:
    I use linux-2.4.5 and I think VMALLOC may have some bugs which i don't
know how to fixup.
    I try to replace some kernel functions with my own implementations.I
will explain it in the following:
    Let's say:
        void (*my_func)(void)=func1;
     where "my_func" is a function pointer defined in kernel, and "func1" is
 a function(void func1(void)) implemented in kernel.And "my_func" is an
 EXPORTED SYMBOL in mips_ksyms.c.

    Now I want to replace "func1" with my own "func2" in a module
 my_module.o:
     extern void (*my_func)(void);
     my_func = func2;
     where "func2" is a function (void fun2(void)) implemented in
 "my_module.o".

     If I do "insmod my_module.o", the kernel should run OK. In fact, it is
 often met an "unhandled kernel unaligned access" or "do_page_fault"
 exception and then panics.

     We know "func1" should be in KSEG0(unmapped , cached) ,So it's address
should be 0x8XXXXXXX.And "my_func" should also pointed to this same address
before inserting
 my_module.o.  "func2" should be in KSEG2(mapped, cached) since it is
 implemented in module, So it's address should be 0xCXXXXXXX.After inserting
 my_module.o, "my_func" should be changed to pointed to this new address in
 KSEG2. But kernel panics......
    If I change "module_map()" in include/asm/module.h from vmalloc to
kmalloc, kernel runs ok after inserting my module. So I think vmalloc may
have some bugs.

    Anyone knows how to fixup it?

    machael
