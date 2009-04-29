Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Apr 2009 15:11:40 +0100 (BST)
Received: from mail-ew0-f174.google.com ([209.85.219.174]:60248 "EHLO
	mail-ew0-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025418AbZD2OLd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 29 Apr 2009 15:11:33 +0100
Received: by ewy22 with SMTP id 22so1287160ewy.0
        for <multiple recipients>; Wed, 29 Apr 2009 07:11:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=doSrwH93X5Gz2CiFpyQRr2ymrpIt7ilye7TH5JLorYg=;
        b=Sn0/Nkkp0VDxahImu6zHMnbDEqu9AfA8p+9uBuKmwGyR/aB+jaBsxqvkNvBv53UQpg
         gUO4pFfhKQTjr5FbUb4fuWV0e09icKKoGBWj7Ij+zOCHk1FckS37gWAVE4Zm/xJUTvyV
         09kDBm0Amk8JeUrzncKkgbbKTjk/NfLEd6YBU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=KuTkTo7YOgiaGeei82+d8WW4FhpfP7aT5OwLOGExgQZAjy/PxpZ2x0QaOHyEYTy2Sm
         nIh2YA5ngir2FJmInyGGdU/DttlKmzpn5ljH7pb/THQlFPKCx9k6jZ3hLff0gNBI0/4q
         SSUH5F8GXfcKXLunGRnuEHzCbj+wfRC/rq9Gg=
MIME-Version: 1.0
Received: by 10.220.74.19 with SMTP id s19mr809517vcj.7.1241014285245; Wed, 29 
	Apr 2009 07:11:25 -0700 (PDT)
In-Reply-To: <20090429121014.GA14199@lst.de>
References: <E1LywHr-0006MX-S3@localhost> <20090429121014.GA14199@lst.de>
Date:	Wed, 29 Apr 2009 08:11:25 -0600
Message-ID: <b2b2f2320904290711x2d7f8769yc8da0de1110f67c9@mail.gmail.com>
Subject: Re: [MIPS] Remove the RAMROOT function for msp71xx
From:	Shane McDonald <mcdonald.shane@gmail.com>
To:	Christoph Hellwig <hch@lst.de>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: multipart/alternative; boundary=0016362852d4a21f420468b227c2
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

--0016362852d4a21f420468b227c2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Christoph:

On Wed, Apr 29, 2009 at 6:10 AM, Christoph Hellwig <hch@lst.de> wrote:

> On Tue, Apr 28, 2009 at 05:00:27PM -0600, Shane McDonald wrote:
> > The RAMROOT function was a successful but non-portable attempt to append
> > the root filesystem to the end of the kernel image.  The preferred and
> > portable solution is to use an initramfs instead.  This patch removes
> > the RAMROOT functionality.
> >
> > This patch has been compile-tested against the current HEAD.
> >
> > Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>
> > ---
> >  arch/mips/pmc-sierra/Kconfig            |   12 ------
> >  arch/mips/pmc-sierra/msp71xx/msp_prom.c |   60
> +------------------------------
>
> Looks good to me, but now a build of drivers/mtd/maps/pmcmsp-ramroot.c
> will fail.  Given that it's useless now you should probably remove it,
> too.


  Yes, definitely.  I wanted to get this patch through before submitting the
mtd patch.  Now that this one is accepted, I'll send off the other patch
soon.

Shane

--0016362852d4a21f420468b227c2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Christoph:<br><br>
<div class=3D"gmail_quote">On Wed, Apr 29, 2009 at 6:10 AM, Christoph Hellw=
ig <span dir=3D"ltr">&lt;<a href=3D"mailto:hch@lst.de">hch@lst.de</a>&gt;</=
span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div class=3D"im">On Tue, Apr 28, 2009 at 05:00:27PM -0600, Shane McDonald =
wrote:<br></div>
<div class=3D"im">&gt; The RAMROOT function was a successful but non-portab=
le attempt to append<br>&gt; the root filesystem to the end of the kernel i=
mage. =A0The preferred and<br>&gt; portable solution is to use an initramfs=
 instead. =A0This patch removes<br>
&gt; the RAMROOT functionality.<br>&gt;<br>&gt; This patch has been compile=
-tested against the current HEAD.<br>&gt;<br>&gt; Signed-off-by: Shane McDo=
nald &lt;<a href=3D"mailto:mcdonald.shane@gmail.com">mcdonald.shane@gmail.c=
om</a>&gt;<br>
&gt; ---<br>&gt; =A0arch/mips/pmc-sierra/Kconfig =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 12 ------<br>&gt; =A0arch/mips/pmc-sierra/msp71xx/msp_prom.c | =A0 60 +=
------------------------------<br><br></div>Looks good to me, but now a bui=
ld of drivers/mtd/maps/pmcmsp-ramroot.c<br>
will fail. =A0Given that it&#39;s useless now you should probably remove it=
,<br>too.</blockquote>
<div>=A0</div>
<div>
<div>=A0Yes, definitely.=A0 I wanted to get this patch through before submi=
tting the mtd patch.=A0 Now that this one is accepted,=A0I&#39;ll send off =
the other patch soon.</div>
<div>=A0</div>
<div>Shane</div></div></div><br>

--0016362852d4a21f420468b227c2--
