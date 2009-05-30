Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 May 2009 19:32:17 +0100 (BST)
Received: from an-out-0708.google.com ([209.85.132.251]:7498 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20022897AbZE3ScK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 30 May 2009 19:32:10 +0100
Received: by an-out-0708.google.com with SMTP id c37so3120195anc.24
        for <linux-mips@linux-mips.org>; Sat, 30 May 2009 11:32:08 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=Jf2AbPEWO6oUa8ja/IUFVdrtdO6tGMP5GuGahWyTV9U=;
        b=aSqX2NThb6wwGdgt+rEr8/wz94dQZd6BXjcaHcK+7BABP0Y/rQr918vxzb0i2bOFXp
         ZjaeTfmK8B01OFtzpN163Xsf0H1s8fDkEPd5Jar4J9lefeczIa0Nju4P3r1azhOeCemj
         vHKV5yy+7BCpv1ZOc5kspZ04FPsB6sPWuvNGM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=UOsCRNtZV2aCnaB2VFr3KyfkEhoDg5HeETltTxHNBSaEBa79oWaN2Ff2MT43iFnNVj
         kkl/6O3hsFqfF6w+VUv4p9EkOBid6nE4lT/pfJTnfe8R/DU9XFIIYm+/h8xsPuQ5IRYV
         Ijr0OzTHUhbTgY0IWGPY8BMCXeeTlTMnkRjqA=
MIME-Version: 1.0
Received: by 10.100.208.8 with SMTP id f8mr5267085ang.64.1243708328699; Sat, 
	30 May 2009 11:32:08 -0700 (PDT)
In-Reply-To: <4A20FF40.6010008@debian.org>
References: <4A20FF40.6010008@debian.org>
Date:	Sat, 30 May 2009 11:32:08 -0700
Message-ID: <347733d50905301132v40c07f58k91d1e74dc40d8521@mail.gmail.com>
Subject: Re: ld: non-dynamic relocations refer to dynamic symbol
From:	Kevin Cernekee <cernekee@gmail.com>
To:	Luk Claes <luk@debian.org>
Cc:	debian-mips@lists.debian.org, linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=001636af022e22eced046b256954
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

--001636af022e22eced046b256954
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Sat, May 30, 2009 at 2:41 AM, Luk Claes <luk@debian.org> wrote:

> There appears to be a mips specific bug in binutils which make some
> packages fail to build when linking. More details can be found in debian bug
> #519006 [0] and binutils upstream bug #10144 [1].
>

I have seen this error when -fPIC is accidentally omitted from CFLAGS when
building shared libraries.

Older versions of MIPS gcc used to implicitly generate PIC code for pretty
much all Linux executables and libraries, so if you forgot to add -fPIC it
usually worked anyway.  But with the addition of PLT support this is no
longer the case.  MIPS gcc now defaults to non-PIC code, which is more
efficient and easier to read in the disassembly.  The downside is that all
of the old broken Makefiles need to be fixed.

--001636af022e22eced046b256954
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Sat, May 30, 2009 at 2:41 AM, Luk Claes <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:luk@debian.org">luk@debian.org</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px=
 solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
There appears to be a mips specific bug in binutils which make some package=
s fail to build when linking. More details can be found in debian bug #5190=
06 [0] and binutils upstream bug #10144 [1].<br>
</blockquote></div><br>I have seen this error when -fPIC is accidentally om=
itted from CFLAGS when building shared libraries.<br><br>Older versions of =
MIPS gcc used to implicitly generate PIC code for pretty much all Linux exe=
cutables and libraries, so if you forgot to add -fPIC it usually worked any=
way.=C2=A0 But with the addition of PLT support this is no longer the case.=
=C2=A0 MIPS gcc now defaults to non-PIC code, which is more efficient and e=
asier to read in the disassembly.=C2=A0 The downside is that all of the old=
 broken Makefiles need to be fixed.<br>

--001636af022e22eced046b256954--
