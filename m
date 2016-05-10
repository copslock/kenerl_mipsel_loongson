Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 May 2016 10:43:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12795 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028583AbcEJInX3UJi- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 May 2016 10:43:23 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 4C19F97F0441;
        Tue, 10 May 2016 09:43:14 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 10 May 2016 09:43:16 +0100
Received: from localhost (10.100.200.213) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Tue, 10 May
 2016 09:43:16 +0100
Date:   Tue, 10 May 2016 09:43:15 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 01/11] MIPS: math-emu: Fix BC1{EQ,NE}Z emulation
Message-ID: <20160510084315.GA17928@NP-P-BURTON>
References: <1461243895-30371-1-git-send-email-paul.burton@imgtec.com>
 <1461243895-30371-2-git-send-email-paul.burton@imgtec.com>
 <20160510080940.GD16402@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20160510080940.GD16402@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.100.200.213]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Tue, May 10, 2016 at 10:09:40AM +0200, Ralf Baechle wrote:
> On Thu, Apr 21, 2016 at 02:04:45PM +0100, Paul Burton wrote:
> 
> > The conditions for branching when emulating the BC1EQZ & BC1NEZ
> > instructions were backwards, leading to each of those instructions being
> > treated as the other. Fix this by reversing the conditions, and clear up
> > the code a little for readability & checkpatch.
> > 
> > Fixes: c909ca718e8f ("MIPS: math-emu: Emulate missing BC1{EQ,NE}Z instructions")
> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > Reviewed-by: James Hogan <james.hogan@imgtec.com>
> 
> Patch ok - but you may want to take Markos off the cc list.  Or iff he's
> still interested, is there any new address for him to use instead?
> 
>   Ralf

Hi Ralf,

It's a case of automated tooling cc'ing people from relevant git
history, without the knowledge that the email address is no longer
valid. I'll see if I can get it to filter him out next time.

Thanks,
    Paul
