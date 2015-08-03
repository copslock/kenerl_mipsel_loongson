Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Aug 2015 17:21:18 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:35380 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012111AbbHCPVNQvlHv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 3 Aug 2015 17:21:13 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t73FLAMH008133;
        Mon, 3 Aug 2015 17:21:10 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t73FL7e2008132;
        Mon, 3 Aug 2015 17:21:07 +0200
Date:   Mon, 3 Aug 2015 17:21:07 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Binbin Zhou <zhoubb@lemote.com>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Chunbo Cui <cuicb@lemote.com>, Huacai Chen <chenhc@lemote.com>
Subject: Re: [PATCH v2 3/8] MIPS: Loongson: Add platform devices for
 Loongson-1A/1B
Message-ID: <20150803152107.GE2843@linux-mips.org>
References: <1434537166-5385-1-git-send-email-zhoubb@lemote.com>
 <1434537166-5385-4-git-send-email-zhoubb@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1434537166-5385-4-git-send-email-zhoubb@lemote.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48546
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

On Wed, Jun 17, 2015 at 06:32:41PM +0800, Binbin Zhou wrote:

>  arch/mips/loongson32/common/platform.c            | 290 +++++++++++++++++++++-

Another lengthy platform.c file.  Have you considered putting that
information into a DT instead?

  Ralf
