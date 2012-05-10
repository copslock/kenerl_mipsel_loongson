Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 May 2012 14:22:25 +0200 (CEST)
Received: from cantor2.suse.de ([195.135.220.15]:57352 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903655Ab2EJMWT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 May 2012 14:22:19 +0200
Received: from relay2.suse.de (unknown [195.135.220.254])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx2.suse.de (Postfix) with ESMTP id C943EA2CD3;
        Thu, 10 May 2012 14:22:11 +0200 (CEST)
Received: by sepie.suse.cz (Postfix, from userid 10020)
        id BAE6476447; Thu, 10 May 2012 14:22:10 +0200 (CEST)
Date:   Thu, 10 May 2012 14:22:10 +0200
From:   Michal Marek <mmarek@suse.cz>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, Tony Luck <tony.luck@gmail.com>,
        linux arch <linux-arch@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "David S. Miller" <davem@davemloft.net>,
        Arnaud Lacombe <lacombar@gmail.com>,
        Andi Kleen <andi@firstfloor.org>, ralf@linux-mips.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 3/4] kbuild: link of vmlinux moved to a script
Message-ID: <20120510122210.GA17550@sepie.suse.cz>
References: <20120428205651.GA7426@merkur.ravnborg.org>
 <20120428205919.GC7442@merkur.ravnborg.org>
 <4FA460AB.6060309@suse.cz>
 <20120505082916.GA14006@merkur.ravnborg.org>
 <CA+8MBbKd9zAouJy5JvUnLwUHMJ65HsYgCTfBgv42nm32EnMPFA@mail.gmail.com>
 <20120508165118.GA11750@merkur.ravnborg.org>
 <CAP=VYLobO--uwxv_hiMYBnjD-AU_0fqyQJD6argQygnkHnm5Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP=VYLobO--uwxv_hiMYBnjD-AU_0fqyQJD6argQygnkHnm5Vg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33228
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mmarek@suse.cz
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, May 09, 2012 at 06:58:16PM -0400, Paul Gortmaker wrote:
> On Tue, May 8, 2012 at 12:51 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
> > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > index 26c5b65..1f4c27b 100644
> > --- a/scripts/link-vmlinux.sh
> > +++ b/scripts/link-vmlinux.sh
> > @@ -78,8 +78,8 @@ kallsyms()
> > � � � � � � � �kallsymopt=--all-symbols
> > � � � �fi
> >
> > - � � � local aflags="${KBUILD_AFLAGS} ${NOSTDINC_FLAGS} � � � � � � � � � � \
> > - � � � � � � � � � � ${LINUXINCLUDE} ${KBUILD_CPPFLAGS}"
> > + � � � local aflags="${KBUILD_AFLAGS} ${KBUILD_AFLAGS_KERNEL} � � � � � � � \
> > + � � � � � � � � � � ${NOSTDINC_FLAGS} ${LINUXINCLUDE} ${KBUILD_CPPFLAGS}"
> 
> All the linux-next builds for mips are failing, which I tracked down to this.
> Applying the above update doesn't help.  What is happening is that MIPS
> gets KBUILD_CPPFLAGS double-quoted, and then you get:
> 
> + mips-wrs-linux-gnu-nm -n .tmp_vmlinux1
> + scripts/kallsyms
> + mips-wrs-linux-gnu-gcc -D__ASSEMBLY__ <..snip..>  -D__KERNEL__
> '-D"VMLINUX_LOAD_ADDRESS=0xffffffff81100000"' '-D"DATAOFFSET=0"' -c -o
> .tmp_kallsyms1.o -x assembler-with-cpp -
> <command-line>:0: error: macro names must be identifiers
> <command-line>:0: error: macro names must be identifiers
> make[1]: *** [vmlinux] Error 1
> 
> Note the  '-D"VMLINUX_LOAD_ADDRESS=0xffffffff81100000"' '-D"DATAOFFSET=0"'
> part -- that is what triggers the two above errors.

I think it should be as simple as the below patch. But I have no mips
machine to verify myself.

Michal

>From d801533d5e6e509d5e115d2fb47655267c4c5ed4 Mon Sep 17 00:00:00 2001
From: Michal Marek <mmarek@suse.cz>
Date: Thu, 10 May 2012 14:15:49 +0200
Subject: [PATCH] mips: Fix KBUILD_CPPFLAGS definition

The KBUILD_CPPFLAGS variable is no longer passed to sh -c 'gcc ...',
but exported and used by the link-vmlinux.sh script. This means that the
double-quotes will not be evaluated by the shell.

Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Michal Marek <mmarek@suse.cz>

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 4fedf5a..722e04a 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -219,8 +219,8 @@ endif
 
 KBUILD_AFLAGS	+= $(cflags-y)
 KBUILD_CFLAGS	+= $(cflags-y)
-KBUILD_CPPFLAGS += -D"VMLINUX_LOAD_ADDRESS=$(load-y)"
-KBUILD_CPPFLAGS += -D"DATAOFFSET=$(if $(dataoffset-y),$(dataoffset-y),0)"
+KBUILD_CPPFLAGS += -DVMLINUX_LOAD_ADDRESS=$(load-y)
+KBUILD_CPPFLAGS += -DDATAOFFSET=$(if $(dataoffset-y),$(dataoffset-y),0)
 
 LDFLAGS			+= -m $(ld-emul)
 
