Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Mar 2004 15:37:38 +0000 (GMT)
Received: from pop.gmx.de ([IPv6:::ffff:213.165.64.20]:25479 "HELO
	mail.gmx.net") by linux-mips.org with SMTP id <S8225236AbUCQPhi>;
	Wed, 17 Mar 2004 15:37:38 +0000
Received: (qmail 8526 invoked by uid 0); 17 Mar 2004 15:37:31 -0000
Received: from 80.61.177.241 by www48.gmx.net with HTTP;
	Wed, 17 Mar 2004 16:37:31 +0100 (MET)
Date: Wed, 17 Mar 2004 16:37:31 +0100 (MET)
From: "freshy98" <freshy98@gmx.net>
To: linux-mips@linux-mips.org
MIME-Version: 1.0
References: <20040317153023Z8225229-9616+3963@linux-mips.org>
Subject: Re: CVS Update@-mips.org: linux
X-Priority: 3 (Normal)
X-Authenticated: #11016536
Message-ID: <7747.1079537851@www48.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-Path: <freshy98@gmx.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4557
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freshy98@gmx.net
Precedence: bulk
X-list: linux-mips

Ralf,

Is this made from the error message I had the day before yesterday?
If so, I will try to build a new vmlinux.64 tonight and retry it.

With kind regards,

freshy98


> 
> CVSROOT:	/home/cvs
> Module name:	linux
> Changes by:	ralf@ftp.linux-mips.org	04/03/17 15:30:19
> 
> Modified files:
> 	arch/mips/mm   : Tag: linux_2_4 sc-rm7k.c 
> 	arch/mips64/mm : Tag: linux_2_4 sc-rm7k.c 
> 
> Log message:
> 	RM7000 second level cache was likely to nuke the system if it was
> 	called with caches already enabled.
> 
> 

-- 
+++ NEU bei GMX und erstmalig in Deutschland: TÜV-geprüfter Virenschutz +++
100% Virenerkennung nach Wildlist. Infos: http://www.gmx.net/virenschutz
