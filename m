Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2014 20:16:05 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57820 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860031AbaFQSOXYh-QJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jun 2014 20:14:23 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id BB691F6F25205;
        Tue, 17 Jun 2014 19:14:12 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Tue, 17 Jun
 2014 19:14:16 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Tue, 17 Jun 2014 19:14:16 +0100
Received: from localhost (192.168.159.86) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 17 Jun
 2014 19:14:10 +0100
Date:   Tue, 17 Jun 2014 19:14:09 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     "Joseph S. Myers" <joseph@codesourcery.com>
CC:     <linux-mips@linux-mips.org>, <libc-alpha@sourceware.org>,
        <linux-api@vger.kernel.org>
Subject: Re: MIPS MSA sigcontext changes in 3.15
Message-ID: <20140617181409.GD7020@pburton-laptop.home>
References: <Pine.LNX.4.64.1406171447030.23412@digraph.polyomino.org.uk>
 <Pine.LNX.4.64.1406171539240.23412@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1406171539240.23412@digraph.polyomino.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.159.86]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40611
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

On Tue, Jun 17, 2014 at 03:44:36PM +0000, Joseph S. Myers wrote:
> On Tue, 17 Jun 2014, Joseph S. Myers wrote:
> 
> > signal mask at a particular offset in the ucontext.  As far as I can see, 
> > extending sigcontext requires a new sigaction flag that could be used to 
> > opt in, for a particular signal handler, to receiving the new-layout 
> > ucontext (so new symbol versions of sigaction in glibc could then pass 
> > that flag to the kernel, but existing binaries would continue to get 
> > old-layout ucontext from the kernel), or else putting the new data at the 
> 
> And a new flag would itself be problematic - signal handlers would need 
> wrapping with userspace code to convert structure layout when new-version 
> sigaction is used on an older kernel.  That suggests putting the new data 
> at the end of ucontext is to be preferred (but in any case it would be 
> best to revert the incompatible changes until something compatible with 
> existing userspace can be produced).
> 
> -- 
> Joseph S. Myers
> joseph@codesourcery.com
> 

True. Oops. I hadn't realised this...

I wonder if the sensible thing is to switch to sigcontext merely
containing a pointer to another struct holding FP state, much like x86.
Only in response to a flag as you describe of course. That way the
kernel could avoid the games it currently plays with splitting the
vector registers into 64b pieces, and it would probably be more open
to wider vector registers if they appear in the future.

Anyway, I agree with reverting the sigcontext change (eec43a224cf1
"MIPS: Save/restore MSA context around signals") in the meantime. I'll
submit a patch as soon as I can.

Given:

 - This issue.

 - A couple of other MSA fixes I have pending cleanup.

 - The fact that the only CPU the kernel supports which has MSA is the
      P5600, and since that is 32b it can't actually make use of MSA
   without the experimental CONFIG_MIPS_O32_FP64_SUPPORT option. Thus
   MSA isn't actually being used yet beyond a few small groups who
   accepted that big shouty experimental warning.

...I wonder if it makes sense to disable MSA support by default for the
moment also.

Thanks,
    Paul
