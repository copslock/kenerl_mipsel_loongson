Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0K4IUo15369
	for linux-mips-outgoing; Sat, 19 Jan 2002 20:18:30 -0800
Received: from smtp.huawei.com ([61.144.161.21])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0K4IKP15365
	for <linux-mips@oss.sgi.com>; Sat, 19 Jan 2002 20:18:20 -0800
Received: from r19223c ([172.17.254.1]) by smtp.huawei.com
          (Netscape Messaging Server 4.15) with SMTP id GQ7VR500.E12; Sun,
          20 Jan 2002 11:16:17 +0800 
Message-ID: <001301c1a160$d2fe5460$3d6e0b0a@huawei.com>
From: "renc stone" <renwei@huawei.com>
To: "Kevin D. Kissell" <kevink@mips.com>, <linux-mips@oss.sgi.com>
References: <025901c1a0c4$30ec20e0$3d6e0b0a@huawei.com> <003601c1a138$868fdc20$0deca8c0@Ulysses>
Subject: Re: use float in no-fpu mips kernel modules?
Date: Sun, 20 Jan 2002 11:16:16 +0800
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


> >   Any one know how to use float point in mips kernel?
> >   We use some 2.4.5 kernel, on idt mips 32334, which has no fpu, I
think.
> >   we want to use the float numbers like this:
> >   float a = 87;
> >   a * = 1.04;
> >   Any kernel functions to do this? or how to compile it use soft fpu
> > support?
>
> The way I integrated the Algorithmics FPU emulaton
> code into the kernel *used* to work for kernel FP.
> Maybe someone has broken it since, and there may
> well be situations where it was unsafe, but have you
> tried simply confuguring FPU emulation and running
> your code with it?
>

I have checked it, the FPU  support is in the kernel.
My kernel can't boot without the FPU emulation support.

that's the module code:
#################
float a = 1.03;
double  b = 1.05;

int init_module (void)
{

    a = 39 * a;
    b /= 34*(1.01 + a);

    printk("\nthe result is : %f", b);
    return 0;

}


void cleanup_module (void)
{
    return;
}
######################

insmod this module to the kernel, kernel will report

[insmod:25] Illegal instruction 81700000 at 8170007c ra=80017fac
...


I look  into the module's code,
and that's inst(objdump):

40:   d4240008        0xd4240008
...
1c:   d4240128        0xd4240128
...
74:   f4240008        0xf4240008
...

these are in .text section.
The other mfc1, swc1 inst in code are ok.

Then I try to use soft float .
compile like this:
 mipsel-linux-gdb   ..... -msoft-float ... -o fp_tmp.o -c fp.c
mipsel-linux-ld -r -EL -static -L/opt/Embdeix/tools/mipsel-linux/lib
-lm -o fp.o fp_tmp.o

(I use lineo's Embedix SDK2.0)

and when insmod  fp1.o , U comes:
fp.o: unresolved symbol dpadd
fp.o: unresolved symbol fpmul
fp.o: unresolved symbol fptodp
fp.o: unresolved symbol dpmul
fp.o: unresolved symbol dpdiv

the gcc's maual says in mips when use -msoftfloat ,
should get some special-compiled lib routines.
Is that dpadd, fpmul ,etc?
How to get that special-compiled lib?
