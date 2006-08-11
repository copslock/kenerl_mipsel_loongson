Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Aug 2006 20:49:37 +0100 (BST)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:64179 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S20045064AbWHKTtf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 Aug 2006 20:49:35 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.13.6/8.13.4) with ESMTP id k7BK9i4G004373;
	Fri, 11 Aug 2006 21:09:44 +0100
Received: (from alan@localhost)
	by localhost.localdomain (8.13.6/8.13.6/Submit) id k7BK9iNY004372;
	Fri, 11 Aug 2006 21:09:44 +0100
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: [PATCH] Image capturing driver for Basler eXcite smart camera
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Thomas Koeller <thomas.koeller@baslerweb.com>
Cc:	linux-kernel@vger.kernel.org, akpm@osdl.org,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <200608102318.04512.thomas.koeller@baslerweb.com>
References: <200608102318.04512.thomas.koeller@baslerweb.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Fri, 11 Aug 2006 21:09:43 +0100
Message-Id: <1155326983.24077.119.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

Ar Iau, 2006-08-10 am 23:18 +0200, ysgrifennodd Thomas Koeller:
> This is a driver used for image capturing by the Basler eXcite smart camera
> platform.

drivers/media/video and the Video4Linux2 API deal with image capture in
Linux. It provides a common API for video and thus image capture. Any
reason that interface is not suitable.

Alan
