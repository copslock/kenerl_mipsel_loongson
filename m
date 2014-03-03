Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Mar 2014 23:25:45 +0100 (CET)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:41849 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816887AbaCCWZmsUNvs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Mar 2014 23:25:42 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 1281B5A7E74;
        Tue,  4 Mar 2014 00:25:38 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id v4UNBgOaEMtM; Tue,  4 Mar 2014 00:25:33 +0200 (EET)
Received: from drone (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id 7CBEF5BC016;
        Tue,  4 Mar 2014 00:25:35 +0200 (EET)
Date:   Tue, 4 Mar 2014 00:24:23 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH 3/5] MIPS: Set page size to 16KB for malta SMP defconfigs
Message-ID: <20140303222423.GA573@drone.musicnaut.iki.fi>
References: <1392904828-12969-1-git-send-email-markos.chandras@imgtec.com>
 <1392904828-12969-4-git-send-email-markos.chandras@imgtec.com>
 <20140221173829.GI19285@linux-mips.org>
 <53148C5A.7020101@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53148C5A.7020101@imgtec.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39399
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

On Mon, Mar 03, 2014 at 02:06:18PM +0000, Markos Chandras wrote:
> Are you referring to programs hard coding the page size to 4k instead of
> using the getpagesize()? Well yes this could be a problem. But is that a
> real problem? We are changing the default value so whoever has such an old
> userland can easily switch to the 4k page size. It may also be a good
> opportunity to expose such application and get the fixed properly :) But if
> that's not acceptable, we can drop the patch. Paul what do you think?

Not so long ago there was an issue with Debian where Iceweasel or
Spidermonkey failed on MIPS/Loongson because of its 8K page size (the
userspace assumed 4K). You will get such issues as long as x86 dominates,
it's not a matter of "old userland".

A.
