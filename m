Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jan 2005 04:15:33 +0000 (GMT)
Received: from dsl-KK-049.206.95.61.touchtelindia.net ([IPv6:::ffff:61.95.206.49]:7599
	"EHLO trishul.procsys.com") by linux-mips.org with ESMTP
	id <S8224791AbVA0EPS>; Thu, 27 Jan 2005 04:15:18 +0000
Received: from procsys.com ([192.168.1.128])
	by trishul.procsys.com (8.12.10/8.12.10) with ESMTP id j0R40KZ7024125
	for <linux-mips@linux-mips.org>; Thu, 27 Jan 2005 09:30:21 +0530
Message-ID: <41F8688A.24C5725C@procsys.com>
Date:	Thu, 27 Jan 2005 09:35:31 +0530
From:	priya <priya@procsys.com>
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Davicom driver support in pmon
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ProcSys-Com-Anti-Virus-Mail-Filter-Virus-Found: no
Return-Path: <priya@procsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: priya@procsys.com
Precedence: bulk
X-list: linux-mips

Hi,
I have implemented a davicom driver on
the same lines as rtl driver in pmon for
a customized mips platform - but iam not
able to set the mac ID. After the init
routine  the driver seem to have has
received a multicaste frame. This i
could verify by putting sufficient
prints. After this nothing happens. I
guess the mac address is also not set
properly. Has any one implemented a
davicom driver in pmon before??

thanks,
priya
