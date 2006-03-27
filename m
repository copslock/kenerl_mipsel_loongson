Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Mar 2006 15:02:09 +0100 (BST)
Received: from zproxy.gmail.com ([64.233.162.200]:63819 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133622AbWC0OBt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 27 Mar 2006 15:01:49 +0100
Received: by zproxy.gmail.com with SMTP id 16so718580nzp
        for <linux-mips@linux-mips.org>; Mon, 27 Mar 2006 06:12:05 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=qGglGeqXRI/VUJXkDfE9eg5iGJhH1DChHo8QD15A000MEhhQ97koPyZHk43vTngyqkuB1svBCiLBcjG/d1o/DSKSVy7QvDvQfLIBhCouoySXTcouYuKpPHvSBmFeJmp0X5ZcWvl9bUnyfr/fuGcr1CY6m+q5Uniy8e+CFpxCIKc=
Received: by 10.36.119.4 with SMTP id r4mr5153662nzc;
        Mon, 27 Mar 2006 06:12:05 -0800 (PST)
Received: by 10.36.49.7 with HTTP; Mon, 27 Mar 2006 06:12:05 -0800 (PST)
Message-ID: <f07e6e0603270612k39c91d01wa0e08c35fee1922c@mail.gmail.com>
Date:	Mon, 27 Mar 2006 20:12:05 +0600
From:	"Kishore K" <hellokishore@gmail.com>
To:	"Kevin D. Kissell" <kevink@mips.com>
Subject: Re: 2.6.14 - problem with malta
Cc:	"Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <005901c6519f$b226e060$10eca8c0@grendel>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_45_1434776.1143468725009"
References: <f07e6e0603240636x5e496cd2g29316d73490aa300@mail.gmail.com>
	 <20060324165518.GA16567@linux-mips.org>
	 <f07e6e0603250122t6328c09coe37141d14396dc12@mail.gmail.com>
	 <000d01c65022$90d758a0$10eca8c0@grendel>
	 <f07e6e0603270326s7acb75e4x3000bb08de93ffc5@mail.gmail.com>
	 <005901c6519f$b226e060$10eca8c0@grendel>
Return-Path: <hellokishore@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hellokishore@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_45_1434776.1143468725009
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 3/27/06, Kevin D. Kissell <kevink@mips.com> wrote:
>
>
> My own Malta kernels are built from rather old 2.6 sources, so it's not
> clear that all the same options are required/possible.  The questions tha=
t
> come to mind for me are:
>
> 1) You're booting a big-endian kernel.  The Malta board can be set up
>     for either endianness with a DIP switch, but I believe that it ships
>     from the factory in little-endian mode.  Have you verified that the
>     endianness setup?
>

After reset, I get the message saying that, board is in Big endian mode.
So,  I assume that there is no problem here.

2)  You're configuring for hot-pluggable CPUs.  That isn't fully supported
>      in the old source base I've got.  It may be fixed in 2.6.14, but do
> you
>      actually need it on a Malta?
>
> 3) You've got support for MIPS MT (the multithreading extension) enabled,
>     with the slave-virtual-processor boot loader, etc.  This stuff only
> works
>     on a 34K core, and could cause severe problems if invoked on a 4Kc.
>     At least you don't have SMP/SMTC multi-virtual-processor support
>     enabled, which would *definitely* cause a prompt crash on a 4Kc,
>     but please turn MIPS_MT off.  If MIPS MT + VPE loader are really
>     selected options in the default malta config file, it needs to be
> fixed!
>
>             Regards,
>
>             Kevin K.
>
> I reset the above options, but the same problem persists. If I compiled
2.6.10 with default configuration (endian is changed to big endian), the
board comes up without any problem.

regards,
--kishore

------=_Part_45_1434776.1143468725009
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 3/27/06, <b class=3D"gmail_sendername">Kevin D. Kissell</b> &lt;<a href=
=3D"mailto:kevink@mips.com">kevink@mips.com</a>&gt; wrote:<div><span class=
=3D"gmail_quote"></span><blockquote class=3D"gmail_quote" style=3D"border-l=
eft: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left:=
 1ex;">
