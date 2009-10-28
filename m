Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2009 08:31:07 +0100 (CET)
Received: from mail-bw0-f221.google.com ([209.85.218.221]:63207 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492524AbZJ1HbB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Oct 2009 08:31:01 +0100
Received: by bwz21 with SMTP id 21so588776bwz.24
        for <linux-mips@linux-mips.org>; Wed, 28 Oct 2009 00:30:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=NycWnAWv8yOhy+S/F77EwUH5dr06v8D2azUFDiKoKsY=;
        b=GkViw6Nv9CrZJIGCVeMLRL3n9yvMFm/nZ73G0ZOa27phZzQuZ0+JR8Wtx5316HrEhM
         1Xeptw3gt+U0IzyP7KerwJA9WUznraM2i4tTvNDjgPsNHaHLY9MPs37oP05lYftLkY0V
         I9aXG11qrRuqcOq5a3IWh2uTGJ9gjcsnis3Fs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Nnf382yTSaRBnu00b0pu+i9UdcKRZ8Sr61wzHeZ3SDTAw3xE4u/YDBmS4O55q/+eUM
         IWf7Abh3n6LCqYfDkiontUT+aYCy0NNRo6IXG5lix1Rr9h2iVhf1PilNsKOX+a3nUwLi
         3BB5dinbYvZyw0nzXQJdP9KSZo9lO9ptUmdB4=
MIME-Version: 1.0
Received: by 10.223.15.11 with SMTP id i11mr487922faa.105.1256715054764; Wed, 
	28 Oct 2009 00:30:54 -0700 (PDT)
In-Reply-To: <3a665c760910280017o11af6412n5fd3abdeda369bf3@mail.gmail.com>
References: <3a665c760910280017o11af6412n5fd3abdeda369bf3@mail.gmail.com>
Date:	Wed, 28 Oct 2009 08:30:54 +0100
Message-ID: <f861ec6f0910280030g6404a13ai7f1c4d526c7b5efd@mail.gmail.com>
Subject: Re: where we get handle_ades_int
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	loody <miloody@gmail.com>
Cc:	Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: multipart/alternative; boundary=0015174762a46c52d50476f9c6e7
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

--0015174762a46c52d50476f9c6e7
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Oct 28, 2009 at 8:17 AM, loody <miloody@gmail.com> wrote:

> Dear all:
> I try to grep handle_ades_int in kernel source code, and I get nothing.
> But I can see the function name in System.map.
> How do we make this function?
> Is this function generate from compiler marco?
> appreciate your help,
> miloody
>
>
in arch/mips/kernel/genex.S, look for the BUILD_HANDLER macro

Manuel

--0015174762a46c52d50476f9c6e7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Oct 28, 2009 at 8:17 AM, loody <=
span dir=3D"ltr">&lt;<a href=3D"mailto:miloody@gmail.com">miloody@gmail.com=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"border=
-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-lef=
t: 1ex;">
Dear all:<br>
I try to grep handle_ades_int in kernel source code, and I get nothing.<br>
But I can see the function name in System.map.<br>
How do we make this function?<br>
Is this function generate from compiler marco?<br>
appreciate your help,<br>
miloody<br>
<br>
</blockquote></div><br>in arch/mips/kernel/genex.S, look for the BUILD_HAND=
LER macro<br><br>Manuel<br><br>

--0015174762a46c52d50476f9c6e7--
