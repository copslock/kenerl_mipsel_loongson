Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 May 2010 07:33:51 +0200 (CEST)
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:49060 "HELO
        na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491768Ab0EYFdh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 May 2010 07:33:37 +0200
Received: from source ([209.85.214.176]) by na3sys009aob101.postini.com ([74.125.148.12]) with SMTP
        ID DSNKS/thLldId/a1vE0LgAgt0SYVIggLCeit@postini.com; Mon, 24 May 2010 22:33:36 PDT
Received: by iwn3 with SMTP id 3so4354141iwn.35
        for <linux-mips@linux-mips.org>; Mon, 24 May 2010 22:33:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.231.148.130 with SMTP id p2mr6959439ibv.11.1274765614631; Mon, 
        24 May 2010 22:33:34 -0700 (PDT)
Received: by 10.231.174.73 with HTTP; Mon, 24 May 2010 22:33:34 -0700 (PDT)
In-Reply-To: <1274445001.9403.5.camel@localhost>
References: <AANLkTikrUGzUykZJwoK3Jq9mEJa6l35jo5DXHae3vbIG@mail.gmail.com>
         <1274445001.9403.5.camel@localhost>
Date:   Tue, 25 May 2010 10:33:34 +0500
Message-ID: <AANLkTim5dn4o3pImEkr21h8ulf4TaOzWUUdhRr0cWHJQ@mail.gmail.com>
Subject: Re: MIPS/Linux assembly issue
From:   adnan iqbal <adnan.iqbal@seecs.edu.pk>
To:     wuzhangjin@gmail.com
Cc:     linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=0016e643594aa1ccdf0487647f22
Return-Path: <adnan.iqbal@seecs.edu.pk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adnan.iqbal@seecs.edu.pk
Precedence: bulk
X-list: linux-mips

--0016e643594aa1ccdf0487647f22
Content-Type: text/plain; charset=ISO-8859-1

Dear Wu and Arnaud

Many many thanx for your help. Because of your help, i have been able to do
the following.

1. Write an assembly program for octeon which starts with a routine __start.
2. Extend this program such that it calls a function written in C which
resides in another file compiled separately but linked statically to make
one executable.
Essentialy i use following sequence of commands for compilation and linking

$as hello2.s -o hello2.o

$gcc -c c_func.c -o c_func.o

$gcc -O2 -g -Wall -Wmissing-prototypes -Wshadow -Wpointer-arith
-Wstrict-prototypes -Wmissing-declarations -Wno-format-zero-length
-fno-strict-aliasing -Wno-long-long -Wno-pointer-sign
-Wdeclaration-after-statement -fno-stack-protector -static
-Wl,-defsym,valt_load_address=0x40000000 -nodefaultlibs -nostartfiles -u
start -Wl,-T,valt_load_address_mips64_linux.lds  -o hello2 hello2.o c_func.o
-lgcc

All this is great but i need to do a bit more. I have to write a c program
which has entry point  __start written in inline-assembly and makes use of c
functions (and global data ) defined in same file. I wrote a program for
this purpose and tried to compile and link it using different methods but it
did not work. The program compiles but gives a segmentation fault. Below is
the code for the program.

The code of hello_in_c.c
-----------------------------------
int f1()
{
//called
return 0;
}

asm(
".text\n"
".globl __start\n"
".ent __start \n"
"__start: \n"
   "\t.set noreorder \n"
   "\t.cpload $gp\n"
   "\t.set reorder\n"
   "\tli $4, 1\n"
   "\tla $5, stradr \n"
   "\tlw $6, strlen\n"
   "\tli $2, 4004\n"
   "\tsyscall\n"
   "\tjal f1\n"
   "\tmove $4, $0\n"
   "\tli $2, 4001\n"
   "\tsyscall\n"
".end __start\n"
"\t.rdata\n"
"stradr: .asciiz  \"hello, world!\\n\"\n"
"strlen: .word . - stradr"
);
-----------------------------------------------------------------
thank you for your previous help and hope to get more from you.

Regards
Adnan





On Fri, May 21, 2010 at 5:30 PM, Wu Zhangjin <wuzhangjin@gmail.com> wrote:

