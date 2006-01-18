Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2006 12:39:00 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:40968 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133596AbWARMim (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Jan 2006 12:38:42 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 1CAADF5AFD;
	Wed, 18 Jan 2006 13:42:23 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 21296-03; Wed, 18 Jan 2006 13:42:22 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id D083FE1C62;
	Wed, 18 Jan 2006 13:42:22 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id k0ICgGcU003537;
	Wed, 18 Jan 2006 13:42:16 +0100
Date:	Wed, 18 Jan 2006 12:42:25 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: CONFIG_64BIT and CONFIG_BUILD_ELF64
In-Reply-To: <20060118123110.GA21786@deprecation.cyrius.com>
Message-ID: <Pine.LNX.4.64N.0601181240090.18424@blysk.ds.pg.gda.pl>
References: <20060118123110.GA21786@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.87.1/1244/Tue Jan 17 09:46:07 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9960
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 18 Jan 2006, Martin Michlmayr wrote:

> Is there a good reason why CONFIG_64BIT does not activate
> CONFIG_BUILD_ELF64 automatically?

 It works with some old toolchains and apparently there are people who 
want this feature.  Please feel free to propose a patch to add such a 
dependency and see if there are any objections.

  Maciej
