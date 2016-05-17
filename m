Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2016 15:16:59 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:43738 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27029635AbcEQNQz6mkfl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 May 2016 15:16:55 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u4HDGtr7006250;
        Tue, 17 May 2016 15:16:55 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u4HDGtf0006249;
        Tue, 17 May 2016 15:16:55 +0200
Date:   Tue, 17 May 2016 15:16:55 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: MSA: Fix a link error on `_init_msa_upper' with
 older GCC
Message-ID: <20160517131654.GI14481@linux-mips.org>
References: <alpine.DEB.2.00.1605162325170.6794@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1605162325170.6794@tp.orcam.me.uk>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53484
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

On Tue, May 17, 2016 at 06:12:27AM +0100, Maciej W. Rozycki wrote:

> --- a/vmlinux.dump	2016-05-17 01:01:03.655891000 +0100
> +++ b/vmlinux.dump	2016-05-17 02:11:49.264564000 +0100

Applied with this junk segment dropped.

  Ralf
