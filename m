Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Dec 2011 19:34:16 +0100 (CET)
Received: from mail.vyatta.com ([76.74.103.46]:47736 "EHLO mail.vyatta.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903617Ab1L0SeM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 27 Dec 2011 19:34:12 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.vyatta.com (Postfix) with ESMTP id 3BD251410002;
        Tue, 27 Dec 2011 10:34:10 -0800 (PST)
X-Virus-Scanned: amavisd-new at tahiti.vyatta.com
Received: from mail.vyatta.com ([127.0.0.1])
        by localhost (mail.vyatta.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id X9T3Q1BWkCPh; Tue, 27 Dec 2011 10:34:09 -0800 (PST)
Received: from nehalam.linuxnetplumber.net (static-50-53-80-93.bvtn.or.frontiernet.net [50.53.80.93])
        by mail.vyatta.com (Postfix) with ESMTPSA id 729CE1410001;
        Tue, 27 Dec 2011 10:34:09 -0800 (PST)
Date:   Tue, 27 Dec 2011 10:34:08 -0800
From:   Stephen Hemminger <shemminger@vyatta.com>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     netdev@vger.kernel.org, Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] net: meth: Add set_rx_mode hook to fix ICMPv6 neighbor
 discovery
Message-ID: <20111227103408.01aad10e@nehalam.linuxnetplumber.net>
In-Reply-To: <4EF95247.7000403@gentoo.org>
References: <4EED3A3D.9080503@gentoo.org>
        <4EF95247.7000403@gentoo.org>
Organization: Vyatta
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 32199
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shemminger@vyatta.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20079

On Tue, 27 Dec 2011 00:06:15 -0500
Joshua Kinard <kumba@gentoo.org> wrote:

> @@ -95,7 +95,7 @@ struct mace_video {
>   * Ethernet interface
>   */
>  struct mace_ethernet {
> -	volatile unsigned long mac_ctrl;
> +	volatile u64 mac_ctrl;
>  	volatile unsigned long int_stat;
>  	volatile unsigned long dma_ctrl;
>  	volatile unsigned long timer;


This device driver writer needs to read:
  Documentation/volatile-considered-harmful.txt
