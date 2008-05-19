Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 May 2008 09:08:09 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:38080 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20022341AbYESIIG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 May 2008 09:08:06 +0100
Received: (qmail 22177 invoked by uid 1000); 19 May 2008 10:08:04 +0200
Date:	Mon, 19 May 2008 10:08:04 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	drzeus@drzeus.cx, sshtylyov@ru.mvista.com
Subject: [PATCH 8/9] au1xmmc: abort requests early if no card is present
Message-ID: <20080519080804.GI21985@roarinelk.homelinux.net>
References: <20080519080339.GA21985@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080519080339.GA21985@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19306
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

