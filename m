Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2015 15:54:04 +0100 (CET)
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:51935 "EHLO
        foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010483AbbAVOyCR7YNo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Jan 2015 15:54:02 +0100
Received: from foss-smtp-na-1.foss.arm.com (unknown [10.80.61.8])
        by foss-mx-na.foss.arm.com (Postfix) with ESMTP id DB4F1279;
        Thu, 22 Jan 2015 08:53:53 -0600 (CST)
Received: from collaborate-mta1.arm.com (highbank-bc01-b06.austin.arm.com [10.112.81.134])
        by foss-smtp-na-1.foss.arm.com (Postfix) with ESMTP id BCBF15FAD7;
        Thu, 22 Jan 2015 08:53:50 -0600 (CST)
Received: from leverpostej (leverpostej.cambridge.arm.com [10.1.205.151])
        by collaborate-mta1.arm.com (Postfix) with ESMTPS id 58E1B13F91D;
        Thu, 22 Jan 2015 08:53:48 -0600 (CST)
Date:   Thu, 22 Jan 2015 14:53:32 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Rob Herring <robherring2@gmail.com>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        David Daney <ddaney.cavm@gmail.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Anton Vorontsov <avorontsov@ru.mvista.com>,
        Vinita Gupta <vgupta@caviumnetworks.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <Pawel.Moll@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>, Tejun Heo <tj@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] SATA: OCTEON: support SATA on OCTEON platform
Message-ID: <20150122145331.GC12911@leverpostej>
References: <1421681040-3392-1-git-send-email-aleksey.makarov@auriga.com>
 <20150119154357.GH21553@leverpostej>
 <54BD580C.6030701@gmail.com>
 <20150121165427.GA8722@leverpostej>
 <54BFDF2B.80708@caviumnetworks.com>
 <CAL_Jsq+Vtp=G6PJZvgksfLSXHBkoTC4TxLymP0ONk9MjaMtMPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+Vtp=G6PJZvgksfLSXHBkoTC4TxLymP0ONk9MjaMtMPQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <mark.rutland@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mark.rutland@arm.com
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

On Thu, Jan 22, 2015 at 02:19:55PM +0000, Rob Herring wrote:
> On Wed, Jan 21, 2015 at 11:17 AM, David Daney <ddaney@caviumnetworks.com> wrote:
> > On 01/21/2015 08:54 AM, Mark Rutland wrote:
> >>
> >> On Mon, Jan 19, 2015 at 07:16:28PM +0000, David Daney wrote:
> >
> > [...]
> >>>>>
> >>>>> @@ -67,6 +76,7 @@ static const struct of_device_id ahci_of_match[] = {
> >>>>>         { .compatible = "ibm,476gtr-ahci", },
> >>>>>         { .compatible = "snps,dwc-ahci", },
> >>>>>         { .compatible = "hisilicon,hisi-ahci", },
> >>>>> +       { .compatible = "cavium,octeon-7130-ahci", },
> >>>>>         {},
> >>>>
> >>>>
> >>>> I was under the impression that the strings other than "generic-ahci"
> >>>> were only for compatibility with existing DTBs. Why do we need to add
> >>>> new platform-specific strings here?
> >>>
> >>>
> >>> Because it is an "existing DTB", The device tree doesn't contain the
> >>> compatible property of "generic-ahci", only "cavium,octeon-7130-ahci".
> >>
> >>
> >> While the DTB may already exist, the string "cavium,octeon-7130-ahci"
> >> isn't in mainline, and as far as I can see has never been supported.
> >
> >
> > There seems to be a disconnect here.  The DTB comes from the hardware boot
> > environment.  The hardware is in some cases already deployed.  It is for all
> > practical purposes, impossible to change the DTB.
> >
> > The idea that the kernel source code controls the content of the device tree
> > doesn't apply here.
> 
> I have to agree that adding the compatible string here is okay.
> Allowing/using generic names is the exception, not the rule. We're
> usually pushing the other way. People often complain about having to
> add a compatible string when they don't need it (yet).

If people are happy adding the string, then I have no problem with that.

My concern was with the "existing DTB" argument, which you've covered
below.

Thanks,
Mark.

> However, the argument that the privately developed DTB has to be
> accepted as is is complete crap. Maybe you have done a good job and
> have all straightforward bindings, so having them accepted won't be a
> big deal. We should be reasonable and not bikeshed things which are
> already in use and only affect a single device. Many of the bindings
> in vendor trees I have seen are a complete mess, but I expect better
> from you.
> 
> Rob
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
