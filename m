Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jan 2013 11:26:56 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:40368 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823555Ab3AaK0zlZaiQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 Jan 2013 11:26:55 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r0VAQswW019165;
        Thu, 31 Jan 2013 11:26:54 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r0VAQrtL019164;
        Thu, 31 Jan 2013 11:26:53 +0100
Date:   Thu, 31 Jan 2013 11:26:53 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: MIPS atomic_set_mask and atomic_clear_mask
Message-ID: <20130131102653.GA17834@linux-mips.org>
References: <20130131034320.GA15216@gentoo.L3L6.loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130131034320.GA15216@gentoo.L3L6.loongson.cn>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35642
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

On Thu, Jan 31, 2013 at 11:43:21AM +0800, yili0568@gmail.com wrote:

> Hello, everybody:
>      Does MIPS need the functions atomic_set_mask and atomic_clear_mask?
>      Or how can I implement these functions.

No, it doesn't need them.  a quick grep would have shown that all users
are either other architectures or architecture-specific code.

As for a possible implementation, there are plenty of examples in
<asm/bitops.h> and <asm/atomic.h> that would need only minor modification.

  Ralf
