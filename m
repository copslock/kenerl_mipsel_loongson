Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Sep 2002 18:47:56 +0200 (CEST)
Received: from [212.74.13.151] ([212.74.13.151]:36848 "EHLO dell.zee2.com")
	by linux-mips.org with ESMTP id <S1122978AbSITQrz>;
	Fri, 20 Sep 2002 18:47:55 +0200
Received: from zee2.com (localhost [127.0.0.1])
	by dell.zee2.com (8.11.6/8.11.6) with ESMTP id g8KGkhM24567;
	Fri, 20 Sep 2002 17:46:44 +0100
Message-ID: <3D8B50F2.760D2BDC@zee2.com>
Date: Fri, 20 Sep 2002 17:46:42 +0100
From: Stuart Hughes <seh@zee2.com>
Organization: Zee2 Ltd
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
CC: Linda Wang <linda.wang@intransa.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: FW: cannot debug multi-threaded programs with gdb/gdbserver
References: <EA23924D8B48774F889C7733226B28E8B7E51C@exalane.intransa.com> <3D8AEC84.ADA8CE0A@zee2.com> <20020920162433.GA12166@nevyn.them.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <seh@zee2.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 259
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: seh@zee2.com
Precedence: bulk
X-list: linux-mips

Daniel Jacobowitz wrote:
> 
> On Fri, Sep 20, 2002 at 10:38:12AM +0100, Stuart Hughes wrote:
> > Hi Linda,
> >
> > It seems to work fine on simple programs, but on some other large
> > applications some behaviour is not predictable (this may well be the
> > application, as it issues SIGSTOP/SIGCONT to control threads, and I
> > think this causes gdb to get confused).
> 
> This should not confuse gdbserver.  I'm not sure what it'll do to
> native GDB, but I don't think it'll confuse that either...

I explained it badly.  By confused I mean that these signals cause the
debugger to stop and print the fact they they received SIGCONT.  I just
want these signals handled by the application and not intercepted by the
debugger, I played with "handle SIGCONT" but I didn't manage to get it
to work as I wanted ( I tried: pass noprint nostop)


> > You would need to:
> > - make a symlink on the homst from lib -> mylibs
> > - set <path_to_your_shared_libs> to /home/seh/project/test
> 
> You should not be doing it this way; life will be much easier if you
> just set the shared libraries up in the same hierarchy on target and
> host and set solib-absolute-prefix /location/of/host/lib/tree.  That
> is,
>         /location/of/host/lib/tree/lib/ld-2.2.5.so
>         /location/of/host/lib/tree/usr/lib/libz.so
> et cetera.

Thanks for the hint, this is a much better way to do it.

Regards, Stuart
