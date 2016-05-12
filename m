Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2016 03:32:19 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7772 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028152AbcELBcRSujEE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 May 2016 03:32:17 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 642D1F45ECB1F;
        Thu, 12 May 2016 02:32:09 +0100 (IST)
Received: from [10.20.78.171] (10.20.78.171) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Thu, 12 May 2016
 02:32:09 +0100
Date:   Thu, 12 May 2016 02:32:00 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        <matt.redfearn@imgtec.com>
Subject: Re: [PATCH] MIPS: tools: Ignore relocation tool
In-Reply-To: <1462994177-6460-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <alpine.DEB.2.00.1605120218540.6794@tp.orcam.me.uk>
References: <1462994177-6460-1-git-send-email-f.fainelli@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.171]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Wed, 11 May 2016, Florian Fainelli wrote:

> Add a .gitignore ignoring arch/mips/boot/tools/relocs.

 It's also left behind after `make distclean' so looks like it's missing a 
clean-up rule or one hasn't been properly wired.

  Maciej
