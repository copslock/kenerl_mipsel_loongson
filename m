Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Mar 2004 15:13:45 +0000 (GMT)
Received: from telviso-dsl-static-03-200-85-107-17.telviso.net.ar ([IPv6:::ffff:200.85.107.17]:63057
	"HELO whatever.org.ar") by linux-mips.org with SMTP
	id <S8224988AbUCIPNl>; Tue, 9 Mar 2004 15:13:41 +0000
Received: (qmail 8893 invoked from network); 9 Mar 2004 12:13:32 -0000
Received: from unknown (HELO obscure.whatever.org.ar) (200.151.110.245)
  by whatever.org.ar with SMTP; 9 Mar 2004 12:13:32 -0000
Message-Id: <6.0.0.22.0.20040309121104.01c25d30@whatever.org.ar>
X-Sender: module@whatever.org.ar@whatever.org.ar
X-Mailer: QUALCOMM Windows Eudora Version 6.0.0.22
Date: Tue, 09 Mar 2004 12:12:53 -0300
To: Ralf Baechle <ralf@linux-mips.org>
From: Tiago =?iso-8859-1?Q?Assump=E7=E3o?= <module@whatever.org.ar>
Subject: Re: 2.4 kernels + >=binutils-2.14.90.0.8
Cc: linux-mips@linux-mips.org
In-Reply-To: <20040309040919.GA11345@linux-mips.org>
References: <404D0132.3020202@gentoo.org>
 <20040308234450.GF16163@rembrandt.csv.ica.uni-stuttgart.de>
 <404D0A18.6050802@gentoo.org>
 <20040309003447.GH16163@rembrandt.csv.ica.uni-stuttgart.de>
 <404D1909.1020005@gentoo.org>
 <20040309040919.GA11345@linux-mips.org>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=====================_977475305==.ALT"
Return-Path: <module@whatever.org.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: module@whatever.org.ar
Precedence: bulk
X-list: linux-mips

--=====================_977475305==.ALT
Content-Type: text/plain; charset="us-ascii"; format=flowed

Yes, MIPS has no execution control flag in page-level.
And agreed, yet I nor PaX team see a way to make MIPS fully supported by PaX
-- if I'm not wrong, at the moment MIPS boards are only supported by ASLR.

I see that MIPS has split TLB's, which can not be distinguished by software
level in another hand. Thus when a page-fault occours I don't see how a piece
of (non-microcoded) exception handler can get aware whether the I-Fetch is 
being
done in original ``code area'' or as an attempt to execute injected payload in
a memory area supposed to carry only readable/writeable data.
Plus JTLB's holding data and code together in the address translation cache.
Plus situations like kseg0 and kseg1 unmaped translations, which would occour
outside of any TLB (having virtual address subtracted by 0x80000000 and
0xA0000000 respectively to get physiscal locations) making, as you mentioned,
only split uTLB's (not counting kseg2 special case). But PaX wants to take 
care of
kernel level security too.
Even MIPS split cache unities (which can be probed separately by software) 
wouldn't
make the approach possible since if you have a piece of data previously 
cached in
D-Cache (load/store) the cache line would need to suffer an invalidation 
and the
context to be saved in the I-Cache before the I-Fetch pipe stage succeeds.

