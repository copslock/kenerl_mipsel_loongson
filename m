Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 May 2004 11:40:58 +0100 (BST)
Received: from verein.lst.de ([IPv6:::ffff:212.34.189.10]:42702 "EHLO
	mail.lst.de") by linux-mips.org with ESMTP id <S8225222AbUEGKk5>;
	Fri, 7 May 2004 11:40:57 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-6.6) with ESMTP id i47AetQc010815
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 7 May 2004 12:40:55 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id i47AetWZ010813;
	Fri, 7 May 2004 12:40:55 +0200
Date: Fri, 7 May 2004 12:40:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: ppopov@mvista.com
Cc: linux-mips@linux-mips.org
Subject: drivers/pcmcia/au1000_generic.c
Message-ID: <20040507104055.GA10779@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

Does someone care for that file in 2.6?  It doesn't compile at all in
2.4, in fact it looks like someone just dropped that file into the tree
after all 2.5 pcmcia changes were over..
