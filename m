Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Feb 2003 08:57:28 +0000 (GMT)
Received: from krt.neobee.net ([IPv6:::ffff:217.26.72.90]:5637 "EHLO
	krt.neobee.net") by linux-mips.org with ESMTP id <S8224939AbTBCI51>;
	Mon, 3 Feb 2003 08:57:27 +0000
Received: (from root@localhost)
	by krt.neobee.net (8.11.6/8.11.4) id h139SOu27696
	for linux-mips@linux-mips.org; Mon, 3 Feb 2003 10:28:24 +0100
Received: from stanojevic ([192.168.0.224])
	by krt.neobee.net (8.11.6/8.11.4) with SMTP id h139SHd27667
	for <linux-mips@linux-mips.org>; Mon, 3 Feb 2003 10:28:23 +0100
Message-ID: <001701c2cb62$3eccd500$e000a8c0@micronasnit.com>
From: "Nemanja Popov" <Nemanja.Popov@micronasnit.com>
To: <linux-mips@linux-mips.org>
Subject: Lexra' s MMU
Date: Mon, 3 Feb 2003 09:57:02 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
X-scanner: scanned by Inflex 1.0.8 - (http://pldaniels.com/inflex/)
Return-Path: <Nemanja.Popov@micronasnit.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Nemanja.Popov@micronasnit.com
Precedence: bulk
X-list: linux-mips

Hi all !
  Does Lexra's CPU LX4280 has MMU. I've found from dateaheet LX4280 that
there is only SMMU (S stands for Simple) which does not include TLB and
exceptions related to that.
  I've noticed port for lexra (among others also for LX4280) on cvs. Is it
possible to run linux on that kind of processor, and if so will it manage
user space application as it should  with mmu.
  Thanx.
