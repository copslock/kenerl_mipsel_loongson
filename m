Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jun 2013 03:37:23 +0200 (CEST)
Received: from perches-mx.perches.com ([206.117.179.246]:36172 "EHLO
        labridge.com" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S6834832Ab3FTBhWOEnAX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Jun 2013 03:37:22 +0200
Received: from [173.51.221.202] (account joe@perches.com HELO [192.168.1.152])
  by labridge.com (CommuniGate Pro SMTP 5.0.14)
  with ESMTPA id 21098855; Wed, 19 Jun 2013 18:37:20 -0700
Message-ID: <1371692239.2146.7.camel@joe-AO722>
Subject: Re: [PATCH 1/2] netdev: octeon_mgmt: Correct tx IFG workaround.
From:   Joe Perches <joe@perches.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Date:   Wed, 19 Jun 2013 18:37:19 -0700
In-Reply-To: <51C25ACA.1070907@gmail.com>
References: <1371688820-4585-1-git-send-email-ddaney.cavm@gmail.com>
         <1371688820-4585-2-git-send-email-ddaney.cavm@gmail.com>
         <1371690487.2146.5.camel@joe-AO722> <51C25ACA.1070907@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37039
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
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

On Wed, 2013-06-19 at 18:28 -0700, David Daney wrote:
> On 06/19/2013 06:08 PM, Joe Perches wrote:
> > On Wed, 2013-06-19 at 17:40 -0700, David Daney wrote:
> >> From: David Daney <david.daney@cavium.com>
> >>
> >> The previous fix was still too agressive to meet ieee specs.  Increase
> >> to (14, 10).
> > []
> >> diff --git a/drivers/net/ethernet/octeon/octeon_mgmt.c b/drivers/net/ethernet/octeon/octeon_mgmt.c
> > []
> >> @@ -1141,10 +1141,13 @@ static int octeon_mgmt_open(struct net_device *netdev)
> >>   		/* For compensation state to lock. */
> >>   		ndelay(1040 * NS_PER_PHY_CLK);
> >>
> >> -		/* Some Ethernet switches cannot handle standard
> >> -		 * Interframe Gap, increase to 16 bytes.
> >> +		/* Default Interframe Gaps are too small.  Recommended
> >> +		 * workaround is.
> >> +		 *
> >> +		 * AGL_GMX_TX_IFG[IFG1]=14
> >> +		 * AGL_GMX_TX_IFG[IFG2]=10
> >
> > Why isn't the TX IFG just 96 bit times?
> 
> I don't have a full understanding of how the transistors are wired up on 
> the chip, so I cannot accurately answer your question.  But I can say 
> that after I empirically found the previous values to get the thing to 
> work, the hardware designers independently found that the values 
> supplied in this patch are required to achieve industry standard IFGs 
> with this hardware.

For one specific chip or for the Octeon entire family?
