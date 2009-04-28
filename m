Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2009 07:21:23 +0100 (BST)
Received: from mail-qy0-f171.google.com ([209.85.221.171]:34109 "EHLO
	mail-qy0-f171.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023955AbZD1GVQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2009 07:21:16 +0100
Received: by qyk1 with SMTP id 1so797681qyk.22
        for <multiple recipients>; Mon, 27 Apr 2009 23:21:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=9aWA6ERNdm7KKDDVA/kxQK+n9Mi+a63m1eMgmzu8mCk=;
        b=hdPQnzKHdo/ox+Ua4dDbeMEaR1jTbXPwVF8y0T3W1ytiXtDcj6iRWZ6kI6N4IEW63k
         Ue7m8MUbj3Q2kJlVBfpNjGeOF4CGJJlE3Oq2TNkfSe+gbkNs7X8MHmqnX6y6U/yCWeIG
         nlZ5lL3z1MTv1fmdDhkwVVVT78UlbQ+yyviwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=XoaTVSXSBvc/zfgABy6IMgwkTcAFqxWhc8W7P6PkXvrkz2s5cdOOrztr+GaUMx+gel
         pbSxqr9P3ioOXjA795RLYOj+5a7J89hSMVICr4/EzmmkzB396xURXZEa07jaH6vWmtSc
         8J3zEh/xAWN8WkVG/ccy3u1UkobWmJkPqu9DU=
MIME-Version: 1.0
Received: by 10.220.74.4 with SMTP id s4mr12530661vcj.18.1240899669865; Mon, 
	27 Apr 2009 23:21:09 -0700 (PDT)
In-Reply-To: <10f740e80904270622u730ba067g660257847dc526de@mail.gmail.com>
References: <E1LyQQX-00047N-6E@localhost>
	 <20090427130952.GA30817@linux-mips.org>
	 <10f740e80904270622u730ba067g660257847dc526de@mail.gmail.com>
Date:	Tue, 28 Apr 2009 00:21:09 -0600
Message-ID: <b2b2f2320904272321l4cf30181rcde6b1d42a5b5547@mail.gmail.com>
Subject: Re: [MIPS] Resolve compile issues with msp71xx configuration
From:	Shane McDonald <mcdonald.shane@gmail.com>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=0016362851fc0643550468977821
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22500
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

--0016362851fc0643550468977821
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello:

On Mon, Apr 27, 2009 at 7:22 AM, Geert Uytterhoeven <geert@linux-m68k.org>wrote:

> On Mon, Apr 27, 2009 at 15:09, Ralf Baechle <ralf@linux-mips.org> wrote:
> > On Mon, Apr 27, 2009 at 06:59:17AM -0600, Shane McDonald wrote:
> >
> >> There have been a number of compile problems with the msp71xx
> >> configuration ever since it was included in the linux-mips.org
> >> repository.  This patch resolves these problems:
> >>  - proper files are included when using a squashfs rootfs
> >>  - resetting the board no longer uses non-existent GPIO routines
> >>  - create the required plat_timer_setup function
> >>
> >> This patch has been compile-tested against the current HEAD.
> >>
> >> Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>
> >> ---
> >>  arch/mips/pmc-sierra/msp71xx/msp_prom.c  |    3 ++-
> >>  arch/mips/pmc-sierra/msp71xx/msp_setup.c |    8 ++------
> >>  arch/mips/pmc-sierra/msp71xx/msp_time.c  |    7 ++-----
> >>  3 files changed, 6 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/arch/mips/pmc-sierra/msp71xx/msp_prom.c
> b/arch/mips/pmc-sierra/msp71xx/msp_prom.c
> >> index e5bd548..1e2d984 100644
> >> --- a/arch/mips/pmc-sierra/msp71xx/msp_prom.c
> >> +++ b/arch/mips/pmc-sierra/msp71xx/msp_prom.c
> >> @@ -44,7 +44,8 @@
> >>  #include <linux/cramfs_fs.h>
> >>  #endif
> >>  #ifdef CONFIG_SQUASHFS
> >> -#include <linux/squashfs_fs.h>
> >> +#include <linux/magic.h>
> >> +#include "../../../../fs/squashfs/squashfs_fs.h"
> >
> > No way.  You're reaching deep into the internals of squashfs for no good
> > reason.  The only use of anything from squashfs_fs.h is a cast and
> casting
> > to void * would work just as well.
>
> He needs the definition of struct squashfs_super_block to access the
> .bytes_used
> field. Alternatively, the offset of that field must be hardcoded.
>
> BTW, the magic is __le32, and bytes_used is __le64, so there are some
> le{32,64}_to_cpu()
> missing.


I am not sure how to proceed here.  My main purpose in providing this patch
was to get the msp71xx platform compiling again, but I stumbled into some
pre-existing code ugliness, which I must confess I was ultimately
responsible for.

As Geert said, I need to reach deep into the squashfs internals to access
the bytes_used field of struct squashfs_super_block; the code just previous
to this line works similar for the cramfs filesystem, where it accesses the
size field of the struct cramfs_super field.  The cramfs code doesn't look
as bad, because its superblock structure is defined in an easier-to-access
file (linux/cramfs_fs.h).

I can see a number of possible paths here:

1. Fix up the existing patch with le{32,64}_to_cpu() as Geert suggested, and
leave everything else as-is.
2. Approach the squashfs maintainers to move the squashfs_fs.h file to a
more public location, and still do 1.
3. Pull the squashfs code entirely.
4. Remove the entire get_ramroot() code, both squashfs and cramfs, as
Christoph has suggested.  I am hesitant to do this as it also affects code
in the MTD subsystem (file maps/pmcmsp-ramroot.c), and it also loses some
functionality on the PMC boards (putting the rootfs in RAM immediately
following the kernel).  Perhaps there's a better way to handle this?

I am open to suggestions on how to proceed.


>
> Gr{oetje,eeting}s,
>
>                                                Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
> geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker.
> But
> when I'm talking to journalists I just say "programmer" or something like
> that.
>                                                            -- Linus
> Torvalds


Shane

--0016362851fc0643550468977821
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello:<br><br><div class=3D"gmail_quote">On Mon, Apr 27, 2009 at 7:22 AM, G=
eert Uytterhoeven <span dir=3D"ltr">&lt;<a href=3D"mailto:geert@linux-m68k.=
org">geert@linux-m68k.org</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0=
pt 0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div class=3D"h5">On Mon, Apr 27, 2009 at 15:09, Ralf Baech=
le &lt;<a href=3D"mailto:ralf@linux-mips.org">ralf@linux-mips.org</a>&gt; w=
rote:<br>
&gt; On Mon, Apr 27, 2009 at 06:59:17AM -0600, Shane McDonald wrote:<br>
&gt;<br>
&gt;&gt; There have been a number of compile problems with the msp71xx<br>
&gt;&gt; configuration ever since it was included in the <a href=3D"http://=
linux-mips.org" target=3D"_blank">linux-mips.org</a><br>
&gt;&gt; repository. =A0This patch resolves these problems:<br>
&gt;&gt; =A0- proper files are included when using a squashfs rootfs<br>
&gt;&gt; =A0- resetting the board no longer uses non-existent GPIO routines=
<br>
&gt;&gt; =A0- create the required plat_timer_setup function<br>
&gt;&gt;<br>
&gt;&gt; This patch has been compile-tested against the current HEAD.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Shane McDonald &lt;<a href=3D"mailto:mcdonald.shane=
@gmail.com">mcdonald.shane@gmail.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; =A0arch/mips/pmc-sierra/msp71xx/msp_prom.c =A0| =A0 =A03 ++-<br>
&gt;&gt; =A0arch/mips/pmc-sierra/msp71xx/msp_setup.c | =A0 =A08 ++------<br=
>
&gt;&gt; =A0arch/mips/pmc-sierra/msp71xx/msp_time.c =A0| =A0 =A07 ++-----<b=
r>
&gt;&gt; =A03 files changed, 6 insertions(+), 12 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/arch/mips/pmc-sierra/msp71xx/msp_prom.c b/arch/mips/p=
mc-sierra/msp71xx/msp_prom.c<br>
&gt;&gt; index e5bd548..1e2d984 100644<br>
&gt;&gt; --- a/arch/mips/pmc-sierra/msp71xx/msp_prom.c<br>
&gt;&gt; +++ b/arch/mips/pmc-sierra/msp71xx/msp_prom.c<br>
&gt;&gt; @@ -44,7 +44,8 @@<br>
&gt;&gt; =A0#include &lt;linux/cramfs_fs.h&gt;<br>
&gt;&gt; =A0#endif<br>
&gt;&gt; =A0#ifdef CONFIG_SQUASHFS<br>
&gt;&gt; -#include &lt;linux/squashfs_fs.h&gt;<br>
&gt;&gt; +#include &lt;linux/magic.h&gt;<br>
&gt;&gt; +#include &quot;../../../../fs/squashfs/squashfs_fs.h&quot;<br>
&gt;<br>
&gt; No way. =A0You&#39;re reaching deep into the internals of squashfs for=
 no good<br>
&gt; reason. =A0The only use of anything from squashfs_fs.h is a cast and c=
asting<br>
&gt; to void * would work just as well.<br>
<br>
</div></div>He needs the definition of struct squashfs_super_block to acces=
s the .bytes_used<br>
field. Alternatively, the offset of that field must be hardcoded.<br>
<br>
BTW, the magic is __le32, and bytes_used is __le64, so there are some<br>
le{32,64}_to_cpu()<br>
missing.</blockquote><div><br>I am not sure how to proceed here.=A0 My main=
 purpose in providing this patch was to get the msp71xx platform compiling =
again, but I stumbled into some pre-existing code ugliness, which I must co=
nfess I was ultimately responsible for.<br>
<br>As Geert said, I need to reach deep into the squashfs internals to acce=
ss the bytes_used field of struct squashfs_super_block; the code just previ=
ous to this line works similar for the cramfs filesystem, where it accesses=
 the size field of the struct cramfs_super field.=A0 The cramfs code doesn&=
#39;t look as bad, because its superblock structure is defined in an easier=
-to-access file (linux/cramfs_fs.h).<br>
<br>I can see a number of possible paths here:<br><br>1. Fix up the existin=
g patch with le{32,64}_to_cpu() as Geert suggested, and leave everything el=
se as-is.<br>2. Approach the squashfs maintainers to move the squashfs_fs.h=
 file to a more public location, and still do 1.<br>
3. Pull the squashfs code entirely.<br>4. Remove the entire get_ramroot() c=
ode, both squashfs and cramfs, as Christoph has suggested.=A0 I am hesitant=
 to do this as it also affects code in the MTD subsystem (file maps/pmcmsp-=
ramroot.c), and it also loses some functionality on the PMC boards (putting=
 the rootfs in RAM immediately following the kernel).=A0 Perhaps there&#39;=
s a better way to handle this?<br>
<br>I am open to suggestions on how to proceed.<br><br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); mar=
gin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<br>
Gr{oetje,eeting}s,<br>
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0Geert<br>
<font color=3D"#888888"><br>
--<br>
Geert Uytterhoeven -- There&#39;s lots of Linux beyond ia32 -- <a href=3D"m=
ailto:geert@linux-m68k.org">geert@linux-m68k.org</a><br>
<br>
In personal conversations with technical people, I call myself a hacker. Bu=
t<br>
when I&#39;m talking to journalists I just say &quot;programmer&quot; or so=
mething like that.<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-- Linus Torvalds</font></bl=
ockquote><div><br>Shane <br></div></div><br>

--0016362851fc0643550468977821--
