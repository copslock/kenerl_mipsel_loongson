Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Feb 2003 18:11:26 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:2298 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225207AbTBLSLZ>;
	Wed, 12 Feb 2003 18:11:25 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h1CIBMq13970;
	Wed, 12 Feb 2003 10:11:22 -0800
Date: Wed, 12 Feb 2003 10:11:22 -0800
From: Jun Sun <jsun@mvista.com>
To: Ashish anand <ashish.anand@inspiretech.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: coprocessor unusable exception..
Message-ID: <20030212101122.O7466@mvista.com>
References: <200302121406.h1CE6mvO002242@smtp.inspirtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200302121406.h1CE6mvO002242@smtp.inspirtek.com>; from ashish.anand@inspiretech.com on Wed, Feb 12, 2003 at 07:28:34PM +0530
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


What kernel are you using?  Most likely someone stick a little
printk in your do_cpu() function.

Jun

On Wed, Feb 12, 2003 at 07:28:34PM +0530, Ashish anand wrote:
> Hello,
> 
> I have a quick and small question..
> 
> if after booting linux when i try to execute shell and other user space 
> commands i get few coprocessor unusable exceptions resulting in messages
> like..
> Got cpu at 2aac289c.
> Got cpu at 2aac28a0.
> Got cpu at 2aac28a4.
> Got cpu at 2aac28a8.
> Got cpu at 2aac28dc.
> Got cpu at 2aac287c.
> Got cpu at 2aac2880.
> Got cpu at 2aac2884.
> 
> where does fault it indicates for..?
> Can I ignore it ..?
> 
> Best Regards,
> Ashish Anand
> 
> 
> 
