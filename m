Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jan 2006 20:11:08 +0000 (GMT)
Received: from nevyn.them.org ([66.93.172.17]:44712 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S8133429AbWAKUKn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Jan 2006 20:10:43 +0000
Received: from drow by nevyn.them.org with local (Exim 4.54)
	id 1EwmLy-0005y9-Ma; Wed, 11 Jan 2006 15:13:54 -0500
Date:	Wed, 11 Jan 2006 15:13:54 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: QEMU and kernel 2.6.15
Message-ID: <20060111201354.GA22873@nevyn.them.org>
References: <20060111.002431.93019846.anemo@mba.ocn.ne.jp> <20060111144355.GA17275@nevyn.them.org> <20060112.000904.74752908.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060112.000904.74752908.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9865
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 12, 2006 at 12:09:04AM +0900, Atsushi Nemoto wrote:
> mips-softmmu/qemu-system-mips -kernel /home/git/build-qemu/arch/mips/boot/vmlinux.bin -m 16 -nographic

Just to check, could you try -m 32 or -m 128?  It shouldn't rely on
more than 16MB, but the boundary condition may be wrong.

Beyond that, I have no idea what might be wrong.

-- 
Daniel Jacobowitz
CodeSourcery
