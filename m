Received:  by oss.sgi.com id <S42281AbQIZKjd>;
	Tue, 26 Sep 2000 03:39:33 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:2052 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S42267AbQIZKjN>;
	Tue, 26 Sep 2000 03:39:13 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id A77B77F3; Tue, 26 Sep 2000 12:44:58 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 8F1FB9014; Tue, 26 Sep 2000 12:36:00 +0200 (CEST)
Date:   Tue, 26 Sep 2000 12:36:00 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     "Gleb O. Raiko" <raiko@niisi.msk.ru>
Cc:     Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr, linux-origin@oss.sgi.com
Subject: Re: libc upgrade
Message-ID: <20000926123600.A413@paradigm.rfc822.org>
References: <20000922152604.A2627@bacchus.dhis.org> <20000925112413.B3247@paradigm.rfc822.org> <20000925132056.A7598@bacchus.dhis.org> <20000925161500.A4773@paradigm.rfc822.org> <20000925221414.A6190@bacchus.dhis.org> <20000926010416.B3761@paradigm.rfc822.org> <39D06065.FC00C7A0@niisi.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <39D06065.FC00C7A0@niisi.msk.ru>; from raiko@niisi.msk.ru on Tue, Sep 26, 2000 at 12:37:57PM +0400
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Sep 26, 2000 at 12:37:57PM +0400, Gleb O. Raiko wrote:
> > > Ok, second theory.  What linker where you using to build all this programs?
> > > The new ld.so needs to know what ld has built programs due to some pretty
> > > stupid pre-2.9.something brokeness in R_MIPS_32 reloction handling.
> > 
> > egcs 1.0.3a binutils 2.8.1 (Very conservative)
> > 
> 
> Well, another question. Ralf uploaded cross tools rpms year ago. Does
> anybody have native rmps for big endian ? Also, does anybody have cross
> tools for sparc glibc 2.1 (RH6.x sparc distribution) ? I can't compile
> cross gcc on my Ultra, it seems like a bug in the sparc compiler, the
> process fails in parsing an enum decl in a header.

I tried to compile cross gcc/binutils from CVS a couple of times
for Linux/Sparc (Ultra) which didnt work as somewhere in the
middle the beast meant to use the native "as" instead of
mipsel-linux-as

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
