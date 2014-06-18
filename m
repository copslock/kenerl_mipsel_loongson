Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jun 2014 21:05:01 +0200 (CEST)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:41543 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6859955AbaFRTE7ef39N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jun 2014 21:04:59 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id 9561A56FA46;
        Wed, 18 Jun 2014 22:04:55 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id 8V+dPLG9Wtjp; Wed, 18 Jun 2014 22:04:48 +0300 (EEST)
Received: from drone (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id 398E05BC020;
        Wed, 18 Jun 2014 22:04:48 +0300 (EEST)
Date:   Wed, 18 Jun 2014 22:04:48 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/3] MIPS: OCTEON: support disabling HOTPLUG_CPU run-time
Message-ID: <20140618190447.GA558@drone.musicnaut.iki.fi>
References: <1402949190-28182-1-git-send-email-aaro.koskinen@iki.fi>
 <1402949190-28182-2-git-send-email-aaro.koskinen@iki.fi>
 <53A0C40F.4020604@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53A0C40F.4020604@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40637
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

On Tue, Jun 17, 2014 at 03:41:19PM -0700, David Daney wrote:
> There should be a separate variable to indicate if hot-plugging CPUs is
> possible which would be used here instead.
> 
> See my comments in patch 3/3 also.

OK, thanks for comments. I will revisit this after the Finnish
midsummer celebrations, i.e. it will take a couple of weeks.

A.
