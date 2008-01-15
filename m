Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2008 06:34:53 +0000 (GMT)
Received: from py-out-1112.google.com ([64.233.166.177]:14217 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20023245AbYAOGeo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Jan 2008 06:34:44 +0000
Received: by py-out-1112.google.com with SMTP id a73so2716187pye.22
        for <linux-mips@linux-mips.org>; Mon, 14 Jan 2008 22:34:43 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        bh=ikERvzErXK6hGPyT1z9f1IJ6bRdc/5/pZ5GFpEdpqho=;
        b=LYNjdhv0f3GvXTrLdlT7o5s72dQJnZ8Xi36hL6ugVNDEtkc12QVq9yOTyZ7MytDi/ZaaAV0U4yo1EhH4ADScvFvUz3yb0No1ZpLH/gkRJpxARAc5Gfa5CRiYpW1eAKAZHpYRuTb3I/dvODIRbbsCH6ekNLdxJtDoycqW4e3HAUA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=QWMIjatTGWWB6SBLGRV/m6jI5atoAIN110TZ0uJVv2WrB6qcxAw4KgkRbA9D0F+P2rm+pCKvE4eiaYPxk8fLIGep8t3tbXTAhLxl5DLcqt0zGHO6m1Ro/9oWGiHkCkKbGx5wd/7LdoSLl3iqEibwjgqeK/kXzU02RADyg2VhESY=
Received: by 10.142.180.17 with SMTP id c17mr2932771wff.144.1200378880264;
        Mon, 14 Jan 2008 22:34:40 -0800 (PST)
Received: by 10.142.140.11 with HTTP; Mon, 14 Jan 2008 22:34:40 -0800 (PST)
Message-ID: <1a18fe6d0801142234h5a6aa573y88f1645ac0d6767d@mail.gmail.com>
Date:	Tue, 15 Jan 2008 07:34:40 +0100
From:	"Luc Perneel" <lper.home@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: [SPAM] Cache aliasing issues using 4K pages.
In-Reply-To: <ECBAEAB5-2C07-4FAA-AB8F-71038F9D3D4F@27m.se>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_4593_33111181.1200378880227"
References: <1a18fe6d0801141225u2395ae6dj39d268014019b4a1@mail.gmail.com>
	 <ECBAEAB5-2C07-4FAA-AB8F-71038F9D3D4F@27m.se>
Return-Path: <lper.home@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18047
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lper.home@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_4593_33111181.1200378880227
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

It is a real SMP system (you could run linux on it using both cores just
like on a dual core x86 desktop).
Never the less, only one of the cores is running linux. the other runs the
real-time part.
We use a kernel module and shared memory to communicate from the linux
applications to the real-time part on the second core.
Thus the HW is SMP, the software is not...
Luc

On Jan 14, 2008 11:34 PM, Markus Gothe <markus.gothe@27m.se> wrote:

> Lemme guess, it's not a dual-core as in SMP but a sub-CPU.This usually
> involves that the memory differs, for example does it have a TLB. Which
> vendor and which core is it? I suppose you use some sort of firmware from
> the vendor to access the sub-CPU, right?
>
> //Markus
>
> On 14 Jan 2008, at 21:25, The Engineer wrote:
>
> We are working with a 2.6.12 kernel on a dual-core mips architecture.
> In this dual-core system, one core is running the linux kernel and the
> other is used for some real-time handling (not directly controlled by
> Linux)
> We had different stability issues, which could be pinpointed to be
> related with cache aliasing problems.
> Cache aliasing happens when the same physical memory can be cached
> twice as it is accessed by two different virtual addresses.
> Indeed, for the index to select the correct cache line the virtual
> address is used. If some bits of the virtual page address are used in
> the cache index, aliasing can occur.
>
>
> As there is no hardware solution in the mips to recover from this
> (which would provide some cache coherency, even for one core), the
> only intrinsic safe solution is to enlarge the page size, so that
> cache indexing is only done by the offset address in the page (thus
> the physical part of the address).
> Another solution is to flush the cache if a page is being remapped to
> an aliased address (but in our case linux does not has control on the
> second core, which can cause issues with shared data between both
> cores).
> Currently the second solution is used in the kernel, but we found
> different issues with it (for instance: we had to merge more recent
> mips kernels, to get a reliable copy-on-write behaviour after
> forks...).
>
> Therefore some questions:
> - Are there still some known issues with cache aliasing in the MIPS
> kernel?
> - Are there known issues when using 16KB pages (8KB pages seems not be
> possible due to tlb issues).
>
> Thanks in advance,
> Luc
>
>
> _______________________________________
>
> Mr Markus Gothe
> Software Engineer
>
> Phone: +46 (0)13 21 81 20 (ext. 1046)
> Fax: +46 (0)13 21 21 15
> Mobile: +46 (0)70 348 44 35
> Diskettgatan 11, SE-583 35 Link=F6ping, Sweden
> www.27m.com
>
>
>
>

------=_Part_4593_33111181.1200378880227
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<span class=3D"HcCDpe">It is a real SMP system (you could run linux on it u=
sing both cores just like on a dual core x86 desktop).<br>Never the less, o=
nly one of the cores is running linux. the other runs the real-time part.<b=
r>
We use a kernel module and shared memory to communicate from the linux appl=
ications to the real-time part on the second core.<br>Thus the HW is SMP, t=
he software is not...<br>Luc<br></span><br><div class=3D"gmail_quote">On Ja=
n 14, 2008 11:34 PM, Markus Gothe &lt;
<a href=3D"mailto:markus.gothe@27m.se">markus.gothe@27m.se</a>&gt; wrote:<b=
r><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204=
, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div style=3D""=
>Lemme guess, it&#39;s not a dual-core as in SMP but a sub-CPU.
<div>This usually involves that the memory differs, for example does it hav=
e a TLB. Which vendor and which core is it? I suppose you use some sort of =
firmware from the vendor to access the sub-CPU, right?</div><div><br></div>
<div>//Markus<br><div><div><div><div></div><div class=3D"Wj3C7c"><br><div><=
div>On 14 Jan 2008, at 21:25, The Engineer wrote:</div><br><blockquote type=
=3D"cite">We are working with a 2.6.12 kernel on a dual-core mips architect=
ure.
<br>In this dual-core system, one core is running the linux kernel and the<=
br>other is used for some real-time handling (not directly controlled by<br=
>Linux)<br>We had different stability issues, which could be pinpointed to =
be
<br>related with cache aliasing problems.<br>Cache aliasing happens when th=
e same physical memory can be cached<br>twice as it is accessed by two diff=
erent virtual addresses.<br>Indeed, for the index to select the correct cac=
he line the virtual
<br>address is used. If some bits of the virtual page address are used in<b=
r>the cache index, aliasing can occur.<br><br><br>As there is no hardware s=
olution in the mips to recover from this<br>(which would provide some cache=
 coherency, even for one core), the
<br>only intrinsic safe solution is to enlarge the page size, so that<br>ca=
che indexing is only done by the offset address in the page (thus<br>the ph=
ysical part of the address).<br>Another solution is to flush the cache if a=
 page is being remapped to
<br>an aliased address (but in our case linux does not has control on the<b=
r>second core, which can cause issues with shared data between both<br>core=
s).<br>Currently the second solution is used in the kernel, but we found
<br>different issues with it (for instance: we had to merge more recent<br>=
mips kernels, to get a reliable copy-on-write behaviour after<br>forks...).=
<br><br>Therefore some questions:<br>- Are there still some known issues wi=
th cache aliasing in the MIPS kernel?
<br>- Are there known issues when using 16KB pages (8KB pages seems not be<=
br>possible due to tlb issues).<br><br>Thanks in advance,<br>Luc<br><br></b=
lockquote></div><br></div></div><div> <span style=3D"border-collapse: separ=
ate; color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-sty=
le: normal; font-variant: normal; font-weight: normal; letter-spacing: norm=
al; line-height: normal; text-indent: 0px; text-transform: none; white-spac=
e: normal; word-spacing: 0px;">
<div style=3D""><span style=3D"border-collapse: separate; color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; font-varia=
nt: normal; font-weight: normal; letter-spacing: normal; line-height: norma=
l; text-indent: 0px; text-transform: none; white-space: normal; word-spacin=
g: 0px;">
<div style=3D""><div style=3D"margin: 0px;">_______________________________=
________</div><div style=3D"margin: 0px; min-height: 14px;"><br></div><div =
style=3D"margin: 0px;">Mr Markus Gothe</div><div style=3D"margin: 0px;">Sof=
tware Engineer
</div><div style=3D"margin: 0px; min-height: 14px;"><br></div><div style=3D=
"margin: 0px;">Phone: +46 (0)13 21 81 20 (ext. 1046)</div><div style=3D"mar=
gin: 0px;">Fax: +46 (0)13 21 21 15</div><div style=3D"margin: 0px;">Mobile:=
 +46 (0)70 348 44 35
</div><div style=3D"margin: 0px;">Diskettgatan 11, SE-583 35 Link=F6ping, S=
weden</div><div style=3D"margin: 0px;"><a href=3D"http://www.27m.com" targe=
t=3D"_blank">www.27m.com</a></div></div><br></span></div></span><br> </div>=
<br></div>
</div></div></div></blockquote></div><br>

------=_Part_4593_33111181.1200378880227--
