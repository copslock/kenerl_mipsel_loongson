Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2005 03:43:17 +0100 (BST)
Received: from vc4-2-0-87.dsl.netrack.net ([IPv6:::ffff:199.45.160.85]:9677
	"EHLO harmony.village.org") by linux-mips.org with ESMTP
	id <S8226083AbVF3CnC>; Thu, 30 Jun 2005 03:43:02 +0100
Received: from localhost (localhost.village.org [127.0.0.1])
	by harmony.village.org (8.13.3/8.13.3) with ESMTP id j5U2f3Pk066517;
	Wed, 29 Jun 2005 20:41:03 -0600 (MDT)
	(envelope-from imp@bsdimp.com)
Date:	Wed, 29 Jun 2005 20:42:46 -0600 (MDT)
Message-Id: <20050629.204246.102671266.imp@bsdimp.com>
To:	ddaney@avtrex.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Problems with Intel e100 driver on new MIPS port, was: Advice
 needed WRT very slow nfs in new port...
From:	"M. Warner Losh" <imp@bsdimp.com>
In-Reply-To: <42C359F8.4060000@avtrex.com>
References: <42C34C4D.9020902@avtrex.com>
	<20050629.195743.48512936.imp@bsdimp.com>
	<42C359F8.4060000@avtrex.com>
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <imp@bsdimp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8253
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imp@bsdimp.com
Precedence: bulk
X-list: linux-mips

In message: <42C359F8.4060000@avtrex.com>
            David Daney <ddaney@avtrex.com> writes:
: M. Warner Losh wrote:
: > In message: <42C34C4D.9020902@avtrex.com>
: >             David Daney <ddaney@avtrex.com> writes:
: > : Does anyone have any idea what would cause 1000mS delay?
: > 
: > That's remarkably close to 1s.  This often indicates that the transmit
: > of your next packet is causing the receive buffer to empty.  This is
: > usually due to blocked interrupts, or a failure to enable interrupts.
: > 
: 
: But I observe ever increasing counts for the device in /proc/interrupts. 
:   So the interrupts are working somewhat.

Are you sure that you've routed the interrupts correctly?  Maybe those
interrupts are 'really' for a different device....

Warner
