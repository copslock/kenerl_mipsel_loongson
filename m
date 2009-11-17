Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Nov 2009 09:12:18 +0100 (CET)
Received: from mail-iw0-f181.google.com ([209.85.223.181]:46632 "EHLO
	mail-iw0-f181.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492267AbZKQIML (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 17 Nov 2009 09:12:11 +0100
Received: by iwn11 with SMTP id 11so6477768iwn.22
        for <multiple recipients>; Tue, 17 Nov 2009 00:12:03 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=7UGFyF7iQWdY+I2mgsoWO8tzDL6LoCWj3nSYg56E074=;
        b=dljevj299f+RvY9ai9OpTvEAvF1lqE8TGNWJaKEjApPxyQDG0nfU8sLHS0+yz2a/P1
         rRUY7QsEBQlia0D6SKn54ok56wnKg8GMg0Y5R+WLrHwbtiF3ubNyVgeCC1ITTTE8EAp+
         rALs6pLObD1t16+py2YcHmtwPFAEhCWSYYCVg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=LyO092cpq5znqniIZ42ff2jWJ51MMFyNMoNkb218oS/KFvBqOjieAIdnTrOOPZaZ9s
         izrBj5bExKsc+q/CK+b9jLjNlPupINzgkDYSgYVFkFVKYaK6kWKLPtcVOb3NhXkORd+N
         jt6oIk8ANs/3FRidJv2fTC/5lTPQZZnALtLRE=
MIME-Version: 1.0
Received: by 10.231.170.201 with SMTP id e9mr811156ibz.15.1258445523167; Tue, 
	17 Nov 2009 00:12:03 -0800 (PST)
Date:	Tue, 17 Nov 2009 16:12:03 +0800
Message-ID: <c6ed1ac50911170012u7a52fbb9h1ae62cabf766122f@mail.gmail.com>
Subject: why it not write those 6bits to entrylo0/1 register?
From:	figo zhang <figo1802@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Content-Type: multipart/alternative; boundary=00504501810260acd404788cae31
Return-Path: <figo1802@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: figo1802@gmail.com
Precedence: bulk
X-list: linux-mips

--00504501810260acd404788cae31
Content-Type: text/plain; charset=ISO-8859-1

hi, all,
i have a qusetion , in arch/mips/mm/tlb-r4k.c, __update_tlb() function:
 321<http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/mips/mm/tlb-r4k.c;h=d73428b18b0a41da13e81c64021e62505200ff2d;hb=317c68c04d53198f38314d29ba28b8fc632eccab#l321>#if
defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
322<http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/mips/mm/tlb-r4k.c;h=d73428b18b0a41da13e81c64021e62505200ff2d;hb=317c68c04d53198f38314d29ba28b8fc632eccab#l322>
               write_c0_entrylo0(ptep->pte_high);
323<http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/mips/mm/tlb-r4k.c;h=d73428b18b0a41da13e81c64021e62505200ff2d;hb=317c68c04d53198f38314d29ba28b8fc632eccab#l323>
               ptep++;
324<http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/mips/mm/tlb-r4k.c;h=d73428b18b0a41da13e81c64021e62505200ff2d;hb=317c68c04d53198f38314d29ba28b8fc632eccab#l324>
               write_c0_entrylo1(ptep->pte_high);
325<http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/mips/mm/tlb-r4k.c;h=d73428b18b0a41da13e81c64021e62505200ff2d;hb=317c68c04d53198f38314d29ba28b8fc632eccab#l325>#else
326<http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/mips/mm/tlb-r4k.c;h=d73428b18b0a41da13e81c64021e62505200ff2d;hb=317c68c04d53198f38314d29ba28b8fc632eccab#l326>
               write_c0_entrylo0(pte_val(*ptep++) >> 6);
327<http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/mips/mm/tlb-r4k.c;h=d73428b18b0a41da13e81c64021e62505200ff2d;hb=317c68c04d53198f38314d29ba28b8fc632eccab#l327>
               write_c0_entrylo1(pte_val(*ptep) >> 6);
328<http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/mips/mm/tlb-r4k.c;h=d73428b18b0a41da13e81c64021e62505200ff2d;hb=317c68c04d53198f38314d29ba28b8fc632eccab#l328>#endif

why this right shift 6 bits? this 6 bits contain some important bit, such
as:
C: [bit3~5]: cohereny attribute of page
D:
V:
G:

and how the kernel write the this 6 bit to entrylo0/1 register?

Best,
Figo.zhang

--00504501810260acd404788cae31
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>hi, all,</div>
<div>i have a qusetion , in arch/mips/mm/tlb-r4k.c, __update_tlb() function=
:</div>
<div>
<div class=3D"pre"><a class=3D"linenr" id=3D"l321" href=3D"http://git.kerne=
l.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dblob;f=3Darch/mips/m=
m/tlb-r4k.c;h=3Dd73428b18b0a41da13e81c64021e62505200ff2d;hb=3D317c68c04d531=
98f38314d29ba28b8fc632eccab#l321">321</a> #if=A0defined(CONFIG_64BIT_PHYS_A=
DDR)=A0&amp;&amp;=A0defined(CONFIG_CPU_MIPS32)</div>

<div class=3D"pre"><a class=3D"linenr" id=3D"l322" href=3D"http://git.kerne=
l.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dblob;f=3Darch/mips/m=
m/tlb-r4k.c;h=3Dd73428b18b0a41da13e81c64021e62505200ff2d;hb=3D317c68c04d531=
98f38314d29ba28b8fc632eccab#l322">322</a> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0write_c0_entrylo0(ptep-&gt;pte_high);</div>

<div class=3D"pre"><a class=3D"linenr" id=3D"l323" href=3D"http://git.kerne=
l.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dblob;f=3Darch/mips/m=
m/tlb-r4k.c;h=3Dd73428b18b0a41da13e81c64021e62505200ff2d;hb=3D317c68c04d531=
98f38314d29ba28b8fc632eccab#l323">323</a> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0ptep++;</div>

<div class=3D"pre"><a class=3D"linenr" id=3D"l324" href=3D"http://git.kerne=
l.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dblob;f=3Darch/mips/m=
m/tlb-r4k.c;h=3Dd73428b18b0a41da13e81c64021e62505200ff2d;hb=3D317c68c04d531=
98f38314d29ba28b8fc632eccab#l324">324</a> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0write_c0_entrylo1(ptep-&gt;pte_high);</div>

<div class=3D"pre"><a class=3D"linenr" id=3D"l325" href=3D"http://git.kerne=
l.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dblob;f=3Darch/mips/m=
m/tlb-r4k.c;h=3Dd73428b18b0a41da13e81c64021e62505200ff2d;hb=3D317c68c04d531=
98f38314d29ba28b8fc632eccab#l325">325</a> #else</div>

<div class=3D"pre"><a class=3D"linenr" id=3D"l326" href=3D"http://git.kerne=
l.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dblob;f=3Darch/mips/m=
m/tlb-r4k.c;h=3Dd73428b18b0a41da13e81c64021e62505200ff2d;hb=3D317c68c04d531=
98f38314d29ba28b8fc632eccab#l326">326</a> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0write_c0_entrylo0(pte_val(*ptep++)=A0&gt;&gt;=A06);</div>

<div class=3D"pre"><a class=3D"linenr" id=3D"l327" href=3D"http://git.kerne=
l.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dblob;f=3Darch/mips/m=
m/tlb-r4k.c;h=3Dd73428b18b0a41da13e81c64021e62505200ff2d;hb=3D317c68c04d531=
98f38314d29ba28b8fc632eccab#l327">327</a> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0write_c0_entrylo1(pte_val(*ptep)=A0&gt;&gt;=A06);</div>

<div class=3D"pre"><a class=3D"linenr" id=3D"l328" href=3D"http://git.kerne=
l.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dblob;f=3Darch/mips/m=
m/tlb-r4k.c;h=3Dd73428b18b0a41da13e81c64021e62505200ff2d;hb=3D317c68c04d531=
98f38314d29ba28b8fc632eccab#l328">328</a> #endif</div>

<div class=3D"pre">=A0</div>
<div class=3D"pre">why this right shift 6 bits? this 6 bits contain some im=
portant bit, such as:</div>
<div class=3D"pre">C: [bit3~5]: cohereny attribute of page</div>
<div class=3D"pre">D:</div>
<div class=3D"pre">V:</div>
<div class=3D"pre">G:</div></div>
<div>=A0</div>
<div>and how the kernel write the this 6 bit to entrylo0/1 register?</div>
<div>=A0</div>
<div>Best,</div>
<div>Figo.zhang</div>

--00504501810260acd404788cae31--
