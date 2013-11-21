Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Nov 2013 20:33:50 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:34109 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6825471Ab3KUTdnn1Y9k (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Nov 2013 20:33:43 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id rALJXIiD023986;
        Thu, 21 Nov 2013 20:33:18 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id rALJXDAm023984;
        Thu, 21 Nov 2013 20:33:13 +0100
Date:   Thu, 21 Nov 2013 20:33:13 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Richard Zhu <r65037@freescale.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, linux-s390@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 24/34] PCI: use weak functions for MSI arch-specific
 functions
Message-ID: <20131121193313.GE13331@linux-mips.org>
References: <1384915853-31006-1-git-send-email-r65037@freescale.com>
 <1384915853-31006-24-git-send-email-r65037@freescale.com>
 <20131121173933.GT10382@linux-mips.org>
 <20131121200804.617d6ae6@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131121200804.617d6ae6@skate>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38568
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

On Thu, Nov 21, 2013 at 08:08:04PM +0100, Thomas Petazzoni wrote:

> I think this patch was mistakenly sent by Richard Zhu. It is already
> part of mainline since 3.12:

Explains the deja vue ...

  Ralf
