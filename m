Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Nov 2009 10:37:41 +0100 (CET)
Received: from mail-px0-f173.google.com ([209.85.216.173]:47974 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492113AbZKQJhe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 17 Nov 2009 10:37:34 +0100
Received: by pxi3 with SMTP id 3so794692pxi.22
        for <multiple recipients>; Tue, 17 Nov 2009 01:37:26 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=EXHeoVl2/cKY+2IwnArpxxkHQXpb92ZIa/avgAkvE2E=;
        b=lcjM0yvOn8z4K+XrfA1Ijra0nfDBdpjUXrO9b3Y4MP0gbYArai9GTjQcTPOq1GxT+2
         AaOJssI92LPQvEwFnVQiGqnr+jp6aBgBzu2+MKVra6MuDaqfssPPxIxaMwzsvmQEGQk3
         QURby79YcZxpEQZ00PPOkT4TaCdfExIxnwq7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=e7gMqQhZuHyh5wXuld5tkPkwoqGoiJKy8o5tdrHP7t037ABs3RH8zPgISy5WMKWSFm
         rchFGwVa+KM1i9tY3tK2ocqQZDAKvu27CbslMaxig6PWEhcZ6SDAjTC46+MfkGJCY788
         3ybVi92pAbUi3C25TlGmeVTo4yYb245nyESQ0=
MIME-Version: 1.0
Received: by 10.115.86.3 with SMTP id o3mr1752430wal.206.1258450645623; Tue, 
	17 Nov 2009 01:37:25 -0800 (PST)
In-Reply-To: <20091117092601.GB2923@linux-mips.org>
References: <c6ed1ac50911170012u7a52fbb9h1ae62cabf766122f@mail.gmail.com>
	 <20091117084047.GA2923@linux-mips.org>
	 <c6ed1ac50911170059w600de299kfe4d79916547d809@mail.gmail.com>
	 <20091117092601.GB2923@linux-mips.org>
Date:	Tue, 17 Nov 2009 17:37:25 +0800
Message-ID: <c6ed1ac50911170137u7463ad53k1568e722696ca570@mail.gmail.com>
Subject: Re: why it not write those 6bits to entrylo0/1 register?
From:	figo zhang <figo1802@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=0016e64b9506b325dd04788ddfa1
Return-Path: <figo1802@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: figo1802@gmail.com
Precedence: bulk
X-list: linux-mips

--0016e64b9506b325dd04788ddfa1
Content-Type: text/plain; charset=ISO-8859-1

2009/11/17 Ralf Baechle <ralf@linux-mips.org>

> On Tue, Nov 17, 2009 at 04:59:59PM +0800, figo zhang wrote:
>
> > > > why this right shift 6 bits? this 6 bits contain some important bit,
> such
> > > > as:
> > > > C: [bit3~5]: cohereny attribute of page
> > >
> > > No, the low 6 bits contain other information maintained by the kernel.
> > > Shifting right by 6 bits is used to drop these software bits.  The
> > > hardware bits are stored in bits 6 and up in a pte so the shift
> operation
> > > is going to move them into the right place.
> > >
> >
> > But i have see the kernel code: include/asm-mips/pgtable-bits.h:
> > #define _CACHE_UNCACHED             (2<<3)
> > #define _CACHE_CACHABLE_NONCOHERENT (3<<3)
> > #define _CACHE_CACHABLE_COW         (3<<3)  /* Au1x                    */
>
> This is code for the special case where CONFIG_64BIT_PHYS_ADDR and
> CONFIG_CPU_MIPS32 are both defined.  In that case tlb-r4k.c also won't do
> shifting.
>
> > in include/asm-mips/pgtbale.h:
> > #define PAGE_READONLY __pgprot(_PAGE_PRESENT | _PAGE_READ | \
> >    PAGE_CACHABLE_DEFAULT)
> >
> > so, if i set a page attrubite is PAGE_READONLY, this attribute will set
> to
> > pte , right? so ,
> > why it should shift 6 bits?
>

Thanks a lot. I am puzzle that  if i set a page attrubite is PAGE_READONLY,
tlb_write_indexed()
will write the 6 bits to entrylo0 register? i am using 24KEC soc.

Thanks,
Figo.zhang


