Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Apr 2013 17:06:05 +0200 (CEST)
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63951 "EHLO
        mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816521Ab3DPPGCRW8A4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Apr 2013 17:06:02 +0200
Received: from pool-72-84-113-162.nrflva.fios.verizon.net ([72.84.113.162] helo=titan)
        by mho-02-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.72)
        (envelope-from <jason@lakedaemon.net>)
        id 1US7S5-000D7r-9e; Tue, 16 Apr 2013 15:05:45 +0000
Received: from titan.lakedaemon.net (localhost [127.0.0.1])
        by titan (Postfix) with ESMTP id 042934185BB;
        Tue, 16 Apr 2013 11:05:38 -0400 (EDT)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Originating-IP: 72.84.113.162
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/zokz6lJWJc0G02lHodharM8/EtD22ldg=
Date:   Tue, 16 Apr 2013 11:05:37 -0400
From:   Jason Cooper <jason@lakedaemon.net>
To:     Andrew Murray <Andrew.Murray@arm.com>
Cc:     linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        siva.kallam@samsung.com, linux-pci@vger.kernel.org,
        linus.walleij@linaro.org, thierry.reding@avionic-design.de,
        Liviu.Dudau@arm.com, grant.likely@secretlab.ca, paulus@samba.org,
        linux-samsung-soc@vger.kernel.org, linux@arm.linux.org.uk,
        jg1.han@samsung.com, jgunthorpe@obsidianresearch.com,
        thomas.abraham@linaro.org, benh@kernel.crashing.org, arnd@arndb.de,
        devicetree-discuss@lists.ozlabs.org, rob.herring@calxeda.com,
        kgene.kim@samsung.com, bhelgaas@google.com,
        linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@free-electrons.com, monstr@monstr.eu,
        linux-kernel@vger.kernel.org, suren.reddy@samsung.com
Subject: Re: [PATCH v7 0/3] of/pci: Provide common support for PCI DT
 parsing
Message-ID: <20130416150537.GC28693@titan.lakedaemon.net>
References: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <jason@lakedaemon.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36243
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

On Tue, Apr 16, 2013 at 11:18:25AM +0100, Andrew Murray wrote:
> This patchset factors out duplicated code associated with parsing PCI
> DT "ranges" properties across the architectures and introduces a
> "ranges" parser. This parser "of_pci_range_parser" can be used directly
> by ARM host bridge drivers enabling them to obtain ranges from device
> trees.
> 
> I've included the Reviewed-by and Tested-by's received from v5/v6 in this
> patchset, earlier versions of this patchset (v3) have been tested-by:
> 
> Thierry Reding <thierry.reding@avionic-design.de>
> Jingoo Han <jg1.han@samsung.com>
> 
> I've tested that this patchset builds and runs on ARM and that it builds on
> PowerPC and x86_64.

Series replaces v6 in mvebu/drivers

thx,

Jason.

> 
> Compared to the v6 sent by Andrew Murray, the following changes have
> been made in response to build errors/warnings:
> 
>  * Inclusion of linux/of_address.h in of_pci.c as suggested by Michal
>    Simek to prevent compilation failures on Microblaze (and others) and his
>    ack.
> 
>  * Use of externs, static inlines and a typo in linux/of_address.h in response
>    to linker errors (multiple defination) on x86_64 as spotted by a kbuild test
>    robot on (jcooper/linux.git mvebu/drivers)
> 
>  * Add EXPORT_SYMBOL_GPL to of_pci_range_parser function to be consistent
>    with of_pci_process_ranges function
