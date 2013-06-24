Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jun 2013 01:06:48 +0200 (CEST)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:39349 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6831610Ab3FXXGrJShDh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Jun 2013 01:06:47 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id 2DB5356F4CC;
        Tue, 25 Jun 2013 02:06:46 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id LTxbeovq+BOK; Tue, 25 Jun 2013 02:06:41 +0300 (EEST)
Received: from musicnaut.iki.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp5.welho.com (Postfix) with SMTP id 3FE775BC004;
        Tue, 25 Jun 2013 02:06:40 +0300 (EEST)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Tue, 25 Jun 2013 02:06:39 +0300
Date:   Tue, 25 Jun 2013 02:06:39 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2 1/2] MIPS: cavium-octeon: cvmx-helper-board: print
 unknown board warning only once
Message-ID: <20130624230639.GC20703@blackmetal.musicnaut.iki.fi>
References: <1372023524-17333-1-git-send-email-aaro.koskinen@iki.fi>
 <51C89567.3000108@gmail.com>
 <20130624220429.GB20703@blackmetal.musicnaut.iki.fi>
 <51C8C940.7080106@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51C8C940.7080106@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37122
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

On Mon, Jun 24, 2013 at 03:33:36PM -0700, David Daney wrote:
> On 06/24/2013 03:04 PM, Aaro Koskinen wrote:
> >On Mon, Jun 24, 2013 at 11:52:23AM -0700, David Daney wrote:
> >>On 06/23/2013 02:38 PM, Aaro Koskinen wrote:
> >>>When booting a new board for the first time, the console is flooded with
> >>>"Unknown board" messages. This is not really helpful. Board type is not
> >>>going to change after the boot, so it's sufficient to print the warning
> >>>only once.
> >>>
> >>>Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> >>
> >>I don't think we need this patch.  In 2/2 you add the board type for
> >>the board you have, so you shouldn't be getting any messages, and
> >>this is unneeded.
> >>
> >>I don't mind spamming people with all the messages,  if people see
> >>these messages, they have bigger problems than too many messages.
> >
> >I guess this patch can be dropped, but whoever tries to improve the
> >support for the next new Octeon board will get annoyed by these same
> >messages...
> 
> I would hope that the "next new Octeon board" would have a
> bootloader that supplies a device tree.  That way most of this would
> never be used, and there would be no messages.

Yes, actually I was wondering if MIPS kernel could offer something
similar to ARM's APPENDED_DTB, i.e. provide some mechanism to pass the
dtb if the bootloader support is missing.

A.
