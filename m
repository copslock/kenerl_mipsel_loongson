Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 May 2008 17:08:20 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:38867 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20022220AbYEGQIR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 May 2008 17:08:17 +0100
Received: (qmail 17974 invoked by uid 1000); 7 May 2008 18:08:10 +0200
Date:	Wed, 7 May 2008 18:08:10 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] au1xmmc: wire up SDIO interrupt
Message-ID: <20080507160810.GG17806@roarinelk.homelinux.net>
References: <20080507160154.GA17806@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080507160154.GA17806@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

