Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jun 2010 07:20:54 +0200 (CEST)
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:48060 "EHLO
        master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491164Ab0FDFUu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Jun 2010 07:20:50 +0200
Received: from localhost (unknown [127.0.0.1])
        by master.linux-sh.org (Postfix) with ESMTP id D1787636B0;
        Fri,  4 Jun 2010 05:20:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at linux-sh.org
Received: from master.linux-sh.org ([127.0.0.1])
        by localhost (master.linux-sh.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BtTlq9lPLxmX; Fri,  4 Jun 2010 14:20:18 +0900 (JST)
Received: by master.linux-sh.org (Postfix, from userid 500)
        id 33187636B3; Fri,  4 Jun 2010 14:20:18 +0900 (JST)
Date:   Fri, 4 Jun 2010 14:20:18 +0900
From:   Paul Mundt <lethal@linux-sh.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     mingo@elte.hu, akpm@linux-foundation.org,
        simon.kagstrom@netinsight.net, David.Woodhouse@intel.com,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v3] printk: fix delayed messages from CPU hotplug events
Message-ID: <20100604052018.GA2565@linux-sh.org>
References: <ee1bf4f9c158983acad0a4548229586128afad67@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee1bf4f9c158983acad0a4548229586128afad67@localhost>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-archive-position: 27070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lethal@linux-sh.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 3022

On Thu, Jun 03, 2010 at 10:11:25PM -0700, Kevin Cernekee wrote:
> [Changes from v2:
> 
> Use hotcpu_notifier - fix will only apply to hotplug events, not
> initial SMP boot
> 
With the hotcpu notifier it looks good to me.

Reviewed-by: Paul Mundt <lethal@linux-sh.org>
