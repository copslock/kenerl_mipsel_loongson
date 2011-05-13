Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 17:50:33 +0200 (CEST)
Received: from chipmunk.wormnet.eu ([195.195.131.226]:51082 "EHLO
        chipmunk.wormnet.eu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491849Ab1EMPua (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 May 2011 17:50:30 +0200
Received: by chipmunk.wormnet.eu (Postfix, from userid 1000)
        id 6351080C2A; Fri, 13 May 2011 16:50:30 +0100 (BST)
Date:   Fri, 13 May 2011 16:50:30 +0100
From:   Alexander Clouter <alex@digriz.org.uk>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     linux-mips@linux-mips.org, florian@openwrt.org
Subject: Re: [PATCH] MIPS: AR7: Fix GCC 4.6.0 build error.
Message-ID: <20110513155030.GO25017@chipmunk>
References: <20110513152855.GM25017@chipmunk>
 <4DCD4EC9.1070804@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DCD4EC9.1070804@mvista.com>
Organization: diGriz
X-URL:  http://www.digriz.org.uk/
X-JabberID: alex@digriz.org.uk
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <alex@digriz.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips

* Sergei Shtylyov <sshtylyov@mvista.com> [2011-05-13 19:31:21+0400]:
>
> >+	struct ar7_gpio_chip *gpch = (!ar7_is_titan())
> 
>    Parens around (!x) are not really necessary. Perhaps Ralf could
> remove them while applying...
> 
I'm happy to resubmit if that is preferred.

Cheers

-- 
Alexander Clouter
.sigmonster says: BOFH excuse #267:
                  The UPS is on strike.
