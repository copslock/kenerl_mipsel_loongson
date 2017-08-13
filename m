Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 22:32:35 +0200 (CEST)
Received: from mail.free-electrons.com ([62.4.15.54]:50626 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993918AbdHMUcYMZYhb convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 13 Aug 2017 22:32:24 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id B3E4C20A1C; Sun, 13 Aug 2017 22:32:17 +0200 (CEST)
Received: from windsurf (unknown [77.147.230.132])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 5BAE02097D;
        Sun, 13 Aug 2017 22:32:11 +0200 (CEST)
Date:   Sun, 13 Aug 2017 22:31:53 +0200
From:   Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: mm: remove duplicate "const" qualifier on
 insn_table
Message-ID: <20170813223153.5b15a8a6@windsurf>
In-Reply-To: <20170803191615.16874-1-thomas.petazzoni@free-electrons.com>
References: <20170803191615.16874-1-thomas.petazzoni@free-electrons.com>
Organization: Free Electrons
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <thomas.petazzoni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59557
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@free-electrons.com
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

Hello,

On Thu,  3 Aug 2017 21:16:15 +0200, Thomas Petazzoni wrote:
> Fixes the following gcc 7.x build error:
> 
> arch/mips/mm/uasm-mips.c:51:26: error: duplicate ‘const’ declaration specifier [-Werror=duplicate-decl-specifier]
>  static const struct insn const insn_table[insn_invalid] = {
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Any feedback on this patch?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
