Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Sep 2006 00:29:44 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:58246 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039154AbWI1X3m (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 29 Sep 2006 00:29:42 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k8SNUCF4008902;
	Fri, 29 Sep 2006 00:30:12 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k8SNTuHx008874;
	Fri, 29 Sep 2006 00:29:56 +0100
Date:	Fri, 29 Sep 2006 00:29:56 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	girish <girishvg@gmail.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: PATCH] cleanup hardcoding __pa/__va macros etc. (take-4)
Message-ID: <20060928232956.GE3394@linux-mips.org>
References: <20060928.003542.21929658.anemo@mba.ocn.ne.jp> <C140DCAC.7A1C%girishvg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C140DCAC.7A1C%girishvg@gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 28, 2006 at 01:58:02AM +0900, girish wrote:
> Date:	Thu, 28 Sep 2006 01:58:02 +0900
> Subject: PATCH] cleanup hardcoding __pa/__va macros etc. (take-4)
> From:	girish <girishvg@gmail.com>
> To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> CC:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
> 	girish <girishvg@gmail.com>
> Content-type: multipart/mixed;
> 	boundary="B_3242253489_7379959"
> 
> 
> > Using just plain text and adding Signed-off-by line would be preferred.
> > Also your patch seems against neither latest lmo nor kernel.org tree...
> 
> The kernel sources I was referring to were 2.6.17-rc6.
> 
> 
> >> In the meantime, I couldn't find the changes suggested for SPARSEMEM support
> >> in the main source tree. Especially the ones reviewed during month of August
> >> ([PATCH] do not count pages in holes with sparsemem ...). Could you please
> >> resend the consolidated patch to the list? Thanks.
> > 
> > August?  I sent the patch with that title in July and applied already.
> > 
> > http://www.linux-mips.org/git?p=linux.git;a=commit;h=239367b4
> 
> Again, I was referring to older sources, that is 2.6.17-rc6. I have just
> upgraded reference sources to 2.6.18 as mentioned above & now I see the
> changes. Thanks. In fact I am experimenting on highmem/sparsemem with
> 2.6.16.16 kernel sources.
> 
> 
> Please find attached patch created from 2.6.18 (kernel.org) tree. Let me
> know if this is alright.
> 
> Signed-off-by: Girish V. Gulawani <girishvg@gmail.com>

-#ifdef CONFIG_ISA
-	if (low < max_dma)
+	if (low < max_dma) }

This doesn't quite compile.

  Ralf
