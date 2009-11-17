Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Nov 2009 10:00:19 +0100 (CET)
Received: from mail-iw0-f181.google.com ([209.85.223.181]:59287 "EHLO
	mail-iw0-f181.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492449AbZKQJAM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 17 Nov 2009 10:00:12 +0100
Received: by iwn11 with SMTP id 11so6494310iwn.22
        for <multiple recipients>; Tue, 17 Nov 2009 01:00:00 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=6c4oSV1ffMn29BNxOs6VOARPUGJvn7xe5pAhDfyHfqI=;
        b=b9kyHwFpf1oWhylwncIjRfsnu5t1Mp+yMgxFWIZysc0wjLPArqRf1uYyjPhicrhjLv
         5iganvtktTDlX5rm00oCJXgfsGhVk/6gRUnzusLu8TyJXzx+yGaJKmQiTMRznPUk67Ws
         HvbGhZz7U1aiXPGwHfpjx0ej01gUEbCIu223w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=UXzOdgu1PxwW/QTY5LwbXeBx5HjQSYkyINMujzqH5sSVDaR6hbDQ7L9KX8k5uCzxm/
         XJZxNzJehaz6MiGQ/UO3QKpjCKN4Wv8pKgS4SecGMaCgx81xmsUE/z1BnhxLBhrY0gCw
         DoTIp9UQrh/RcXRNSY+l9VQuRAf7todNHR4Dk=
MIME-Version: 1.0
Received: by 10.231.1.22 with SMTP id 22mr1357882ibd.56.1258448399975; Tue, 17 
	Nov 2009 00:59:59 -0800 (PST)
In-Reply-To: <20091117084047.GA2923@linux-mips.org>
References: <c6ed1ac50911170012u7a52fbb9h1ae62cabf766122f@mail.gmail.com>
	 <20091117084047.GA2923@linux-mips.org>
Date:	Tue, 17 Nov 2009 16:59:59 +0800
Message-ID: <c6ed1ac50911170059w600de299kfe4d79916547d809@mail.gmail.com>
Subject: Re: why it not write those 6bits to entrylo0/1 register?
From:	figo zhang <figo1802@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=00151773eaa0d9443f04788d593c
Return-Path: <figo1802@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: figo1802@gmail.com
Precedence: bulk
X-list: linux-mips

--00151773eaa0d9443f04788d593c
Content-Type: text/plain; charset=ISO-8859-1

2009/11/17 Ralf Baechle <ralf@linux-mips.org>

> On Tue, Nov 17, 2009 at 04:12:03PM +0800, figo zhang wrote:
>
> > hi, all,
> > i have a qusetion , in arch/mips/mm/tlb-r4k.c, __update_tlb() function:
> >  321<
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/mips/mm/tlb-r4k.c;h=d73428b18b0a41da13e81c64021e62505200ff2d;hb=317c68c04d53198f38314d29ba28b8fc632eccab#l321
> >#if
> > defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
> > 322<
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/mips/mm/tlb-r4k.c;h=d73428b18b0a41da13e81c64021e62505200ff2d;hb=317c68c04d53198f38314d29ba28b8fc632eccab#l322
> >
> >                write_c0_entrylo0(ptep->pte_high);
> > 323<
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/mips/mm/tlb-r4k.c;h=d73428b18b0a41da13e81c64021e62505200ff2d;hb=317c68c04d53198f38314d29ba28b8fc632eccab#l323
> >
> >                ptep++;
> > 324<
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/mips/mm/tlb-r4k.c;h=d73428b18b0a41da13e81c64021e62505200ff2d;hb=317c68c04d53198f38314d29ba28b8fc632eccab#l324
> >
> >                write_c0_entrylo1(ptep->pte_high);
> > 325<
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/mips/mm/tlb-r4k.c;h=d73428b18b0a41da13e81c64021e62505200ff2d;hb=317c68c04d53198f38314d29ba28b8fc632eccab#l325
> >#else
> > 326<
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/mips/mm/tlb-r4k.c;h=d73428b18b0a41da13e81c64021e62505200ff2d;hb=317c68c04d53198f38314d29ba28b8fc632eccab#l326
> >
> >                write_c0_entrylo0(pte_val(*ptep++) >> 6);
> > 327<
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/mips/mm/tlb-r4k.c;h=d73428b18b0a41da13e81c64021e62505200ff2d;hb=317c68c04d53198f38314d29ba28b8fc632eccab#l327
> >
> >                write_c0_entrylo1(pte_val(*ptep) >> 6);
> > 328<
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/mips/mm/tlb-r4k.c;h=d73428b18b0a41da13e81c64021e62505200ff2d;hb=317c68c04d53198f38314d29ba28b8fc632eccab#l328
> >#endif
> >
> > why this right shift 6 bits? this 6 bits contain some important bit, such
> > as:
> > C: [bit3~5]: cohereny attribute of page
>
> No, the low 6 bits contain other information maintained by the kernel.
> Shifting right by 6 bits is used to drop these software bits.  The
> hardware bits are stored in bits 6 and up in a pte so the shift operation
> is going to move them into the right place.
>

But i have see the kernel code: include/asm-mips/pgtable-bits.h:
#define _CACHE_UNCACHED             (2<<3)
#define _CACHE_CACHABLE_NONCOHERENT (3<<3)
#define _CACHE_CACHABLE_COW         (3<<3)  /* Au1x                    */

#ifdef CONFIG_MIPS_UNCACHED
#define PAGE_CACHABLE_DEFAULT _CACHE_UNCACHED
#elif defined(CONFIG_DMA_NONCOHERENT)
#define PAGE_CACHABLE_DEFAULT _CACHE_CACHABLE_NONCOHERENT
#elif defined(CONFIG_CPU_RM9000)
#define PAGE_CACHABLE_DEFAULT _CACHE_CWB
#else
#define PAGE_CACHABLE_DEFAULT _CACHE_CACHABLE_COW
#endif

in include/asm-mips/pgtbale.h:
#define PAGE_READONLY __pgprot(_PAGE_PRESENT | _PAGE_READ | \
   PAGE_CACHABLE_DEFAULT)

