Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Jan 2005 16:09:28 +0000 (GMT)
Received: from mo00.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:24046 "EHLO
	mo00.iij4u.or.jp") by linux-mips.org with ESMTP id <S8224912AbVAWQJX>;
	Sun, 23 Jan 2005 16:09:23 +0000
Received: MO(mo00)id j0NG9JmN028833; Mon, 24 Jan 2005 01:09:19 +0900 (JST)
Received: MDO(mdo00) id j0NG9ImR005787; Mon, 24 Jan 2005 01:09:19 +0900 (JST)
Received: 4UMRO00 id j0NG9Hhq016946; Mon, 24 Jan 2005 01:09:18 +0900 (JST)
	from stratos (localhost [127.0.0.1]) (authenticated)
Date:	Mon, 24 Jan 2005 01:09:15 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	linux-mips <linux-mips@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp
Subject: [resend]]PATCH 2.6] vr41xx: fixed gettimeoffset
Message-Id: <20050124010915.54dc7fe1.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi,

VR41xx gettimeoffset is wrong.
This patch changes vr41xx gettimeoffset to fixed rate gettimeoffset.

Please apply this patch to v2.6.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
