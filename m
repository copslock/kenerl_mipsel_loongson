Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Oct 2005 12:11:23 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:17684 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133494AbVJNLLD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Oct 2005 12:11:03 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9EBAx2H003957;
	Fri, 14 Oct 2005 12:10:59 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9EBAwAw003956;
	Fri, 14 Oct 2005 12:10:58 +0100
Date:	Fri, 14 Oct 2005 12:10:58 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Lohoff <flo@rfc822.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Tftp problems with ARC firmware
Message-ID: <20051014111058.GA2608@linux-mips.org>
References: <20051013193225.GA3137@linux-mips.org> <20051013220936.GA15668@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051013220936.GA15668@paradigm.rfc822.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 14, 2005 at 12:09:36AM +0200, Florian Lohoff wrote:

> >   echo 1 > /proc/sys/net/ipv4/ip_no_pmtu_disc
> >   echo 4096 32767 > /proc/sys/net/ipv4/ip_local_port_range
> > 
> > at a new version of tftp-hpa which solves the PMTU problem by disabling it
> > only for the tftp client and introduces a new -R begin:end option which
> > allows to limit the port number range.  The changes are about to become
> > available in the tftp-hpa git repository at
> > http://www.kernel.org/pub/scm/network/tftp/tftp-hpa.git; see also
> > http://www.linux-mips.org/wiki/ARC#tftp-hpa.  Please send test reports to
> > syslinux@zytor.com and linux-mips@linux-mips.org.
> 
> I made a patch against tftpd-hpa for disabling path MTU discovery - Its
> in the Debian BTS: 
> 
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=316616
> 
> It should already be merged upstream. User "-F" to disable PMTUd.

Never made it to HPA - HPA wrote the patches for these two bugs himself
yesterday when I mentioned the problem to him.  His patches are different
in the he disables PMTU discovery entirely - it's not useful for TFTP.
And your patch doesn't work around the other firmware bug which requires
restricting the port range.  We had to get rid of the currently recommended
workaround - it seriously restricts the IP stack; cripples is probably
the right expression for busy servers.

Patch rotting in the Debian bugtracking system seems to become a classic ;-)

  Ralf
