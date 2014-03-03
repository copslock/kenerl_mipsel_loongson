Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Mar 2014 15:29:31 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.89.28.114]:35768 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817179AbaCCO32KBPVz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Mar 2014 15:29:28 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 299013A9B379;
        Mon,  3 Mar 2014 14:29:20 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Mon, 3 Mar 2014 14:29:22 +0000
Received: from localhost (192.168.154.79) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 3 Mar
 2014 14:29:21 +0000
Date:   Mon, 3 Mar 2014 14:29:21 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 3/5] MIPS: Set page size to 16KB for malta SMP defconfigs
Message-ID: <20140303142921.GF13880@pburton-linux.le.imgtec.org>
References: <1392904828-12969-1-git-send-email-markos.chandras@imgtec.com>
 <1392904828-12969-4-git-send-email-markos.chandras@imgtec.com>
 <20140221173829.GI19285@linux-mips.org>
 <53148C5A.7020101@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <53148C5A.7020101@imgtec.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39398
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

On Mon, Mar 03, 2014 at 02:06:18PM +0000, Markos Chandras wrote:
> On 02/21/2014 05:38 PM, Ralf Baechle wrote:
> >On Thu, Feb 20, 2014 at 02:00:26PM +0000, Markos Chandras wrote:
> >
> >>From: Paul Burton <paul.burton@imgtec.com>
> >>
> >>For Malta defconfigs which may run on an SMP configuration without
> >>hardware cache anti-aliasing, a 16KB page size is a safer default.
> >>Most notably at the moment it will avoid cache aliasing issues for
> >>multicore proAptiv systems.
> >
> >You're aware that this may cause binary compatibility issues with old
> >userland?  So far the defaults were chosen to maximise compatibility
> >over performance.
> >
> >   Ralf
> >
> Hi Ralf,
> 
> Are you referring to programs hard coding the page size to 4k instead of
> using the getpagesize()? Well yes this could be a problem. But is that a
> real problem? We are changing the default value so whoever has such an old
> userland can easily switch to the 4k page size. It may also be a good
> opportunity to expose such application and get the fixed properly :) But if
> that's not acceptable, we can drop the patch. Paul what do you think?
> 
> -- 
> markos

I think the potential backwards compatibility issue is probably not a
huge issue for Malta, but that it would make sense to dig deeper into
why proAptiv SMP systems don't run correctly with 4KB pages. You don't
actually have to look very far to find userland which depends upon 4KB
pages (*cough* android *cough*). I consider this patch an acceptable
workaround for the proAptiv problem on Malta, but I don't know enough
at the moment to say whether there's a proper fix.

Paul
