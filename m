Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Dec 2013 22:54:44 +0100 (CET)
Received: from [195.154.112.97] ([195.154.112.97]:44022 "EHLO hall.aurel32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825378Ab3L3VymRHAlC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Dec 2013 22:54:42 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1VxknH-0005Wk-GR; Mon, 30 Dec 2013 22:54:39 +0100
Date:   Mon, 30 Dec 2013 22:54:39 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V15 00/12] MIPS: Add Loongson-3 based machines support
Message-ID: <20131230215439.GA20636@hall.aurel32.net>
References: <1387109676-540-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1387109676-540-1-git-send-email-chenhc@lemote.com>
X-Mailer: Mutt 1.5.21 (2010-09-15)
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Sun, Dec 15, 2013 at 08:14:24PM +0800, Huacai Chen wrote:
> This patchset is prepared for the next 3.14 release for Linux/MIPS. 
> Loongson-3 is a multi-core MIPS family CPU, it is MIPS64R2 compatible
> and has the same IMP field (0x6300) as Loongson-2. These patches make
> Linux kernel support Loongson-3 CPU and Loongson-3 based computers
> (including Laptop, Mini-ITX, All-In-One PC, etc.)

In general this patchset is suffering from coding style issue. I would
suggest you to use the script checkpatch.pl, in the scripts/ directory
of the linux sources.

It currently gives 1 error and 61 warnings for all the patches. You
should try to fix most of them if not all, there are only some rare
cases where the warning should be ignored. 

I am not going to report all the mistakes in the individual patch, the
tool is doing that a lot better than me. Just don't forget to run it
before submitting patches.

-- 
Aurelien Jarno	                        GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net
