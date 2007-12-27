Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Dec 2007 18:32:28 +0000 (GMT)
Received: from smtp-out25.alice.it ([85.33.2.25]:51218 "EHLO
	smtp-out25.alice.it") by ftp.linux-mips.org with ESMTP
	id S20035723AbXL0ScU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Dec 2007 18:32:20 +0000
Received: from FBCMMO02.fbc.local ([192.168.68.196]) by smtp-out25.alice.it with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 27 Dec 2007 19:32:14 +0100
Received: from FBCMCL01B06.fbc.local ([192.168.69.87]) by FBCMMO02.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 27 Dec 2007 19:32:13 +0100
Received: from [192.168.0.3] ([82.55.115.235]) by FBCMCL01B06.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 27 Dec 2007 19:32:11 +0100
From:	Matteo Croce <technoboy85@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH][MIPS][6/6]: AR7 leds
Date:	Thu, 27 Dec 2007 19:32:14 +0100
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
References: <200712271919.23577.technoboy85@gmail.com>
In-Reply-To: <200712271919.23577.technoboy85@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200712271932.14733.technoboy85@gmail.com>
X-OriginalArrivalTime: 27 Dec 2007 18:32:13.0333 (UTC) FILETIME=[CC908450:01C848B6]
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

wrong count, sorry, we don't need LEDs anymore.
What to do with leds? We already use the generic-led subsystem?
