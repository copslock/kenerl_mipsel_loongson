Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Jun 2009 18:31:48 +0200 (CEST)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:49103 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492634AbZFOQbm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 15 Jun 2009 18:31:42 +0200
Received: from gandalf ([74.67.89.75]) by hrndva-omta03.mail.rr.com
          with ESMTP
          id <20090615163041388.MECJ3293@hrndva-omta03.mail.rr.com>;
          Mon, 15 Jun 2009 16:30:41 +0000
Date:	Mon, 15 Jun 2009 12:30:40 -0400 (EDT)
From:	Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To:	David Daney <ddaney@caviumnetworks.com>
cc:	Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org,
	Wang Liming <liming.wang@windriver.com>,
	Wu Zhangjin <wuzj@lemote.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH v3] filter local function prefixed by $L
In-Reply-To: <4A366FF7.2010206@caviumnetworks.com>
Message-ID: <alpine.DEB.2.00.0906151214160.30161@gandalf.stny.rr.com>
References: <cover.1244994151.git.wuzj@lemote.com> <d0983eb71d7517d0e536352f3288e995abbb0e07.1244994151.git.wuzj@lemote.com> <4A366FF7.2010206@caviumnetworks.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips


On Mon, 15 Jun 2009, David Daney wrote:

> Wu Zhangjin wrote:
> > From: Wu Zhangjin <wuzj@lemote.com>
> > 
> > this patch fixed the warning as following:
> > 
> > mipsel-linux-gnu-objcopy: 'fs/proc/.tmp_gl_devices.o': No such file
> > mipsel-linux-gnu-ld: fs/proc/.tmp_gl_devices.o: No such file: No such
> > file or directory
> > rm: cannot remove `fs/proc/.tmp_gl_devices.o': No such file or directory
> > rm: cannot remove `fs/proc/.tmp_mx_devices.o': No such file or directory
> > 
> > the real reason of above warning is that the $Lxx local functions will
> > be treated as global symbols, so, should be filtered.
> > 
> > Signed-off-by: Wu Zhangjin <wuzj@lemote.com>
> > ---
> >  scripts/recordmcount.pl |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> > 
> > diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
> > index 533d3bf..542cb04 100755
> > --- a/scripts/recordmcount.pl
> > +++ b/scripts/recordmcount.pl
> > @@ -343,6 +343,10 @@ sub update_funcs
> >  	if (!$use_locals) {
> >  	    return;
> >  	}
> > +	# filter $LXXX tags
> > +	if ("$ref_func" =~ m/\$L/) {
> > +		return;
> > +	}
> 
> Certainly this is true for mips.  I doubt it is for all architectures targed
> by Linux.

Yes, that should probably go into a mips only change. Unless you can 
reproduce it on all other archs, or at least x86.

You could also do this in the function_regex variable.

 "^([0-9a-fA-F]+)\\s+<(.|[^\$]L.*?|\$[^L].*?|[^\$][^L].*?)>:"

There may even be a better way, but I'm not in the mood to look it up ;-)

-- Steve
