Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Apr 2005 16:17:08 +0100 (BST)
Received: from mx01.qsc.de ([IPv6:::ffff:213.148.129.14]:48848 "EHLO
	mx01.qsc.de") by linux-mips.org with ESMTP id <S8226148AbVDSPQx>;
	Tue, 19 Apr 2005 16:16:53 +0100
Received: from port-195-158-168-232.dynamic.qsc.de ([195.158.168.232] helo=hattusa.textio)
	by mx01.qsc.de with esmtp (Exim 3.35 #1)
	id 1DNuSx-0002ba-00; Tue, 19 Apr 2005 17:16:43 +0200
Received: from ths by hattusa.textio with local (Exim 4.50)
	id 1DNtpH-000479-L8; Tue, 19 Apr 2005 16:35:43 +0200
Date:	Tue, 19 Apr 2005 16:35:43 +0200
To:	Greg Weeks <greg.weeks@timesys.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: sysv ipc msg functions
Message-ID: <20050419143543.GB3300@hattusa.textio>
References: <426518D0.5080506@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426518D0.5080506@timesys.com>
User-Agent: Mutt/1.5.9i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7764
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Greg Weeks wrote:
> I needed this glibc patch to get the sysv ipc msgctl functions to work 
> correctly. This looks a bit hackish to me, so I wanted to run it past 
> everybody here before filing it with glibc.

The Debian glibc has a similiar patch, see
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=200215&archive=yes
for a discussion.


Thiemo
