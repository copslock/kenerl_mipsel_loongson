Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Apr 2013 17:38:27 +0200 (CEST)
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:39013 "EHLO
        cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6826577Ab3DRPiXQFs3q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Apr 2013 17:38:23 +0200
Received: from arm.com (e106165-lin.cambridge.arm.com [10.1.197.23])
        by cam-smtp0.cambridge.arm.com (8.13.8/8.13.8) with ESMTP id r3IFc3pj011678;
        Thu, 18 Apr 2013 16:38:03 +0100
Date:   Thu, 18 Apr 2013 16:38:03 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Grant Likely <grant.likely@secretlab.ca>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
        "jgunthorpe@obsidianresearch.com" <jgunthorpe@obsidianresearch.com>,
        "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
        "siva.kallam@samsung.com" <siva.kallam@samsung.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree-discuss@lists.ozlabs.org" 
        <devicetree-discuss@lists.ozlabs.org>,
        "jg1.han@samsung.com" <jg1.han@samsung.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "kgene.kim@samsung.com" <kgene.kim@samsung.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "suren.reddy@samsung.com" <suren.reddy@samsung.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "thomas.petazzoni@free-electrons.com" 
        <thomas.petazzoni@free-electrons.com>,
        "thierry.reding@avionic-design.de" <thierry.reding@avionic-design.de>,
        "thomas.abraham@linaro.org" <thomas.abraham@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
Subject: Re: [PATCH v7 2/3] of/pci: Provide support for parsing PCI DT
 ranges property
Message-ID: <20130418153803.GA19373@arm.com>
References: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com>
 <1366107508-12672-3-git-send-email-Andrew.Murray@arm.com>
 <20130418134401.84AEE3E1319@localhost>
 <20130418142434.GA18881@arm.com>
 <CACxGe6u7yoecyTR2r-EzpcRxLuSw-p9KC7jA12wEQZs4of3vFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACxGe6u7yoecyTR2r-EzpcRxLuSw-p9KC7jA12wEQZs4of3vFA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <andrew.murray@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36267
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrew.murray@arm.com
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

On Thu, Apr 18, 2013 at 04:29:54PM +0100, Grant Likely wrote:
> On Thu, Apr 18, 2013 at 3:24 PM, Andrew Murray <andrew.murray@arm.com> wrote:
> > On Thu, Apr 18, 2013 at 02:44:01PM +0100, Grant Likely wrote:
> >> On Tue, 16 Apr 2013 11:18:27 +0100, Andrew Murray <Andrew.Murray@arm.com> wrote:
> >> >             /* Act based on address space type */
> >> >             res = NULL;
> >> > -           switch ((pci_space >> 24) & 0x3) {
> >> > -           case 1:         /* PCI IO space */
> >> > +           res_type = range.flags & IORESOURCE_TYPE_BITS;
> >> > +           if (res_type == IORESOURCE_IO) {
> >>
> >> Why the change from switch() to an if/else if sequence?
> >
> > Russell King suggested this change - see
> > https://patchwork.kernel.org/patch/2323941/
> 
> Umm, that isn't what that link shows. That link shows the patch
> already changing to an if/else if construct, and rmk is commenting on
> that.

Arh yes sorry about that. I can't find or remember any good reason why I
changed it from a switch to an if/else :\

Andrew Murray
