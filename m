Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Dec 2017 17:36:31 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:52532 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990491AbdLTQgXFo006 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Dec 2017 17:36:23 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id vBKGaKbZ020199;
        Wed, 20 Dec 2017 17:36:20 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id vBKGaGfZ020197;
        Wed, 20 Dec 2017 17:36:16 +0100
Date:   Wed, 20 Dec 2017 17:36:16 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Huacai Chan <chenhc@lemote.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] MIPS: Lonngson64: Copy kernel command line from
 arcs_cmdline
Message-ID: <20171220163616.GH28538@linux-mips.org>
References: <20171216145751.3486-1-jiaxun.yang@flygoat.com>
 <20171216145751.3486-2-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171216145751.3486-2-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61528
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

On Sat, Dec 16, 2017 at 10:57:47PM +0800, Jiaxun Yang wrote:

> Since lemote-2f/marchtype.c need to get cmdline from loongson.h
> this patch simply copy kernel command line from arcs_cmdline
> to fix that issue

Sorry, I don't quite understand.

Is the issue that arcs_cmdline[] is declared as __initdata in
arch/mips/kernel/setup.c?

Note that it's ok to use arcs_cmdline on a non-ARCS machine.  ARC systems
were the first systems supported by Linux/MIPS, that's how the variable
got its name; the name was just never properly cleaned up but probably
should.

  Ralf
