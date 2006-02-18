Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Feb 2006 15:48:48 +0000 (GMT)
Received: from lennier.cc.vt.edu ([198.82.162.213]:57763 "EHLO
	lennier.cc.vt.edu") by ftp.linux-mips.org with ESMTP
	id S8133466AbWBRPsh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 18 Feb 2006 15:48:37 +0000
Received: from steiner.cc.vt.edu (IDENT:mirapoint@evil-steiner.cc.vt.edu [10.1.1.14])
	by lennier.cc.vt.edu (8.12.11/8.12.11) with ESMTP id k1IFtGww008323;
	Sat, 18 Feb 2006 10:55:16 -0500
Received: from [192.168.1.2] (blacksburg-bsr1-69-170-32-128.chvlva.adelphia.net [69.170.32.128])
	by steiner.cc.vt.edu (MOS 3.7.3a-GA)
	with ESMTP id EZF63355 (AUTH spbecker);
	Sat, 18 Feb 2006 10:55:13 -0500 (EST)
Message-ID: <43F74360.9080100@gentoo.org>
Date:	Sat, 18 Feb 2006 10:55:12 -0500
From:	"Stephen P. Becker" <geoman@gentoo.org>
User-Agent: Mail/News 1.5 (X11/20060214)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	syslinux@zytor.com
Subject: Re: Tftp problems with ARC firmware
References: <20051013193225.GA3137@linux-mips.org>
In-Reply-To: <20051013193225.GA3137@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10513
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> I'd like to point those who you need to use these crude workarounds:
> 
>   echo 1 > /proc/sys/net/ipv4/ip_no_pmtu_disc
>   echo 4096 32767 > /proc/sys/net/ipv4/ip_local_port_range
> 
> at a new version of tftp-hpa which solves the PMTU problem by disabling it
> only for the tftp client and introduces a new -R begin:end option which
> allows to limit the port number range.  The changes are about to become
> available in the tftp-hpa git repository at
> http://www.kernel.org/pub/scm/network/tftp/tftp-hpa.git; see also
> http://www.linux-mips.org/wiki/ARC#tftp-hpa.  Please send test reports to
> syslinux@zytor.com and linux-mips@linux-mips.org.
> 
>   Ralf
> 
> 

I just (finally) got around to testing this (version 0.42), and I still 
need to set ip_no_pmtu_disc to 1 to netboot.  Is this working for anybody?

-Steve
