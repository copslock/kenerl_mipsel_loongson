Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Mar 2014 00:12:57 +0100 (CET)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:56190 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6842534AbaCSXMyDWXMa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Mar 2014 00:12:54 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id 5643821B944;
        Thu, 20 Mar 2014 01:12:52 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id VBWyye6srjzR; Thu, 20 Mar 2014 01:12:47 +0200 (EET)
Received: from drone (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id 5E0725BC005;
        Thu, 20 Mar 2014 01:12:47 +0200 (EET)
Date:   Thu, 20 Mar 2014 01:11:27 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Cc:     David Daney <ddaney@caviumnetworks.com>, ralf@linux-mips.org,
        "Yang,Wei" <Wei.Yang@windriver.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: octeon: Fix warning in of_device_alloc on cn3xxx
Message-ID: <20140319231126.GA19187@drone.musicnaut.iki.fi>
References: <1395118084-24018-1-git-send-email-Wei.Yang@windriver.com>
 <532968AD.4010402@windriver.com>
 <20140319162008.GA4368@alberich>
 <5329E343.60309@caviumnetworks.com>
 <20140319220330.GC4368@alberich>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140319220330.GC4368@alberich>
User-Agent: Mutt/1.5.22 (2013-10-16)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39517
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

On Wed, Mar 19, 2014 at 11:03:30PM +0100, Andreas Herrmann wrote:
> Starting with commit 3da5278727a895d49a601f67fd49dffa0b80f9a5 (of/irq:
> Rework of_irq_count()) the following warning is triggered on octeon
> cn3xxx:

[...]

> Reported-by: Yang Wei <wei.yang@windriver.com>
> Cc: David Daney <david.daney@caviumnetworks.com>
> Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Thanks,

A.
