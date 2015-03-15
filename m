Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Mar 2015 19:30:55 +0100 (CET)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:58918 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008174AbbCOSaxOsonI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 15 Mar 2015 19:30:53 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id 7887319C17A;
        Sun, 15 Mar 2015 20:30:53 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id bkOxjJfAfyg8; Sun, 15 Mar 2015 20:30:48 +0200 (EET)
Received: from fuloong-minipc (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id 7DD345BC01B;
        Sun, 15 Mar 2015 20:30:48 +0200 (EET)
Date:   Sun, 15 Mar 2015 20:30:48 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Aleksey Makarov <aleksey.makarov@auriga.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v2 3/3] MIPS: OCTEON: Use device tree to probe for flash
 chips.
Message-ID: <20150315183048.GA586@fuloong-minipc.musicnaut.iki.fi>
References: <1425565893-30614-1-git-send-email-aleksey.makarov@auriga.com>
 <1425565893-30614-4-git-send-email-aleksey.makarov@auriga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1425565893-30614-4-git-send-email-aleksey.makarov@auriga.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Thu, Mar 05, 2015 at 05:31:31PM +0300, Aleksey Makarov wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Don't assume they are there, the device tree will tell us.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.
