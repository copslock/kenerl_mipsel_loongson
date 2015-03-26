Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Mar 2015 21:52:28 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27007636AbbCZUw0rBA8q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Mar 2015 21:52:26 +0100
Date:   Thu, 26 Mar 2015 20:52:26 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] MIPS: mm: tlbex: Replace cpu_has_mips_r2_exec_hazard
 with cpu_has_mips_r2_r6
In-Reply-To: <55030539.6070803@imgtec.com>
Message-ID: <alpine.LFD.2.11.1503262051350.5791@eddie.linux-mips.org>
References: <1424731974-27926-1-git-send-email-ddaney.cavm@gmail.com> <1426238288-15560-1-git-send-email-markos.chandras@imgtec.com> <20150313144443.GA12977@linux-mips.org> <55030539.6070803@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Fri, 13 Mar 2015, Markos Chandras wrote:

> > Either of this David's revert or this patch applied will leave
> > cpu_has_mips_r2_exec_hazard unused which at a glance doesn't seem to
> > be right and defeats David's old patches 9e290a19 / 41f0e4d0 from working.
> > 
> > cpu_has_mips_r2_exec_hazard was made unused by 625c0a21 which I think
> > should be reverted and cpu_has_mips_r2_exec_hazard be defined to be something
> > like
> 
> Indeed that looks an old regression. Thanks for spotting that.

 Noted here:

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=alpine.LFD.2.11.1502240011420.17311%40eddie.linux-mips.org

several weeks ago already.

  Maciej
