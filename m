Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2009 15:49:04 +0100 (BST)
Received: from rv-out-0708.google.com ([209.85.198.243]:58991 "EHLO
	rv-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20021395AbZD1Os4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2009 15:48:56 +0100
Received: by rv-out-0708.google.com with SMTP id k29so415788rvb.24
        for <multiple recipients>; Tue, 28 Apr 2009 07:48:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=l6mN8KoGosSZmYiFyRkVnCjwqOL9aV0U8+zmjmN29X4=;
        b=OMkfc5J/A66CfjNP0xlle2hRkbgmMpciOQH6tTkv5it1sq9ppUQMA+tpS/iPiqnKK8
         7WObL9WDUUQG266CUhlekxaCEcqN+/Rqutzikvmf54Maj8YehhPm5/DVA+oQmckoczlN
         81Us+YrFT9sroSDB39GgcLZkV3Q7jaCZKkF1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=nbFN2JDs0k6wK6a/nxNO3a85ckB3UO0jMf613ZG3RI8JBATT1ZTrNdmgLPIOA1mAUo
         I0JuxlNHS2d0UVruHGMgOYvwE5hdyn9qXiuww7RkwQZUEAXOwGY/2RBYrtwA425Y0kTn
         Cqg00DE3qRGIMIf+JjJTd3jy4s4Iue+gd8FF8=
MIME-Version: 1.0
Received: by 10.220.74.19 with SMTP id s19mr6015646vcj.7.1240930133087; Tue, 
	28 Apr 2009 07:48:53 -0700 (PDT)
In-Reply-To: <20090428092005.GA2408@lst.de>
References: <E1LyQQX-00047N-6E@localhost>
	 <20090427130952.GA30817@linux-mips.org>
	 <10f740e80904270622u730ba067g660257847dc526de@mail.gmail.com>
	 <20090428092005.GA2408@lst.de>
Date:	Tue, 28 Apr 2009 08:48:52 -0600
Message-ID: <b2b2f2320904280748q3a45ecf6r46dcb536877663c@mail.gmail.com>
Subject: Re: [MIPS] Resolve compile issues with msp71xx configuration
From:	Shane McDonald <mcdonald.shane@gmail.com>
To:	Christoph Hellwig <hch@lst.de>
Cc:	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=0016362852d4c6758d04689e8f64
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22513
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

--0016362852d4c6758d04689e8f64
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello:

On Tue, Apr 28, 2009 at 3:20 AM, Christoph Hellwig <hch@lst.de> wrote:

> On Mon, Apr 27, 2009 at 03:22:33PM +0200, Geert Uytterhoeven wrote:
> > He needs the definition of struct squashfs_super_block to access the
> .bytes_used
> > field. Alternatively, the offset of that field must be hardcoded.
>
> No, that whole crap needs to go.  FS code has no business poking into fs
> internal structures.  BTW, this whole setup is really, really gross,
> it's mtd map driver calling arch code to get base + size for mapping,
> poking into fs internal structures.  I really wonder what people have
> been smoking to come up with crap like that.
>
> We should just leave it uncompilable as a sign for future generations
> not to such stupid stuff.


So, just so I'm clear, you prefer option 4 of removing the entire
get_ramroot() code? :-)

> If the rootfs really is in ram only (and thus you discard any changes to
> it) you can just use an initramfs which is a lot simpler than any of the
> cramfs and squashfs hacks and supported by platform-independent code.
The rootfs is ram only with a union mount of a jffs2 filesystem to retain
changes.  The target system is a resource-constrained router board, and we
were trying to keep everything as small as possible.  If I remember
correctly, this code originally came over from an internal 2.4 port on an
even more resource-constrained platform; perhaps there are better options in
today's world.

I will look into a better solution to this problem.  In the meantime, I'm
hesitant to remove the existing code -- I think I prefer to leave it
uncompilable until that solution is found.

Shane

--0016362852d4c6758d04689e8f64
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hello:</div>
<div>=A0</div>
<div class=3D"gmail_quote">On Tue, Apr 28, 2009 at 3:20 AM, Christoph Hellw=
ig <span dir=3D"ltr">&lt;<a href=3D"mailto:hch@lst.de">hch@lst.de</a>&gt;</=
span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div class=3D"im">On Mon, Apr 27, 2009 at 03:22:33PM +0200, Geert Uytterhoe=
ven wrote:<br>&gt; He needs the definition of struct squashfs_super_block t=
o access the .bytes_used<br>&gt; field. Alternatively, the offset of that f=
ield must be hardcoded.<br>
<br></div>No, that whole crap needs to go. =A0FS code has no business pokin=
g into fs<br>internal structures. =A0BTW, this whole setup is really, reall=
y gross,<br>it&#39;s mtd map driver calling arch code to get base + size fo=
r mapping,<br>
poking into fs internal structures. =A0I really wonder what people have<br>=
been smoking to come up with crap like that.<br><br>We should just leave it=
 uncompilable as a sign for future generations<br>not to such stupid stuff.=
</blockquote>

<div>=A0</div>
<div>So, just so I&#39;m clear, you prefer option 4 of removing the entire =
get_ramroot() code? :-)</div></div>
<div>=A0</div>
<div>&gt; If the rootfs really is in ram only (and thus you discard any cha=
nges to<br>&gt; it) you can just use an initramfs which is a lot simpler th=
an any of the<br>&gt; cramfs and squashfs hacks and supported by platform-i=
ndependent code.<br>
</div>
<div>The rootfs is ram only with a union mount of a jffs2 filesystem to ret=
ain changes.=A0 The target system is a resource-constrained router board, a=
nd we were trying to keep everything as small as possible.=A0 If I remember=
 correctly, this code originally came over from an internal 2.4 port on an =
even more resource-constrained platform; perhaps there are better options i=
n today&#39;s world.</div>

<div>=A0</div>
<div>I will look into a better solution to this problem.=A0 In the meantime=
, I&#39;m hesitant to remove the existing code -- I think I prefer to leave=
 it uncompilable until that solution is found.</div>
<div>=A0</div>
<div>Shane</div>

--0016362852d4c6758d04689e8f64--
