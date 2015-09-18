Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Sep 2015 21:19:30 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:44584 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013662AbbIRTT0kJ4ja (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Sep 2015 21:19:26 +0200
Received: from akpm3.mtv.corp.google.com (unknown [216.239.45.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EB3ACBD7;
        Fri, 18 Sep 2015 19:19:19 +0000 (UTC)
Date:   Fri, 18 Sep 2015 12:19:19 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     Stephen Boyd <sboyd@codeaurora.org>,
        Andy Gross <agross@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org,
        linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>,
        Paul Walmsley <paul@pwsan.com>,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: Re: [PATCH 0/3] Add __ioread32_copy() and use it
Message-Id: <20150918121919.fa20552946703ae772d636e9@linux-foundation.org>
In-Reply-To: <20150916025546.GE1747@two.firstfloor.org>
References: <1442346089-32077-1-git-send-email-sboyd@codeaurora.org>
        <20150915155815.5a41a8dc537610ab44d8d3dc@linux-foundation.org>
        <20150916023219.GD1747@two.firstfloor.org>
        <20150915195031.0a1756a2.akpm@linux-foundation.org>
        <20150916025546.GE1747@two.firstfloor.org>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49239
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
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

On Wed, 16 Sep 2015 04:55:46 +0200 Andi Kleen <andi@firstfloor.org> wrote:

> > Under what circumstances will the compiler (or linker?) do this? 
> 
> Compiler.
> 
> > LTO enabled?
> 
> Yes it's for LTO.  The optimization allows the compiler to drop unused
> functions, which is very popular with users (a lot use it to get smaller
> kernel images)
> 

Does this look truthful and complete?


--- a/include/linux/compiler-gcc.h~a
+++ a/include/linux/compiler-gcc.h
@@ -205,7 +205,10 @@
 
 #if GCC_VERSION >= 40600
 /*
- * Tell the optimizer that something else uses this function or variable.
+ * When used with Link Time Optimization, gcc can optimize away C functions or
+ * variables which are referenced only from assembly code.  __visible tells the
+ * optimizer that something else uses this function or variable, thus preventing
+ * this.
  */
 #define __visible	__attribute__((externally_visible))
 #endif
_
