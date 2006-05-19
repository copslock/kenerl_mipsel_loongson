Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 May 2006 17:01:55 +0200 (CEST)
Received: from webmail45.rediffmail.com ([203.199.83.135]:64728 "HELO
	rediffmail.com") by ftp.linux-mips.org with SMTP id S8133954AbWESPBI
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 May 2006 17:01:08 +0200
Received: (qmail 3760 invoked by uid 510); 19 May 2006 14:59:30 -0000
Date:	19 May 2006 14:59:30 -0000
Message-ID: <20060519145930.3759.qmail@webmail45.rediffmail.com>
Received: from unknown (202.153.32.139) by rediffmail.com via HTTP; 19 may 2006 14:59:30 -0000
MIME-Version: 1.0
From:	"Tacitus Rodriguez" <tacitus@rediffmail.com>
Reply-To: "Tacitus Rodriguez" <tacitus@rediffmail.com>
To:	linux-mips@linux-mips.org
Subject: System crash due to memory card change
Content-type: multipart/alternative;
	boundary="Next_1148050770---0-203.199.83.135-3752"
Return-Path: <tacitus@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11497
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tacitus@rediffmail.com
Precedence: bulk
X-list: linux-mips

 This is a multipart mime message


--Next_1148050770---0-203.199.83.135-3752
Content-type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

  =0AHi Guys,=0A=0AI have a telephony application that works perfectly fine=
 on Linux 2.6.16 & MALTA platform with SDRAM Transcend V54C365804VCT7. Howe=
ver, when I tried with other SDRAM memory of Hyundai Korea GM72V66841ET75 m=
ake, system crashes on starting the application within couple of minutes. T=
he SDRAM config is same in both case. The kernel trace is as below:=0A=0A**=
*********************************************************************=0A=0A=
app>NMI taken!!!!=0ANMI[#1]:=0ACpu 0=0A$ 0   : 00000000 00000000 7e5fdb78 7=
e5fdb58=0A$ 4   : 1004b364 00000010 7e5fdb60 7e5fdb58=0A$ 8   : 10005ae4 10=
005afa 1004b3c8 1004b3e0=0A$12   : 7e5fdb60 00000002 0000000b 0000324e=0A$1=
6   : ffff8985 ffffcdb2 ffffbeb7 00000007=0A$20   : 0000645d 00000001 00000=
000 100586e0=0A$24   : 00000005 00000000=0A$28   : 100143c0 7e5fda78 000000=
00 0049be5c=0AHi    : 00000000=0ALo    : 0001f70c=0Aepc   : 0049cab4     No=
t tainted=0Ara    : 0049be5c Status: 0048a404    KERNEL ERL=0ACause : 30800=
00c=0ABadVA : 00494360=0APrId  : 0001800b=0AModules linked in:=0AProcess hs=
_voip_mips_ap (pid: 658, threadinfo=3D83316000, task=3D832fc4e8)=0AStack : =
00000a44 00000001 1004b364 7e5fdc10 7e5fdca8 00010000 00000003 100586e0=0A =
       10041560 0049be5c 7e5fdca8 00030000 00000000 00000000 1004b364 0049b=
970=0A        fffeffff fffdfffd fffffffe ffff0000 fff8fffc fff8fff6 0008fff=
f 000f000f=0A        00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000=0A        00000000 00000000 00000000 00000000 00000000 00=
000000 00000000 00000000=0A        ...=0ACall Trace:=0A                    =
                                                                           =
                              =0ACode: 00000000  00000000  27bdffe0 <afb000=
00> afb10004  afb20008  afb3000c  afb40010  afb50014=0A=0A*****************=
******************************************************=0A=0ACan anybody sug=
gest what could be the problem cause?=0A=0AThanks!=0ATacitus
--Next_1148050770---0-203.199.83.135-3752
Content-type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<P>=0A&nbsp; <BR>=0AHi Guys,<BR>=0A<BR>=0AI have a telephony application th=
at works perfectly fine on Linux 2.6.16 &amp; MALTA platform with SDRAM Tra=
nscend V54C365804VCT7. However, when I tried with other SDRAM memory of Hyu=
ndai Korea GM72V66841ET75 make, system crashes on starting the application =
within couple of minutes. The SDRAM config is same in both case. The kernel=
 trace is as below:<BR>=0A<BR>=0A******************************************=
*****************************<BR>=0A<BR>=0Aapp&gt;NMI taken!!!!<BR>=0ANMI[#=
1]:<BR>=0ACpu 0<BR>=0A$ 0&nbsp;  : 00000000 00000000 7e5fdb78 7e5fdb58<BR>=
=0A$ 4&nbsp;  : 1004b364 00000010 7e5fdb60 7e5fdb58<BR>=0A$ 8&nbsp;  : 1000=
5ae4 10005afa 1004b3c8 1004b3e0<BR>=0A$12&nbsp;  : 7e5fdb60 00000002 000000=
0b 0000324e<BR>=0A$16&nbsp;  : ffff8985 ffffcdb2 ffffbeb7 00000007<BR>=0A$2=
0&nbsp;  : 0000645d 00000001 00000000 100586e0<BR>=0A$24&nbsp;  : 00000005 =
00000000<BR>=0A$28&nbsp;  : 100143c0 7e5fda78 00000000 0049be5c<BR>=0AHi&nb=
sp; &nbsp; : 00000000<BR>=0ALo&nbsp; &nbsp; : 0001f70c<BR>=0Aepc&nbsp;  : 0=
049cab4&nbsp; &nbsp;  Not tainted<BR>=0Ara&nbsp; &nbsp; : 0049be5c Status: =
0048a404&nbsp; &nbsp; KERNEL ERL<BR>=0ACause : 3080000c<BR>=0ABadVA : 00494=
360<BR>=0APrId&nbsp; : 0001800b<BR>=0AModules linked in:<BR>=0AProcess hs_v=
oip_mips_ap (pid: 658, threadinfo=3D83316000, task=3D832fc4e8)<BR>=0AStack =
: 00000a44 00000001 1004b364 7e5fdc10 7e5fdca8 00010000 00000003 100586e0<B=
R>=0A&nbsp; &nbsp; &nbsp; &nbsp; 10041560 0049be5c 7e5fdca8 00030000 000000=
00 00000000 1004b364 0049b970<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; fffeffff ff=
fdfffd fffffffe ffff0000 fff8fffc fff8fff6 0008ffff 000f000f<BR>=0A&nbsp; &=
nbsp; &nbsp; &nbsp; 00000000 00000000 00000000 00000000 00000000 00000000 0=
0000000 00000000<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; 00000000 00000000 000000=
00 00000000 00000000 00000000 00000000 00000000<BR>=0A&nbsp; &nbsp; &nbsp; =
&nbsp; ...<BR>=0ACall Trace:<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp;  <BR>=0ACode: 00000000&nbsp; 00000000&nbsp; 27bdffe0 &lt=
;afb00000&gt; afb10004&nbsp; afb20008&nbsp; afb3000c&nbsp; afb40010&nbsp; a=
fb50014<BR>=0A<BR>=0A******************************************************=
*****************<BR>=0A<BR>=0ACan anybody suggest what could be the proble=
m cause?<BR>=0A<BR>=0AThanks!<BR>=0ATacitus=0A</P>=0A<br><br>=0A<a href=3D"=
http://adworks.rediff.com/cgi-bin/AdWorks/sigclick.cgi/www.rediff.com/signa=
ture-home.htm/1507191490@Middle5?PARTNER=3D3"><IMG SRC=3D"http://adworks.re=
diff.com/cgi-bin/AdWorks/sigimpress.cgi/www.rediff.com/signature-home.htm/1=
963059423@Middle5?OAS_query=3Dnull&PARTNER=3D3" BORDER=3D0 VSPACE=3D0 HSPAC=
E=3D0></a>=0A
--Next_1148050770---0-203.199.83.135-3752--
