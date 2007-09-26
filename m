Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2007 12:32:52 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:6597 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20029521AbXIZLco (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Sep 2007 12:32:44 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id B194B400ED;
	Wed, 26 Sep 2007 13:32:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id VkNWb9Nhuu5z; Wed, 26 Sep 2007 13:32:10 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 33236400A9;
	Wed, 26 Sep 2007 13:32:10 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l8QBWCQe028165;
	Wed, 26 Sep 2007 13:32:12 +0200
Date:	Wed, 26 Sep 2007 12:32:08 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>, linux-mips@linux-mips.org,
	Franck Bui-Huu <fbuihuu@gmail.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: CONFIG_BUILD_ELF64 broken on IP32 since 2.6.20
In-Reply-To: <20070926102412.GK3337@deprecation.cyrius.com>
Message-ID: <Pine.LNX.4.64N.0709261226340.30122@blysk.ds.pg.gda.pl>
References: <20070925181353.GA15412@deprecation.cyrius.com> <46FA1260.4000404@gmail.com>
 <20070926091443.GA10236@deprecation.cyrius.com> <46FA2C39.9020503@gmail.com>
 <20070926102412.GK3337@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4403/Wed Sep 26 09:09:09 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 26 Sep 2007, Martin Michlmayr wrote:

> > Weird, all these symbols seem to be 32 bits ones...
> > 
> > Could you put somewhere your vmlinux you're actually running ?
> 
> http://merkel.debian.org/~tbm/tmp/vmlinux.32
> Note that I'm using "make vmlinux.32"

 It should not matter here -- the build is done using the ELF32 or ELF64 
file format according to CONFIG_BUILD_ELF64 and if you request a target 
like "vmlinux.32" or "vmlinux.64" the resulting "vmlinux" binary is 
converted to ELF32 or ELF64 respectively with `objcopy' (which is 
equivalent to `cp', barring oddities of `objcopy', if "vmlinux" is already 
of the "right" type).

  Maciej
