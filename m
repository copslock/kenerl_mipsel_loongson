Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 May 2008 09:04:59 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:3008 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20021870AbYEHIE4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 May 2008 09:04:56 +0100
Received: (qmail 24587 invoked by uid 1000); 8 May 2008 10:04:54 +0200
Date:	Thu, 8 May 2008 10:04:54 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] au1xmmc: wire up SDIO interrupt
Message-ID: <20080508080454.GG24383@roarinelk.homelinux.net>
References: <20080508080040.GA24383@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080508080040.GA24383@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

