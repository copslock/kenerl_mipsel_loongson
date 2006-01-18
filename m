Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2006 14:17:08 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:33808 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133619AbWAROQu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Jan 2006 14:16:50 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id E665DF5B09;
	Wed, 18 Jan 2006 15:20:28 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 10916-03; Wed, 18 Jan 2006 15:20:28 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id A1E57F599A;
	Wed, 18 Jan 2006 15:20:28 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id k0IEKLg2025556;
	Wed, 18 Jan 2006 15:20:21 +0100
Date:	Wed, 18 Jan 2006 14:20:31 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	"Stephen P. Becker" <geoman@gentoo.org>
Cc:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: CONFIG_64BIT and CONFIG_BUILD_ELF64
In-Reply-To: <43CE4CCB.9050605@gentoo.org>
Message-ID: <Pine.LNX.4.64N.0601181418060.18424@blysk.ds.pg.gda.pl>
References: <20060118123110.GA21786@deprecation.cyrius.com>
 <Pine.LNX.4.64N.0601181240090.18424@blysk.ds.pg.gda.pl> <43CE4CCB.9050605@gentoo.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.87.1/1244/Tue Jan 17 09:46:07 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 18 Jan 2006, Stephen P. Becker wrote:

> discussion concerning this yesterday.  The thing is that for certain machines
> such as ip22 and ip32, booting a ELF64 kernel is problematic, so people have
> to make sure they use the vmlinux.32 target.

 Absolutely.  Making `make boot' build a reasonable bootable object for a 
given platform might not be a bad idea.

  Maciej
