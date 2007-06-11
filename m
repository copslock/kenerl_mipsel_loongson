Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jun 2007 14:27:39 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:35087 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20024007AbXFKN1h (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 11 Jun 2007 14:27:37 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 3355CE1CA8;
	Mon, 11 Jun 2007 15:26:56 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q8WZRmXjJNBa; Mon, 11 Jun 2007 15:26:56 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id CC6B9E1C97;
	Mon, 11 Jun 2007 15:26:55 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l5BDR6FT010591;
	Mon, 11 Jun 2007 15:27:06 +0200
Date:	Mon, 11 Jun 2007 14:27:02 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] Remove MIPS SEAD support
In-Reply-To: <11815673362011-git-send-email-fbuihuu@gmail.com>
Message-ID: <Pine.LNX.4.64N.0706111425110.6714@blysk.ds.pg.gda.pl>
References: <11815673353523-git-send-email-fbuihuu@gmail.com>
 <11815673362011-git-send-email-fbuihuu@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.3/3399/Mon Jun 11 09:27:52 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 11 Jun 2007, Franck Bui-Huu wrote:

> Mips Sead support is deprecated and scheduled for removal
> since September 2006.

 Oh, is it?  The last time I tried it worked.  Have you tried it and 
failed to build?  That should be easy to fix.

  Maciej
