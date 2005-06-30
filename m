Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2005 07:50:54 +0100 (BST)
Received: from p549F5F56.dip.t-dialin.net ([IPv6:::ffff:84.159.95.86]:55276
	"EHLO p549F5F56.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8226003AbVF3Gud>; Thu, 30 Jun 2005 07:50:33 +0100
Received: from c152027.adsl.hansenet.de ([IPv6:::ffff:213.39.152.27]:48914
	"EHLO gruft.cubic.org") by linux-mips.net with ESMTP
	id <S869077AbVF3GuR>; Thu, 30 Jun 2005 08:50:17 +0200
Received: from cubic.org (starbase [192.168.10.1])
	by gruft.cubic.org (8.12.2/8.12.2) with ESMTP id j5U6o3m9013755
	for <linux-mips@linux-mips.org>; Thu, 30 Jun 2005 08:50:03 +0200
Message-ID: <42C39066.2060406@cubic.org>
Date:	Thu, 30 Jun 2005 08:25:42 +0200
From:	Michael Stickel <michael@cubic.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Problems with Intel e100 driver on new MIPS port, was: Advice
 needed WRT very slow nfs in new port...
References: <42C34C4D.9020902@avtrex.com>	<20050629.195743.48512936.imp@bsdimp.com>	<42C359F8.4060000@avtrex.com> <20050629.204246.102671266.imp@bsdimp.com>
In-Reply-To: <20050629.204246.102671266.imp@bsdimp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <michael@cubic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael@cubic.org
Precedence: bulk
X-list: linux-mips

M. Warner Losh wrote:

>In message: <42C359F8.4060000@avtrex.com>
>            David Daney <ddaney@avtrex.com> writes:
>: M. Warner Losh wrote:
>: > In message: <42C34C4D.9020902@avtrex.com>
>: >             David Daney <ddaney@avtrex.com> writes:
>: > : Does anyone have any idea what would cause 1000mS delay?
>: > 
>: > That's remarkably close to 1s.  This often indicates that the transmit
>: > of your next packet is causing the receive buffer to empty.  This is
>: > usually due to blocked interrupts, or a failure to enable interrupts.
>: > 
>: 
>: But I observe ever increasing counts for the device in /proc/interrupts. 
>:   So the interrupts are working somewhat.
>
>Are you sure that you've routed the interrupts correctly?  Maybe those
>interrupts are 'really' for a different device....
>  
>
Add some debugging to the interrupt routine of the e100 and see what 
happens.

Michael
