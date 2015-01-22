Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2015 22:55:50 +0100 (CET)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:34308 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009484AbbAVVzt309tB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Jan 2015 22:55:49 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id 05F1F19BE18;
        Thu, 22 Jan 2015 23:55:49 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id 5AoA-8Lnzp78; Thu, 22 Jan 2015 23:55:44 +0200 (EET)
Received: from fuloong-minipc (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp6.welho.com (Postfix) with ESMTP id D7DD65BC004;
        Thu, 22 Jan 2015 23:55:43 +0200 (EET)
Date:   Thu, 22 Jan 2015 23:55:43 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
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
Subject: Re: [PATCH] SATA: OCTEON: support SATA on OCTEON platform
Message-ID: <20150122215543.GA5048@fuloong-minipc.musicnaut.iki.fi>
References: <1421681040-3392-1-git-send-email-aleksey.makarov@auriga.com>
 <20150119154357.GH21553@leverpostej>
 <54BD580C.6030701@gmail.com>
 <20150121165427.GA8722@leverpostej>
 <54BFDF2B.80708@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54BFDF2B.80708@caviumnetworks.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45440
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

On Wed, Jan 21, 2015 at 09:17:31AM -0800, David Daney wrote:
> On 01/21/2015 08:54 AM, Mark Rutland wrote:
> >While the DTB may already exist, the string "cavium,octeon-7130-ahci"
> >isn't in mainline, and as far as I can see has never been supported.
> 
> There seems to be a disconnect here.  The DTB comes from the hardware boot
> environment.  The hardware is in some cases already deployed.  It is for all
> practical purposes, impossible to change the DTB.

It's possible to change/fix the DTB in platform code like currently
done for the OCTEON in-tree DTBs. But that's ugly.

I think there should be also a mechanism to override the DTB completely
with a user supplied one like with kernel APPENDED_DTB on ARM.

A.
