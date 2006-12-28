Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2006 16:20:09 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.184]:25171 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S28575624AbWL1QUF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 Dec 2006 16:20:05 +0000
Received: by nf-out-0910.google.com with SMTP id l24so5147929nfc
        for <linux-mips@linux-mips.org>; Thu, 28 Dec 2006 08:20:04 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=fzwGB938arKgY+LY2b7R2e9QwdYGuFpCCb9uSATshc9LYaBK/0i6KEs0BLVsbrghKpO6el9nXDSgK2wa+5uFeD679F2ZgeVeGBtTOTkh4pSrp+B4BYEu6DKksmMz0vHbHB/Bu61FPiKgrRhi4EpMIY/Tt+da5Ps4fHoyeZs0B2Y=
Received: by 10.82.190.2 with SMTP id n2mr1126909buf.1167322804457;
        Thu, 28 Dec 2006 08:20:04 -0800 (PST)
Received: by 10.82.107.11 with HTTP; Thu, 28 Dec 2006 08:20:04 -0800 (PST)
Message-ID: <acd2a5930612280820l43639382x1f573386f2752d18@mail.gmail.com>
Date:	Thu, 28 Dec 2006 19:20:04 +0300
From:	"Vitaly Wool" <vitalywool@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH][respin] pnx8550: fix system timer support
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
In-Reply-To: <20061229.011621.05599370.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_123553_6259184.1167322804431"
References: <20061228171405.b1e3eed8.vitalywool@gmail.com>
	 <20061229.011621.05599370.anemo@mba.ocn.ne.jp>
Return-Path: <vitalywool@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13523
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vitalywool@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_123553_6259184.1167322804431
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 12/28/06, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
>
> On Thu, 28 Dec 2006 17:14:05 +0300, Vitaly Wool <vitalywool@gmail.com>
> wrote:
> > --- linux-mips.git.orig/arch/mips/philips/pnx8550/common/time.c
> > +++ linux-mips.git/arch/mips/philips/pnx8550/common/time.c
> > @@ -29,11 +29,22 @@
> >  #include <asm/hardirq.h>
> >  #include <asm/div64.h>
> >  #include <asm/debug.h>
> > +#include <asm/time.h>
>
> As I said before, asm/time.h is already included just before there.
> Why double inclusion?
>
>
Oh shoot, thanks, this hunk is bogus.

Vitaly

------=_Part_123553_6259184.1167322804431
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<span class="gmail_quote">On 12/28/06, <b class="gmail_sendername">Atsushi Nemoto</b> &lt;<a href="mailto:anemo@mba.ocn.ne.jp">anemo@mba.ocn.ne.jp</a>&gt; wrote:</span><blockquote class="gmail_quote" style="margin-top: 0; margin-right: 0; margin-bottom: 0; margin-left: 0; margin-left: 0.80ex; border-left-color: #cccccc; border-left-width: 1px; border-left-style: solid; padding-left: 1ex">
On Thu, 28 Dec 2006 17:14:05 +0300, Vitaly Wool &lt;<a href="mailto:vitalywool@gmail.com">vitalywool@gmail.com</a>&gt; wrote:<br>&gt; --- linux-mips.git.orig/arch/mips/philips/pnx8550/common/time.c<br>&gt; +++ linux-mips.git
/arch/mips/philips/pnx8550/common/time.c<br>&gt; @@ -29,11 +29,22 @@<br>&gt;&nbsp;&nbsp;#include &lt;asm/hardirq.h&gt;<br>&gt;&nbsp;&nbsp;#include &lt;asm/div64.h&gt;<br>&gt;&nbsp;&nbsp;#include &lt;asm/debug.h&gt;<br>&gt; +#include &lt;asm/time.h&gt;
<br><br>As I said before, asm/time.h is already included just before there.<br>Why double inclusion?<br><br></blockquote><br>Oh shoot, thanks, this hunk is bogus.<br><br>Vitaly<br>

------=_Part_123553_6259184.1167322804431--
