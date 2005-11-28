Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Nov 2005 10:34:46 +0000 (GMT)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:39613 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133396AbVK1Ke2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 28 Nov 2005 10:34:28 +0000
Received: from localhost (in-1.mx.triera.net [213.161.0.25])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 013F1C00C
	for <linux-mips@linux-mips.org>; Mon, 28 Nov 2005 11:37:34 +0100 (CET)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-1.mx.triera.net (Postfix) with SMTP id C14C81BC08C
	for <linux-mips@linux-mips.org>; Mon, 28 Nov 2005 11:37:36 +0100 (CET)
Received: from [172.18.1.53] (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id 695961A18AE
	for <linux-mips@linux-mips.org>; Mon, 28 Nov 2005 11:37:36 +0100 (CET)
Subject: PIC/Cardbus on AU1200
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Mon, 28 Nov 2005 11:37:19 +0100
Message-Id: <1133174239.11413.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9557
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi

We'd like to add a Cardbus to the AMD AU1200 CPU.

Does anybody has any experience in this?

I've seen that many ARM boards uses IT8152 IC from ITE,
however I cannot find any more information about it.
Does any bod know for a PCI (or Cardbus) controller, 
that can connect easily to the AU1200?

BR,
Matej
