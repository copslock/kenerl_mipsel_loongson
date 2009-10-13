Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2009 17:51:28 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17326 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493096AbZJMPvV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2009 17:51:21 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4ad4a1e90000>; Tue, 13 Oct 2009 08:51:05 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 13 Oct 2009 08:51:07 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 13 Oct 2009 08:51:07 -0700
Message-ID: <4AD4A1E9.1080309@caviumnetworks.com>
Date:	Tue, 13 Oct 2009 08:51:05 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 0/2] Two improvements to Octeon irq handling.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Oct 2009 15:51:07.0721 (UTC) FILETIME=[FA652B90:01CA4C1C]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The first patch is a locking correctness issue, the second an optimization.

David Daney (2):
   MIPS: Octeon: Use write_lock_irqsave/write_unlock_irqrestore when
     setting irq affinity.
   MIPS: Octeon: Use lockless interrupt controller operations when
     possible.

  arch/mips/cavium-octeon/octeon-irq.c |  187 
++++++++++++++++++++++++++++++++--
  1 files changed, 178 insertions(+), 9 deletions(-)