> >
> > >
> > > > D:
> > > > V:
> > > > G:
> > > >
> > > > and how the kernel write the this 6 bit to entrylo0/1 register?
> > >
> > > A TLB write instruction about 5 lines further down in the code.
> > >
> >
> > which function write those 6 bits to register? tlb_write_indexed() ? if i
> > want set pages cache attribute is uncached/write-back , how it can set it
> > correctly to MIPS?
>
> See drivers/char/mem.c; search for pgprot_noncached().  This is where
> for uncached mmaps pick the apropriate page protection and cache bits.
> Several other drivers may do equivalent things.
>
>  Ralf
>

--0016e64b9506b325dd04788ddfa1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br>
<div class=3D"gmail_quote">2009/11/17 Ralf Baechle <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:ralf@linux-mips.org">ralf@linux-mips.org</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div class=3D"im">On Tue, Nov 17, 2009 at 04:59:59PM +0800, figo zhang wrot=
e:<br><br>&gt; &gt; &gt; why this right shift 6 bits? this 6 bits contain s=
ome important bit, such<br>&gt; &gt; &gt; as:<br>&gt; &gt; &gt; C: [bit3~5]=
: cohereny attribute of page<br>
&gt; &gt;<br>&gt; &gt; No, the low 6 bits contain other information maintai=
ned by the kernel.<br>&gt; &gt; Shifting right by 6 bits is used to drop th=
ese software bits. =A0The<br>&gt; &gt; hardware bits are stored in bits 6 a=
nd up in a pte so the shift operation<br>
&gt; &gt; is going to move them into the right place.<br>&gt; &gt;<br>&gt;<=
br>&gt; But i have see the kernel code: include/asm-mips/pgtable-bits.h:<br=
>&gt; #define _CACHE_UNCACHED =A0 =A0 =A0 =A0 =A0 =A0 (2&lt;&lt;3)<br>&gt; =
#define _CACHE_CACHABLE_NONCOHERENT (3&lt;&lt;3)<br>
&gt; #define _CACHE_CACHABLE_COW =A0 =A0 =A0 =A0 (3&lt;&lt;3) =A0/* Au1x =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/<br><br></div>This is code for the=
 special case where CONFIG_64BIT_PHYS_ADDR and<br>CONFIG_CPU_MIPS32 are bot=
h defined. =A0In that case tlb-r4k.c also won&#39;t do<br>
shifting.<br>
<div class=3D"im"><br>&gt; in include/asm-mips/pgtbale.h:<br>&gt; #define P=
AGE_READONLY __pgprot(_PAGE_PRESENT | _PAGE_READ | \<br>&gt; =A0 =A0PAGE_CA=
CHABLE_DEFAULT)<br>&gt;<br>&gt; so, if i set a page attrubite is PAGE_READO=
NLY, this attribute will set to<br>
&gt; pte , right? so ,<br>&gt; why it should shift 6 bits?<br></div></block=
quote>
<div>=A0</div>
<div>Thanks a lot. I am puzzle that=A0 if i set a page attrubite is PAGE_RE=
ADONLY, tlb_write_indexed() </div>
<div>will write the 6 bits to entrylo0 register? i am using 24KEC soc.</div=
>
<div>=A0</div>
<div>Thanks,</div>
<div>Figo.zhang</div>
<div>=A0</div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div class=3D"im">&gt;<br>&gt; &gt;<br>&gt; &gt; &gt; D:<br>&gt; &gt; &gt; =
V:<br>&gt; &gt; &gt; G:<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; and how the ker=
nel write the this 6 bit to entrylo0/1 register?<br>&gt; &gt;<br>&gt; &gt; =
A TLB write instruction about 5 lines further down in the code.<br>
&gt; &gt;<br>&gt;<br>&gt; which function write those 6 bits to register? tl=
b_write_indexed() ? if i<br>&gt; want set pages cache attribute is uncached=
/write-back , how it can set it<br>&gt; correctly to MIPS?<br><br></div>
See drivers/char/mem.c; search for pgprot_noncached(). =A0This is where<br>=
for uncached mmaps pick the apropriate page protection and cache bits.<br>S=
everal other drivers may do equivalent things.<br><font color=3D"#888888"><=
br>
=A0Ralf<br></font></blockquote></div><br>

--0016e64b9506b325dd04788ddfa1--
