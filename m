Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2006 08:24:01 +0100 (BST)
Received: from mailout2.samsung.com ([203.254.224.25]:30700 "EHLO
	mailout2.samsung.com") by ftp.linux-mips.org with ESMTP
	id S20037820AbWH2HX7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 29 Aug 2006 08:23:59 +0100
Received: from ep_mmp2 (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0J4R000WE0JRD0@mailout2.samsung.com> for
 linux-mips@linux-mips.org; Tue, 29 Aug 2006 16:23:51 +0900 (KST)
Received: from mon12key ([10.88.163.201])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 HotFix 1.17 (built Jun 23
 2003)) with ESMTPA id <0J4R004IX0JQ2P@mmp2.samsung.com> for
 linux-mips@linux-mips.org; Tue, 29 Aug 2006 16:23:51 +0900 (KST)
Date:	Tue, 29 Aug 2006 16:23:55 +0900
From:	=?ks_c_5601-1987?B?wMzA58HY?= <jj76.lee@samsung.com>
Subject: Data corruption during direct-IO
In-reply-to: <50c9a2250607062212w70de956ax7aefd4f131ae9396@mail.gmail.com>
To:	'linux-mips' <linux-mips@linux-mips.org>
Message-id: <0J4R004IY0JQ2P@mmp2.samsung.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Content-type: text/plain; charset=ks_c_5601-1987
Content-transfer-encoding: 7BIT
Thread-index: AcahhBZjm5Q6FhFfR1OnbzKQpyBJXgpsgKLA
Return-Path: <jj76.lee@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12454
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jj76.lee@samsung.com
Precedence: bulk
X-list: linux-mips

Hi everyone.

I'm working on some application which is using directly block device with
direct-IO.
When the application writes some patterns and reads it again. The pattern
is broken with 32bytes. I think that is due to the data-cache coherent
problem.

So, I inserted the code dma_cache_inv() before direct-IO().

After the patch, it works well. 

Could you tell me why the data is broken and why mips-kernel doesn't handle
data cache?

Thanks for any comments. 

Best Regards
JJ
