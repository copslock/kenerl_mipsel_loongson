Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jul 2009 08:54:55 +0200 (CEST)
Received: from 1wt.eu ([62.212.114.60]:37070 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492008AbZGAGyr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Jul 2009 08:54:47 +0200
Date:	Wed, 1 Jul 2009 08:49:37 +0200
From:	Willy Tarreau <w@1wt.eu>
To:	Frank Seidel <Frank.Seidel@sphairon.com>
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH] linux-2.4: br2684: fix double freeing skb
Message-ID: <20090701064937.GA22396@1wt.eu>
References: <4A49C9BC.6050908@sphairon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A49C9BC.6050908@sphairon.com>
User-Agent: Mutt/1.5.11
Return-Path: <w@1wt.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w@1wt.eu
Precedence: bulk
X-list: linux-mips

On Tue, Jun 30, 2009 at 10:15:56AM +0200, Frank Seidel wrote:
> Author: Peter Sieber <siep@sphairon.com>
> 
> Fix double freeing skb, see net/core/dev.c
> dev_queue_xmit().
> 
> Signed-off-by: Peter Sieber <siep@sphairon.com>
> Signed-off-by: Frank Seidel <Frank.Seidel@sphairon.com>

queued for inclusion, thanks Frank!

Willy
