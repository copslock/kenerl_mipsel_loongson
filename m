Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jun 2006 18:13:37 +0100 (BST)
Received: from web31513.mail.mud.yahoo.com ([68.142.198.142]:9876 "HELO
	web31513.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133494AbWFLRN1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 Jun 2006 18:13:27 +0100
Received: (qmail 65852 invoked by uid 60001); 12 Jun 2006 17:13:20 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=T8abjrgaIMLE5XB73mD4rhnj1uIA/0Ri+Eq7hMa7HXSddnyXajwYCuUXS1cimGK8OuQPEl7pgtSC9Kbm7M+ZuL8jz+SRSyzJY5ZMt2gTswHigRJY2Hn1DkG2DrwqXV8D6gt1WdcZR4CjOFFHkF0knQnDpkB3vLdss991NPHN58I=  ;
Message-ID: <20060612171320.65850.qmail@web31513.mail.mud.yahoo.com>
Received: from [208.187.37.98] by web31513.mail.mud.yahoo.com via HTTP; Mon, 12 Jun 2006 10:13:20 PDT
Date:	Mon, 12 Jun 2006 10:13:20 -0700 (PDT)
From:	Jonathan Day <imipak@yahoo.com>
Subject: Re: where I can find a crosscompiler for BCM1255
To:	Jim Gifford <maillist@jg555.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <448A1497.3000909@jg555.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips



--- Jim Gifford <maillist@jg555.com> wrote:

> Jonathan Day wrote:
> > I have built cross-compilers for the Broadcom
> BCM1250
> > using the instructions and patches on the "Linux
> From
> > Scratch" website. You need to look for the
> > cross-compiler version of their guide, then select
> > "browse online" and finally "mips64" to get to the
> > instructions/patches for building for the 64-bit
> MIPS
> > platforms.
> >
> > Do NOT use their kernel or kernel patches - use
> the
> > version in the git repository on linux-mips.
> >
> >   
> 
> Johnathan, I'm on of the developers of CLFS, did you
>  run into a problem 
> with the patches? The patch is diff  kernel.org and
> linux-mips.org 
> kernels. Just curious, if we missed something let me
> know.

No, the patches are fine. The problem is "Rapid
Development Syndrome" - no matter how fast the patches
are updated, critical bugfixes will likely work their
way into the git repository before the next patch
update. This isn't a big issue for 99.99% of the tools
- there, updates are as likely to cause problems as
fix them, so the delay is actually beneficial.

(Now, -configuring- the Linux kernel can be
interesting, as I've yet to get dialog to function
correctly...)

Jonathan


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
