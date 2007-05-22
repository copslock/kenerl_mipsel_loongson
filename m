Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 May 2007 17:18:44 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:21898 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20024435AbXEVQSj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 22 May 2007 17:18:39 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 7F93A861E0;
	Tue, 22 May 2007 17:18:49 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1HqW8O-0000ds-Fu; Tue, 22 May 2007 16:18:48 +0100
Date:	Tue, 22 May 2007 16:18:48 +0100
To:	sknauert@wesleyan.edu
Cc:	linux-mips@linux-mips.org
Subject: Re: SGI O2 meth: missing sysfs device symlink
Message-ID: <20070522151848.GB19833@networkno.de>
References: <20070516151939.GH19816@deprecation.cyrius.com> <20070516160313.GA3409@bongo.bofh.it> <50621.192.168.2.50.1179383217.squirrel@eppesuigoccas.homedns.org> <20070517151636.GJ3586@deprecation.cyrius.com> <20070521154726.GE5943@linux-mips.org> <20070522110956.GB29118@linux-mips.org> <1179834093.7896.23.camel@scarafaggio> <34888.129.133.92.31.1179835313.squirrel@webmail.wesleyan.edu> <20070522122808.GD32557@linux-mips.org> <36324.129.133.92.31.1179840724.squirrel@webmail.wesleyan.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36324.129.133.92.31.1179840724.squirrel@webmail.wesleyan.edu>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

sknauert@wesleyan.edu wrote:
> > On Tue, May 22, 2007 at 08:01:53AM -0400, sknauert@wesleyan.edu wrote:
> >
> >> I've noticed that besides kernel complied from the Debian 2.6.18, I
> >> can't
> >> get any other kernel (vanilla from kernel.org or the separate linux-MIPS
> >> repository) to boot on my O2.
> >>
> >> If you need beta testers, I can try, but it will take a day or so
> >> (compiling on the O2 is slow).
> >
> > Sounds almost like you're building an excessibly large kernel
> > configuration.
> > A realistic kernel config will crosscompile within a few minutes on a
> > modest machine such as a 3GHz / 1GB P4-class PC.
> >
> 
> I could never get cross-compiling to work, so I've been doing all my
> compiling directly on the R5K 300 Mhz CPU in my O2. If there is an easy
> way to get this to work, I'd be very thankful for some pointers. Might my
> trying to compile on the actual machine be why I can't seem to use any
> source other than Debian's 2.6.18?

Should be rather straightforward:

- Add the sources.list line mentioned in the repository to your
  /etc/apt/sources.list, for debian/stable that's:

  deb http://people.debian.org/~ths/toolchain/current etch/

- apt-get update
- apt-get install gcc-4.1-mips-linux-gnu

- In your www.linux-mips.org source tree, compile with e.g.
  make CROSS_COMPILE=mips-linux-gnu- oldconfig
  make CROSS_COMPILE=mips-linux-gnu- all


Thiemo
