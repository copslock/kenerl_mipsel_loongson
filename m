Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2015 15:20:24 +0100 (CET)
Received: from mail-wg0-f50.google.com ([74.125.82.50]:65057 "EHLO
        mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010595AbbAVOUVrIbEU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Jan 2015 15:20:21 +0100
Received: by mail-wg0-f50.google.com with SMTP id b13so1975786wgh.9;
        Thu, 22 Jan 2015 06:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=j6q9TCXt4oEz8wzBgv44nk3sx1V4VGdQRA+GzlE2vis=;
        b=Td852Y+y3a77qOmCpgQRLqQGdPcJOD8wGkM7a33Puy3VlRXRAy3XN2jbUYkrQhcObg
         +YBmnPN6acRuKlOLSkh3JM3tykVawmm8P2p8cmhWap0M/GR5ha1SWwoV08Cov3LmWLNq
         HiO9X095kJixpmRNiaPvsGRan+Q6t8X/q7A4JD1CctobThAYPB/iSpzC+ANDoNWn24ZP
         m0nZertC4OsLpQDTtlm0GjMiGBm3ad2lbveMiOvd91cIrTJnuWxAvg8DgfU1Xq07Mpf7
         VHneAm6iF5o6ITNcOqrJLEXN9DdjGSKB605O7ysUMESvjvRy8kpHi8Fato4IiFpGkU07
         uh6A==
X-Received: by 10.194.84.240 with SMTP id c16mr3644285wjz.74.1421936416547;
 Thu, 22 Jan 2015 06:20:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.194.59.199 with HTTP; Thu, 22 Jan 2015 06:19:55 -0800 (PST)
In-Reply-To: <54BFDF2B.80708@caviumnetworks.com>
References: <1421681040-3392-1-git-send-email-aleksey.makarov@auriga.com>
 <20150119154357.GH21553@leverpostej> <54BD580C.6030701@gmail.com>
 <20150121165427.GA8722@leverpostej> <54BFDF2B.80708@caviumnetworks.com>
From:   Rob Herring <robherring2@gmail.com>
Date:   Thu, 22 Jan 2015 08:19:55 -0600
Message-ID: <CAL_Jsq+Vtp=G6PJZvgksfLSXHBkoTC4TxLymP0ONk9MjaMtMPQ@mail.gmail.com>
Subject: Re: [PATCH] SATA: OCTEON: support SATA on OCTEON platform
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
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
Content-Type: text/plain; charset=UTF-8
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
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

On Wed, Jan 21, 2015 at 11:17 AM, David Daney <ddaney@caviumnetworks.com> wrote:
> On 01/21/2015 08:54 AM, Mark Rutland wrote:
>>
>> On Mon, Jan 19, 2015 at 07:16:28PM +0000, David Daney wrote:
>
> [...]
>>>>>
>>>>> @@ -67,6 +76,7 @@ static const struct of_device_id ahci_of_match[] = {
>>>>>         { .compatible = "ibm,476gtr-ahci", },
>>>>>         { .compatible = "snps,dwc-ahci", },
>>>>>         { .compatible = "hisilicon,hisi-ahci", },
>>>>> +       { .compatible = "cavium,octeon-7130-ahci", },
>>>>>         {},
>>>>
>>>>
>>>> I was under the impression that the strings other than "generic-ahci"
>>>> were only for compatibility with existing DTBs. Why do we need to add
>>>> new platform-specific strings here?
>>>
>>>
>>> Because it is an "existing DTB", The device tree doesn't contain the
>>> compatible property of "generic-ahci", only "cavium,octeon-7130-ahci".
>>
>>
>> While the DTB may already exist, the string "cavium,octeon-7130-ahci"
>> isn't in mainline, and as far as I can see has never been supported.
>
>
> There seems to be a disconnect here.  The DTB comes from the hardware boot
> environment.  The hardware is in some cases already deployed.  It is for all
> practical purposes, impossible to change the DTB.
>
> The idea that the kernel source code controls the content of the device tree
> doesn't apply here.

I have to agree that adding the compatible string here is okay.
Allowing/using generic names is the exception, not the rule. We're
usually pushing the other way. People often complain about having to
add a compatible string when they don't need it (yet).

However, the argument that the privately developed DTB has to be
accepted as is is complete crap. Maybe you have done a good job and
have all straightforward bindings, so having them accepted won't be a
big deal. We should be reasonable and not bikeshed things which are
already in use and only affect a single device. Many of the bindings
in vendor trees I have seen are a complete mess, but I expect better
from you.

Rob
