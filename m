Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 May 2013 22:42:43 +0200 (CEST)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:45098 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827511Ab3EOUk409bSJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 May 2013 22:40:56 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id 8885F19BEA0;
        Wed, 15 May 2013 23:39:41 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id 4ttNlBc+Zy1e; Wed, 15 May 2013 23:39:37 +0300 (EEST)
Received: from musicnaut.iki.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp4.welho.com (Postfix) with SMTP id 867F25BC011;
        Wed, 15 May 2013 23:39:36 +0300 (EEST)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Wed, 15 May 2013 23:39:36 +0300
Date:   Wed, 15 May 2013 23:39:36 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 3.10-rc1 MIPS regression: Lemote mini-PC boot hangs
Message-ID: <20130515203936.GB14202@blackmetal.musicnaut.iki.fi>
References: <20130515194805.GA14202@blackmetal.musicnaut.iki.fi>
 <5193ED56.3040602@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5193ED56.3040602@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36413
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

On Wed, May 15, 2013 at 01:17:26PM -0700, David Daney wrote:
> http://www.linux-mips.org/archives/linux-mips/2013-05/msg00096.html
> 
> Specifically, the dynamic ASID sizing is broken.  You should be able
> to boot if you revert that bit.

I pulled your patches, and now the Lemote box boots fine. I look forward
seeing these in -rc2.

Thanks,

A.
