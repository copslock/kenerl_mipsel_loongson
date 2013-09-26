Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Sep 2013 14:45:44 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:53522 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6819473Ab3IZMpmgsdLh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Sep 2013 14:45:42 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r8QCjdMU022627;
        Thu, 26 Sep 2013 14:45:39 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r8QCjaqf022626;
        Thu, 26 Sep 2013 14:45:36 +0200
Date:   Thu, 26 Sep 2013 14:45:36 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V12 00/13] MIPS: Add Loongson-3 based machines support
Message-ID: <20130926124536.GC31496@linux-mips.org>
References: <1380100546-8302-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1380100546-8302-1-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37990
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

On Wed, Sep 25, 2013 at 05:15:34PM +0800, Huacai Chen wrote:

Generally this patchset is still adding an eyewatering number of
#ifdef CONFIG_CPU_LOONGSON2/3s to the code.  What we had in the existing
code base was already ugly.  So I just went through arch/mips removing
many of the existing ifdefs.

Will push that out to upstream-sfr a little later this afternoon.

This means, your patchset is not going to apply cleanly anymore!

Also I'm wondering about these two uses of CONFIG_CPU_LOONGSON2:

arch/mips/mm/tlbex.c:#if defined(CONFIG_32BIT) || defined(CONFIG_CPU_LOONGSON2)
arch/mips/mm/tlbex.c:#if defined(CONFIG_32BIT) || defined(CONFIG_CPU_LOONGSON2)

Why would we want to treat a Loongson2 - a 64 bit CPU after all - as a 32 bit
CPU?  Can you explain?

Thanks!

  Ralf
