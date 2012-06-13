Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jun 2012 23:54:01 +0200 (CEST)
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:1848 "EHLO
        cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903760Ab2FMVx5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jun 2012 23:53:57 +0200
Received: from cpsps-ews25.kpnxchange.com ([10.94.84.191]) by cpsmtpb-ews03.kpnxchange.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 13 Jun 2012 23:53:52 +0200
Received: from CPSMTPM-TLF101.kpnxchange.com ([195.121.3.4]) by cpsps-ews25.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Wed, 13 Jun 2012 23:53:51 +0200
Received: from [192.168.1.102] ([212.123.169.34]) by CPSMTPM-TLF101.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Wed, 13 Jun 2012 23:53:52 +0200
Message-ID: <1339624431.30984.185.camel@x61.thuisdomein>
Subject: Re: [PATCH] MIPS: remove three unused headers
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Date:   Wed, 13 Jun 2012 23:53:51 +0200
In-Reply-To: <20120613145614.GC5516@linux-mips.org>
References: <1339491792.30984.110.camel@x61.thuisdomein>
         <20120613145614.GC5516@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3 (3.2.3-3.fc16) 
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-OriginalArrivalTime: 13 Jun 2012 21:53:52.0207 (UTC) FILETIME=[0562ADF0:01CD49AF]
X-RcptDomain: linux-mips.org
X-archive-position: 33632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pebolle@tiscali.nl
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, 2012-06-13 at 15:56 +0100, Ralf Baechle wrote:
> On Tue, Jun 12, 2012 at 11:03:12AM +0200, Paul Bolle wrote:
> 
> > No file includes these three headers. It seems they have never been
> > included since at least v2.6.12-rc2. They can safely be removed.
> 
> >  arch/mips/include/asm/sibyte/sb1250_l2c.h |  131 -------
> >  arch/mips/include/asm/sibyte/sb1250_ldt.h |  422 ----------------------
> >  arch/mips/include/asm/sibyte/sb1250_mc.h  |  550 -----------------------------
> 
> These headers describe the on-chip hardware of the SB1250 SOC.  Some of
> the drivers to use them are currently stuck midflight on their path to
> submission.

OK, I see. Thanks.

>   The remaining ones I'd like to keep around as documentation
> or for later use.

I'd say that arch/mips/include/ is were one puts code and
Documentation/mips/ is were one puts documentation. Can't the unused
header files you want to keep (preferably with, say, a .txt extension)
be added to Documentation/mips/?
 
>   Ditto for your other BCM1480 related patch....

Thanks,


Paul Bolle
