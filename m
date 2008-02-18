Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Feb 2008 10:21:50 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:61153 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20027477AbYBRKVr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 18 Feb 2008 10:21:47 +0000
Received: (qmail 7307 invoked by uid 1000); 18 Feb 2008 11:21:46 +0100
Date:	Mon, 18 Feb 2008 11:21:46 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Adrian Bunk <bunk@kernel.org>
Cc:	Jean Delvare <khali@linux-fr.org>, ralf@linux-mips.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: mips SMBUS_PSC_BASE compile errors
Message-ID: <20080218102146.GA7282@roarinelk.homelinux.net>
References: <20080217200953.GJ1403@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080217200953.GJ1403@cs181133002.pp.htv.fi>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18248
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

> ...
>   CC      arch/mips/au1000/common/platform.o
> /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/au1000/common/platform.c:277: error: 'PSC0_BASE_ADDR' undeclared here (not in a function)
> /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/au1000/common/platform.c:314: warning: no previous prototype for 'au1xxx_platform_init'
> make[2]: *** [arch/mips/au1000/common/platform.o] Error 1

Thanks, here's a patch. The db1200/pb1550 defconfigs (+ i2c enabled) compile
fine with it:

---