so, if i set a page attrubite is PAGE_READONLY, this attribute will set to
pte , right? so ,
why it should shift 6 bits?

>
> > D:
> > V:
> > G:
> >
> > and how the kernel write the this 6 bit to entrylo0/1 register?
>
> A TLB write instruction about 5 lines further down in the code.
>

which function write those 6 bits to register? tlb_write_indexed() ? if i
want set pages cache attribute is uncached/write-back , how it can set it
correctly to MIPS?

Thanks,
Figo.zhang

>
>  Ralf
>

--00151773eaa0d9443f04788d593c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br>
<div class=3D"gmail_quote">2009/11/17 Ralf Baechle <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:ralf@linux-mips.org">ralf@linux-mips.org</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div class=3D"im">On Tue, Nov 17, 2009 at 04:12:03PM +0800, figo zhang wrot=
e:<br><br>&gt; hi, all,<br>&gt; i have a qusetion , in arch/mips/mm/tlb-r4k=
.c, __update_tlb() function:<br></div>&gt; =A0321&lt;<a href=3D"http://git.=
kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dblob;f=3Darch/m=
ips/mm/tlb-r4k.c;h=3Dd73428b18b0a41da13e81c64021e62505200ff2d;hb=3D317c68c0=
4d53198f38314d29ba28b8fc632eccab#l321" target=3D"_blank">http://git.kernel.=
org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dblob;f=3Darch/mips/mm/=
tlb-r4k.c;h=3Dd73428b18b0a41da13e81c64021e62505200ff2d;hb=3D317c68c04d53198=
f38314d29ba28b8fc632eccab#l321</a>&gt;#if<br>

