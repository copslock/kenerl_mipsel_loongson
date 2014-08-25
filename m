Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Aug 2014 14:51:09 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52249 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006715AbaHYMvHzVkdM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Aug 2014 14:51:07 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s7PCp7q8029305;
        Mon, 25 Aug 2014 14:51:07 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s7PCp7Dr029304;
        Mon, 25 Aug 2014 14:51:07 +0200
Date:   Mon, 25 Aug 2014 14:51:07 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@gmail.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [RFC PATCH V2] MIPS: fix build with binutils 2.24.51+
Message-ID: <20140825125107.GA25892@linux-mips.org>
References: <1408465632-34262-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1408465632-34262-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42220
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

On Tue, Aug 19, 2014 at 06:27:12PM +0200, Manuel Lauss wrote:

> With binutils snapshots since 29.07.2014 I get the following build failure:
> {standard input}: Warning: .gnu_attribute 4,3 requires `softfloat'
>   LD      arch/mips/alchemy/common/built-in.o
> mipsel-softfloat-linux-gnu-ld: Warning: arch/mips/alchemy/common/built-in.o
>  uses -msoft-float (set by arch/mips/alchemy/common/prom.o),
>  arch/mips/alchemy/common/sleeper.o uses -mhard-float
> 
> Extend cflags with a soft-float directive for the assembler, and add
> hardfloat directives to assembler files dealing with FPU
> registers to compensate.

I had a discussion about this with Maciej.  He suggested that this
behavious of binutils should be taken a look at but also that we rather
should remove the -msoft-float option from the kernel and I support his
view.

I did add -msoft-float in 6218cf4410cfce7bc7e89834e73525b124625d4c
[[MIPS] Always pass -msoft-float.] in 2006 because back then there was a
wave of bug reports from people attempting to use hard fp in the kernel
which of course did result in FPR corruption.  Adding -msoft-float made
sure that floating point operations would result in a link error because
the kernel does not supply a soft-fp library.

But maybe there are other methods to achieve the same - such as

#define float diediedie
#define double goboom

  Ralf
