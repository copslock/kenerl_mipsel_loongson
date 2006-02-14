Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2006 08:51:49 +0000 (GMT)
Received: from mo00.po.2iij.net ([210.130.202.204]:58347 "EHLO
	mo00.po.2iij.net") by ftp.linux-mips.org with ESMTP
	id S8133381AbWBNIuk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Feb 2006 08:50:40 +0000
Received: NPO MO00 id k1E8uwNw019520; Tue, 14 Feb 2006 17:56:58 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (NPO-MR/mbox03) id k1E8uvm1021728
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Tue, 14 Feb 2006 17:56:57 +0900 (JST)
Message-Id: <200602140856.k1E8uvm1021728@mbox03.po.2iij.net>
Date:	Tue, 14 Feb 2006 17:56:57 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] fix cache coherency issues
In-Reply-To: <20060214.164216.48797359.nemoto@toshiba-tops.co.jp>
References: <20060214112653.25ed3e05.yoichi_yuasa@tripeaks.co.jp>
	<20060214.120846.15248106.nemoto@toshiba-tops.co.jp>
	<200602140707.k1E77Tah013064@mbox00.po.2iij.net>
	<20060214.164216.48797359.nemoto@toshiba-tops.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Envid: tripeaks.co.jp
Envelope-Id: tripeaks.co.jp
X-archive-position: 10451
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Tue, 14 Feb 2006 16:42:16 +0900 (JST)
Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> >>>>> On Tue, 14 Feb 2006 16:07:29 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> said:
> yuasa> I added the patch and tested it.  It has same problem.
> 
> Thank you.  I realize the reason just now.  VR41XX's PTE format is a
> bit different from others.  I should use mk_pte() to wrap these
> difference.
> 
> Could you try this patch?  64BIT_PHYS_ADDR + MIPS32_R1 part are not
> tested ;-)

This patch fixed the boot problem, but the kernel still has cache coherency problem.

~# ./cachetest 
Test separation: 4096 bytes: FAIL - cache not coherent
Test separation: 8192 bytes: pass
Test separation: 16384 bytes: pass
Test separation: 32768 bytes: pass
Test separation: 65536 bytes: pass
Test separation: 131072 bytes: pass
Test separation: 262144 bytes: pass
Test separation: 524288 bytes: pass
Test separation: 1048576 bytes: pass
Test separation: 2097152 bytes: pass
Test separation: 4194304 bytes: pass
Test separation: 8388608 bytes: pass
Test separation: 16777216 bytes: pass
VM page alias coherency test: minimum fast spacing: 8192 (2 pages)

I'm using the following test program.

http://lkml.org/lkml/2003/8/29/6

Yoichi