<div class=3D"im">&gt; defined(CONFIG_64BIT_PHYS_ADDR) &amp;&amp; defined(C=
ONFIG_CPU_MIPS32)<br></div>&gt; 322&lt;<a href=3D"http://git.kernel.org/?p=
=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dblob;f=3Darch/mips/mm/tlb-r4=
k.c;h=3Dd73428b18b0a41da13e81c64021e62505200ff2d;hb=3D317c68c04d53198f38314=
d29ba28b8fc632eccab#l322" target=3D"_blank">http://git.kernel.org/?p=3Dlinu=
x/kernel/git/torvalds/linux-2.6.git;a=3Dblob;f=3Darch/mips/mm/tlb-r4k.c;h=
=3Dd73428b18b0a41da13e81c64021e62505200ff2d;hb=3D317c68c04d53198f38314d29ba=
28b8fc632eccab#l322</a>&gt;<br>

<div class=3D"im">&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0write_c0_entrylo0(pte=
p-&gt;pte_high);<br></div>&gt; 323&lt;<a href=3D"http://git.kernel.org/?p=
=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dblob;f=3Darch/mips/mm/tlb-r4=
k.c;h=3Dd73428b18b0a41da13e81c64021e62505200ff2d;hb=3D317c68c04d53198f38314=
d29ba28b8fc632eccab#l323" target=3D"_blank">http://git.kernel.org/?p=3Dlinu=
x/kernel/git/torvalds/linux-2.6.git;a=3Dblob;f=3Darch/mips/mm/tlb-r4k.c;h=
=3Dd73428b18b0a41da13e81c64021e62505200ff2d;hb=3D317c68c04d53198f38314d29ba=
28b8fc632eccab#l323</a>&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ptep++;<br>&gt; 324&lt;<a href=3D"http:=
//git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dblob;f=3D=
arch/mips/mm/tlb-r4k.c;h=3Dd73428b18b0a41da13e81c64021e62505200ff2d;hb=3D31=
7c68c04d53198f38314d29ba28b8fc632eccab#l324" target=3D"_blank">http://git.k=
ernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dblob;f=3Darch/mi=
ps/mm/tlb-r4k.c;h=3Dd73428b18b0a41da13e81c64021e62505200ff2d;hb=3D317c68c04=
d53198f38314d29ba28b8fc632eccab#l324</a>&gt;<br>

<div class=3D"im">&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0write_c0_entrylo1(pte=
p-&gt;pte_high);<br></div>&gt; 325&lt;<a href=3D"http://git.kernel.org/?p=
=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dblob;f=3Darch/mips/mm/tlb-r4=
k.c;h=3Dd73428b18b0a41da13e81c64021e62505200ff2d;hb=3D317c68c04d53198f38314=
d29ba28b8fc632eccab#l325" target=3D"_blank">http://git.kernel.org/?p=3Dlinu=
x/kernel/git/torvalds/linux-2.6.git;a=3Dblob;f=3Darch/mips/mm/tlb-r4k.c;h=
=3Dd73428b18b0a41da13e81c64021e62505200ff2d;hb=3D317c68c04d53198f38314d29ba=
28b8fc632eccab#l325</a>&gt;#else<br>
&gt; 326&lt;<a href=3D"http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds=
/linux-2.6.git;a=3Dblob;f=3Darch/mips/mm/tlb-r4k.c;h=3Dd73428b18b0a41da13e8=
1c64021e62505200ff2d;hb=3D317c68c04d53198f38314d29ba28b8fc632eccab#l326" ta=
rget=3D"_blank">http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-=
2.6.git;a=3Dblob;f=3Darch/mips/mm/tlb-r4k.c;h=3Dd73428b18b0a41da13e81c64021=
e62505200ff2d;hb=3D317c68c04d53198f38314d29ba28b8fc632eccab#l326</a>&gt;<br=
>

<div class=3D"im">&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0write_c0_entrylo0(pte=
_val(*ptep++) &gt;&gt; 6);<br></div>&gt; 327&lt;<a href=3D"http://git.kerne=
l.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dblob;f=3Darch/mips/m=
m/tlb-r4k.c;h=3Dd73428b18b0a41da13e81c64021e62505200ff2d;hb=3D317c68c04d531=
98f38314d29ba28b8fc632eccab#l327" target=3D"_blank">http://git.kernel.org/?=
p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dblob;f=3Darch/mips/mm/tlb-r=
4k.c;h=3Dd73428b18b0a41da13e81c64021e62505200ff2d;hb=3D317c68c04d53198f3831=
4d29ba28b8fc632eccab#l327</a>&gt;<br>

