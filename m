Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jan 2005 17:20:05 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.186]:56785
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225399AbVANRTy>; Fri, 14 Jan 2005 17:19:54 +0000
Received: from [212.227.126.207] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1CpV70-0007Jd-00
	for linux-mips@linux-mips.org; Fri, 14 Jan 2005 18:19:50 +0100
Received: from [217.91.102.65] (helo=create.4g)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1CpV70-0001IV-00
	for linux-mips@linux-mips.org; Fri, 14 Jan 2005 18:19:51 +0100
From: Michael Stickel <michael.stickel@4g-systems.biz>
To: linux-mips@linux-mips.org
Subject: Au1500 PCI-Bus error handler.
Date: Fri, 14 Jan 2005 18:19:46 +0100
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501141819.46601.michael.stickel@4g-systems.biz>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:f72049c8971f462876d14eb8b3ccbbf1
Return-Path: <michael.stickel@4g-systems.biz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael.stickel@4g-systems.biz
Precedence: bulk
X-list: linux-mips

Hi,

I'm currently implementing an Au1500 PCI-Bus error handler, that printk's PCI 
Errors. The Au1500 has a PCI error reporting interrupt (AU1500_PCI_ERR_INT = 
22). Has someone in the list some experience with that? And, does someone 
know how I can generate a PCI-Bus error?

Michael
