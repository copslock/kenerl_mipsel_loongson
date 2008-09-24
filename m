Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2008 14:52:14 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:58606 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S28777236AbYIXNwM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 24 Sep 2008 14:52:12 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m8ODq9TB001918;
	Wed, 24 Sep 2008 15:52:09 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m8ODq8CI001914;
	Wed, 24 Sep 2008 14:52:08 +0100
Date:	Wed, 24 Sep 2008 14:52:07 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
cc:	Ralf Baechle <ralf@linux-mips.org>, bzolnier@gmail.com,
	linux-ide@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] IDE: Fix platform device registration in Swarm IDE driver
In-Reply-To: <48DA1F9D.6000501@ru.mvista.com>
Message-ID: <Pine.LNX.4.55.0809241448480.811@cliff.in.clinika.pl>
References: <20080922122853.GA15210@linux-mips.org> <48DA1F9D.6000501@ru.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 24 Sep 2008, Sergei Shtylyov wrote:

>    Platform device in the driver itself? Interesting... :-)

 Better than nothing for platforms which did not have platform
initialisation at all.  Some driver subsystems do not support
non-driver-model devices at all or anymore.

  Maciej
