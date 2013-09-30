Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Sep 2013 23:27:20 +0200 (CEST)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:54516 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823043Ab3I3V1Svb8oV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Sep 2013 23:27:18 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id 5D07B19BF73;
        Tue,  1 Oct 2013 00:27:16 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id xhNfQJ22cHl4; Tue,  1 Oct 2013 00:27:11 +0300 (EEST)
Received: from musicnaut.iki.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp4.welho.com (Postfix) with SMTP id 675FA5BC012;
        Tue,  1 Oct 2013 00:27:10 +0300 (EEST)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Tue, 01 Oct 2013 00:27:08 +0300
Date:   Tue, 1 Oct 2013 00:27:08 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     devel@driverdev.osuosl.org, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>, richard@nod.at,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] staging: octeon-ethernet: don't assume that CPU 0 is
 special
Message-ID: <20130930212707.GA14359@blackmetal.musicnaut.iki.fi>
References: <1380397834-14286-1-git-send-email-aaro.koskinen@iki.fi>
 <5249B37E.4050000@caviumnetworks.com>
 <20130930193502.GE4572@blackmetal.musicnaut.iki.fi>
 <5249D407.2090904@caviumnetworks.com>
 <20130930195642.GF4572@blackmetal.musicnaut.iki.fi>
 <5249E84F.2070008@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5249E84F.2070008@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38078
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

On Mon, Sep 30, 2013 at 02:08:31PM -0700, David Daney wrote:
> On 09/30/2013 12:56 PM, Aaro Koskinen wrote:
> >What guarantees that CPU0 is around (or the smp_affinity is at its
> >default value) by the time user executes modprobe?
> 
> Nothing enforced by the kernel.  Just don't take CPU0 off-line and
> you should be good to go.
> 
> There is a lot of room for improvement in the driver.
> 
> Really this whole thing of starting NAPI on multiple CPUs for the
> same input queue is not good.  It leads to loss of packet ordering
> when forwarding.

I agree. I have also another patch which deletes this functionality
altogether - should I post that one instead? In modern kernel you can use
RPS to steer packets to different cores/softirqs threads, so in a way the
driver currently duplicates some of the generic kernel functionality...

A.
