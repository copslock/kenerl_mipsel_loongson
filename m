Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 May 2017 18:19:09 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:40982 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993949AbdE2QTBUNf3p (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 29 May 2017 18:19:01 +0200
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 301DFC056789;
        Mon, 29 May 2017 16:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 301DFC056789
Authentication-Results: ext-mx08.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx08.extmail.prod.ext.phx2.redhat.com; spf=pass smtp.mailfrom=oleg@redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.redhat.com 301DFC056789
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1824718844;
        Mon, 29 May 2017 16:18:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 29 May 2017 18:18:53 +0200 (CEST)
Date:   Mon, 29 May 2017 18:18:50 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Stafford Horne <shorne@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org, Jamie Iles <jamie.iles@oracle.com>
Subject: Re: [PATCH] kthread: fix boot hang (regression) on MIPS/OpenRISC
Message-ID: <20170529161850.GA15236@redhat.com>
References: <20170529072207.16130-1-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170529072207.16130-1-vegard.nossum@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 29 May 2017 16:18:54 +0000 (UTC)
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58069
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: oleg@redhat.com
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

On 05/29, Vegard Nossum wrote:
>
> This fixes a regression in commit 4d6501dce079 where I didn't notice
> that MIPS and OpenRISC were reinitialising p->{set,clear}_child_tid to
> NULL after our initialisation in copy_process().

Oh, I didn't even know that arch/ can play with xxx_child_tid,

> We can simply get rid of the arch-specific initialisation here

Agreed. Thanks!

Acked-by: Oleg Nesterov <oleg@redhat.com>
