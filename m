Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Mar 2005 13:01:37 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.183]:18685
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8229623AbVCZNBX> convert rfc822-to-8bit; Sat, 26 Mar 2005 13:01:23 +0000
Received: from [212.227.126.161] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1DFAuo-0008Vw-00
	for linux-mips@linux-mips.org; Sat, 26 Mar 2005 14:01:22 +0100
Received: from [80.171.18.129] (helo=d018129.adsl.hansenet.de)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1DFAun-00045P-00
	for linux-mips@linux-mips.org; Sat, 26 Mar 2005 14:01:21 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
To:	linux-mips@linux-mips.org
Subject: board configuration and status registers (BCSR)
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Disposition: inline
Organization: Sator Laser GmbH
Date:	Sat, 26 Mar 2005 13:59:10 +0100
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200503261359.10332.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Hi!

From what I could tell, all the Alchemy based boards have those BCSR, but I 
wonder where I could find more info about those. The Au1100 programming 
manual is totally silent on that matter but in the attached hardware itself I 
couldn't find anything that corresponds to that - or am I just not looking 
hard enough? Could anybody point me to some docs on that?

cheers

Uli