Indeed, execution protection (in a general way) does not require split TLB.
Other solutions designed and implemented by PaX are SEGMEXEC (using specific
segmentation features of x86 basead core's) and MPROTECT. The last one uses
vm_flags to control every memory mapping's state, ensuring that these never 
hold
VM_WRITE | VM_MAYWRITE together with VM_EXEC | VM_MAYEXEC. But as the
solution becomes more complex it also tends to gain more issues. First of 
all, this
wouldn't be as simple and ``automatic'' as per page control. Another point 
is that this
solution wouldn't prevent kernel level attacks so, among others, any 
compromise in
this level could lead to direct manipulation of a task's mappings flags. At 
the end
a known problem is an attacker who is able to write to the filesystem and 
to request
this file to be mapped in memory as PROT_EXEC. In other words: yes it is 
possible to
achieve execution protection in other ways, but not as precise as page-level.

If anybody has an idea of how to design and implement such solution on MIPS 
computers
I'd really like to hear it.


http://pax.grsecurity.net for further information.



PS.: Kumba, I'd like to have a copy of your kernel image to take a look,
could you please send it to me?



Best regards,


--
                    Tiago Assumpcao

                 module@whatever.org.ar
                7D9A A6BA 8275 964E EF47
                EE5A 7AFF C759 B578 ACAA
      http://whatever.org.ar/~module [/myself.asc]




At 01:09 9/3/2004, you wrote:
>On Mon, Mar 08, 2004 at 08:08:25PM -0500, Kumba wrote:
>
> > Hmm, well, The readelf -l and -S output from a 2.14.90.0.7-based
> > cross-compiler is attached, along with -l & -S outout from the
> > 2.15.90.0.1.1 (--version reports 2.15.90.0.1) as well for comparison.
> >
> > The PAX_FLAGS bit comes from a patch added in gentoo for PaX support in
> > binaries.  More info on PaX is at http://pax.grsecurity.net.  I'm going
> > to rebuild my kernel cross-compiler without that one patch and see what
> > the results are.
>
>PAX can't be fully supported on MIPS anyway; the architecture doesn't
>have a no-exec flag in it's pages.
>
>PAX docs are bullshit btw.  execution proection doesn't require a split TLB
>and anyway, the MIPS uTLBs are split.
>
>   Ralf



--=====================_977475305==.ALT
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<body>
Yes, MIPS has no execution control flag in page-level.<br>
And agreed, yet I nor PaX team see a way to make MIPS fully supported by
PaX<br>
-- if I'm not wrong, at the moment MIPS boards are only supported by
ASLR.<br><br>
I see that MIPS has split TLB's, which can not be distinguished by
software<br>
level in another hand. Thus when a page-fault occours I don't see how a
piece<br>
of (non-microcoded) exception handler can get aware whether the I-Fetch
is being<br>
done in original ``code area'' or as an attempt to execute injected
payload in<br>
a memory area supposed to carry only readable/writeable data.<br>
Plus JTLB's holding data and code together in the address translation
cache.<br>
Plus situations like kseg0 and kseg1 unmaped translations, which would
occour<br>
outside of any TLB (having virtual address subtracted by 0x80000000
and<br>
0xA0000000 respectively to get physiscal locations) making, as you
mentioned,<br>
only split uTLB's (not counting kseg2 special case). But PaX wants to
take care of<br>
kernel level security too.<br>
Even MIPS split cache unities (which can be probed separately by
software) wouldn't<br>
make the approach possible since if you have a piece of data previously
cached in<br>
D-Cache (load/store) the cache line would need to suffer an invalidation
and the<br>
context to be saved in the I-Cache before the I-Fetch pipe stage
succeeds.<br><br>
Indeed, execution protection (in a general way) does not require split
TLB.<br>
Other solutions designed and implemented by PaX are SEGMEXEC (using
specific<br>
segmentation features of x86 basead core's) and MPROTECT. The last one
uses<br>
vm_flags to control every memory mapping's state, ensuring that these
never hold<br>
VM_WRITE | VM_MAYWRITE together with VM_EXEC | VM_MAYEXEC. But as
the<br>
solution becomes more complex it also tends to gain more issues. First of
all, this<br>
wouldn't be as simple and ``automatic'' as per page control. Another
point is that this<br>
solution wouldn't prevent kernel level attacks so, among others, any
compromise in<br>
this level could lead to direct manipulation of a task's mappings flags.
At the end<br>
a known problem is an attacker who is able to write to the filesystem and
to request<br>
this file to be mapped in memory as PROT_EXEC. In other words: yes it is
possible to<br>
achieve execution protection in other ways, but not as precise as
page-level.<br><br>
If anybody has an idea of how to design and implement such solution on
MIPS computers<br>
I'd really like to hear it.<br><br>
<br>
<a href=3D"http://pax.grsecurity.net/" eudora=3D"autourl">http://pax.grsecur=
ity.net</a>
for further information.<br><br>
<br><br>
PS.: Kumba, I'd like to have a copy of your kernel image to take a look,<br>
could you please send it to me?<br><br>
<br><br>
Best regards,<br><br>
<x-sigsep><p></x-sigsep>
<font face=3D"Courier New, Courier">--<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Tiago Assumpcao<br><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; module@whatever.org.ar<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 7D9A A6BA 8275 964E EF47<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; EE5A 7AFF C759 B578 ACAA<br>
&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"http://whatever.org.ar/~module"=
 eudora=3D"autourl">http://whatever.org.ar/~module</a> [/myself.asc]<br><br>
<br><br>
<br>
</font>At 01:09 9/3/2004, you wrote:<br>
<blockquote type=3Dcite class=3Dcite cite>On Mon, Mar 08, 2004 at 08:08:25PM=
 -0500, Kumba wrote:<br><br>
&gt; Hmm, well, The readelf -l and -S output from a 2.14.90.0.7-based <br>
&gt; cross-compiler is attached, along with -l &amp; -S outout from the <br>
&gt; 2.15.90.0.1.1 (--version reports 2.15.90.0.1) as well for=
 comparison.<br>
&gt; <br>
&gt; The PAX_FLAGS bit comes from a patch added in gentoo for PaX support in=
 <br>
&gt; binaries.&nbsp; More info on PaX is at <a=
 href=3D"http://pax.grsecurity.net.=A0/"=
 eudora=3D"autourl">http://pax.grsecurity.net. </a> I'm going <br>
&gt; to rebuild my kernel cross-compiler without that one patch and see what=
 <br>
&gt; the results are.<br><br>
PAX can't be fully supported on MIPS anyway; the architecture doesn't<br>
have a no-exec flag in it's pages.<br><br>
PAX docs are bullshit btw.&nbsp; execution proection doesn't require a split=
 TLB<br>
and anyway, the MIPS uTLBs are split.<br><br>
&nbsp; Ralf</blockquote>
<x-sigsep><p></x-sigsep>
<br>
</body>
</html>

--=====================_977475305==.ALT--
