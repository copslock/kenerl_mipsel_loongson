Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Nov 2010 15:56:38 +0100 (CET)
Received: from mail-qy0-f170.google.com ([209.85.216.170]:58251 "EHLO
        mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491032Ab0KKO4e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Nov 2010 15:56:34 +0100
Received: by qyk4 with SMTP id 4so985448qyk.15
        for <linux-mips@linux-mips.org>; Thu, 11 Nov 2010 06:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=XAEkQ2ZOSsU7ceROWZiogWiIzxB03DR5Gk9YKWUKjl4=;
        b=joiP3wnNyBiFbz98GNyXSJsCsLfL1hayh1Zg1afR0vW30iGW0ltm1/PorcA/rbS11M
         4kMgslNzgU01LfAQPkojqNQuBeKg3cS4pB1CXQN9WkuqD8xCxkvjAqGF6q6CuO+tiYP8
         NWvDuy8iyNGxuZ8VaxggXmQPfmI7mrqwlmEkY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=H0SJsoYzsGLrEEuZYl4TZaljRD6R/mrR+EMswtgBqgxh3RJYNKfihkJpxGKIsyG/Qp
         MgsrLeoHOWgjujx9dk4LOQhZWUZhyIJXDMz+Yo8gkAZF5T33EUd2R3ZRNAsa8344upaS
         E9D5HLHbI7SUru1SxkxHalZUQVCdytKcTrtHU=
MIME-Version: 1.0
Received: by 10.224.19.129 with SMTP id a1mr958738qab.154.1289487387967; Thu,
 11 Nov 2010 06:56:27 -0800 (PST)
Received: by 10.220.162.69 with HTTP; Thu, 11 Nov 2010 06:56:27 -0800 (PST)
In-Reply-To: <20101111124952.GA11052@infradead.org>
References: <AANLkTi=mLwQ0N_cErHzES1ZWvOa8jQspeYwKgn9sU4Jm@mail.gmail.com>
        <20101104125052.GA22429@infradead.org>
        <AANLkTinqK-HvuHPeaTgxJOJuWMfomP2C12G=uVcqhWdn@mail.gmail.com>
        <20101109140527.GA13041@infradead.org>
        <AANLkTik09-0udnrpAJ-mTxMx8iKZ5UTq-ucduQJOZkws@mail.gmail.com>
        <AANLkTik=-jiE5xeJCTQZnbf7AFk7Wzap5ToBDceqsEdH@mail.gmail.com>
        <20101111124952.GA11052@infradead.org>
Date:   Thu, 11 Nov 2010 20:26:27 +0530
Message-ID: <AANLkTinB-EGV9yLd=s174VNWzF-Dat-=v+N0bhZqyWV4@mail.gmail.com>
Subject: Re: XFS mounting fails on MIPS
From:   Ajeet Yadav <ajeet.yadav.77@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "xfs@oss.sgi.com" <xfs@oss.sgi.com>, linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=0015175cb2c2b3c1990494c82db3
Return-Path: <ajeet.yadav.77@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ajeet.yadav.77@gmail.com
Precedence: bulk
X-list: linux-mips

--0015175cb2c2b3c1990494c82db3
Content-Type: text/plain; charset=ISO-8859-1

Ah! I got your point
thank you very much
On Thu, Nov 11, 2010 at 6:19 PM, Christoph Hellwig <hch@infradead.org>wrote:

> On Thu, Nov 11, 2010 at 11:10:33AM +0530, Ajeet Yadav wrote:
> > I think mips folks agree with the change. I really wish to have there
> > comment.
> >
> > I also wish to know do we really need fix in XFS for virtual indexed
> > architecture, I think its generic issue as many architecture now use VIVT
> or
> > VIPT caches. Do we want to say XFS is relatively unstable with virtual
> > indexed architecture ?
>
> The vmap flushing APIs I repeatedly pointed you at are the generic
> solution.  They've been implement for arm, parisc and sh already, it's
> just that no one has bothered to do it for mips yet.
>
> Without the proper flushing anything that uses vmap, which includes
> XFS is not "relatively unstable" but in fact not usable on systems
> with virtually indexed caches.
>

--0015175cb2c2b3c1990494c82db3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Ah! I got your point</div>
<div>thank you very much<br></div>
<div class=3D"gmail_quote">On Thu, Nov 11, 2010 at 6:19 PM, Christoph Hellw=
ig <span dir=3D"ltr">&lt;<a href=3D"mailto:hch@infradead.org">hch@infradead=
.org</a>&gt;</span> wrote:<br>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote">
<div class=3D"im">On Thu, Nov 11, 2010 at 11:10:33AM +0530, Ajeet Yadav wro=
te:<br>&gt; I think mips folks agree with the change. I really wish to have=
 there<br>&gt; comment.<br>&gt;<br>&gt; I also wish to know do we really ne=
ed fix in XFS for virtual indexed<br>
&gt; architecture, I think its generic issue as many architecture now use V=
IVT or<br>&gt; VIPT caches. Do we want to say XFS is relatively unstable wi=
th virtual<br>&gt; indexed architecture ?<br><br></div>The vmap flushing AP=
Is I repeatedly pointed you at are the generic<br>
solution. =A0They&#39;ve been implement for arm, parisc and sh already, it&=
#39;s<br>just that no one has bothered to do it for mips yet.<br><br>Withou=
t the proper flushing anything that uses vmap, which includes<br>XFS is not=
 &quot;relatively unstable&quot; but in fact not usable on systems<br>
with virtually indexed caches.<br></blockquote></div><br>

--0015175cb2c2b3c1990494c82db3--
