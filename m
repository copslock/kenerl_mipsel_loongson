Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jan 2015 13:26:40 +0100 (CET)
Received: from cpsmtpb-ews10.kpnxchange.com ([213.75.39.15]:62059 "EHLO
        cpsmtpb-ews10.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011396AbbALM0j2eN3f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Jan 2015 13:26:39 +0100
Received: from cpsps-ews12.kpnxchange.com ([10.94.84.179]) by cpsmtpb-ews10.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Mon, 12 Jan 2015 13:26:34 +0100
Received: from CPSMTPM-TLF101.kpnxchange.com ([195.121.3.4]) by cpsps-ews12.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Mon, 12 Jan 2015 13:26:33 +0100
Received: from [192.168.10.106] ([77.173.140.92]) by CPSMTPM-TLF101.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Mon, 12 Jan 2015 13:26:33 +0100
Message-ID: <1421065593.22660.57.camel@x220>
Subject: Re: MIPS: ralink: CONFIG_RALINK_ILL_ACC?
From:   Paul Bolle <pebolle@tiscali.nl>
To:     John Crispin <blogic@openwrt.org>
Cc:     Valentin Rothberg <valentinrothberg@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 12 Jan 2015 13:26:33 +0100
In-Reply-To: <1415622769.21229.15.camel@x220>
References: <1414403681.28499.4.camel@x220> <544E188B.9000707@openwrt.org>
         <1415622769.21229.15.camel@x220>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Jan 2015 12:26:33.0633 (UTC) FILETIME=[005AB910:01D02E63]
X-RcptDomain: linux-mips.org
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45084
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

John,

On Mon, 2014-11-10 at 13:32 +0100, Paul Bolle wrote:
> On Mon, 2014-10-27 at 11:03 +0100, John Crispin wrote:
> > On 27/10/2014 10:54, Paul Bolle wrote:
> > > Your commit 78865eacb4aa ("MIPS: ralink: add illegal access
> > > driver") landed in today's linux-next (ie, next-20141027). That
> > > commit dates back to May 16, 2013! It adds a driver that is built
> > > if CONFIG_RALINK_ILL_ACC is set. But there's no Kconfig symbol
> > > RALINK_ILL_ACC.
> > > 
> > > I assume that patch that adds this symbol is queued somewhere. Is
> > > that correct?
> > 
> > i'll look into it. the commit that move all dts files to a central
> > folder broke some of my patches so i had to rebase them. apparently
> > the bit that adds the symbol got lost.
> 
> (CONFIG_RALINK_ILL_ACC was already gone in next-20141029. So that issue
> is resolved, as far as I care.)

It returned in next-20141114 and then made it into mainline (v3.19-rc1
and later). But there's still no Kconfig symbol RALINK_ILL_ACC. What's
the status of the patch to add it?


Paul Bolle
