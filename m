Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2005 22:13:02 +0100 (BST)
Received: from mail.glaze.se ([IPv6:::ffff:212.209.188.162]:36358 "HELO
	rocket.glaze.se") by linux-mips.org with SMTP id <S8225411AbVITVMr>;
	Tue, 20 Sep 2005 22:12:47 +0100
Received: from IBMJP (unknown [10.42.1.6])
	by rocket.glaze.se (Postfix) with ESMTP id 730CF376471
	for <linux-mips@linux-mips.org>; Tue, 20 Sep 2005 23:12:45 +0200 (CEST)
From:	"Jan Pedersen" <jan.pedersen@glaze.dk>
To:	<linux-mips@linux-mips.org>
Subject: support for NS DP83847
Date:	Tue, 20 Sep 2005 23:12:47 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcW+KAwQudJ86A6eQhO01u2hZf0YtQ==
Message-Id: <20050920211245.730CF376471@rocket.glaze.se>
Return-Path: <jan.pedersen@glaze.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9006
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jan.pedersen@glaze.dk
Precedence: bulk
X-list: linux-mips

A patch which adds support for the National semiconducor DP83847 PHY in the
au1000 driver is available at http://www.jp-embedded.com. It is well tested,
feel free to use it. There is also a patch available which adds supports for
the mips based boards available at the same site. If there are iterest of
adding theese to the linux-mips kernel cvs, feel free to do so.
