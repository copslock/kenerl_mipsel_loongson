Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Oct 2013 14:24:23 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52075 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6868780Ab3JKMYRoCnlH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Oct 2013 14:24:17 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r9BCOGtf027720;
        Fri, 11 Oct 2013 14:24:16 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r9BCO8RO027719;
        Fri, 11 Oct 2013 14:24:08 +0200
Date:   Fri, 11 Oct 2013 14:24:08 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Anton Arapov <anton@redhat.com>,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] UPROBES: Remove useless __weak attribute
Message-ID: <20131011122407.GO1615@linux-mips.org>
References: <20131009120809.GN1615@linux-mips.org>
 <20131011005128.GA2199@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131011005128.GA2199@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Fri, Oct 11, 2013 at 06:21:28AM +0530, Srikar Dronamraju wrote:

> Will be nice to have another arch(mips) support for uprobes. 

It's basically ready to be merged - but it's triggering issues elsewhere
in the kernel which I have to resolve first.

The short version is that the memory special mapping created by uprobe
with VM_EXEC but not VM_READ permissions is not working but it's working
if I add VM_READ.  That should not be necessary so something deep down
in the guts of arch/mips is wrong.

  Ralf
