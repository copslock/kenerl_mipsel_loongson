Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Apr 2013 15:09:38 +0200 (CEST)
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:30257 "EHLO
        mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822444Ab3DRNJh1XKVb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Apr 2013 15:09:37 +0200
Received: from pool-72-84-113-162.nrflva.fios.verizon.net ([72.84.113.162] helo=titan)
        by mho-02-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.72)
        (envelope-from <jason@lakedaemon.net>)
        id 1USoac-000Oqu-Nm; Thu, 18 Apr 2013 13:09:26 +0000
Received: from titan.lakedaemon.net (localhost [127.0.0.1])
        by titan (Postfix) with ESMTP id 45757419B53;
        Thu, 18 Apr 2013 09:09:19 -0400 (EDT)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Originating-IP: 72.84.113.162
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX18tkj7t3/jbiok1kHs2krz8shGQEMiTaQ8=
Date:   Thu, 18 Apr 2013 09:09:19 -0400
From:   Jason Cooper <jason@lakedaemon.net>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
        "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        "siva.kallam@samsung.com" <siva.kallam@samsung.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree-discuss@lists.ozlabs.org" 
        <devicetree-discuss@lists.ozlabs.org>,
        Jingoo Han <jg1.han@samsung.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Kukjin Kim <kgene.kim@samsung.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "suren.reddy@samsung.com" <suren.reddy@samsung.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Michal Simek <monstr@monstr.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Thierry Reding <thierry.reding@avionic-design.de>,
        Thomas Abraham <thomas.abraham@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v7 3/3] of/pci: mips: convert to common
 of_pci_range_parser
Message-ID: <20130418130919.GI27197@titan.lakedaemon.net>
References: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com>
 <1366107508-12672-4-git-send-email-Andrew.Murray@arm.com>
 <CACRpkdbBaT1OKr5t8HW4+8y_wSDmGxmewAyVMekx8S-K9s3K8Q@mail.gmail.com>
 <20130418125910.GA17128@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130418125910.GA17128@arm.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <jason@lakedaemon.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36261
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

On Thu, Apr 18, 2013 at 01:59:10PM +0100, Andrew Murray wrote:
> On Wed, Apr 17, 2013 at 04:42:48PM +0100, Linus Walleij wrote:
> > On Tue, Apr 16, 2013 at 12:18 PM, Andrew Murray <Andrew.Murray@arm.com> wrote:
> > 
> > > This patch converts the pci_load_of_ranges function to use the new common
> > > of_pci_range_parser.
> > >
> > > Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
> > > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > > Reviewed-by: Rob Herring <rob.herring@calxeda.com>
> > 
> > Tested-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Jason - you may not have seen this, but here (Linus Walleij) is another Tested-by
> to add to this patch in your tree (if you can).

Thanks, I saw it.  Unfortunately, the PR was already sent, and the branch
is now pulled into arm-soc.

thx,

Jason.