<div style=3D"direction: ltr;"><span class=3D"q">






<div><font face=3D"Arial" size=3D"2"></font>&nbsp;</div></span></div><div s=
tyle=3D"direction: ltr;"><div style=3D"background: rgb(228, 228, 228) none =
repeat scroll 0% 50%; -moz-background-clip: initial; -moz-background-origin=
: initial; -moz-background-inline-policy: initial; font-family: arial; font=
-style: normal; font-variant: normal; font-weight: normal; font-size: 10pt;=
 line-height: normal; font-size-adjust: none; font-stretch: normal;">
My own=20
Malta kernels are built from rather old 2.6 sources, so it's not</div>
<div style=3D"background: rgb(228, 228, 228) none repeat scroll 0% 50%; -mo=
z-background-clip: initial; -moz-background-origin: initial; -moz-backgroun=
d-inline-policy: initial; font-family: arial; font-style: normal; font-vari=
ant: normal; font-weight: normal; font-size: 10pt; line-height: normal; fon=
t-size-adjust: none; font-stretch: normal;">
clear that=20
all the same options are required/possible.&nbsp; The questions that</div>
<div style=3D"background: rgb(228, 228, 228) none repeat scroll 0% 50%; -mo=
z-background-clip: initial; -moz-background-origin: initial; -moz-backgroun=
d-inline-policy: initial; font-family: arial; font-style: normal; font-vari=
ant: normal; font-weight: normal; font-size: 10pt; line-height: normal; fon=
t-size-adjust: none; font-stretch: normal;">
come to=20
mind for me are:</div>
<div style=3D"background: rgb(228, 228, 228) none repeat scroll 0% 50%; -mo=
z-background-clip: initial; -moz-background-origin: initial; -moz-backgroun=
d-inline-policy: initial; font-family: arial; font-style: normal; font-vari=
ant: normal; font-weight: normal; font-size: 10pt; line-height: normal; fon=
t-size-adjust: none; font-stretch: normal;">
&nbsp;</div>
<div style=3D"background: rgb(228, 228, 228) none repeat scroll 0% 50%; -mo=
z-background-clip: initial; -moz-background-origin: initial; -moz-backgroun=
d-inline-policy: initial; font-family: arial; font-style: normal; font-vari=
ant: normal; font-weight: normal; font-size: 10pt; line-height: normal; fon=
t-size-adjust: none; font-stretch: normal;">
1) You're=20
booting a big-endian kernel.&nbsp; The Malta board can be set up</div>
<div style=3D"background: rgb(228, 228, 228) none repeat scroll 0% 50%; -mo=
z-background-clip: initial; -moz-background-origin: initial; -moz-backgroun=
d-inline-policy: initial; font-family: arial; font-style: normal; font-vari=
ant: normal; font-weight: normal; font-size: 10pt; line-height: normal; fon=
t-size-adjust: none; font-stretch: normal;">
&nbsp;&nbsp;&nbsp;=20
for either endianness with a DIP switch, but I believe that it ships</div>
<div style=3D"background: rgb(228, 228, 228) none repeat scroll 0% 50%; -mo=
z-background-clip: initial; -moz-background-origin: initial; -moz-backgroun=
d-inline-policy: initial; font-family: arial; font-style: normal; font-vari=
ant: normal; font-weight: normal; font-size: 10pt; line-height: normal; fon=
t-size-adjust: none; font-stretch: normal;">
&nbsp;&nbsp;&nbsp;=20
from the factory in little-endian mode.&nbsp; Have you verified that the</d=
iv>
<div style=3D"background: rgb(228, 228, 228) none repeat scroll 0% 50%; -mo=
z-background-clip: initial; -moz-background-origin: initial; -moz-backgroun=
d-inline-policy: initial; font-family: arial; font-style: normal; font-vari=
ant: normal; font-weight: normal; font-size: 10pt; line-height: normal; fon=
t-size-adjust: none; font-stretch: normal;">
&nbsp;&nbsp;&nbsp;=20
endianness setup?</div></div></blockquote><div><br>
After reset, I get the message saying that, board is in Big endian mode. So=
,&nbsp; I assume that there is no problem here.<br>
</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div st=
yle=3D"direction: ltr;"><div style=3D"background: rgb(228, 228, 228) none r=
epeat scroll 0% 50%; -moz-background-clip: initial; -moz-background-origin:=
 initial; -moz-background-inline-policy: initial; font-family: arial; font-=
