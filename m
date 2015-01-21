Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2015 01:58:50 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:51535 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011961AbbAUA6sJ5l1w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jan 2015 01:58:48 +0100
Date:   Wed, 21 Jan 2015 00:58:48 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     David Daney <ddaney.cavm@gmail.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        linux-mips@linux-mips.org,
        Matthew Fortune <Matthew.Fortune@imgtec.com>
Subject: Re: [PATCH RFC v2 24/70] MIPS: asm: spinlock: Replace sub instruction
 with addiu
In-Reply-To: <20150120222028.GI1205@linux-mips.org>
Message-ID: <alpine.LFD.2.11.1501210052290.28301@eddie.linux-mips.org>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-25-git-send-email-markos.chandras@imgtec.com> <alpine.LFD.2.11.1501200028390.28301@eddie.linux-mips.org> <54BE3BFD.5070108@imgtec.com> <54BE8DC7.4030009@gmail.com>
 <20150120222028.GI1205@linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45384
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

Ralf,

> > According to a comment on another thread from Ralf, this has been observed
> > in the wild only once.  We can simplify the code and remove that comment.
> > Why not just use the ADDIU and be done with it?
> > 
> > There are many locking and atomic primitives that don't have any such error
> > checking.  What makes the read lock so special that it needs this extra
> > protection?
> 
> Because I was desparate to find a use for the signed add ;-)
> 
> Honestly, it's nice to have such a safeguard if it's available at no
> runtime overhead at all but these days are such nice lock debugging tools
> that the loss won't be missed.  So (cut'n'paste):
> 
> Why not just use the ADDIU and be done with it?

 Given David's comment I meant to defer to you on this as the originator 
of this bit, but since you have spoken, I think we've come to a conclusion 
now. :)

  Maciej
