Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2003 12:33:22 +0100 (BST)
Received: from mail011.syd.optusnet.com.au ([IPv6:::ffff:210.49.20.139]:53127
	"EHLO mail011.syd.optusnet.com.au") by linux-mips.org with ESMTP
	id <S8225240AbTFLLdU>; Thu, 12 Jun 2003 12:33:20 +0100
Received: from localhost.karma (c17997.eburwd3.vic.optusnet.com.au [210.49.198.98])
	by mail011.syd.optusnet.com.au (8.11.6p2/8.11.6) with ESMTP id h5CBXBX13016;
	Thu, 12 Jun 2003 21:33:12 +1000
Received: from satisfactory (satisfactory [192.168.0.1])
	by localhost.karma (Postfix) with ESMTP
	id D3B4C1C; Thu, 12 Jun 2003 21:33:09 +1000 (EST)
Received: by satisfactory (Postfix, from userid 500)
	id 1514247606; Thu, 12 Jun 2003 21:36:26 +0000 (UTC)
Date: Thu, 12 Jun 2003 21:36:25 +0000
From: Andrew Clausen <clausen@gnu.org>
To: Trevor Woerner <mips081@vtnet.ca>
Cc: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: 64-bit sysinfo
Message-ID: <20030612213625.GF480@gnu.org>
References: <200306120659.26501.mips081@vtnet.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306120659.26501.mips081@vtnet.ca>
X-Accept-Language: en,pt
User-Agent: Mutt/1.5.4i
Return-Path: <clausen@gnu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2605
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clausen@gnu.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 12, 2003 at 06:59:26AM -0400, Trevor Woerner wrote:
> I'm crossing my fingers and hoping that my solution is to build all 
> user-space apps with some switch that will set the sizes of data types 
> to be the same between user space and kernel space. Does some such 
> option exist?

No, the kernel should provide 32 bit values.  This is a bug.

I *thought* I sent a patch for this a while ago... I'm not sure now.

Cheers,
Andrew
