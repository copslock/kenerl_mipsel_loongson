Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Mar 2005 15:38:56 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.185]:8919 "EHLO
	moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8226872AbVCVPil>; Tue, 22 Mar 2005 15:38:41 +0000
Received: from [212.227.126.155] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1DDlSp-0003G5-00
	for linux-mips@linux-mips.org; Tue, 22 Mar 2005 16:38:39 +0100
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1DDlSp-0001aD-00
	for linux-mips@linux-mips.org; Tue, 22 Mar 2005 16:38:39 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: ohci-au1xxx.c breakage
Date:	Tue, 22 Mar 2005 16:38:46 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503221638.46922.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7502
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Greetings!

There seem to have been some changes to the USB driver kernel API which the 
Au1xxx driver wasn't adapted to. I just wanted to say that I'm working on it, 
but without really knowing much about the framework so success is not 
guaranteed... 

If someone else wants to earn the fame I will happily step back. ;)

Uli
