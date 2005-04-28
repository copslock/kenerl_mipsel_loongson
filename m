Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Apr 2005 03:14:55 +0100 (BST)
Received: from ntfw.echelon.com ([IPv6:::ffff:205.229.50.10]:8944 "EHLO
	[205.229.50.10]") by linux-mips.org with ESMTP id <S8225474AbVD1COk>;
	Thu, 28 Apr 2005 03:14:40 +0100
Received: from miles.echelon.com by [205.229.50.10]
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with ESMTP; Wed, 27 Apr 2005 19:14:38 -0700
Received: by miles.echelon.echcorp.com with Internet Mail Service (5.5.2653.19)
	id <JWPMNMC3>; Wed, 27 Apr 2005 19:14:36 -0700
Message-ID: <5375D9FB1CC3994D9DCBC47C344EEB590165465A@miles.echelon.echcorp.com>
From:	Prashant Viswanathan <vprashant@echelon.com>
To:	linux-mips@linux-mips.org
Subject:  Big Endian au1550
Date:	Wed, 27 Apr 2005 19:14:35 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Return-Path: <vprashant@echelon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vprashant@echelon.com
Precedence: bulk
X-list: linux-mips

Is there a reason why the default configuration file doesn't support Big
Endian for the dbAu1550? 

Even if I edit .config to set the endianness to "BIG" it seems to change to
"Little Endian" every time a make is run.

Thanks
Prashant
