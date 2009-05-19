Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 May 2009 03:14:14 +0100 (BST)
Received: from yx-out-1718.google.com ([74.125.44.153]:24333 "EHLO
	yx-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024540AbZESCOI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 May 2009 03:14:08 +0100
Received: by yx-out-1718.google.com with SMTP id 4so1995997yxp.24
        for <linux-mips@linux-mips.org>; Mon, 18 May 2009 19:14:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=oSwWIkOzS4/hd2ftZbH4zJQHZNvAyBPvtnvJZuXO8Sw=;
        b=csLhwT3Fd2Rr+wsWQo6MfF4EcIyojlcfU/1boHMJx4Xh+uwom4mLsH3++wGdfvGTbS
         G96WABKk69F3BD0P3OePGMSlJ9lIwa8XQlOlfwHTKwC98G96C9d5XpcE28FmSzAEVnZv
         O/kTWCf2IY95BiJaiqjt9dfURZvgdCa82Bth4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Yn7uborrn7keUGmZSverqYXAD0pGCS7ANa+CFuA2x77pOUEYt2R+d4PjJ6RJpGSSjP
         TSZhzWXfFuvYENIFYWonVHSEHE2J6bP3pFjc1woycPqu5V96mI0QU5Z1nOXM+x5c8eOW
         g//ac0Jm5Ph01gP9nPmNMv4JKnSLJNVG9B8LI=
MIME-Version: 1.0
Received: by 10.100.254.12 with SMTP id b12mr10107739ani.43.1242699246516; 
	Mon, 18 May 2009 19:14:06 -0700 (PDT)
Date:	Tue, 19 May 2009 10:14:06 +0800
Message-ID: <e805e9e20905181914m544c44dax937f441bd44c9317@mail.gmail.com>
Subject: need help for porting yamon
From:	tao wan <wannmt@gmail.com>
To:	linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=00163662e71126ba7b046a3a7768
Return-Path: <wannmt@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wannmt@gmail.com
Precedence: bulk
X-list: linux-mips

--00163662e71126ba7b046a3a7768
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable

hi=A3=ACeveryone=A3=A1
i am porting yamon to an au1250  board which was mostly like a
DBAU1200 develop board.
the different is that dbau1200 uses 4 chips` ddr2-533,but we just use 2
chips` ddr2-800, the total size is 128MB
i am using flash programmer to burn yamon and use ocd commander to debug.
yamon was successfully burned to flash at the start address 0xbfc00000 but
when it does  ram test,it failed.

in detail,yamon codes are executed in such a way :
reset.S---> reset_dbau1200.S---->init.S--->C code
our yamon was failed in init.S,in the branch sys_memory_setup

sys_memory_setup  perform a ram write and read to test whether it can work =
.
basicly it write to such addresses:
0xa0000000=A3=BA0xaaaaaaaa
0xa0fffffc:0xfedebabe
0xa1fffffc:0xfedebabe
0xa2fffffc:0xfedebabe
0xa3fffffc:0xfedebabe
0xa4fffffc:0xfedebabe
0xa5fffffc:0xfedebabe
0xa6fffffc:0xfedebabe
0xa7fffffc:0x55555555

i use ocd to read ram and found it`s:
0xa0000000=A3=BA0xaaaaaaaa
0xa0fffffc:0xfedebabe
0xa1fffffc:0xfedebabe
0xa2fffffc:0x00000000
0xa3fffffc:0xfedebabe
0xa4fffffc:0x00000000
0xa5fffffc:0xfedebabe
0xa6fffffc:0xfedebabe
0xa7fffffc:0x55555555

i try many times and it is always 0xa2fffffc and  0xa4fffffc address error.
i feel very puzzled!
i use another board and it is still the same problem.so i think it may not
be a hardware problem.
it may be a wrong ram initialization.

what i changed in reset_db1200.S is :

With a DDR clock of 198MHz (sdconfigb[CR]=3D1), DDR clock period is 5ns
mem_sdmode: 0000 0001 0010 0111 0010 0010 0010 0100 : 0x01272224
  Twtr=3D001  (1+1 clocks) data sheet specs 10ns for tWTR
   Twr=3D010  (1+2 clocks) data sheet specs 15ns for tWR
  Tras=3D0111 (1+7 clocks) data sheet specs 40ns for tRAS
   Trp=3D010  (1+2 clocks) data sheet specs 15ns for tRP
Trcdwr=3D010  (1+2 clocks) data sheet specs 15ns for tRCD
Trcdrd=3D010  (1+2 clocks) data sheet specs 15ns for tRCD
  Tcas=3D100  (CL=3D3      ) data sheet specs CL=3D3 for 400mhz
mem_sdaddr: 0010 0011 0001 0000 0000 0011 1110 0000 : 0x231003E0
    BR=3D0    (bank,row,col)
    RS=3D10   (13 row)
    CS=3D011  (10 col)
  E=3D1    (enabled)
  CSBA=3D0000000000 (0x00000000)
CSMASK=3D1111100000 (0xF8000000)
mem_sdconfiga: 0011 0001 0100 0000 0000 0110 0000 1010 : 0x3140060A
     E=3D0    (refresh disable)
    CE=3D11   (both clocks enabled)
   RPT=3D00   (1 refresh per cycle)
   Trc=3D010100 (1+20 clocks) data sheet specs 55ns for tRC, 105ns for tRFC
   REF=3D0x60A  (1562 clocks) data sheet specs 7.8125us intervals (8K rows =
in
64ms)
mem_sdconfigb: 1010 0000 0000 0010 0000 0000 0000 0000 : 0xA002000C
    CR=3D1    (1:1)
    BW=3D0    (32bit wide bus)
    MT=3D1    (DDR2)
  PSEL=3D0    (addr 10 for auto precharge)
    C2=3D0    (core lowest priority)
    AC=3D00   (default)
    HP=3D0    (no half-pll mode)
    PM=3D00   (no power modes)
CKECNT=3D00   (n/a)
    BB=3D0    (normal)
    DS=3D1    (full drive strength)
    FS=3D0    (normal)
   PDX=3D00   (n/a)
CKEmin=3D00   (n/a ?)
    CB=3D0    (normal)
 TXARD=3D000  (n/a)
    BA=3D0    (no block)
  TXSR=3D001100 (1+12 * 16=3D208 > 200 clocks)
mem_sdwrmd:
Mode Register 0: 0000 0100 0011 0010 : 0x0432
   PD=3D0     Fast Exit
   WR=3D010   3 Clocks
  DLL=3D0     Normal
   TM=3D0     Normal
   CL=3D011   CL=3D3
   BT=3D0     sequential burst type
   BL=3D010   burst length of 4
Mode Register 1: 0000 0100 0000 0000 : 0x0400
  OUT=3D0     Normal drive strength
 RDQS=3D0     Disable
  DQS=3D1     Disable
  OCD=3D000   Not supported
  RTT=3D10    150 Ohm termination needed with two ranks populated
   AL=3D00    0
  ODS=3D0     100%
  DLL=3D0     Normal/Enable
Mode Register 2: 0x0000
Mode Register 3: 0x0000
 */
#define MEM_SDMODE0_DDR2 0x01272224
#define MEM_SDMODE1_DDR2 0x00000000
#define MEM_SDADDR0_DDR2 0x231003E0
#define MEM_SDADDR1_DDR2 0x00000000
#define MEM_SDCONFIGA_DDR2 0x3140060A
#define MEM_SDCONFIGB_DDR2 0xA002000C
#define MEM_MR0_DDR2  0x00000432
#define MEM_MR1_DDR2  0x40000440
#define MEM_MR2_DDR2  0x80000000
#define MEM_MR3_DDR2  0xC0000000

my ddr2 is
/*
 * SDCS0 - 64MB DDR2-800 winbond w9751g6ib (8Mbit x 16 x 4bank devices)
 *    64MB DDR2-800 winbond w9751g6ib (8Mbit x 16 x 4bank devices)
*/
could anybody give me some suggestion to this comfiguration ?
or if this is just fine what can be the probabilities to the above error?

another question,because au1250 doesn`t support ddr2-800,so i set our ddr2
to work as a ddr2-533,can this be OK?

thanks!

--00163662e71126ba7b046a3a7768
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: quoted-printable

<div>hi=A3=ACeveryone=A3=A1</div>
<div>i am porting yamon to an au1250&nbsp; board which was&nbsp;mostly like=
 a DBAU1200&nbsp;develop board.</div>
<div>the different is that dbau1200 uses&nbsp;4 chips` ddr2-533,but we just=
 use 2 chips` ddr2-800, the total size is 128MB&nbsp;&nbsp;&nbsp;</div>
<div>i am using flash programmer to burn yamon and use ocd commander to deb=
ug.</div>
<div>yamon was successfully burned to flash at the start address 0xbfc00000=
 but when it&nbsp;does &nbsp;ram test,it failed.</div>
<div>&nbsp;</div>
<div>in detail,yamon codes are executed in such a way :</div>
<div>reset.S---&gt; reset_dbau1200.S----&gt;init.S---&gt;C code</div>
<div>our yamon was failed in init.S,in the branch sys_memory_setup</div>
<div>&nbsp;</div>
<div>sys_memory_setup&nbsp; perform a ram write and read to test whether it=
 can work .</div>
<div>basicly it write to such addresses:</div>
<div>0xa0000000=A3=BA0xaaaaaaaa<br>0xa0fffffc:0xfedebabe<br>0xa1fffffc:0xfe=
debabe<br>0xa2fffffc:0xfedebabe<br>0xa3fffffc:0xfedebabe<br>0xa4fffffc:0xfe=
debabe<br>0xa5fffffc:0xfedebabe<br>0xa6fffffc:0xfedebabe<br>0xa7fffffc:0x55=
555555</div>

<div>&nbsp;</div>
<div>i use ocd to read ram and found it`s:</div>
<div>0xa0000000=A3=BA0xaaaaaaaa<br>0xa0fffffc:0xfedebabe<br>0xa1fffffc:0xfe=
debabe<br>0xa2fffffc:0x00000000<br>0xa3fffffc:0xfedebabe<br>0xa4fffffc:0x00=
000000<br>0xa5fffffc:0xfedebabe<br>0xa6fffffc:0xfedebabe<br>0xa7fffffc:0x55=
555555</div>

<div>&nbsp;</div>
<div>i try many times and it is always 0xa2fffffc and&nbsp; 0xa4fffffc addr=
ess error.</div>
<div>i feel very puzzled!</div>
<div>i use another board and it is still the same problem.so i think it may=
 not be a hardware problem.</div>
<div>it may be a wrong ram initialization.</div>
<div>&nbsp;</div>
<div>what i changed in reset_db1200.S is :</div>
<div>&nbsp;</div>
<div>With a DDR clock of 198MHz (sdconfigb[CR]=3D1), DDR clock period is 5n=
s</div>
<div>mem_sdmode: 0000 0001 0010 0111 0010 0010 0010 0100 : 0x01272224<br>&n=
bsp; Twtr=3D001&nbsp; (1+1 clocks) data sheet specs 10ns for tWTR<br>&nbsp;=
&nbsp; Twr=3D010&nbsp; (1+2 clocks) data sheet specs 15ns for tWR<br>&nbsp;=
 Tras=3D0111 (1+7 clocks) data sheet specs 40ns for tRAS<br>
&nbsp;&nbsp; Trp=3D010&nbsp; (1+2 clocks) data sheet specs 15ns for tRP<br>=
Trcdwr=3D010&nbsp; (1+2 clocks) data sheet specs 15ns for tRCD<br>Trcdrd=3D=
010&nbsp; (1+2 clocks) data sheet specs 15ns for tRCD<br>&nbsp; Tcas=3D100&=
nbsp; (CL=3D3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ) data sheet specs CL=3D3 for 4=
00mhz</div>

<div>mem_sdaddr: 0010 0011 0001 0000 0000 0011 1110 0000 : 0x231003E0<br>&n=
bsp;&nbsp;&nbsp; BR=3D0&nbsp;&nbsp;&nbsp; (bank,row,col)<br>&nbsp;&nbsp;&nb=
sp; RS=3D10&nbsp;&nbsp; (13 row)<br>&nbsp;&nbsp;&nbsp; CS=3D011&nbsp; (10 c=
ol)<br>&nbsp; E=3D1&nbsp;&nbsp;&nbsp; (enabled)<br>&nbsp; CSBA=3D0000000000=
 (0x00000000)<br>CSMASK=3D1111100000 (0xF8000000)</div>

<div>mem_sdconfiga: 0011 0001 0100 0000 0000 0110 0000 1010 : 0x3140060A<br=
>&nbsp;&nbsp;&nbsp;&nbsp; E=3D0&nbsp;&nbsp;&nbsp; (refresh disable)<br>&nbs=
p;&nbsp;&nbsp; CE=3D11&nbsp;&nbsp; (both clocks enabled)<br>&nbsp;&nbsp; RP=
T=3D00&nbsp;&nbsp; (1 refresh per cycle)<br>&nbsp;&nbsp; Trc=3D010100 (1+20=
 clocks) data sheet specs 55ns for tRC, 105ns for tRFC<br>
&nbsp;&nbsp; REF=3D0x60A&nbsp; (1562 clocks) data sheet specs 7.8125us inte=
rvals (8K rows in 64ms)</div>
<div>mem_sdconfigb: 1010 0000 0000 0010 0000 0000 0000 0000 : 0xA002000C<br=
>&nbsp;&nbsp;&nbsp; CR=3D1&nbsp;&nbsp;&nbsp; (1:1)<br>&nbsp;&nbsp;&nbsp; BW=
=3D0&nbsp;&nbsp;&nbsp; (32bit wide bus)<br>&nbsp;&nbsp;&nbsp; MT=3D1&nbsp;&=
nbsp;&nbsp; (DDR2)<br>&nbsp; PSEL=3D0&nbsp;&nbsp;&nbsp; (addr 10 for auto p=
recharge)<br>&nbsp;&nbsp;&nbsp; C2=3D0&nbsp;&nbsp;&nbsp; (core lowest prior=
ity)<br>
&nbsp;&nbsp;&nbsp; AC=3D00&nbsp;&nbsp; (default)<br>&nbsp;&nbsp;&nbsp; HP=
=3D0&nbsp;&nbsp;&nbsp; (no half-pll mode)<br>&nbsp;&nbsp;&nbsp; PM=3D00&nbs=
p;&nbsp; (no power modes)<br>CKECNT=3D00&nbsp;&nbsp; (n/a)<br>&nbsp;&nbsp;&=
nbsp; BB=3D0&nbsp;&nbsp;&nbsp; (normal)<br>&nbsp;&nbsp;&nbsp; DS=3D1&nbsp;&=
nbsp;&nbsp; (full drive strength)<br>&nbsp;&nbsp;&nbsp; FS=3D0&nbsp;&nbsp;&=
nbsp; (normal)<br>&nbsp;&nbsp; PDX=3D00&nbsp;&nbsp; (n/a)<br>CKEmin=3D00&nb=
sp;&nbsp; (n/a ?)<br>
&nbsp;&nbsp;&nbsp; CB=3D0&nbsp;&nbsp;&nbsp; (normal)<br>&nbsp;TXARD=3D000&n=
bsp; (n/a)<br>&nbsp;&nbsp;&nbsp; BA=3D0&nbsp;&nbsp;&nbsp; (no block)<br>&nb=
sp; TXSR=3D001100 (1+12 * 16=3D208 &gt; 200 clocks)</div>
<div>mem_sdwrmd:<br>Mode Register 0: 0000 0100 0011 0010 : 0x0432<br>&nbsp;=
&nbsp; PD=3D0&nbsp;&nbsp;&nbsp;&nbsp; Fast Exit<br>&nbsp;&nbsp; WR=3D010&nb=
sp;&nbsp; 3 Clocks<br>&nbsp; DLL=3D0&nbsp;&nbsp;&nbsp;&nbsp; Normal<br>&nbs=
p;&nbsp; TM=3D0&nbsp;&nbsp;&nbsp;&nbsp; Normal<br>&nbsp;&nbsp; CL=3D011&nbs=
p;&nbsp; CL=3D3<br>&nbsp;&nbsp; BT=3D0&nbsp;&nbsp;&nbsp;&nbsp; sequential b=
urst type<br>&nbsp;&nbsp; BL=3D010&nbsp;&nbsp; burst length of 4</div>

<div>Mode Register 1: 0000 0100 0000 0000 : 0x0400<br>&nbsp; OUT=3D0&nbsp;&=
nbsp;&nbsp;&nbsp; Normal drive strength<br>&nbsp;RDQS=3D0&nbsp;&nbsp;&nbsp;=
&nbsp; Disable<br>&nbsp; DQS=3D1&nbsp;&nbsp;&nbsp;&nbsp; Disable<br>&nbsp; =
OCD=3D000&nbsp;&nbsp; Not supported<br>&nbsp; RTT=3D10&nbsp;&nbsp;&nbsp; 15=
0 Ohm termination needed with two ranks populated<br>
&nbsp;&nbsp; AL=3D00&nbsp;&nbsp;&nbsp; 0<br>&nbsp; ODS=3D0&nbsp;&nbsp;&nbsp=
;&nbsp; 100%<br>&nbsp; DLL=3D0&nbsp;&nbsp;&nbsp;&nbsp; Normal/Enable</div>
<div>Mode Register 2: 0x0000<br>Mode Register 3: 0x0000<br>&nbsp;*/<br>#def=
ine MEM_SDMODE0_DDR2&nbsp;0x01272224<br>#define MEM_SDMODE1_DDR2&nbsp;0x000=
00000<br>#define MEM_SDADDR0_DDR2&nbsp;0x231003E0<br>#define MEM_SDADDR1_DD=
R2&nbsp;0x00000000<br>
#define MEM_SDCONFIGA_DDR2&nbsp;0x3140060A<br>#define MEM_SDCONFIGB_DDR2&nb=
sp;0xA002000C<br>#define MEM_MR0_DDR2&nbsp;&nbsp;0x00000432<br>#define MEM_=
MR1_DDR2&nbsp;&nbsp;0x40000440<br>#define MEM_MR2_DDR2&nbsp;&nbsp;0x8000000=
0<br>#define MEM_MR3_DDR2&nbsp;&nbsp;0xC0000000</div>

<div>&nbsp;</div>
<div>my ddr2 is </div>
<div>/*<br>&nbsp;* SDCS0 - 64MB DDR2-800 winbond w9751g6ib (8Mbit x 16 x 4b=
ank devices)<br>&nbsp;* &nbsp;&nbsp; 64MB DDR2-800 winbond w9751g6ib (8Mbit=
 x 16 x 4bank devices)<br>*/</div>
<div>could anybody give me some suggestion to this comfiguration ?</div>
<div>or if this is just fine what can be the probabilities to&nbsp;the&nbsp=
;above&nbsp;error?</div>
<div>&nbsp;</div>
<div>another question,because au1250 doesn`t support ddr2-800,so i set our =
ddr2 to work as a ddr2-533,can this be OK?</div>
<div>&nbsp;</div>
<div>thanks!</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>

--00163662e71126ba7b046a3a7768--
