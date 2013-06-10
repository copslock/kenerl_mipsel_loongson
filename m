Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 20:45:21 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45784 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817177Ab3FJSpQQDJ-H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Jun 2013 20:45:16 +0200
Date:   Mon, 10 Jun 2013 19:45:16 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Manuel Lauss <manuel.lauss@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: Alchemy: fix wait function
In-Reply-To: <20130610154944.GB5303@linux-mips.org>
Message-ID: <alpine.LFD.2.03.1306101940450.18329@linux-mips.org>
References: <1369315716-7408-1-git-send-email-manuel.lauss@gmail.com> <20130610154944.GB5303@linux-mips.org>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36816
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

On Mon, 10 Jun 2013, Ralf Baechle wrote:

> > Only an interrupt can wake the core from 'wait', enable interrupts
> > locally before executing 'wait'.
> > 
> > Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> > ---
> > Ralf made me aware of the race in between enabling interrupts and
> > entering wait.  While this patch does not eliminate it, it shrinks it
> > to 1 instruction.  It's not perfect, but lets Alchemy boot until a
> > more sophisticated solution (like __r4k_wait) can be implemented
> > without having to duplicate the interrupt exception handler.
> 
> It doesn't shrink it - interrupts will be pending from the time they
> were disabled to the point where they get re-enabled.  That can be quite
> a few cycles and so the likelyhood for hitting the race is not that low.

 My understanding has been the race is that an interrupt can be taken 
between the MTC0 instruction used to enable interrupts and the WAIT 
instruction and the handler can disable interrupts back.  That's not going 
to be a problem if the interrupt is taken "a few cycles" later, because by 
then WAIT will have already been executed.

 Have I been missing something here?

  Maciej
