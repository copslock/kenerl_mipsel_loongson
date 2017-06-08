Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 17:08:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45663 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993911AbdFHPIBmGtp4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2017 17:08:01 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id EF13364D6150E;
        Thu,  8 Jun 2017 16:07:50 +0100 (IST)
Received: from [10.20.78.153] (10.20.78.153) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Thu, 8 Jun 2017
 16:07:53 +0100
Date:   Thu, 8 Jun 2017 16:07:44 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 4/4] MIPS: Branch straight to ll in mips_atomic_set()
In-Reply-To: <20170608115748.GU6973@jhogan-linux.le.imgtec.org>
Message-ID: <alpine.DEB.2.00.1706081604060.21750@tp.orcam.me.uk>
References: <cover.5633df325dbcbc41dbf9cc60df22b38f7812e73a.1496240182.git-series.james.hogan@imgtec.com> <c17c30b035caec45c1de97f4d069ab31fec2067e.1496240182.git-series.james.hogan@imgtec.com> <580e1148-aaf9-895c-09ec-8b38772a9154@gmail.com>
 <20170531164754.GM6973@jhogan-linux.le.imgtec.org> <d671ae4e-f58b-6f7e-4814-f8ef764a8625@gmail.com> <alpine.DEB.2.00.1706080734010.21750@tp.orcam.me.uk> <20170608115748.GU6973@jhogan-linux.le.imgtec.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.153]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58367
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

On Thu, 8 Jun 2017, James Hogan wrote:

> >  A PAUSE might be in order here.
> 
> Quite possibly, though I'm not sure its worth bothering to optimise this
> old/unused code.

 Well, given that...

> I had a patch somewhere to add PAUSE to spinlock loops...

... I advise doing it consistently throughout, so that someone does not 
copy-&-paste the wrong piece if nothing else.  On it's own I agree it 
would be quite odd to only have the least used piece optimised.

  Maciej
