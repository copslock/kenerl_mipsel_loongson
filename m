Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2007 14:26:55 +0100 (BST)
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:22762 "EHLO
	kraid.nerim.net") by ftp.linux-mips.org with ESMTP
	id S20023829AbXJAN0q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Oct 2007 14:26:46 +0100
Received: from hyperion.delvare (jdelvare.pck.nerim.net [62.212.121.182])
	by kraid.nerim.net (Postfix) with ESMTP id 3F836CF12E;
	Mon,  1 Oct 2007 15:26:13 +0200 (CEST)
Date:	Mon, 1 Oct 2007 15:26:13 +0200
From:	Jean Delvare <khali@linux-fr.org>
To:	Mark Zhan <rongkai.zhan@windriver.com>
Cc:	i2c@lm-sensors.org, linux-mips@linux-mips.org,
	rtc-linux@googlegroups.com, a.zummo@towertech.it,
	ralf@linux-mips.org
Subject: Re: [i2c] [PATCH 1/4] i2c sibyte adapter driver is rewritten with
 2.6.x style binding model
Message-ID: <20071001152613.4c2be23c@hyperion.delvare>
In-Reply-To: <46FF7262.9060802@windriver.com>
References: <46FF7262.9060802@windriver.com>
X-Mailer: Sylpheed-Claws 2.5.5 (GTK+ 2.10.6; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <khali@linux-fr.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16769
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
Precedence: bulk
X-list: linux-mips

Hi Mark,

On Sun, 30 Sep 2007 17:54:42 +0800, Mark Zhan wrote:
> This patch re-writes the sibyte i2c adapter driver with 2.6.x style
> binding model.
> 
> Signed-off-by: Mark Zhan <rongkai.zhan@windriver.com>
> ---
>   drivers/i2c/busses/i2c-sibyte.c |  150 ++++++++++++++--------------------------
>   1 file changed, 55 insertions(+), 95 deletions(-)
> 
> --- a/drivers/i2c/busses/i2c-sibyte.c
> +++ b/drivers/i2c/busses/i2c-sibyte.c
> @@ -1,4 +1,5 @@
>   /*
> + * Copyright (C) 2007 Wind River Inc. Mark Zhan <rongkai.zhan@windriver.com>
>    * Copyright (C) 2004 Steven J. Hill
>    * Copyright (C) 2001,2002,2003 Broadcom Corporation
>    * Copyright (C) 1995-2000 Simon G. Vogl

Patch doesn't apply. It seems that your mailer added a leading space on
all context lines? Please address the problem and resend the patch(es).
I volunteer to review patches 1 and 2, once I can apply them.

-- 
Jean Delvare
