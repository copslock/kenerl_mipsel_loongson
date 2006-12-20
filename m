Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Dec 2006 12:01:41 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:58640 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S28582458AbWLTMBe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 Dec 2006 12:01:34 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 158B6FE2B9;
	Wed, 20 Dec 2006 13:01:19 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AseC5nLWdLAQ; Wed, 20 Dec 2006 13:01:18 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 9ADE9FE2B5;
	Wed, 20 Dec 2006 13:01:18 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id kBKC1MsL010498;
	Wed, 20 Dec 2006 13:01:23 +0100
Date:	Wed, 20 Dec 2006 12:01:19 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@osdl.org>, Ralf Baechle <ralf@linux-mips.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Antonino Daplas <adaplas@pol.net>, James.Bottomley@SteelEye.com
cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
	linux-scsi@vger.kernel.org
Subject: [PATCH 2.6.20-rc1 00/10] TURBOchannel update to the driver model
Message-ID: <Pine.LNX.4.64N.0612182115550.10069@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.7/2360/Wed Dec 20 07:24:09 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hello,

 It has been much longer than expected, but finally it is here!  This 
series of patches converts support for the TURBOchannel bus to the driver 
model.  As a nice side effect, the generic part of the code is now really 
generic, that is no more dependencies on MIPS specifics under drivers/tc/ 
and platform specific code for MIPS got moved where it belongs.  As to 
whether other relevant platforms will add TURBOchannel support or not I 
cannot tell right now. ;-)

 All the changes have been successfully tested with a DECstation 5000/133 
and the necessary bits of additional hardware as appropriate.  Where 
drivers supporting different bus attachments were concerned, they were 
built for configurations enabling all the other buses supported and 
run-time checked if possible.

 And last but not least, thanks to James Simmons for beginning this work a 
while ago as his code was great to start with.

  Maciej
