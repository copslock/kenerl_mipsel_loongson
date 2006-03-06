Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Mar 2006 17:01:44 +0000 (GMT)
Received: from [62.38.112.228] ([62.38.112.228]:35718 "EHLO pfn3.pefnos")
	by ftp.linux-mips.org with ESMTP id S8133992AbWCFRBe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 6 Mar 2006 17:01:34 +0000
Received: from xorhgos2.pefnos (xorhgos2.pefnos [192.168.0.3])
	by pfn3.pefnos (Postfix) with ESMTP id 6E0B932F69;
	Mon,  6 Mar 2006 19:09:21 +0200 (EET)
From:	"P. Christeas" <p_christ@hol.gr>
To:	Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: does the linux support rootfs on vfat?
Date:	Mon, 6 Mar 2006 19:08:54 +0200
User-Agent: KMail/1.9
References: <50c9a2250603042217l475e84pc9ab7ce87c40eb76@mail.gmail.com> <20060305112247.GA4243@linux-mips.org> <440C6814.4020204@am.sony.com>
In-Reply-To: <440C6814.4020204@am.sony.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603061908.58658.p_christ@hol.gr>
Return-Path: <p_christ@hol.gr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10738
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p_christ@hol.gr
Precedence: bulk
X-list: linux-mips

On Monday 06 March 2006 6:49 pm, you wrote:
> It's attractive for a limited resource device that needs to have FAT
> support for a removable flash memory card (for Windows PC
> interoperability).  If you can use FAT for the root fs, that reduces the
> system resource needs.
>
> It doesn't make sense if his ide disk is non-removable though.
>

IMHO it is a bad idea alltogether. You are asking for trouble. The system 
resource needs are rather increased [1] than decreased. 
On the other hand, you would you need to trade files between the *root* fs of 
the linux and Windoze? Usually we want to trade some user files (like photos, 
music etc.), but not the system files. Would you trust Windoze ever not to 
destroy something in those root files? Why don't you create a second, VFAT 
partition and mount it somewhere?

[1] ext2 or whatever is optimized. FAT isn't so and you really want to run 
Linux trivial files from an optimized system.
