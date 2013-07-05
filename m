Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jul 2013 19:19:58 +0200 (CEST)
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:60453 "EHLO
        mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6827525Ab3GERT5V130c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Jul 2013 19:19:57 +0200
Received: from pool-72-84-113-162.nrflva.fios.verizon.net ([72.84.113.162] helo=titan)
        by mho-01-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.72)
        (envelope-from <jason@lakedaemon.net>)
        id 1Uv9fg-000Ixh-CS; Fri, 05 Jul 2013 17:19:48 +0000
Received: from titan.lakedaemon.net (localhost [127.0.0.1])
        by titan (Postfix) with ESMTP id A0C4E45EC48;
        Fri,  5 Jul 2013 13:19:44 -0400 (EDT)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Originating-IP: 72.84.113.162
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX18wXOkNyRVX73rTPGh4UJu5rEtNzt15vmc=
Date:   Fri, 5 Jul 2013 13:19:44 -0400
From:   Jason Cooper <jason@lakedaemon.net>
To:     Andrew Murray <amurray@embedded-bits.co.uk>
Cc:     ralf@linux-mips.org, Andrew.Murray@arm.com, monstr@monstr.eu,
        microblaze-uclinux@itee.uq.edu.au, linux-mips@linux-mips.org,
        blogic@openwrt.org, ddaney@caviumnetworks.com
Subject: Re: of_pci_range_parser patch series
Message-ID: <20130705171944.GI2569@titan.lakedaemon.net>
References: <BF39C5705592B0469C55326EC158C01A80307EBE26@GEORGE.Emea.Arm.com>
 <20130705132944.GA6417@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130705132944.GA6417@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <jason@lakedaemon.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37269
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jason@lakedaemon.net
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

On Fri, Jul 05, 2013 at 02:29:44PM +0100, Andrew Murray wrote:
> > Andrew,
> > 
> > I noticed that [1] is now in -next but not the MIPS patch [2], not the
> > MicroBlaze patch [3].  What is the reason for that?  If it's only the
> > lack of an ack, here's mine for the MIPS version:
> 
> There was no reason other that the missing acks.

This series got held up one release cycle for build failure on powerpc,
so we trimmed it down to the essentials that we needed and could confirm
didn't break anything.  Hence dropping mips and microblaze portions.

> > Acked-by: Ralf Baechle <ralf@linux-mips.org>
> 
> Thanks for this.
> 
> Jason - is it possible/best to take this through your tree?

All the other bits will be in v3.11-rc1.  It'd probably be best to go
ahead and take it through the linux-mips tree once -rc1 drops.  We can
take it if you'd like but there really isn't any need to do so.  Same
goes for the microblaze portion.  Just rebase the patch onto -rc1 and
send to the appropriate maintainers.

hth,

Jason.
