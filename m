Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2007 09:06:45 +0100 (BST)
Received: from smtp1.linux-foundation.org ([65.172.181.25]:9657 "EHLO
	smtp1.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S20021781AbXD1IGn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 28 Apr 2007 09:06:43 +0100
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3S86Xmk006001
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 28 Apr 2007 01:06:34 -0700
Received: from box (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id l3S86WDq017685;
	Sat, 28 Apr 2007 01:06:32 -0700
Date:	Sat, 28 Apr 2007 01:06:32 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, jeff@garzik.org, ralf@linux-mips.org,
	sshtylyov@ru.mvista.com
Subject: Re: [PATCH 3/3] MIPS: Drop unnecessary CONFIG_ISA from RBTX49XX
Message-Id: <20070428010632.7042b2d5.akpm@linux-foundation.org>
In-Reply-To: <20070425.015625.96686329.anemo@mba.ocn.ne.jp>
References: <20070425.015625.96686329.anemo@mba.ocn.ne.jp>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Wed, 25 Apr 2007 01:56:25 +0900 (JST) Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> Those boards do not need CONFIG_ISA if the ne driver could be
> selectable without it.  Disable it and update a defconfig.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
>  arch/mips/Kconfig                     |    2 --
>  arch/mips/configs/rbhma4500_defconfig |   31 -------------------------------

This patch doesn't touch drivers/net, but is related to it, and to the
other two patches.

I will treat patches 1 and 2 as Jeff things, and patch 3 as a Ralf thing. 
Hopefully everything will work OK if they get merged out-of-order.
