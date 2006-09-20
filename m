Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Sep 2006 18:08:08 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:48202 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20027554AbWITRIH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 Sep 2006 18:08:07 +0100
Received: by mo.po.2iij.net (mo31) id k8KH83Fx052680; Thu, 21 Sep 2006 02:08:03 +0900 (JST)
Received: from localhost.localdomain (34.26.30.125.dy.iij4u.or.jp [125.30.26.34])
	by mbox.po.2iij.net (mbox33) id k8KH7sgh096138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 21 Sep 2006 02:07:54 +0900 (JST)
Date:	Thu, 21 Sep 2006 01:56:38 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 0/4]  remove scheduled boards
Message-Id: <20060921015638.480ea7b1.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

These boards were scheduled to be removed after 2.6.18 released.

[1/4] MIPS EV96100 evaluation board
[2/4] Momentum / PMC-Sierra Jaguar ATX evaluation board
[3/4] Momentum Ocelot, Ocelot 3, Ocelot C and Ocelot G
[4/4] IT8172-based platforms, ITE 8172G and Globespan IVR

also included in MIPS Technologies' Altas and SEAD evaluation board in the list.
But, SEAD seems to be maintained by Maciej.
Therefore, it is not included in.

Please apply these patches.

Thanks,

Yoichi