> Hi,
>
> Just found Arnaud have explained the problems, so here give you an
> example I have written one year ago:
>
> # File: hello.s -- Say Hello to MIPS Assembly Language Programmer
> # Author: falcon <wuzhangjin@gmail.com>, 2009/01/17
> # Ref:
> #    [*] http://www.tldp.org/HOWTO/Assembly-HOWTO/mips.html
> #    [*] MIPS Assembly Language Programmer's Guide
> #    [*] See MIPS Run Linux(second version)
> # Compile:
> #       $ gcc -o hello hello.s
> #       or
> #       $ as -o hello.o hello.s
> #       $ ld -e main -o hello hello.o
>
>    .text
>    .globl main
> main:
>
>    .set noreorder
>    .cpload $gp       # setup the pointer to global data
>    .set reorder
>                      # print sth. via sys_write
>    li $a0, 1         # print to standard ouput
>    la $a1, stradr    # set the string address
>    lw $a2, strlen    # set the string length
>    li $v0, 4004      # index of sys_write:
>                      # __NR_write in /usr/include/asm/unistd.h
>    syscall           # causes a system call trap.
>
>                      # exit via sys_exit
>    move $a0, $0      # exit status as 0
>    li $v0, 4001      # index of sys_exit
>                      # __NR_exit in /usr/include/asm/unistd.h
>    syscall
>
>    .rdata
> stradr: .asciiz "hello, world!\n"
> strlen: .word . - stradr  # current address - the string address
> # end
>
> Regards,
>         Wu Zhangjin
>
> On Fri, 2010-05-21 at 16:46 +0500, adnan iqbal wrote:
> > Hi all,
> >
> > I am trying to compile/link/execute following very simple program in
> > debian/MIPS (Tried on Qemu and Octeon). I am getting errors while
> > executing the program. gdb also shows a strange behavior showing
> > program entrypoint somehere in data segement. Any help getting this
> > sorted out shall be appreciated.
> >
> > Regards
> > Adnan
> >
> > Commands used to compile/link
> > ----------------------------------------------------
> > $ as hello.s -o hello.o
> > $ld hello.o -o hello
> > $ ./hello
> >
> >
> > The code
> > ---------------
> >       .data
> > str:
> >         .asciiz "hello world\n"
> >         .text
> >         .globl __start
> >
> > __start:
> >         jal f2
> >         la $4,str
> >         li $2,4
> >         syscall
> >
> >         ## terminate program via _exit () system call
> >         li $2, 10
> >         syscall
> > f2:
> >         add $8,$8,$0
> >         jr $31
> >
>
>
>

--0016e643594aa1ccdf0487647f22
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dear Wu and Arnaud<br><br>Many many thanx for your help. Because of your he=
lp, i have been able to do the following.<br><br>1. Write an assembly progr=
am for octeon which starts with a routine __start.<br>2. Extend this progra=
m such that it calls a function written in C which resides in another file =
compiled separately but linked statically to make one executable.<br>
Essentialy i use following sequence of commands for compilation and linking=
<br><br>$as hello2.s -o hello2.o<br><br>$gcc -c c_func.c -o c_func.o <br><b=
r>$gcc -O2 -g -Wall -Wmissing-prototypes -Wshadow -Wpointer-arith -Wstrict-=
prototypes -Wmissing-declarations -Wno-format-zero-length -fno-strict-alias=
ing -Wno-long-long -Wno-pointer-sign -Wdeclaration-after-statement -fno-sta=
ck-protector -static -Wl,-defsym,valt_load_address=3D0x40000000 -nodefaultl=
ibs -nostartfiles -u start -Wl,-T,valt_load_address_mips64_linux.lds=A0 -o =
hello2 hello2.o c_func.o -lgcc<br>
<br>All this is great but i need to do a bit more. I have to write a c prog=
ram which has entry point=A0 __start written in inline-assembly and makes u=
se of c functions (and global data ) defined in same file. I wrote a progra=
m for this purpose and tried to compile and link it using different methods=
 but it did not work. The program compiles but gives a segmentation fault. =
Below is the code for the program.<br>
<br>The code of hello_in_c.c<br>-----------------------------------<br>int =
f1()<br>{<br>//called<br>return 0;<br>}<br><br>asm(<br>&quot;.text\n&quot;<=
br>&quot;.globl __start\n&quot;<br>&quot;.ent __start \n&quot;<br>&quot;__s=
tart: \n&quot;<br>
=A0=A0 &quot;\t.set noreorder \n&quot;<br>=A0=A0 &quot;\t.cpload $gp\n&quot=
;<br>=A0=A0 &quot;\t.set reorder\n&quot;<br>=A0=A0 &quot;\tli $4, 1\n&quot;=
<br>=A0=A0 &quot;\tla $5, stradr \n&quot;<br>=A0=A0 &quot;\tlw $6, strlen\n=
&quot;<br>=A0=A0 &quot;\tli $2, 4004\n&quot;<br>
=A0=A0 &quot;\tsyscall\n&quot;<br>=A0=A0 &quot;\tjal f1\n&quot;<br>=A0=A0 &=
quot;\tmove $4, $0\n&quot;<br>=A0=A0 &quot;\tli $2, 4001\n&quot;<br>=A0=A0 =
&quot;\tsyscall\n&quot;<br>&quot;.end __start\n&quot;<br>&quot;\t.rdata\n&q=
uot;<br>&quot;stradr: .asciiz=A0 \&quot;hello, world!\\n\&quot;\n&quot;<br>
&quot;strlen: .word . - stradr&quot;<br>);<br>-----------------------------=
------------------------------------<br>thank you for your previous help an=
d hope to get more from you.<br><br>Regards<br>Adnan<br><br><br><br><br>
<br><div class=3D"gmail_quote">On Fri, May 21, 2010 at 5:30 PM, Wu Zhangjin=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:wuzhangjin@gmail.com">wuzhangjin@g=
mail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">
Hi,<br>
<br>
Just found Arnaud have explained the problems, so here give you an<br>
example I have written one year ago:<br>
<br>
# File: hello.s -- Say Hello to MIPS Assembly Language Programmer<br>
# Author: falcon &lt;<a href=3D"mailto:wuzhangjin@gmail.com">wuzhangjin@gma=
il.com</a>&gt;, 2009/01/17<br>
# Ref:<br>
# =A0 =A0[*] <a href=3D"http://www.tldp.org/HOWTO/Assembly-HOWTO/mips.html"=
 target=3D"_blank">http://www.tldp.org/HOWTO/Assembly-HOWTO/mips.html</a><b=
