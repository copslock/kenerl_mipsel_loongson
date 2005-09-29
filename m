Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Sep 2005 11:47:56 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:41990 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465572AbVI3Kmg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Sep 2005 11:42:36 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j8UAgLuo005536;
	Fri, 30 Sep 2005 11:42:27 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j8TNjhOi004468;
	Fri, 30 Sep 2005 00:45:43 +0100
Date:	Fri, 30 Sep 2005 00:45:42 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] minor fix in asm-mips/module.h
Message-ID: <20050929234542.GB3983@linux-mips.org>
References: <cda58cb8050926000665f843dc@mail.gmail.com> <20050926115539.GB3175@linux-mips.org> <cda58cb805092605057f7cad7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb805092605057f7cad7d@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9091
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 26, 2005 at 02:05:36PM +0200, Franck wrote:

> 2005/9/26, Ralf Baechle <ralf@linux-mips.org>:
> > On Mon, Sep 26, 2005 at 09:06:50AM +0200, Franck wrote:
> >
> > > This patch replaces an empty preprocessor condition #elif by #else.

Thanks for noticing.

> > > It adds 4ksc and 4ksd as well.

--- module.h~old        2005-09-26 14:02:32.000000000 +0200
+++ module.h    2005-09-26 09:54:08.000000000 +0200
@@ -113,7 +113,11 @@ search_module_dbetables(unsigned long ad
 #define MODULE_PROC_FAMILY "RM9000"
 #elif defined CONFIG_CPU_SB1
 #define MODULE_PROC_FAMILY "SB1"
-#elif
+#elif defined CONFIG_CPU_4KSC
+#define MODULE_PROC_FAMILY "4KSC"
+#elif defined CONFIG_CPU_4KSD
+#define MODULE_PROC_FAMILY "4KSD"

There are no CONFIG_CPU_4KSC and CONFIG_CPU_4KSD configuration options.
Did you really create this patch against the linux module of the CVS
repository or was it a different tree?

Thanks,

  Ralf
