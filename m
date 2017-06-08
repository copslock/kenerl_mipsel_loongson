Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 08:37:37 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28191 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993302AbdFHGhbJcTwz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2017 08:37:31 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 3F5D771CE445E;
        Thu,  8 Jun 2017 07:37:22 +0100 (IST)
Received: from [10.20.78.153] (10.20.78.153) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Thu, 8 Jun 2017
 07:37:22 +0100
Date:   Thu, 8 Jun 2017 07:37:14 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     David Daney <ddaney.cavm@gmail.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 4/4] MIPS: Branch straight to ll in mips_atomic_set()
In-Reply-To: <d671ae4e-f58b-6f7e-4814-f8ef764a8625@gmail.com>
Message-ID: <alpine.DEB.2.00.1706080734010.21750@tp.orcam.me.uk>
References: <cover.5633df325dbcbc41dbf9cc60df22b38f7812e73a.1496240182.git-series.james.hogan@imgtec.com> <c17c30b035caec45c1de97f4d069ab31fec2067e.1496240182.git-series.james.hogan@imgtec.com> <580e1148-aaf9-895c-09ec-8b38772a9154@gmail.com>
 <20170531164754.GM6973@jhogan-linux.le.imgtec.org> <d671ae4e-f58b-6f7e-4814-f8ef764a8625@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.153]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58302
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

On Wed, 31 May 2017, David Daney wrote:

> > > The subsection keeps the code for the (hopefully) cold path out of line
> > > which should result in a smaller cache footprint in the hot path.
> > 
> > Hmm, yes that would make sense if it did something useful there, but it
> > just immediately jumps back to the ll.
> 
> In this case, it could be that the pattern was copied without carefully
> examining what was being done.

 A PAUSE might be in order here.

  Maciej
