Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2007 11:33:58 +0100 (BST)
Received: from nz-out-0506.google.com ([64.233.162.234]:21637 "EHLO
	nz-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022599AbXENKd4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 May 2007 11:33:56 +0100
Received: by nz-out-0506.google.com with SMTP id z3so955922nzf
        for <linux-mips@linux-mips.org>; Mon, 14 May 2007 03:32:52 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IV7Hmdu+o9xVj2SNR037TLJ7ExLEIMb7qK//Gfd3ecqNmCNa8KCoFzJwCKgicrRquUg0F9sMkcQH4185adnda5parZuIF18oT/4cR7sMM6t1f4jyr+lK2gsKg1a28J8mwuMhdUEMdcOTp3fEmcQcj1RKEIrczXFxBBPuR+FV/IQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZqbHU/AKSK5/SbwlJ2o2y+Plh1TQFBeW0dVjsDOSOY1dzfUU7lnA/ic3SUpgw9+gpCdB5uu7g0KTnR272vUDcrGzVLOD76mhQWa+lWVGDKIm46AWIZu4IZ1/GXQwD7yC1d1rvLoY+/z+8s6bHeSvKTDki8ujOyQ0CkKbv13idfI=
Received: by 10.65.97.18 with SMTP id z18mr20106qbl.1179138771963;
        Mon, 14 May 2007 03:32:51 -0700 (PDT)
Received: by 10.65.241.19 with HTTP; Mon, 14 May 2007 03:32:51 -0700 (PDT)
Message-ID: <cda58cb80705140332i79e8396braa008ddf878fb177@mail.gmail.com>
Date:	Mon, 14 May 2007 12:32:51 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] MIPS: Run checksyscalls for N32 and O32 ABI
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, sam@ravnborg.org
In-Reply-To: <20070514.170716.18313509.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cda58cb80705140023w2829d86y662e6fa957b3734c@mail.gmail.com>
	 <20070514.164650.126759873.nemoto@toshiba-tops.co.jp>
	 <cda58cb80705140055r1c3d8431v7be5f805d7dea1db@mail.gmail.com>
	 <20070514.170716.18313509.nemoto@toshiba-tops.co.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15058
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 5/14/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Mon, 14 May 2007 09:55:01 +0200, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> > > Without that, fresh build will fail because missing-syscalls target
> > > requires include/asm, etc.
> >
> > yes but from top makefile, we already have this depedency:
> >
> >         $ grep archprepare: Makefile
> >         archprepare: prepare1 scripts_basic
>
> Yes, and arch Makefile is included _before_ the line.  So "make" will
> try to build arch-missing-syscalls before prepare1.
>

hmm okay. But this depedency is not really nice IMHO...

Something weird is that if you do this on top of your patch, it seems to work:

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 5aa0f41..04a57f9 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -713,7 +713,7 @@ ifdef CONFIG_MIPS32_O32
        $(Q)$(MAKE) $(build)=. missing-syscalls EXTRA_CFLAGS="-mabi=32"
 endif

-archprepare: arch-missing-syscalls
+prepare0: arch-missing-syscalls

 archclean:
        @$(MAKE) $(clean)=arch/mips/boot

It seems that we can't rely on the order of the execution of megerd
prerequisites...
-- 
               Franck
