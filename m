Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2017 13:27:27 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.230]:47271 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990425AbdKMM1UCRL3S convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Nov 2017 13:27:20 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1412.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 13 Nov 2017 12:27:11 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 13 Nov
 2017 04:25:55 -0800
Date:   Mon, 13 Nov 2017 12:25:53 +0000
From:   James Hogan <james.hogan@mips.com>
To:     John Crispin <john@phrozen.org>
CC:     Mathias Kresin <dev@kresin.me>, <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/2] MIPS: ralink: fix MT7628 pinmux
Message-ID: <20171113122552.GA15260@jhogan-linux>
References: <1494483075-17816-1-git-send-email-dev@kresin.me>
 <2ddeb62a-adae-d715-7c77-a27df30db6df@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <2ddeb62a-adae-d715-7c77-a27df30db6df@phrozen.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510575969-452060-12338-438077-9
X-BESS-VER: 2017.14.1-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186876
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60850
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

On Sun, Nov 12, 2017 at 10:55:50AM +0100, John Crispin wrote:
> 
> 
> On 11/05/17 08:11, Mathias Kresin wrote:
> > According to the datasheet the REFCLK pin is shared with GPIO#37 and
> > the PERST pin is shared with GPIO#36.
> >
> > Signed-off-by: Mathias Kresin <dev@kresin.me>
> Acked-by: John Crispin <john@phrozen.org>

Thanks, both patches applied.

Cheers
James

> > ---
> >   arch/mips/ralink/mt7620.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
> > index 094a0ee..528a6ac 100644
> > --- a/arch/mips/ralink/mt7620.c
> > +++ b/arch/mips/ralink/mt7620.c
> > @@ -144,8 +144,8 @@ static struct rt2880_pmx_func i2c_grp_mt7628[] = {
> >   	FUNC("i2c", 0, 4, 2),
> >   };
> >   
> > -static struct rt2880_pmx_func refclk_grp_mt7628[] = { FUNC("reclk", 0, 36, 1) };
> > -static struct rt2880_pmx_func perst_grp_mt7628[] = { FUNC("perst", 0, 37, 1) };
> > +static struct rt2880_pmx_func refclk_grp_mt7628[] = { FUNC("reclk", 0, 37, 1) };
> > +static struct rt2880_pmx_func perst_grp_mt7628[] = { FUNC("perst", 0, 36, 1) };
> >   static struct rt2880_pmx_func wdt_grp_mt7628[] = { FUNC("wdt", 0, 38, 1) };
> >   static struct rt2880_pmx_func spi_grp_mt7628[] = { FUNC("spi", 0, 7, 4) };
> >   
> 
> 
