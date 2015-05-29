Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 May 2015 10:48:52 +0200 (CEST)
Received: from mail.o-t.ch ([217.197.209.32]:46014 "EHLO mail.o-t.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007528AbbE2IsvMx8ki (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 29 May 2015 10:48:51 +0200
Received: from [192.168.1.33] (unknown [130.125.10.26])
        (Authenticated sender: lf@o-t.ch)
        by mail.o-t.ch (Postfix) with ESMTPSA id 249B41801A4;
        Fri, 29 May 2015 10:48:41 +0200 (CEST)
Message-ID: <556827FE.9080906@libres.ch>
Date:   Fri, 29 May 2015 10:49:02 +0200
From:   Laurent Fasnacht <l@libres.ch>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>, Laurent Fasnacht <l@libres.ch>
CC:     linux-mips@linux-mips.org, trivial@kernel.org
Subject: Re: [PATCH] MIPS: ath79: fix build problem if CONFIG_BLK_DEV_INITRD
 is not set
References: <556603C8.5010502@libres.ch> <20150528153808.GA7012@linux-mips.org>
In-Reply-To: <20150528153808.GA7012@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <l@libres.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47722
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: l@libres.ch
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

On 28. 05. 15 17:38, Ralf Baechle wrote:
> On Wed, May 27, 2015 at 07:50:00PM +0200, Laurent Fasnacht wrote:
>> [...]
> This patch is corrupt.  Please check how you send out your patches.
> The lines which I marked with XXX should be blank lines containing just
> one space character.  Instead the lines were removed and the space
> inserted into the following line.  Because this patch is trivial I
> fix that manually but please sort our your patch submission process
> for the future.

Thank you very much. My apologies for the inconvenience, next time I'll
do better.

> Also note that adding two lines in most jurisdictions doesn't constitute
> something copyrightable, adding a copyright notice or not.

I fully agree.

Laurent
