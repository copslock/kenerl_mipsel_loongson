Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Mar 2015 19:37:35 +0100 (CET)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:60398 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013706AbbCMShdhYgpR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Mar 2015 19:37:33 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 5D1465A702E;
        Fri, 13 Mar 2015 20:37:23 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id NJ-sEbgoBTqu; Fri, 13 Mar 2015 20:37:18 +0200 (EET)
Received: from fuloong-minipc (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id D19BC5BC006;
        Fri, 13 Mar 2015 20:37:28 +0200 (EET)
Date:   Fri, 13 Mar 2015 20:37:28 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Paul Martin <paul.martin@codethink.co.uk>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/6] MIPS: OCTEON: Tell the kernel build system we can do
 Little Endian
Message-ID: <20150313183728.GH587@fuloong-minipc.musicnaut.iki.fi>
References: <1426268098-1603-1-git-send-email-paul.martin@codethink.co.uk>
 <1426268098-1603-2-git-send-email-paul.martin@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1426268098-1603-2-git-send-email-paul.martin@codethink.co.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46376
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

On Fri, Mar 13, 2015 at 05:34:53PM +0000, Paul Martin wrote:
> Update the Kconfig file so that the configure system will
> allow us to build the kernel little endian.

This should be the last patch in the series.

A.
