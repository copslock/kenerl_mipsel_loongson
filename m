Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2004 23:01:09 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:40696 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225314AbUBDXBH>;
	Wed, 4 Feb 2004 23:01:07 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id i14N14L04569;
	Wed, 4 Feb 2004 15:01:04 -0800
Date: Wed, 4 Feb 2004 15:01:04 -0800
From: Jun Sun <jsun@mvista.com>
To: Prashant Viswanathan <vprashant@echelon.com>
Cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>,
	jsun@mvista.com
Subject: Re: configuring console to use a different UART
Message-ID: <20040204150104.G26726@mvista.com>
References: <5375D9FB1CC3994D9DCBC47C344EEB59383A13@miles.echelon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5375D9FB1CC3994D9DCBC47C344EEB59383A13@miles.echelon.com>; from vprashant@echelon.com on Wed, Feb 04, 2004 at 02:42:13PM -0800
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Feb 04, 2004 at 02:42:13PM -0800, Prashant Viswanathan wrote:
> Hi,
> 
> How can I change the kernel so that it uses the UART I specify for the
> console instead of the first available one? I dont want to pass this on the
> bootline but want to compile this into vmlinux.
> 

With 2.6, set CONFIG_CMDLINE with something like:

console=ttyS1,38400

With 2.4, add (strcpy or strcat) the above string to your arcs_cmdline 
defined by your specific board code.

Jun