r>
# =A0 =A0[*] MIPS Assembly Language Programmer&#39;s Guide<br>
# =A0 =A0[*] See MIPS Run Linux(second version)<br>
# Compile:<br>
# =A0 =A0 =A0 $ gcc -o hello hello.s<br>
# =A0 =A0 =A0 or<br>
# =A0 =A0 =A0 $ as -o hello.o hello.s<br>
# =A0 =A0 =A0 $ ld -e main -o hello hello.o<br>
<br>
 =A0 =A0.text<br>
 =A0 =A0.globl main<br>
main:<br>
<br>
 =A0 =A0.set noreorder<br>
 =A0 =A0.cpload $gp =A0 =A0 =A0 # setup the pointer to global data<br>
 =A0 =A0.set reorder<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# print sth. via sys_write<br>
 =A0 =A0li $a0, 1 =A0 =A0 =A0 =A0 # print to standard ouput<br>
 =A0 =A0la $a1, stradr =A0 =A0# set the string address<br>
 =A0 =A0lw $a2, strlen =A0 =A0# set the string length<br>
 =A0 =A0li $v0, 4004 =A0 =A0 =A0# index of sys_write:<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# __NR_write in /usr/include/as=
m/unistd.h<br>
 =A0 =A0syscall =A0 =A0 =A0 =A0 =A0 # causes a system call trap.<br>
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# exit via sys_exit<br>
 =A0 =A0move $a0, $0 =A0 =A0 =A0# exit status as 0<br>
 =A0 =A0li $v0, 4001 =A0 =A0 =A0# index of sys_exit<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# __NR_exit in /usr/include/asm=
/unistd.h<br>
 =A0 =A0syscall<br>
<br>
 =A0 =A0.rdata<br>
stradr: .asciiz &quot;hello, world!\n&quot;<br>
strlen: .word . - stradr =A0# current address - the string address<br>
# end<br>
<br>
Regards,<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0Wu Zhangjin<br>
</font><div><div></div><div class=3D"h5"><br>
On Fri, 2010-05-21 at 16:46 +0500, adnan iqbal wrote:<br>
&gt; Hi all,<br>
&gt;<br>
&gt; I am trying to compile/link/execute following very simple program in<b=
r>
&gt; debian/MIPS (Tried on Qemu and Octeon). I am getting errors while<br>
&gt; executing the program. gdb also shows a strange behavior showing<br>
&gt; program entrypoint somehere in data segement. Any help getting this<br=
>
&gt; sorted out shall be appreciated.<br>
&gt;<br>
&gt; Regards<br>
&gt; Adnan<br>
&gt;<br>
&gt; Commands used to compile/link<br>
&gt; ----------------------------------------------------<br>
&gt; $ as hello.s -o hello.o<br>
&gt; $ld hello.o -o hello<br>
&gt; $ ./hello<br>
&gt;<br>
&gt;<br>
&gt; The code<br>
&gt; ---------------<br>
&gt; =A0 =A0 =A0 .data<br>
&gt; str:<br>
&gt; =A0 =A0 =A0 =A0 .asciiz &quot;hello world\n&quot;<br>
&gt; =A0 =A0 =A0 =A0 .text<br>
&gt; =A0 =A0 =A0 =A0 .globl __start<br>
&gt;<br>
&gt; __start:<br>
&gt; =A0 =A0 =A0 =A0 jal f2<br>
&gt; =A0 =A0 =A0 =A0 la $4,str<br>
&gt; =A0 =A0 =A0 =A0 li $2,4<br>
&gt; =A0 =A0 =A0 =A0 syscall<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 ## terminate program via _exit () system call<br>
&gt; =A0 =A0 =A0 =A0 li $2, 10<br>
&gt; =A0 =A0 =A0 =A0 syscall<br>
&gt; f2:<br>
&gt; =A0 =A0 =A0 =A0 add $8,$8,$0<br>
&gt; =A0 =A0 =A0 =A0 jr $31<br>
&gt;<br>
<br>
<br>
</div></div></blockquote></div><br>

--0016e643594aa1ccdf0487647f22--
