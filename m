Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2018 08:39:45 +0100 (CET)
Received: from mxhk.zte.com.cn ([63.217.80.70]:24144 "EHLO mxhk.zte.com.cn"
	rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
	id S23990418AbeJaHjkla4Si (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 31 Oct 2018 08:39:40 +0100
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
	by Forcepoint Email with ESMTPS id 29A48546F684D577C821;
	Wed, 31 Oct 2018 15:39:38 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
	by mse01.zte.com.cn with ESMTP id w9V7dSGe015250;
	Wed, 31 Oct 2018 15:39:28 +0800 (GMT-8)
	(envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018103115395006-7800048 ;
          Wed, 31 Oct 2018 15:39:50 +0800 
From:	Yi Wang <wang.yi59@zte.com.cn>
To:	paul.burton@mips.com, sboyd@kernel.org
Cc:	mturquette@baylibre.com, linux-mips@linux-mips.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhong.weidong@zte.com.cn, Yi Wang <wang.yi59@zte.com.cn>
Subject: [PATCH v3 0/2] fix memory leak and unregister issue in clk_boston_setup()
Date:	Wed, 31 Oct 2018 15:41:40 +0800
Message-Id: <1540971702-3133-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-10-31 15:39:50,
	Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-10-31 15:39:20,
	Serialize complete at 2018-10-31 15:39:20
X-MAIL:	mse01.zte.com.cn w9V7dSGe015250
Return-Path: <wang.yi59@zte.com.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wang.yi59@zte.com.cn
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

This fix two issues in clk_boston_setup() function:
- possible memory leak of 'onecell'
- registered clks not unregister when error happens

Changes from v2:
- include smatch to the commit
- unregister clks which registered before going out

Yi Wang (2):
  clk: boston: fix possible memory leak in clk_boston_setup()
  clk: boston: unregister clks on failure in clk_boston_setup()

 drivers/clk/imgtec/clk-boston.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

-- 
1.8.3.1
