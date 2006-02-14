Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2006 01:53:22 +0000 (GMT)
Received: from mo00.po.2iij.net ([210.130.202.204]:41448 "EHLO
	mo00.po.2iij.net") by ftp.linux-mips.org with ESMTP
	id S3467611AbWBNBxN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Feb 2006 01:53:13 +0000
Received: NPO MO00 id k1E1xTPg024121; Tue, 14 Feb 2006 10:59:29 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (NPO-MR/mbox02) id k1E1xSRW007832
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Tue, 14 Feb 2006 10:59:28 +0900 (JST)
Date:	Tue, 14 Feb 2006 10:59:28 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] fix cache coherency issues
Message-Id: <20060214105928.0cd46e6f.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20060214.011508.41198724.anemo@mba.ocn.ne.jp>
References: <20060214.011508.41198724.anemo@mba.ocn.ne.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Envid: tripeaks.co.jp
Envelope-Id: tripeaks.co.jp
X-archive-position: 10429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Nemoto-san,

VR41xx cannot be booted with 2.6.16-rc2 + patch.
It freeze after "Freeing unused kernel memory: 168k freed".

Yoichi
