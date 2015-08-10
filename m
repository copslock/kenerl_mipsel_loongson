Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Aug 2015 21:17:54 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26681 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012919AbbHJTRw40mYa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Aug 2015 21:17:52 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 661728AFB43F7;
        Mon, 10 Aug 2015 20:17:43 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 10 Aug 2015 20:17:46 +0100
Received: from localhost (192.168.154.168) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 10 Aug
 2015 20:17:46 +0100
Date:   Mon, 10 Aug 2015 20:17:46 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [4.1,013/123] MIPS: c-r4k: Fix cache flushing for MT cores
Message-ID: <20150810191745.GA28790@mchandras-linux.le.imgtec.org>
References: <20150808220718.304261727@linuxfoundation.org>
 <55C8EF32.5010807@imgtec.com>
 <20150810184953.GA19646@kroah.com>
 <55C8F785.5020605@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <55C8F785.5020605@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.168]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

On Mon, Aug 10, 2015 at 12:12:05PM -0700, Leonid Yegoshin wrote:
> On 08/10/2015 11:49 AM, gregkh@linuxfoundation.org wrote:
> > On Mon, Aug 10, 2015 at 11:36:34AM -0700, Leonid Yegoshin wrote:
> >>
> > So, this is broken in Linus's tree too?
> 
> Yes.
> 
> >    Or is it fixed there, and if
> > so, what is the git commit id?
> 
> There is no an accepted fix. My old patch is in
> 
> https://git.linux-mips.org/cgit/yegoshin/mips.git/commit/?id=98f6c462eb5319a4dcb3830f902c48141f38cd12
> 
> It was a precursor for my EVA set of patches since2.6.35.9 but was never 
> accepted and was lost during redesign of EVA by Markos.
> 
> - Leonid.
> 

I hope you realize that blocking this patch from the stable trees does not
actually fix the problem. The patch may not be perfect but it's better than what
we had before.

-- 
markos
