Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Nov 2017 11:26:14 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.244]:38351 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992157AbdKTK0FqrY90 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Nov 2017 11:26:05 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 20 Nov 2017 10:25:09 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 20 Nov
 2017 02:25:09 -0800
Date:   Mon, 20 Nov 2017 10:25:07 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Paul Burton <paul.burton@imgtec.com>, <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [22/26] MIPS: generic: Introduce generic DT-based board support
Message-ID: <20171120102507.GD27409@jhogan-linux.mipstec.com>
References: <20160826153725.11629-23-paul.burton@imgtec.com>
 <20171119034325.GA17384@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20171119034325.GA17384@roeck-us.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1511173509-637138-21356-324272-1
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.60
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187128
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.60 MARKETING_SUBJECT      HEADER: Subject contains popular marketing words 
X-BESS-Outbound-Spam-Status: SCORE=0.60 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, MARKETING_SUBJECT
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61021
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

On Sat, Nov 18, 2017 at 07:43:25PM -0800, Guenter Roeck wrote:
> On Fri, Aug 26, 2016 at 04:37:21PM +0100, Paul Burton wrote:
> > Introduce a "generic" platform, which aims to be board-agnostic by
> > making use of device trees passed by the boot protocol defined in the
> > MIPS UHI (Universal Hosting Interface) specification. Provision is made
> > for supporting boards which use a legacy boot protocol that can't be
> > changed, but adding support for such boards or any others is left to
> > followon patches.
> > 
> > Right now the built kernels expect to be loaded to 0x80100000, ie. in
> > kseg0. This is fine for the vast majority of MIPS platforms, but
> > nevertheless it would be good to remove this limitation in the future by
> > mapping the kernel via the TLB such that it can be loaded anywhere & map
> > itself appropriately.
> > 
> > Configuration is handled by dynamically generating configs using
> > scripts/kconfig/merge_config.sh, somewhat similar to the way powerpc
> > makes use of it. This allows for variations upon the configuration, eg.
> > differing architecture revisions or subsets of driver support for
> > differing boards, to be handled without having a large number of
> > defconfig files.
> > 
> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> 
> Guess it is known that this patch causes failures when building
> "allmodconfig" on test systems such as 0day; it was reported by 0day
> some two months ago. nevertheless, the patch found its way into mainline
> without fix. Does anyone care, or should I simply disable "allmodconfig"
> test builds for mips ?

Hi Guenter,

I can't find any emails from 0day in relation to this patch (I've also
dug about on the kbuild-all archives without success). Could you link to
or quote the build failure you're referring to.

Thanks
James
