Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 May 2004 20:26:26 +0100 (BST)
Received: from p508B675A.dip.t-dialin.net ([IPv6:::ffff:80.139.103.90]:54806
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8226016AbUEYT0X>; Tue, 25 May 2004 20:26:23 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i4PJQJ1v022490;
	Tue, 25 May 2004 21:26:19 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i4PJQIeN022489;
	Tue, 25 May 2004 21:26:18 +0200
Date:	Tue, 25 May 2004 21:26:18 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ratin Kumar <ratin@koperasw.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Gnome/Mozilla on Malta
Message-ID: <20040525192618.GB21912@linux-mips.org>
References: <00b601c44289$09cfc2a0$6901a8c0@ratwin1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00b601c44289$09cfc2a0$6901a8c0@ratwin1>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5165
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 25, 2004 at 11:49:36AM -0700, Ratin Kumar wrote:

> Has anyone tried building gnome and/or mozilla for Malta?

Really, there's nothing Malta-specific in Gnome or Mozilla.

> My target is RH7.3 port for mipsel with a matrox mill II PCI card in frame
> buffer mode.
> 
>  
> 
> I have tried native build of gnome and got quiet a few components going.
> 
>  
> 
> I have also tried garnome with some success in getting a few components to
> build but it failed with Nautilus.
> 
>  
> 
> I have also tried KDE but for some odd reason it does not pick up my QT
> installation during configure stage, even after I have set the
> LD_LIBRARY_PATH...

Take a look at what the configure script really does.  Typically when
something like this happens the config script is trying to link a library
which fails because the library doesn't have the necessary DT_NEEDED
entries due to yet other bugs or the symbol it is tested for doesn't
exist in that particular version.

Having the right compiler version is very important to get some gnome code
to work.  Even more so if it's written in C++ and for KDE code.  You may
want to check you're using the same versions as i.e. i386 was using for
the same distribution.

> Basically I want to have a browser running on RH installation.

How about cheating, the Debian people got it working ;-)

  Ralf
