Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Feb 2004 18:22:48 +0000 (GMT)
Received: from mother.pmc-sierra.com ([IPv6:::ffff:216.241.224.12]:63957 "HELO
	mother.pmc-sierra.bc.ca") by linux-mips.org with SMTP
	id <S8225486AbUBSSWs>; Thu, 19 Feb 2004 18:22:48 +0000
Received: (qmail 20387 invoked from network); 19 Feb 2004 18:22:40 -0000
Received: from unknown (HELO ogmios.pmc-sierra.bc.ca) (216.241.226.59)
  by mother.pmc-sierra.com with SMTP; 19 Feb 2004 18:22:40 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogmios.pmc-sierra.bc.ca (8.12.9/8.12.7) with ESMTP id i1JIMdlR003571
	for <linux-mips@linux-mips.org>; Thu, 19 Feb 2004 10:22:39 -0800
Received: by bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <1B2CDMC6>; Thu, 19 Feb 2004 10:22:39 -0800
Message-ID: <9DFF23E1E33391449FDC324526D1F25901D0A6AB@sjc1exm02.pmc_nt.nt.pmc-sierra.bc.ca>
From: Adam Kiepul <Adam_Kiepul@pmc-sierra.com>
To: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: IT8172 IDE support in 2.4.24
Date: Thu, 19 Feb 2004 10:17:25 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Adam_Kiepul@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4384
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Adam_Kiepul@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Hi,

Could anyone please tell me whether the 2.4.24 source actually supports the IDE HDD in the default configuration for the ITE 8172?
I have built the kernel and it boots up fine with the NFS root. However, it is unable to mount the root file system on a HDD. When I try to mount the /dev/hda1 while running with NFS root I get the "/dev/hda1 is not a valid block device" message. Am I missing something?

Thanks a lot,

-------------------
Adam Kiepul
Sr. Applications Engineer

PMC-Sierra, Microprocessor Division
Mission Towers One
3975 Freedom Circle
Santa Clara, CA 95054, USA
Direct: 408 239 8124
Fax: 408 492 9462
http://www.pmc-sierra.com/processors
