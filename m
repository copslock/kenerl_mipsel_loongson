Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jan 2008 09:36:47 +0000 (GMT)
Received: from host194-211-dynamic.20-79-r.retail.telecomitalia.it ([79.20.211.194]:21716
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20025128AbYAHJgh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 Jan 2008 09:36:37 +0000
Received: from 89-96-243-184.ip14.fastwebnet.it ([89.96.243.184] helo=[192.168.215.26])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1JCAsm-0002OQ-Il
	for linux-mips@linux-mips.org; Tue, 08 Jan 2008 10:36:30 +0100
Subject: new bug on 2.6.24-rc6
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Tue, 08 Jan 2008 10:36:39 +0100
Message-Id: <1199784999.11579.10.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

I don't know if this is related to mips, but the latest kernel keeps
hanging (at least four times in one day) with this stack trace on both
vfs_read and vfs_write:

800940e4 cache_alloc_refill
80094004 kmem_cache_alloc
801f5fc8 radix_tree_node_alloc
801f6110 radix_tree_insert
8006ba9c add_to_page_cache
8006bcb8 add_to_page_cache_lru
[...]

I am just wondering if anyone if using successfully this kernel version.

bye,
Giuseppe
