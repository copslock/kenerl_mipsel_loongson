Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 May 2016 22:29:55 +0200 (CEST)
Received: from mail-io0-f169.google.com ([209.85.223.169]:35740 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27033511AbcEWUCwgAf5Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 May 2016 22:02:52 +0200
Received: by mail-io0-f169.google.com with SMTP id p64so109153899ioi.2;
        Mon, 23 May 2016 13:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=KP5JPzNjmCJbAMS3wu+tahbCIHftCLpExx4H35R7xM0=;
        b=DcE/jcqs+PL7ewB3F5lGjf01IqS2CB1QLfTG98MZIC7Q/fY3jrQJFNgwABeqKoIw5x
         rU8/i7K3fxXtGx80/CAFBMW1INBo2FR3Y6pfbGOVt9IdqolNCmxTGIYqsLu9nh3hnH1v
         CumOga268ZvNo1dPGY46yWTj7brh67PKDLg1kmVIJmuO5igXg3agMfATM+Z9J1x5vosQ
         yD9bPrUYSKNLcADW0E89BMgJy9UPp1ohquj4638GroEYJfAJtpkgTaf1sgzCwB2ZXtzM
         pOAeLjoruX1ZxXrCTqVMx4h9sRID0RyNCMQOQdYJ/I9AeD/w/MelbBqLmYanngYkY7Pt
         vNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=KP5JPzNjmCJbAMS3wu+tahbCIHftCLpExx4H35R7xM0=;
        b=Z7QeKKrZI4Lp495xoEWOy/K5s7OhpwEA3CINtaPUbnPen1CNL+/l1927anfbPEF1aE
         KWR+cDlLQf4p4rV9hh8x/49jXszAD1TjK8/ecIdLoqT8bK/VA+b/yXtHE/VG1gmNpBk7
         /+i4KYVHTRSAG5I56DCs6ozPubpgG3Y54KwTAz9Y79AYHEeHYpEPHYnq4vScJw93ybxn
         0W1qNm9HBq+aWdGeBiFH1vJi1ZxD9P5QRfQ1ikV4LcL+PoJyOyg5ZdWd7AQUzIsJ80Ze
         8DCCFFowCnB+IHeZhA/VeyI/kk1QU/aRnLjJ9/JvwpmgihIMVzrtyMl+vi6MQ4NU2FUe
         pNtg==
X-Gm-Message-State: AOPr4FXx1o7QXe3wS2/JPYXawy0CQQ0bItKC5/kTFqwhnupU9/MtFGt7w5f+zG+b5pJSfvrcU/zdcocUmfggjw==
MIME-Version: 1.0
X-Received: by 10.107.12.154 with SMTP id 26mr13485508iom.21.1464033766433;
 Mon, 23 May 2016 13:02:46 -0700 (PDT)
Received: by 10.107.202.198 with HTTP; Mon, 23 May 2016 13:02:46 -0700 (PDT)
In-Reply-To: <57435538.7030503@gentoo.org>
References: <20160523151346.GA23204@ak-desktop.emea.nsn-net.net>
        <20160523152007.GB28729@linux-mips.org>
        <57432E02.9000008@gmail.com>
        <20160523185226.GA1253@raspberrypi.musicnaut.iki.fi>
        <57435538.7030503@gentoo.org>
Date:   Mon, 23 May 2016 16:02:46 -0400
Message-ID: <CAEcYz2SiSLCnYnXP+1Y8M71tPaOvLAUhJgEhunipjAfoPb4V4g@mail.gmail.com>
Subject: Re: THP broken on OCTEON?
From:   Alastair Bridgewater <alastair.bridgewater@gmail.com>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        linux-mips@linux-mips.org, "Hill, Steven" <Steven.Hill@cavium.com>
Content-Type: multipart/alternative; boundary=001a113ee558967104053387ece5
Return-Path: <alastair.bridgewater@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53626
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alastair.bridgewater@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

--001a113ee558967104053387ece5
Content-Type: text/plain; charset=UTF-8

On Mon, May 23, 2016 at 3:08 PM, Joshua Kinard <kumba@gentoo.org> wrote:

> On 05/23/2016 14:52, Aaro Koskinen wrote:
> > On Mon, May 23, 2016 at 09:21:22AM -0700, David Daney wrote:
> >> On 05/23/2016 08:20 AM, Ralf Baechle wrote:
> >>> On Mon, May 23, 2016 at 06:13:46PM +0300, Aaro Koskinen wrote:
> >>>> I'm getting kernel crashes (see below) reliably when building Perl in
> >>>> parallel (make -j16) on OCTEON EBH5600 board (8 cores, 4 GB RAM) with
> >>>> Linux 4.6.
> >>>>
> >>>> It seems that CONFIG_TRANSPARENT_HUGEPAGE has something to do with the
> >>>> issue - disabling it makes build go through fine.
> >>>>
> >>>> Any ideas?
> >>>
> >>> I thought it was working except on SGI Origin 200/2000 aka IP27 where
> >>> Joshua Kinard (added to cc) was hitting issues as well.
> >>>
> >>> Joshua, does that similar to the issues you were hitting?
> >>
> >> There is nothing OCTEON specific in the THP code, or huge pages in
> general.
> >>
> >> That said, we have seen other THP related failures, and have never been
> able
> >> to find the cause.
> >>
> >> If someone can come up with a reproducible test case that triggers
> quickly,
> >> we can run it in our simulator and easily find the problem.
> >
> > Trying to build Perl is a reliable reproducer. Is that too heavyweight
> > for your simulator?
> >
> > I was able to reproduce this also on EdgeRouter Pro, but there the kernel
> > does not fail, only compiler dies with SIGBUS:
> >
> > [  315.095264] Data bus error, epc == 0000000000a801c4, ra ==
> 0000000000a80624
> >
> > And without THP the build is fine.
> >
> > I also tried CN68XX board with 16 GB RAM and also there I get SIGBUS
> failure
> > instead of Machine Check.
>
> SIGBUS is closer to what I was seeing on IP30/IP27, but there's two
> different
> SIGBUS errors in MIPS, a Data Bus Error (DBE) and Instruction Bus Error
> (IBE).
>  I've only seen IBEs result from using THP on Octane/IP30 and
> Origin/Onyx2/IP27.
>
> Also CC'ing Alastair Bridgewater (nyef), who was working on bringing up the
> IP35 hardware (Origin 300/350), as he had been working on tracing down some
> possible issues in the TLB code.  He had a small test case at the below
> address
> (use annotation #2), but I don't know if he got any further on debugging
> it.
>
> http://paste.lisp.org/display/305809#2
>

I still haven't gotten anywhere with this. FWIW, we confirmed that it
affects at least some of the R1x000 CPUs, and it doesn't seem to affect
OCTEON (tested on an ERlite-3). And, at least for any IP35 testing (R14000
/ R16000), my kernel configuration does not include
CONFIG_TRANSPARENT_HUGEPAGE. One of the scary parts of this one is the
cases where it DOESN'T fault. It manages to read SOMETHING, but it's not
the right data (typically zeros, but it's still scary, and what if it was a
write instead of a read?). I don't really have any other systems to test
with, so I don't know if it's R10k-specific or somewhat more general.

-- Alastair

--001a113ee558967104053387ece5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Mon, May 23, 2016 at 3:08 PM, Joshua Kinard <span dir=
=3D"ltr">&lt;<a href=3D"mailto:kumba@gentoo.org" target=3D"_blank">kumba@ge=
ntoo.org</a>&gt;</span> wrote:<br><div class=3D"gmail_extra"><div class=3D"=
gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">On 05/23/2016 14:52, Aaro Koski=
nen wrote:<br>
&gt; On Mon, May 23, 2016 at 09:21:22AM -0700, David Daney wrote:<br>
&gt;&gt; On 05/23/2016 08:20 AM, Ralf Baechle wrote:<br>
&gt;&gt;&gt; On Mon, May 23, 2016 at 06:13:46PM +0300, Aaro Koskinen wrote:=
<br>
&gt;&gt;&gt;&gt; I&#39;m getting kernel crashes (see below) reliably when b=
uilding Perl in<br>
&gt;&gt;&gt;&gt; parallel (make -j16) on OCTEON EBH5600 board (8 cores, 4 G=
B RAM) with<br>
&gt;&gt;&gt;&gt; Linux 4.6.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; It seems that CONFIG_TRANSPARENT_HUGEPAGE has something to=
 do with the<br>
&gt;&gt;&gt;&gt; issue - disabling it makes build go through fine.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Any ideas?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I thought it was working except on SGI Origin 200/2000 aka IP2=
7 where<br>
&gt;&gt;&gt; Joshua Kinard (added to cc) was hitting issues as well.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Joshua, does that similar to the issues you were hitting?<br>
&gt;&gt;<br>
&gt;&gt; There is nothing OCTEON specific in the THP code, or huge pages in=
 general.<br>
&gt;&gt;<br>
&gt;&gt; That said, we have seen other THP related failures, and have never=
 been able<br>
&gt;&gt; to find the cause.<br>
&gt;&gt;<br>
&gt;&gt; If someone can come up with a reproducible test case that triggers=
 quickly,<br>
&gt;&gt; we can run it in our simulator and easily find the problem.<br>
&gt;<br>
&gt; Trying to build Perl is a reliable reproducer. Is that too heavyweight=
<br>
&gt; for your simulator?<br>
&gt;<br>
&gt; I was able to reproduce this also on EdgeRouter Pro, but there the ker=
nel<br>
&gt; does not fail, only compiler dies with SIGBUS:<br>
&gt;<br>
&gt; [=C2=A0 315.095264] Data bus error, epc =3D=3D 0000000000a801c4, ra =
=3D=3D 0000000000a80624<br>
&gt;<br>
&gt; And without THP the build is fine.<br>
&gt;<br>
&gt; I also tried CN68XX board with 16 GB RAM and also there I get SIGBUS f=
ailure<br>
&gt; instead of Machine Check.<br>
<br>
SIGBUS is closer to what I was seeing on IP30/IP27, but there&#39;s two dif=
ferent<br>
SIGBUS errors in MIPS, a Data Bus Error (DBE) and Instruction Bus Error (IB=
E).<br>
=C2=A0I&#39;ve only seen IBEs result from using THP on Octane/IP30 and Orig=
in/Onyx2/IP27.<br>
<br>
Also CC&#39;ing Alastair Bridgewater (nyef), who was working on bringing up=
 the<br>
IP35 hardware (Origin 300/350), as he had been working on tracing down some=
<br>
possible issues in the TLB code.=C2=A0 He had a small test case at the belo=
w address<br>
(use annotation #2), but I don&#39;t know if he got any further on debuggin=
g it.<br>
<br>
<a href=3D"http://paste.lisp.org/display/305809#2" rel=3D"noreferrer" targe=
t=3D"_blank">http://paste.lisp.org/display/305809#2</a><span class=3D"HOEnZ=
b"><font color=3D"#888888"><br></font></span></blockquote></div><br></div><=
div class=3D"gmail_extra">I still haven&#39;t gotten anywhere with this. FW=
IW, we confirmed that it affects at least some of the R1x000 CPUs, and it d=
oesn&#39;t seem to affect OCTEON (tested on an ERlite-3). And, at least for=
 any IP35 testing (R14000 / R16000), my kernel configuration does not inclu=
de CONFIG_TRANSPARENT_HUGEPAGE. One of the scary parts of this one is the c=
ases where it DOESN&#39;T fault. It manages to read SOMETHING, but it&#39;s=
 not the right data (typically zeros, but it&#39;s still scary, and what if=
 it was a write instead of a read?). I don&#39;t really have any other syst=
ems to test with, so I don&#39;t know if it&#39;s R10k-specific or somewhat=
 more general.<br><br></div><div class=3D"gmail_extra">-- Alastair<br></div=
></div>

--001a113ee558967104053387ece5--
