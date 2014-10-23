Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2014 18:41:09 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47988 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012270AbaJWQlH2lEyY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Oct 2014 18:41:07 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s9NGf6Be005023;
        Thu, 23 Oct 2014 18:41:06 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s9NGf6AM005022;
        Thu, 23 Oct 2014 18:41:06 +0200
Date:   Thu, 23 Oct 2014 18:41:06 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Alexander Sverdlin <alexander.sverdlin@nsn.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] Make Octeon GPIO IRQ chip CPU hotplug-aware
Message-ID: <20141023164106.GA6247@linux-mips.org>
References: <544908B8.7050109@nsn.com>
 <544925CC.7040801@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <544925CC.7040801@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43540
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

On Thu, Oct 23, 2014 at 08:59:08AM -0700, David Daney wrote:
> Date:   Thu, 23 Oct 2014 08:59:08 -0700
> From: David Daney <ddaney.cavm@gmail.com>
> To: Alexander Sverdlin <alexander.sverdlin@nsn.com>
> CC: ralf@linux-mips.org, linux-mips@linux-mips.org
> Subject: Re: [PATCH] Make Octeon GPIO IRQ chip CPU hotplug-aware
> Content-Type: text/plain; charset=UTF-8; format=flowed
> 
> On 10/23/2014 06:55 AM, Alexander Sverdlin wrote:
> >From: Alexander Sverdlin <alexander.sverdlin@nsn.com>
> >
> >Make Octeon GPIO IRQ chip CPU hotplug-aware
> >
> >Seems that irq_cpu_offline callbacks were forgotten in v1 and v2 CIU
> >GPIO chips. There is such a callback for octeon_irq_chip_ciu2_gpio,
> >covering CIU2 chips. Without this callback GPIO IRQs are not being migrated
> >during core offlining. Patch is tested on Octeon II.
> >
> >Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nsn.com>
> 
> Acked-by: David Daney <david.daney@cavium.com>
> 
> Ralf, please apply.

Already did that, so the commits won't have your ack.

Thanks for reviewing!

  Ralf