style: normal; font-variant: normal; font-weight: normal; font-size: 10pt; =
line-height: normal; font-size-adjust: none; font-stretch: normal;">
2)&nbsp;=20
You're configuring for hot-pluggable CPUs.&nbsp; That isn't fully=20
supported</div>
<div style=3D"background: rgb(228, 228, 228) none repeat scroll 0% 50%; -mo=
z-background-clip: initial; -moz-background-origin: initial; -moz-backgroun=
d-inline-policy: initial; font-family: arial; font-style: normal; font-vari=
ant: normal; font-weight: normal; font-size: 10pt; line-height: normal; fon=
t-size-adjust: none; font-stretch: normal;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;in=20
the old source base I've got.&nbsp; It may be fixed in 2.6.14, but do you</=
div>
<div style=3D"background: rgb(228, 228, 228) none repeat scroll 0% 50%; -mo=
z-background-clip: initial; -moz-background-origin: initial; -moz-backgroun=
d-inline-policy: initial; font-family: arial; font-style: normal; font-vari=
ant: normal; font-weight: normal; font-size: 10pt; line-height: normal; fon=
t-size-adjust: none; font-stretch: normal;">
&nbsp;&nbsp;&nbsp;&nbsp;=20
actually need it on a Malta?</div>
<div style=3D"background: rgb(228, 228, 228) none repeat scroll 0% 50%; -mo=
z-background-clip: initial; -moz-background-origin: initial; -moz-backgroun=
d-inline-policy: initial; font-family: arial; font-style: normal; font-vari=
ant: normal; font-weight: normal; font-size: 10pt; line-height: normal; fon=
t-size-adjust: none; font-stretch: normal;">
&nbsp;</div>
<div style=3D"background: rgb(228, 228, 228) none repeat scroll 0% 50%; -mo=
z-background-clip: initial; -moz-background-origin: initial; -moz-backgroun=
d-inline-policy: initial; font-family: arial; font-style: normal; font-vari=
ant: normal; font-weight: normal; font-size: 10pt; line-height: normal; fon=
t-size-adjust: none; font-stretch: normal;">
3) You've=20
got support for MIPS MT (the multithreading extension) enabled,</div>
<div style=3D"background: rgb(228, 228, 228) none repeat scroll 0% 50%; -mo=
z-background-clip: initial; -moz-background-origin: initial; -moz-backgroun=
d-inline-policy: initial; font-family: arial; font-style: normal; font-vari=
ant: normal; font-weight: normal; font-size: 10pt; line-height: normal; fon=
t-size-adjust: none; font-stretch: normal;">
&nbsp;&nbsp;&nbsp;&nbsp;with=20
the slave-virtual-processor boot loader, etc.&nbsp; This stuff only works</=
div>
<div style=3D"background: rgb(228, 228, 228) none repeat scroll 0% 50%; -mo=
z-background-clip: initial; -moz-background-origin: initial; -moz-backgroun=
d-inline-policy: initial; font-family: arial; font-style: normal; font-vari=
ant: normal; font-weight: normal; font-size: 10pt; line-height: normal; fon=
t-size-adjust: none; font-stretch: normal;">
&nbsp;&nbsp;&nbsp;=20
on a 34K core, and could cause severe problems if invoked on a 4Kc.</div>
<div style=3D"background: rgb(228, 228, 228) none repeat scroll 0% 50%; -mo=
z-background-clip: initial; -moz-background-origin: initial; -moz-backgroun=
d-inline-policy: initial; font-family: arial; font-style: normal; font-vari=
ant: normal; font-weight: normal; font-size: 10pt; line-height: normal; fon=
t-size-adjust: none; font-stretch: normal;">
&nbsp;&nbsp;&nbsp;&nbsp;At=20
least you don't have SMP/SMTC multi-virtual-processor support</div>
<div style=3D"background: rgb(228, 228, 228) none repeat scroll 0% 50%; -mo=
z-background-clip: initial; -moz-background-origin: initial; -moz-backgroun=
d-inline-policy: initial; font-family: arial; font-style: normal; font-vari=
ant: normal; font-weight: normal; font-size: 10pt; line-height: normal; fon=
t-size-adjust: none; font-stretch: normal;">
&nbsp;&nbsp;&nbsp;=20
enabled, which would *definitely* cause a prompt crash on a 4Kc,</div>
<div style=3D"background: rgb(228, 228, 228) none repeat scroll 0% 50%; -mo=
z-background-clip: initial; -moz-background-origin: initial; -moz-backgroun=
d-inline-policy: initial; font-family: arial; font-style: normal; font-vari=
ant: normal; font-weight: normal; font-size: 10pt; line-height: normal; fon=
t-size-adjust: none; font-stretch: normal;">
&nbsp;&nbsp;&nbsp;&nbsp;but=20
please turn MIPS_MT off.&nbsp; If&nbsp;MIPS&nbsp;MT&nbsp;+ VPE&nbsp;loader =
are=20
really</div>
<div style=3D"background: rgb(228, 228, 228) none repeat scroll 0% 50%; -mo=
z-background-clip: initial; -moz-background-origin: initial; -moz-backgroun=
d-inline-policy: initial; font-family: arial; font-style: normal; font-vari=
ant: normal; font-weight: normal; font-size: 10pt; line-height: normal; fon=
t-size-adjust: none; font-stretch: normal;">
&nbsp;&nbsp;&nbsp;=20
selected options&nbsp;in the&nbsp;default malta config file, it needs to be=
=20
fixed!</div>
<div style=3D"background: rgb(228, 228, 228) none repeat scroll 0% 50%; -mo=
z-background-clip: initial; -moz-background-origin: initial; -moz-backgroun=
d-inline-policy: initial; font-family: arial; font-style: normal; font-vari=
ant: normal; font-weight: normal; font-size: 10pt; line-height: normal; fon=
t-size-adjust: none; font-stretch: normal;">
&nbsp;</div>
<div style=3D"background: rgb(228, 228, 228) none repeat scroll 0% 50%; -mo=
z-background-clip: initial; -moz-background-origin: initial; -moz-backgroun=
d-inline-policy: initial; font-family: arial; font-style: normal; font-vari=
ant: normal; font-weight: normal; font-size: 10pt; line-height: normal; fon=
t-size-adjust: none; font-stretch: normal;">
&nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; Regards,</div>
<div style=3D"background: rgb(228, 228, 228) none repeat scroll 0% 50%; -mo=
z-background-clip: initial; -moz-background-origin: initial; -moz-backgroun=
d-inline-policy: initial; font-family: arial; font-style: normal; font-vari=
ant: normal; font-weight: normal; font-size: 10pt; line-height: normal; fon=
t-size-adjust: none; font-stretch: normal;">
&nbsp;</div>
<div style=3D"background: rgb(228, 228, 228) none repeat scroll 0% 50%; -mo=
z-background-clip: initial; -moz-background-origin: initial; -moz-backgroun=
d-inline-policy: initial; font-family: arial; font-style: normal; font-vari=
ant: normal; font-weight: normal; font-size: 10pt; line-height: normal; fon=
t-size-adjust: none; font-stretch: normal;">
&nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; Kevin K.</div><font face=3D"Arial" si=
ze=3D"2">
<div><br></div></font>

</div></blockquote></div>I reset the above options, but the same
problem persists. If I compiled 2.6.10 with default configuration
(endian is changed to big endian), the board comes up without any
problem.<br>
<br>
regards,<br>
--kishore<br>
<br>

------=_Part_45_1434776.1143468725009--
