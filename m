Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2006 10:14:29 +0200 (CEST)
Received: from web38407.mail.mud.yahoo.com ([209.191.125.38]:5784 "HELO
	web38407.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133411AbWEXIOT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 May 2006 10:14:19 +0200
Received: (qmail 90335 invoked by uid 60001); 24 May 2006 08:14:06 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=lloqjMsfgmzJptopL47IJeirYrqj+rjKsrP/t/9tgQf6FVDeDgI34LIPOvLPp+plLZ7zFq5fMmcatG3zN7TOS2ia82DLjZkTlctXZ+JZi++CZ5dPKTb9X6MdJl6c+hV3UILdWftIqvQwZiZmWdNH7gEu7c2MaehzsuOIusLzFy0=  ;
Message-ID: <20060524081406.90333.qmail@web38407.mail.mud.yahoo.com>
Received: from [203.92.57.132] by web38407.mail.mud.yahoo.com via HTTP; Wed, 24 May 2006 01:14:06 PDT
Date:	Wed, 24 May 2006 01:14:06 -0700 (PDT)
From:	ashley jones <ashley_jones_2000@yahoo.com>
Subject: Re: Can't debug core files with GDB
To:	Tony Lin <lin.tony@gmail.com>, Daniel Jacobowitz <dan@debian.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <404548f40605171139i67084776pd9ae7c34ec19ec95@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-825593055-1148458446=:89965"
Content-Transfer-Encoding: 8bit
Return-Path: <ashley_jones_2000@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashley_jones_2000@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-825593055-1148458446=:89965
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

hi,
          where are you running your GDB ? on i386 ? then i guess you shouldnt specify --host=mips-linux. just run .configure script and specify only target as mips-linux.
   
  Regards,
  A'Jones.


Tony Lin <lin.tony@gmail.com> wrote:
  Objdump didn't yield any useful information, perhaps I didn't set the
flags correctly to show all the private registers.

You may be right about the kernel generated core file though. I
checked the registerd in gdb, everything looks good except the program
counter was zero. I then modified the mips kernel to spit out the
registers when doing the coredump. A valid pc (0x4008c0) was there
when doing fs/exec.c:do_coredump()

printks from do_coredump()
-----------
bash-2.05a# killall -SIGSEGV nebtest
1:<6>

printing contents of pt_regs *regs
1:<6>cp0_status 0xdc13
1:<6>lo 0x0
1:<6>hi 0x0
1:<6>cp0_badvaddr 0x803fbda0
1:<6>cp0_cause 0x10801000
1:<6>cp0_epc 0x4008c0


Calling 'info registers' in gdb coredump
----------------------
Reading symbols from /lib/ld.so.1...done.
Loaded symbols for /lib/ld.so.1
#0 0x00000000 in ?? ()
(gdb) info registers
zero at v0 v1 a0 a1 a2 a3
R0 00000000 1000dc00 0000000f 00000000 0000000f 2aac1000 0000000f 00000000
t0 t1 t2 t3 t4 t5 t6 t7
R8 00000000 00000001 00000003 49276d20 68697320 00000000 00000000 7468656e
s0 s1 s2 s3 s4 s5 s6 s7
R16 2ab00230 7fff7e64 2ad09f50 004008d0 00000001 004007dc 00000000 1001f328
t8 t9 k0 k1 gp sp s8 ra
R24 00000003 00000000 fbad2a84 00000000 10008040 7fff7de0 7fff7de0 00400898
sr lo hi bad cause pc
10801000 0000dc13 00000000 803fbda0 004008c0 00000000
fsr fir
00000000 00000000
(gdb)

(gdb) x/32 0x4008c0
0x4008c0 : 0x1000ffff 0x00000000 0x00000000
0x00000000
0x4008d0 <__libc_csu_init>: 0x3c1c0fc0 0x279c7770
0x0399e021 0x27bdffd8
0x4008e0 <__libc_csu_init+16>: 0xafbf0020 0xafb1001c
0xafb00018 0xafbc0010
0x4008f0 <__libc_csu_init+32>: 0x8f998054 0x00000000
0x0320f809 0x00000000
0x400900 <__libc_csu_init+48>: 0x8fbc0010 0x8f838034
0x8f828040 0x00431023



The 0x4008c0 address doesn't look half bad, pointing within main(). So
it looks like the mips kernel had all the right registers values but
just didn't format it correctly in the core dump? It wrote the pc into
cause, cause into sr, and cp0_status into lo.


Thanks much,
- Tony

On 5/17/06, Daniel Jacobowitz wrote:
> Check the contents of the core file with objdump? I recall seeing at
> least one recent MIPS kernel which failed to save registers. Take a
> look at the .reg section.
>
> --
> Daniel Jacobowitz
> CodeSourcery
>



		
---------------------------------
How low will we go? Check out Yahoo! Messenger’s low  PC-to-Phone call rates.
--0-825593055-1148458446=:89965
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>hi,</div>  <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; where are you running your GDB ? on i386 ? then i guess you shouldnt specify --host=mips-linux. just run .configure script&nbsp;and specify only target as mips-linux.</div>  <div>&nbsp;</div>  <div>Regards,</div>  <div>A'Jones.<BR><BR><BR><B><I>Tony Lin &lt;lin.tony@gmail.com&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Objdump didn't yield any useful information, perhaps I didn't set the<BR>flags correctly to show all the private registers.<BR><BR>You may be right about the kernel generated core file though. I<BR>checked the registerd in gdb, everything looks good except the program<BR>counter was zero. I then modified the mips kernel to spit out the<BR>registers when doing the coredump. A valid pc (0x4008c0) was there<BR>when doing fs/exec.c:do_coredump()<BR><BR>printks from do_coredump()<BR>-----------<BR>bash-2.05a# killall
 -SIGSEGV nebtest<BR>1:&lt;6&gt;<BR><BR>printing contents of pt_regs *regs<BR>1:&lt;6&gt;cp0_status 0xdc13<BR>1:&lt;6&gt;lo 0x0<BR>1:&lt;6&gt;hi 0x0<BR>1:&lt;6&gt;cp0_badvaddr 0x803fbda0<BR>1:&lt;6&gt;cp0_cause 0x10801000<BR>1:&lt;6&gt;cp0_epc 0x4008c0<BR><BR><BR>Calling 'info registers' in gdb coredump<BR>----------------------<BR>Reading symbols from /lib/ld.so.1...done.<BR>Loaded symbols for /lib/ld.so.1<BR>#0 0x00000000 in ?? ()<BR>(gdb) info registers<BR>zero at v0 v1 a0 a1 a2 a3<BR>R0 00000000 1000dc00 0000000f 00000000 0000000f 2aac1000 0000000f 00000000<BR>t0 t1 t2 t3 t4 t5 t6 t7<BR>R8 00000000 00000001 00000003 49276d20 68697320 00000000 00000000 7468656e<BR>s0 s1 s2 s3 s4 s5 s6 s7<BR>R16 2ab00230 7fff7e64 2ad09f50 004008d0 00000001 004007dc 00000000 1001f328<BR>t8 t9 k0 k1 gp sp s8 ra<BR>R24 00000003 00000000 fbad2a84 00000000 10008040 7fff7de0 7fff7de0 00400898<BR>sr lo hi bad cause pc<BR>10801000 0000dc13 00000000 803fbda0 004008c0 00000000<BR>fsr
 fir<BR>00000000 00000000<BR>(gdb)<BR><BR>(gdb) x/32 0x4008c0<BR>0x4008c0 <MAIN+228>: 0x1000ffff 0x00000000 0x00000000<BR>0x00000000<BR>0x4008d0 &lt;__libc_csu_init&gt;: 0x3c1c0fc0 0x279c7770<BR>0x0399e021 0x27bdffd8<BR>0x4008e0 &lt;__libc_csu_init+16&gt;: 0xafbf0020 0xafb1001c<BR>0xafb00018 0xafbc0010<BR>0x4008f0 &lt;__libc_csu_init+32&gt;: 0x8f998054 0x00000000<BR>0x0320f809 0x00000000<BR>0x400900 &lt;__libc_csu_init+48&gt;: 0x8fbc0010 0x8f838034<BR>0x8f828040 0x00431023<BR><BR><BR><BR>The 0x4008c0 address doesn't look half bad, pointing within main(). So<BR>it looks like the mips kernel had all the right registers values but<BR>just didn't format it correctly in the core dump? It wrote the pc into<BR>cause, cause into sr, and cp0_status into lo.<BR><BR><BR>Thanks much,<BR>- Tony<BR><BR>On 5/17/06, Daniel Jacobowitz <DAN@DEBIAN.ORG>wrote:<BR>&gt; Check the contents of the core file with objdump? I recall seeing at<BR>&gt; least one recent MIPS kernel which failed to save
 registers. Take a<BR>&gt; look at the .reg section.<BR>&gt;<BR>&gt; --<BR>&gt; Daniel Jacobowitz<BR>&gt; CodeSourcery<BR>&gt;<BR><BR></BLOCKQUOTE><BR><p>
		<hr size=1>How low will we go? Check out Yahoo! Messenger’s low <a href="http://us.rd.yahoo.com/mail_us/taglines/postman8/*http://us.rd.yahoo.com/evt=39663/*http://voice.yahoo.com"> PC-to-Phone call rates.
--0-825593055-1148458446=:89965--
