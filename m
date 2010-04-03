Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Apr 2010 03:54:03 +0200 (CEST)
Received: from smtp.gentoo.org ([140.211.166.183]:56695 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492194Ab0DCBx7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 3 Apr 2010 03:53:59 +0200
Received: by smtp.gentoo.org (Postfix, from userid 2181)
        id 2469F1B41BB; Sat,  3 Apr 2010 01:53:52 +0000 (UTC)
Date:   Sat, 3 Apr 2010 01:53:52 +0000
From:   Zhang Le <r0bertz@gentoo.org>
To:     Andreas Barth <aba@not.so.argh.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH v3 1/3] Loongson-2F: Flush the branch target history
        such as BTB and RAS
Message-ID: <20100403015352.GA26168@woodpecker.gentoo.org>
Mail-Followup-To: Andreas Barth <aba@not.so.argh.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <cover.1268453720.git.wuzhangjin@gmail.com> <05e2ba2596f23fa4dda64d63ce2480504b1be4ac.1268453720.git.wuzhangjin@gmail.com> <20100402145401.GS27216@mails.so.argh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100402145401.GS27216@mails.so.argh.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <r0bertz@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

On 16:54 Fri 02 Apr     , Andreas Barth wrote:
> * Wu Zhangjin (wuzhangjin@gmail.com) [100313 05:45]:
> > This patch did clear BTB(branch target buffer), forbid RAS(return
> > address stack) via Loongson-2F's 64bit diagnostic register.
> 
> Unfortunatly the Loongson 2F here still fails with this patch,
> compiled with the new binutils and both options enabled.

Which version of binutils exactly?
The patch is in cvs, but latest binutils-2.20.1 still didn't include it.
You need to patch it.

Zhang, Le
