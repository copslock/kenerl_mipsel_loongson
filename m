Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Nov 2012 20:30:57 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:54509 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6825882Ab2KOTa4jiPGD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 15 Nov 2012 20:30:56 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id qAFJUrqe001786;
        Thu, 15 Nov 2012 20:30:53 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id qAFJUogA001752;
        Thu, 15 Nov 2012 20:30:50 +0100
Date:   Thu, 15 Nov 2012 20:30:50 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, arnd@arndb.de, linux-mips@linux-mips.org
Subject: Re: [RFC PATCH v1 26/31] ARC: Build system: Makefiles, Kconfig,
 Linker script
Message-ID: <20121115193050.GA1244@linux-mips.org>
References: <1352281674-2186-1-git-send-email-vgupta@synopsys.com>
 <1352281674-2186-27-git-send-email-vgupta@synopsys.com>
 <50A52B45.6030907@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50A52B45.6030907@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35018
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, Nov 15, 2012 at 05:49:57PM +0000, James Hogan wrote:

> On 07/11/12 09:47, Vineet Gupta wrote:
> > +config ARC
> 
> I just came across arch/mips/Kconfig which also defines ARC (and ARC32).
> It's only used within arch/mips/, however it's probably more likely that
> your ARC/CONFIG_ARC will find it's way into the generic bits of the
> kernel which could get hit when the other ARC is defined.
> 
> Perhaps it's worth getting the other ARC renamed just in case?

The MIPS world surely isn't as attached to the CONFIG_ARC config symbol
as Synopsis so I'm going to rename CONFIG_ARC and a few other firmware
related config symbols to use a consistent prefix of CONFIG_FW_.

  Ralf
