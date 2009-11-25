Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2009 07:53:05 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:41175 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492034AbZKYGxC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Nov 2009 07:53:02 +0100
Received: by pzk35 with SMTP id 35so5439306pzk.22
        for <multiple recipients>; Tue, 24 Nov 2009 22:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=rSZ8P5wG3rF3oT3v0mv0NlvjBuZbjy+RwIEr92FYrgo=;
        b=NuIlBJj4hRo78btaZItP8wuKZKfV+o8T0rhpScHUBp+ZcxfCoVPgU6VHvfQDkyj7xR
         X8cP6KlkrMHYvKsh2/ngrA+Ho+6BvXZrkEmUJDd0dnchRWjGc11o3WvCdk257+WvLfyg
         E/tfYFVbyYGypLuJ0cxDrKB0ercnu9N7hnOnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Oqoe3L5u4HwlUYaRHhd4tH1KHk/5dSWPMCkChPsFpWxUj3QeRpZ5G/k/XU4ni0lIto
         77WUnXFMJWHR+bfX+icWrbCx2CIWB+gAAIaJcEbcSxWtrF3JlSQT3nDkeSpCHssfrfuu
         3Oy9AL5rQ6l/0kqi5QXRPQCqRGcEwqrPDKrFU=
MIME-Version: 1.0
Received: by 10.114.214.36 with SMTP id m36mr6173566wag.172.1259131971807; 
        Tue, 24 Nov 2009 22:52:51 -0800 (PST)
In-Reply-To: <20091117084047.GA2923@linux-mips.org>
References: <c6ed1ac50911170012u7a52fbb9h1ae62cabf766122f@mail.gmail.com>
         <20091117084047.GA2923@linux-mips.org>
Date:   Wed, 25 Nov 2009 14:52:51 +0800
Message-ID: <c6ed1ac50911242252u5e43f7ffh3fd599ca8f59ff43@mail.gmail.com>
Subject: Re: why it not write those 6bits to entrylo0/1 register?
From:   figo zhang <figo1802@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=0016e64b0ab0e7ae4704792c81fd
Return-Path: <figo1802@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: figo1802@gmail.com
Precedence: bulk
X-list: linux-mips

--0016e64b0ab0e7ae4704792c81fd
Content-Type: text/plain; charset=ISO-8859-1

>
> No, the low 6 bits contain other information maintained by the kernel.
> Shifting right by 6 bits is used to drop these software bits.  The
> hardware bits are stored in bits 6 and up in a pte so the shift operation
> is going to move them into the right place.
>

yes, i know why shout shift this 6 bits, see this :

entrylo[01]:
  3130 29                         6 5 3 2 1 0
  -------------------------------------------
  | | PFN                         | C |D|V|G|
  -------------------------------------------

linux pte:
  31                     12 111098 7 6 5 3 2 1 0
  -------------------------------------------
  | PFN                | C |D|V|G|B|M|A|W|R|P|
  -------------------------------------------

so , the linux PTE has the least significant 6 bits is mantain by linux PTE,
the hardware
PTE entrylo[0~1] have no such bits, so it need to shift .

ralf, is some description on the kernel code? if it has, it would be easy
understand .

>
> > D:
> > V:
> > G:
> >
> > and how the kernel write the this 6 bit to entrylo0/1 register?
>
> A TLB write instruction about 5 lines further down in the code.
>
>  Ralf
>

--0016e64b0ab0e7ae4704792c81fd
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"b=
order-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; paddin=
g-left: 1ex;"><div class=3D"im">
<br>
</div>No, the low 6 bits contain other information maintained by the kernel=
.<br>
Shifting right by 6 bits is used to drop these software bits. =A0The<br>
hardware bits are stored in bits 6 and up in a pte so the shift operation<b=
r>
is going to move them into the right place.<br></blockquote><div><br>yes, i=
 know why shout shift this 6 bits, see this :<br><br>entrylo[01]:<br>=A0 31=
30 29=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 6 5 3 2 1 0<br>=A0 -------------------------------------------<br>
=A0 | | PFN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0=
=A0 | C |D|V|G|<br>=A0 -------------------------------------------<br><br>l=
inux pte:<br>=A0 31=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 12 111098 7 6 5 3 2 1 0<br>=A0 -------------------------------------=
------<br>=A0 | PFN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | C |D|V|G=
|B|M|A|W|R|P|<br>
=A0 -------------------------------------------<br><br>so , the linux PTE h=
as the least significant 6 bits is mantain by linux PTE, the hardware <br>P=
TE entrylo[0~1] have no such bits, so it need to shift .<br><br>ralf, is so=
me description on the kernel code? if it has, it would be easy understand .=
 <br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im"><br>
&gt; D:<br>
&gt; V:<br>
&gt; G:<br>
&gt;<br>
&gt; and how the kernel write the this 6 bit to entrylo0/1 register?<br>
<br>
</div>A TLB write instruction about 5 lines further down in the code.<br>
<font color=3D"#888888"><br>
 =A0Ralf<br>
</font></blockquote></div><br>

--0016e64b0ab0e7ae4704792c81fd--
