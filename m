Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Dec 2007 09:47:34 +0000 (GMT)
Received: from rv-out-0910.google.com ([209.85.198.186]:22233 "EHLO
	rv-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20029658AbXLVJr0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 22 Dec 2007 09:47:26 +0000
Received: by rv-out-0910.google.com with SMTP id l15so492987rvb.24
        for <linux-mips@linux-mips.org>; Sat, 22 Dec 2007 01:47:14 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=p0hXdTv+AR7thQfNVv68jsu4bx06cR7Ik1mAQ4LiT0M=;
        b=CQyPW0XqMt38d7ojRT60mRtwa0qg6ys/piEQMD/uGre4u8+BmxlmSxu4+AgqklASMZwUPUWqfxiA/7PyR08XiXoWKBv3F3Ygwu3J5/ghKpAyqwdJ7oyJVjq5aOC+WuqEl12kx5uVxMQYAt8HZEvXSzQvcVZfm+7+KNnNLf7Yp+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=hKWRhs5yKCPQqaE6ps1/bkV3cTWfC4Du8VFMRG1sme0oYWEBuRX/L5JgMxO5YCqbN1ViOYWX23BZWn3V8rpOrg88x3V5ETULkBhYf3sDLuzKnsHqlrj9k26G8OmXHTnta3UZcQqgSApCG7rXFceSfgfl+MIvt0tzrVnzZp+/5OM=
Received: by 10.141.44.13 with SMTP id w13mr1260119rvj.181.1198316834135;
        Sat, 22 Dec 2007 01:47:14 -0800 (PST)
Received: by 10.140.203.15 with HTTP; Sat, 22 Dec 2007 01:47:14 -0800 (PST)
Message-ID: <84144f020712220147q2e291fa1t4ee03e4d64be95b@mail.gmail.com>
Date:	Sat, 22 Dec 2007 11:47:14 +0200
From:	"Pekka Enberg" <penberg@cs.helsinki.fi>
To:	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Subject: Re: [PATCH] SC26XX: New serial driver for SC2681 uarts
Cc:	"Andrew Morton" <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	"Andy Whitcroft" <apw@shadowen.org>,
	"Alan Cox" <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20071205092506.GA6691@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20071202194346.36E3FDE4C4@solo.franken.de>
	 <20071203155317.772231f9.akpm@linux-foundation.org>
	 <20071204234112.GA12352@alpha.franken.de>
	 <20071204192738.54e79a97.akpm@linux-foundation.org>
	 <20071205092506.GA6691@alpha.franken.de>
X-Google-Sender-Auth: 2a0b04f06c6c25f0
Return-Path: <penberg@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: penberg@cs.helsinki.fi
Precedence: bulk
X-list: linux-mips

Hi Thomas,

On Dec 5, 2007 11:25 AM, Thomas Bogendoerfer <tsbogend@alpha.franken.de> wrote:
> > These:
> >
> > > +#define READ_SC(p, r)        readb((p)->membase + RD_##r)
> > > +#define WRITE_SC(p, r, v)    writeb((v), (p)->membase + WR_##r)
> >
> > and these:
> >
> > > +#define READ_SC_PORT(p, r)     read_sc_port(p, RD_PORT_##r)
> > > +#define WRITE_SC_PORT(p, r, v) write_sc_port(p, WR_PORT_##r, v)
> >
> > really don't need to exist.  All they do is make the code harder to read.
>
> but they make the code safer. The chip has common register and port
> registers, which are randomly splattered over the address range. And
> some of them are read only, some write only. Read only and Write
> only register live at the same register offset and their function
> usually doesn't have anything in common. By using these macros I'll
> get compile errors when doing a READ_SC from a write only register
> and vice versa. I will also get compile errors, if I try to access a
> common register via READ_SC_PORT/WRITE_SC_PORT.

You can use grep to make sure there are no reads to a write-only
register. What you have there is not safety but macro obfuscation at
its best. It makes the code harder to read for anyone not intimately
familiar with the driver.
