Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Aug 2005 15:58:55 +0100 (BST)
Received: from mx02.qsc.de ([IPv6:::ffff:213.148.130.14]:52196 "EHLO
	mx02.qsc.de") by linux-mips.org with ESMTP id <S8225240AbVHJO6k>;
	Wed, 10 Aug 2005 15:58:40 +0100
Received: from port-195-158-169-137.dynamic.qsc.de ([195.158.169.137] helo=hattusa.textio)
	by mx02.qsc.de with esmtp (Exim 3.35 #1)
	id 1E2s6A-0002J9-00; Wed, 10 Aug 2005 17:02:30 +0200
Received: from ths by hattusa.textio with local (Exim 4.52)
	id 1E2s6A-0003Jb-9a; Wed, 10 Aug 2005 17:02:30 +0200
Date:	Wed, 10 Aug 2005 17:02:30 +0200
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Greg Weeks <greg.weeks@timesys.com>, linux-mips@linux-mips.org
Subject: Re: 24K malta
Message-ID: <20050810150230.GC1638@hattusa.textio>
References: <42FA03D4.5060400@timesys.com> <20050810140243.GD2840@linux-mips.org> <42FA0B9E.4030900@timesys.com> <42FA1311.4060903@timesys.com> <20050810144947.GE2840@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050810144947.GE2840@linux-mips.org>
User-Agent: Mutt/1.5.9i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Wed, Aug 10, 2005 at 10:45:37AM -0400, Greg Weeks wrote:
> 
> > Current CVS fails to build the malta_defconfig with:
> > 
> > 
> > scripts/kconfig/mconf arch/mips/Kconfig
> > arch/mips/Kconfig:690: can't open file "arch/mips/tx4938/Kconfig"
> > make[1]: *** [menuconfig] Error 1
> > make: *** [menuconfig] Error 2
> 
> CVS pilot error.  cvs -q update -d -P and don't forget to bitch about it ;)

The CVS authors should have made some sane global defaults. I use this
~/.cvsrc to make it less annoying:

hattusa:~$ cat .cvsrc
cvs -qz9
diff -upNR
rdiff -uR
update -dPR
checkout -P


Thiemo
