Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Oct 2007 16:02:59 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:49941 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20023308AbXJIPCu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 9 Oct 2007 16:02:50 +0100
Received: by mo.po.2iij.net (mo31) id l99F1VVB062109; Wed, 10 Oct 2007 00:01:31 +0900 (JST)
Received: from delta (221.25.30.125.dy.iij4u.or.jp [125.30.25.221])
	by mbox.po.2iij.net (po-mbox303) id l99F1PTx018407
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 10 Oct 2007 00:01:25 +0900
Date:	Wed, 10 Oct 2007 00:01:24 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: fix cpu_type_enum
Message-Id: <20071010000124.c1f995bc.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.0 (GTK+ 2.10.11; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

You forgot a colon after CPU_BCM4710.

http://www.linux-mips.org/git?p=linux-queue.git;a=commit;h=74b4db70cfaa5809eb684bccd5e57150e5149b1d

Yoichi
