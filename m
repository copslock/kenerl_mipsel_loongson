Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jun 2008 07:39:14 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:57539 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20029937AbYFIGjM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jun 2008 07:39:12 +0100
Received: (qmail 8914 invoked by uid 1000); 9 Jun 2008 08:39:11 +0200
Date:	Mon, 9 Jun 2008 08:39:11 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org, sshtylyov@ru.mvista.com,
	drzeus@drzeus.cx, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] au1xmmc: abort requests early if no card is present.
Message-ID: <20080609063911.GG8724@roarinelk.homelinux.net>
References: <20080609063521.GA8724@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080609063521.GA8724@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

