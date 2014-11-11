Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2014 11:18:14 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57097 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013354AbaKKKSM7d4cc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Nov 2014 11:18:12 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sABAICam028499;
        Tue, 11 Nov 2014 11:18:12 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sABAIBst028498;
        Tue, 11 Nov 2014 11:18:11 +0100
Date:   Tue, 11 Nov 2014 11:18:11 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongbing Hu <huhb@lemote.com>
Subject: Re: [PATCH V2 07/12] MIPS: Loongson: Add Loongson-3A/3B GPIO support
Message-ID: <20141111101811.GH27259@linux-mips.org>
References: <1415081610-25639-1-git-send-email-chenhc@lemote.com>
 <1415081610-25639-8-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1415081610-25639-8-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43986
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

On Tue, Nov 04, 2014 at 02:13:28PM +0800, Huacai Chen wrote:

This looks like a full blown GPIO driver and thus should be moved to
drivers/gpio.

  Ralf
