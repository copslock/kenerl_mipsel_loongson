Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jan 2005 05:35:36 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:39696 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224788AbVASFfa>; Wed, 19 Jan 2005 05:35:30 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 1865AF5973; Wed, 19 Jan 2005 06:35:29 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 28651-07; Wed, 19 Jan 2005 06:35:29 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id E32FFE1C8B; Wed, 19 Jan 2005 06:35:28 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j0J5ZS6c003411;
	Wed, 19 Jan 2005 06:35:28 +0100
Date: Wed, 19 Jan 2005 05:35:29 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
In-Reply-To: <20050119143146.09982d63.yuasa@hh.iij4u.or.jp>
Message-ID: <Pine.LNX.4.61L.0501190533450.26851@blysk.ds.pg.gda.pl>
References: <20050115013112Z8225557-1340+1316@linux-mips.org>
 <20050119134211.2c0e24f5.yuasa@hh.iij4u.or.jp>
 <Pine.LNX.4.61L.0501190502070.26851@blysk.ds.pg.gda.pl>
 <20050119143146.09982d63.yuasa@hh.iij4u.or.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/661/Tue Jan 11 02:44:13 2005
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status: Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6946
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 19 Jan 2005, Yoichi Yuasa wrote:

> >  Neither of these uses any CONFIG_* macros.
> 
> I'm making patch for giu.c and icu.c.
> These patches need it. 

 Then please just include what you need within these patches.  That's the 
usual way of doing stuff.

  Maciej
