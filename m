Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Oct 2004 00:37:56 +0100 (BST)
Received: from ra.tuxdriver.com ([IPv6:::ffff:24.172.12.4]:21266 "EHLO
	ra.tuxdriver.com") by linux-mips.org with ESMTP id <S8225280AbUJFXhw>;
	Thu, 7 Oct 2004 00:37:52 +0100
Received: from bilbo.tuxdriver.com (bilbo.tuxdriver.com [24.172.12.5])
	by ra.tuxdriver.com (8.11.6/8.11.6) with ESMTP id i96MZmh20871
	for <linux-mips@linux-mips.org>; Wed, 6 Oct 2004 18:35:48 -0400
Received: from bilbo.tuxdriver.com (bilbo [127.0.0.1])
	by bilbo.tuxdriver.com (8.12.11/8.12.11) with ESMTP id i96NciTB013434
	for <linux-mips@linux-mips.org>; Wed, 6 Oct 2004 19:38:44 -0400
Received: (from linville@localhost)
	by bilbo.tuxdriver.com (8.12.11/8.12.11/Submit) id i96NchHs013433
	for linux-mips@linux-mips.org; Wed, 6 Oct 2004 19:38:43 -0400
Date: Wed, 6 Oct 2004 19:38:43 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: MIPS Linux List <linux-mips@linux-mips.org>
Subject: glibc 2.3.3 patches for mips?
Message-ID: <20041006233841.GA13351@tuxdriver.com>
Mail-Followup-To: MIPS Linux List <linux-mips@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <linville@bilbo.tuxdriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5963
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linville@tuxdriver.com
Precedence: bulk
X-list: linux-mips

Anyone here using glibc 2.3.3 on mips?  I had trouble using crosstool to
build a gcc_3.3.3-glibc_2.3.3 combination.  gcc_3.3.3-glibc_2.3.3 seems
to have built fine, although I haven't done much testing of the
binaries...

If anyone is using glibc_2.3.3, what patches (if any) did you use to get
it going?

Thanks,

John
-- 
John W. Linville
linville@tuxdriver.com
