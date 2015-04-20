Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Apr 2015 13:55:53 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27011180AbbDTLzuvX68m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Apr 2015 13:55:50 +0200
Date:   Mon, 20 Apr 2015 12:55:50 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Cowgill <James.Cowgill@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH] MIPS: asm: elf: Set O32 default FPU flags
In-Reply-To: <20150412232154.GA26498@fuloong-minipc.musicnaut.iki.fi>
Message-ID: <alpine.LFD.2.11.1504201250450.21733@eddie.linux-mips.org>
References: <6D39441BF12EF246A7ABCE6654B0235320FBCA7C@LEMAIL01.le.imgtec.org> <1424949090-20682-1-git-send-email-markos.chandras@imgtec.com> <alpine.LFD.2.11.1504071617580.21028@eddie.linux-mips.org> <20150412232154.GA26498@fuloong-minipc.musicnaut.iki.fi>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46945
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

On Mon, 13 Apr 2015, Aaro Koskinen wrote:

> >  Can you please backport this change to 4.0 ASAP, preferably before it 
> > hits the actual release?
> > 
> >  It fixes a 3.19->4.0 regression, likely affecting all FPU processors and 
> > wreaking havoc.  For example I came across a system that boots 3.19 just 
> > fine, but hangs in `ypbind' with 4.0.  It works again with this change 
> > applied.
> 
> It seems this patch, and some other fixes for fatal regressions,
> missed 4.0, although they were reported right after the -rc1 was out.
> 
> Basically 4.0 is unusable for MIPS users.

 I've had some success with the "nofpu" kernel parameter; in fact I didn't 
notice the problem as I was testing full FPU emulation and until I enabled 
the FPU hardware.  You may try the option temporarily as a workaround.  

 Hopefully the fix makes it through to 4.0.1 or suchlike.

  Maciej
