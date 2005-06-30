Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2005 02:58:30 +0100 (BST)
Received: from vc4-2-0-87.dsl.netrack.net ([IPv6:::ffff:199.45.160.85]:13524
	"EHLO harmony.village.org") by linux-mips.org with ESMTP
	id <S8226078AbVF3B6J>; Thu, 30 Jun 2005 02:58:09 +0100
Received: from localhost (localhost.village.org [127.0.0.1])
	by harmony.village.org (8.13.3/8.13.3) with ESMTP id j5U1u1wp066152;
	Wed, 29 Jun 2005 19:56:01 -0600 (MDT)
	(envelope-from imp@bsdimp.com)
Date:	Wed, 29 Jun 2005 19:57:43 -0600 (MDT)
Message-Id: <20050629.195743.48512936.imp@bsdimp.com>
To:	ddaney@avtrex.com
Cc:	linux-mips@linux-mips.org, linux.nics@intel.com
Subject: Re: Problems with Intel e100 driver on new MIPS port, was: Advice
 needed WRT very slow nfs in new port...
From:	"M. Warner Losh" <imp@bsdimp.com>
In-Reply-To: <42C34C4D.9020902@avtrex.com>
References: <42C1C6EA.5080709@avtrex.com>
	<42C34C4D.9020902@avtrex.com>
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <imp@bsdimp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8251
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imp@bsdimp.com
Precedence: bulk
X-list: linux-mips

In message: <42C34C4D.9020902@avtrex.com>
            David Daney <ddaney@avtrex.com> writes:
: Does anyone have any idea what would cause 1000mS delay?

That's remarkably close to 1s.  This often indicates that the transmit
of your next packet is causing the receive buffer to empty.  This is
usually due to blocked interrupts, or a failure to enable interrupts.

Warner
