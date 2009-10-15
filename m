Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Oct 2009 19:21:26 +0200 (CEST)
Received: from mail-fx0-f221.google.com ([209.85.220.221]:34384 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492923AbZJORVT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Oct 2009 19:21:19 +0200
Received: by fxm21 with SMTP id 21so1304210fxm.33
        for <multiple recipients>; Thu, 15 Oct 2009 10:21:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=tsGYVI5USBV4cLhdIqO/8YSrNOegQG+NKVahet2DgvM=;
        b=G9jLZoo0SWKKtCmve5znndPPRY0S6lZGPGUgLh/zTutQQ3AfFbduKePsEg5/uJ0u+5
         szGsA1O8rv0mzv1cHL/iVzLKTZnoizQe9bJiMWA7inPauYVSWv6vHczShhtuTdyGdI81
         fQUONA15FaS7dHxLmAj8dQoab63RHtBGU8PRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=bK9ujEyoT6izrhnN22jzPwKv1WmkzN5r3MIwdVrwvlz+RhQapBcPuOwIX/Z8CTCOLH
         OPDqeWqQnFqAY+PNPcc/fAlEeIbPd/MBvYn9gdz4+sj/53f5EVI/koTBrpf/2GgtuVHB
         Pc79HMbF91jZ4Aib/JKG8yC7mIhgpxbuS22dA=
MIME-Version: 1.0
Received: by 10.223.144.82 with SMTP id y18mr52024fau.74.1255627274496; Thu, 
	15 Oct 2009 10:21:14 -0700 (PDT)
In-Reply-To: <1255626454-12715-1-git-send-email-manuel.lauss@gmail.com>
References: <1255626454-12715-1-git-send-email-manuel.lauss@gmail.com>
Date:	Thu, 15 Oct 2009 19:21:14 +0200
Message-ID: <f861ec6f0910151021r42933fcevc2a492d1b45fff0a@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Alchemy: get rid of superfluous UART definitions
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Content-Type: multipart/alternative; boundary=0023545bd760aaad130475fc8116
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24343
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

--0023545bd760aaad130475fc8116
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Oct 15, 2009 at 7:07 PM, Manuel Lauss
<manuel.lauss@googlemail.com>wrote:

> Remove unused uart bit definitions and base macros.
>
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
> Applies on top of the previous prom_putchar patch.
>

...and depends on alchemy irq changes lmo-queue.

        Manuel

--0023545bd760aaad130475fc8116
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Thu, Oct 15, 2009 at 7:07 PM, Manuel =
Lauss <span dir=3D"ltr">&lt;<a href=3D"mailto:manuel.lauss@googlemail.com">=
manuel.lauss@googlemail.com</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt=
 0pt 0pt 0.8ex; padding-left: 1ex;">
Remove unused uart bit definitions and base macros.<br>
<br>
Signed-off-by: Manuel Lauss &lt;<a href=3D"mailto:manuel.lauss@gmail.com">m=
anuel.lauss@gmail.com</a>&gt;<br>
---<br>
Applies on top of the previous prom_putchar patch.<br></blockquote><div><br=
>...and depends on alchemy irq changes lmo-queue.<br>=A0</div>=A0=A0=A0=A0=
=A0=A0=A0 Manuel<br></div>

--0023545bd760aaad130475fc8116--
