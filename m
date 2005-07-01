Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 10:39:18 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:28690 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226135AbVGAJjB>; Fri, 1 Jul 2005 10:39:01 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 33A4EF5977; Fri,  1 Jul 2005 11:38:49 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 15473-09; Fri,  1 Jul 2005 11:38:49 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id E39DAE1C8A; Fri,  1 Jul 2005 11:38:48 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j619cp2b011209;
	Fri, 1 Jul 2005 11:38:51 +0200
Date:	Fri, 1 Jul 2005 10:38:55 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	David Daney <ddaney@avtrex.com>,
	Michael Stickel <michael@cubic.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: RE: Problems with Intel e100 driver on new MIPS port, was: Advice
 needed WRT very slow nfs in new port...
In-Reply-To: <Pine.LNX.4.62.0507011059420.5245@numbat.sonytel.be>
Message-ID: <Pine.LNX.4.61L.0507011036110.30138@blysk.ds.pg.gda.pl>
References: <01049E563C8ECC43AD6B53A5AF419B38098BD1@avtrex-server2.hq2.avtrex.com>
 <Pine.LNX.4.61L.0507010953420.30138@blysk.ds.pg.gda.pl>
 <Pine.LNX.4.62.0507011059420.5245@numbat.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/962/Fri Jul  1 07:19:05 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 1 Jul 2005, Geert Uytterhoeven wrote:

> The e100 is a quite popular card, so I'd expect it to be in use on many
> platforms.

 Is it?  I've thought manufacturers only mount these chips on motherboards 
as otherwise nobody would buy them. ;-)  Oh well...

  Maciej
