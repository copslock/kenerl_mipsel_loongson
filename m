Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Apr 2003 17:32:50 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:30194 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225203AbTD2Qcs>;
	Tue, 29 Apr 2003 17:32:48 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h3TGWfq20673;
	Tue, 29 Apr 2003 09:32:41 -0700
Date: Tue, 29 Apr 2003 09:32:41 -0700
From: Jun Sun <jsun@mvista.com>
To: Gilad Benjamini <yaelgilad@myrealbox.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: getting cycles in 64 bit resolution
Message-ID: <20030429093241.A20639@mvista.com>
References: <1051604123.bea267c0yaelgilad@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1051604123.bea267c0yaelgilad@myrealbox.com>; from yaelgilad@myrealbox.com on Tue, Apr 29, 2003 at 08:15:23AM +0000
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2227
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Apr 29, 2003 at 08:15:23AM +0000, Gilad Benjamini wrote:
> Hi,
> get_cycles provides me the low 32 bit of the number
> of cycles.
> How can I, in a 32 bit system, get the high 32 bit ?
>

CPU counter register only has 32 bit.  You have to 
maintain the upper 32bit yourself if you want 64bit counter.  
You might be able to re-use timerhi variable in arch/mips/kernel/time.c file.

Jun