<div class=3D"im">&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0write_c0_entrylo1(pte=
_val(*ptep) &gt;&gt; 6);<br></div>&gt; 328&lt;<a href=3D"http://git.kernel.=
org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dblob;f=3Darch/mips/mm/=
tlb-r4k.c;h=3Dd73428b18b0a41da13e81c64021e62505200ff2d;hb=3D317c68c04d53198=
f38314d29ba28b8fc632eccab#l328" target=3D"_blank">http://git.kernel.org/?p=
=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dblob;f=3Darch/mips/mm/tlb-r4=
k.c;h=3Dd73428b18b0a41da13e81c64021e62505200ff2d;hb=3D317c68c04d53198f38314=
d29ba28b8fc632eccab#l328</a>&gt;#endif<br>

<div class=3D"im">&gt;<br>&gt; why this right shift 6 bits? this 6 bits con=
tain some important bit, such<br>&gt; as:<br>&gt; C: [bit3~5]: cohereny att=
ribute of page<br><br></div>No, the low 6 bits contain other information ma=
intained by the kernel.<br>
Shifting right by 6 bits is used to drop these software bits. =A0The<br>har=
dware bits are stored in bits 6 and up in a pte so the shift operation<br>i=
s going to move them into the right place.<br></blockquote>
<div>=A0</div>
<div>But i have see the kernel code: include/asm-mips/pgtable-bits.h:</div>
<div>#define _CACHE_UNCACHED=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (2&lt;&lt;=
3)<br>#define _CACHE_CACHABLE_NONCOHERENT (3&lt;&lt;3)<br>#define _CACHE_CA=
CHABLE_COW=A0=A0=A0=A0=A0=A0=A0=A0 (3&lt;&lt;3)=A0 /* Au1x=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */</div>
<div>=A0</div>
<div>#ifdef CONFIG_MIPS_UNCACHED<br>#define PAGE_CACHABLE_DEFAULT=A0_CACHE_=
UNCACHED<br>#elif defined(CONFIG_DMA_NONCOHERENT)<br>#define PAGE_CACHABLE_=
DEFAULT=A0_CACHE_CACHABLE_NONCOHERENT<br>#elif defined(CONFIG_CPU_RM9000)<b=
r>
#define PAGE_CACHABLE_DEFAULT=A0_CACHE_CWB<br>#else<br>#define PAGE_CACHABL=
E_DEFAULT=A0_CACHE_CACHABLE_COW<br>#endif</div>
<div>=A0</div>
<div>in include/asm-mips/pgtbale.h:</div>
<div>#define PAGE_READONLY=A0__pgprot(_PAGE_PRESENT | _PAGE_READ | \<br>=A0=
=A0=A0PAGE_CACHABLE_DEFAULT)</div>
<div>=A0</div>
<div>so, if i set a page attrubite is PAGE_READONLY, this attribute will se=
t to pte , right? so ,</div>
<div>why it should shift 6 bits?</div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div class=3D"im"><br>&gt; D:<br>&gt; V:<br>&gt; G:<br>&gt;<br>&gt; and how=
 the kernel write the this 6 bit to entrylo0/1 register?<br><br></div>A TLB=
 write instruction about 5 lines further down in the code.<br></blockquote>

<div>=A0</div>
<div>which function write those 6 bits to register? tlb_write_indexed() ?=
=A0if i want set pages cache=A0attribute=A0is uncached/write-back , how it =
can set it correctly to MIPS?</div>
<div>=A0</div>
<div>Thanks,</div>
<div>Figo.zhang</div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><font color=3D"#888888"><br>=A0R=
alf<br></font></blockquote></div><br>

--00151773eaa0d9443f04788d593c--
