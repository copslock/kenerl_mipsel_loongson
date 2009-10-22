Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2009 00:09:17 +0200 (CEST)
Received: from zrtps0kp.nortel.com ([47.140.192.56]:64457 "EHLO
	zrtps0kp.nortel.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493832AbZJVWJL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2009 00:09:11 +0200
Received: from zcarhxs1.corp.nortel.com (casmtp.ca.nortel.com [47.129.230.89])
	by zrtps0kp.nortel.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id n9MM8ro07774;
	Thu, 22 Oct 2009 22:08:53 GMT
Received: from localhost.localdomain ([47.130.81.219] RDNS failed) by zcarhxs1.corp.nortel.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 22 Oct 2009 18:08:32 -0400
Message-ID: <4AE0D72A.4090607@nortel.com>
Date:	Thu, 22 Oct 2009 16:05:30 -0600
From:	"Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.4pre) Gecko/20090922 Fedora/3.0-2.7.b4.fc11 Thunderbird/3.0b4
MIME-Version: 1.0
To:	David Daney <ddaney@caviumnetworks.com>
CC:	netdev@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: Irq architecture for multi-core network driver.
References: <4AE0D14B.1070307@caviumnetworks.com>
In-Reply-To: <4AE0D14B.1070307@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Oct 2009 22:08:32.0133 (UTC) FILETIME=[313BFB50:01CA5364]
Return-Path: <CFRIESEN@nortel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cfriesen@nortel.com
Precedence: bulk
X-list: linux-mips

On 10/22/2009 03:40 PM, David Daney wrote:

> The main problem I have encountered is how to fit the interrupt
> management into the kernel framework.  Currently the interrupt source
> is connected to a single irq number.  I request_irq, and then manage
> the masking and unmasking on a per cpu basis by directly manipulating
> the interrupt controller's affinity/routing registers.  This goes
> behind the back of all the kernel's standard interrupt management
> routines.  I am looking for a better approach.
> 
> One thing that comes to mind is that I could assign a different
> interrupt number per cpu to the interrupt signal.  So instead of
> having one irq I would have 32 of them.  The driver would then do
> request_irq for all 32 irqs, and could call enable_irq and disable_irq
> to enable and disable them.  The problem with this is that there isn't
> really a single packets-ready signal, but instead 16 of them.  So If I
> go this route I would have 16(lines) x 32(cpus) = 512 interrupt
> numbers just for the networking hardware, which seems a bit excessive.

Does your hardware do flow-based queues?  In this model you have
multiple rx queues and the hardware hashes incoming packets to a single
queue based on the addresses, ports, etc. This ensures that all the
packets of a single connection always get processed in the order they
arrived at the net device.

Typically in this model you have as many interrupts as queues
(presumably 16 in your case).  Each queue is assigned an interrupt and
that interrupt is affined to a single core.

The intel igb driver is an example of one that uses this sort of design.

Chris
