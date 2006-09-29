Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Sep 2006 10:59:20 +0100 (BST)
Received: from wx-out-0506.google.com ([66.249.82.226]:30334 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038526AbWI2J7S (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 29 Sep 2006 10:59:18 +0100
Received: by wx-out-0506.google.com with SMTP id h30so953296wxd
        for <linux-mips@linux-mips.org>; Fri, 29 Sep 2006 02:59:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=aS56V3uQjM9J/RcD5ONK7MJtkj6uyJoCWetupCrnyfeqIsfLYlHwBX/80q0cA6ZSbS2ARFBQ8Y8SSkV49/DcnKquhYOc5qKNHtb2sN98Au0W+orwwZY3STFzFGHNWnq+LQJ9y97g/X//xOotZ/Yfotdw+XcjiQEP7HlKMdaViRg=
Received: by 10.90.80.8 with SMTP id d8mr1235974agb;
        Fri, 29 Sep 2006 02:59:17 -0700 (PDT)
Received: by 10.90.31.10 with HTTP; Fri, 29 Sep 2006 02:59:17 -0700 (PDT)
Message-ID: <5ee285ba0609290259g2edf60c7ja7463036c748991b@mail.gmail.com>
Date:	Fri, 29 Sep 2006 17:59:17 +0800
From:	"David Lee" <receive4me@gmail.com>
To:	"Freddy Spierenburg" <freddy@dusktilldawn.nl>
Subject: Re: HELP: opcode not supported on this processor
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20060929094729.GM17027@dusktilldawn.nl>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_5423_2804826.1159523957406"
References: <5ee285ba0609290235v7b518495u2dccb1ef82b117d0@mail.gmail.com>
	 <20060929094729.GM17027@dusktilldawn.nl>
Return-Path: <receive4me@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: receive4me@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_5423_2804826.1159523957406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

HI Freddy,

Thanks a lot for your help.

my target is a MIPS32. Based on what you advised, it must be a wrong
configuration in Linux header files. I'll check and see what'll happen.

Thanks again.

David


On 9/29/06, Freddy Spierenburg <freddy@dusktilldawn.nl> wrote:
>
> Hi David,
>
> On Fri, Sep 29, 2006 at 05:35:48PM +0800, David Lee wrote:
> > /tmp/ccwOZSG3.s:5143: Error: opcode not supported on this processor:
> mips1
> > (mips1) `ll $4,16($2)'
> > /tmp/ccwOZSG3.s:5145: Error: opcode not supported on this processor:
> mips1
> > (mips1) `sc $4,16($2)'
>
> Are you sure you want to assemble for the mips1 target?
>
> I know these both opcodes are valid MIPS32 opcodes, but don't
> know if they exist for the mips1 target.
>
> You might want to look for something like
>
>
> http://www.cs.cornell.edu/courses/cs314/2005FA/resources/MIPS_Vol2.pdf
>
> but this one is for MIPS32. If you need mips1 you better search
> for a likewise document.
>
>
> --
> $ cat ~/.signature
> Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
> GnuPG: 0x7941D1E1=C948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
> $ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!
>
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.5 (GNU/Linux)
>
> iD8DBQFFHOuxbxf9XXlB0eERAjTjAKCisVWs1p8ViEDGQnWexpfoQ6c3kACgxn/y
> GRv42zeXJWfW62Iy6eC54dI=
> =I9OS
> -----END PGP SIGNATURE-----
>
>
>

------=_Part_5423_2804826.1159523957406
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>HI Freddy,</div>
<div>&nbsp;</div>
<div>Thanks a lot for your help.</div>
<div>&nbsp;</div>
<div>my target is a MIPS32. Based on what you advised, it must be a wrong configuration in Linux header files. I'll check and see what'll happen.</div>
<div>&nbsp;</div>
<div>Thanks again.</div>
<div>&nbsp;</div>
<div>David<br><br>&nbsp;</div>
<div><span class="gmail_quote">On 9/29/06, <b class="gmail_sendername">Freddy Spierenburg</b> &lt;<a href="mailto:freddy@dusktilldawn.nl">freddy@dusktilldawn.nl</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi David,<br><br>On Fri, Sep 29, 2006 at 05:35:48PM +0800, David Lee wrote:<br>&gt; /tmp/ccwOZSG3.s:5143: Error: opcode not supported on this processor: mips1
<br>&gt; (mips1) `ll $4,16($2)'<br>&gt; /tmp/ccwOZSG3.s:5145: Error: opcode not supported on this processor: mips1<br>&gt; (mips1) `sc $4,16($2)'<br><br>Are you sure you want to assemble for the mips1 target?<br><br>I know these both opcodes are valid MIPS32 opcodes, but don't
<br>know if they exist for the mips1 target.<br><br>You might want to look for something like<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="http://www.cs.cornell.edu/courses/cs314/2005FA/resources/MIPS_Vol2.pdf">http://www.cs.cornell.edu/courses/cs314/2005FA/resources/MIPS_Vol2.pdf
</a><br><br>but this one is for MIPS32. If you need mips1 you better search<br>for a likewise document.<br><br><br>--<br>$ cat ~/.signature<br>Freddy Spierenburg &lt;<a href="mailto:freddy@dusktilldawn.nl">freddy@dusktilldawn.nl
</a>&gt;&nbsp;&nbsp;<a href="http://freddy.snarl.nl/">http://freddy.snarl.nl/</a><br>GnuPG: 0x7941D1E1=C948 5851 26D2 FA5C 39F1&nbsp;&nbsp;E588 6F17 FD5D 7941 D1E1<br>$ # Please read <a href="http://www.ietf.org/rfc/rfc2015.txt">http://www.ietf.org/rfc/rfc2015.txt
</a> before complain!<br><br><br>-----BEGIN PGP SIGNATURE-----<br>Version: GnuPG v1.4.5 (GNU/Linux)<br><br>iD8DBQFFHOuxbxf9XXlB0eERAjTjAKCisVWs1p8ViEDGQnWexpfoQ6c3kACgxn/y<br>GRv42zeXJWfW62Iy6eC54dI=<br>=I9OS<br>-----END PGP SIGNATURE-----
<br><br><br></blockquote></div><br>

------=_Part_5423_2804826.1159523957406--
