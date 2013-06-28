Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jun 2013 09:08:32 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55180 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6818702Ab3F1HIcNijmD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 28 Jun 2013 09:08:32 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5S78TCB031947;
        Fri, 28 Jun 2013 09:08:29 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5S78TP5031946;
        Fri, 28 Jun 2013 09:08:29 +0200
Date:   Fri, 28 Jun 2013 09:08:29 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V10 12/13] MIPS: Loongson 3: Add CPU hotplug support
Message-ID: <20130628070829.GJ10727@linux-mips.org>
References: <1366030028-5084-1-git-send-email-chenhc@lemote.com>
 <1366030028-5084-13-git-send-email-chenhc@lemote.com>
 <20130628070553.GI10727@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130628070553.GI10727@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37190
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

On Fri, Jun 28, 2013 at 09:05:53AM +0200, Ralf Baechle wrote:

> > +		"flush_loop:                             \n" /* flush L1 */
> 
> Please don't use normale in inline assembler.  This might result in build
> errors.  it's horrible to read but number local labels like:

That was meant to read "Please don't use normal labels" in inline assembler.

  Ralf
