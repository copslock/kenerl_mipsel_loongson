Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2005 16:17:18 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.185]:9214 "EHLO
	moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8226053AbVDDPRC>; Mon, 4 Apr 2005 16:17:02 +0100
Received: from [212.227.126.161] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1DITK0-0000QK-00
	for linux-mips@linux-mips.org; Mon, 04 Apr 2005 17:17:00 +0200
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1DITK0-0004jD-00
	for linux-mips@linux-mips.org; Mon, 04 Apr 2005 17:17:00 +0200
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Au1100 FB driver uplift for 2.6
Date:	Mon, 4 Apr 2005 17:17:28 +0200
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504041717.29098.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Greetings!

I'm just looking at these changes and I'm delighted to finally see them in. 
However, I have one small problem: the old version allowed to program EXTCLK1 
and the LCD controller clock via 'mode_toyclksrc' in the panel configuration 
database[1], but this has been removed (also the 'mode_backlight' member, 
btw).
FYI, on the TTP1100[2], the pixelclock for some displays types is created via 
EXTCLK1 which doesn't work anymore, which is why I'm asking.

Am I on the wrong way or should I just reimplement it and send a patch?

Uli

[1] I have a few nits on that, too: IMHO it could be made constant and marked 
as '__initdata' so it is discarded after initialization.
[2] Based on DB1100. Are there any pointers on how to port to a new board, 
btw?
