Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 May 2013 14:45:16 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:50296 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823763Ab3E0MpL0Rvfe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 May 2013 14:45:11 +0200
Date:   Mon, 27 May 2013 13:45:11 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
cc:     Sanjay Lal <sanjayl@kymasys.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 00/18] KVM/MIPS32: Support for the new Virtualization
 ASE (VZ-ASE)
In-Reply-To: <519A7249.1030302@gmail.com>
Message-ID: <alpine.LFD.2.03.1305202029460.10753@linux-mips.org>
References: <n> <1368942460-15577-1-git-send-email-sanjayl@kymasys.com> <519A4640.6060202@gmail.com> <456B70C6-A896-4B94-B8EF-DE6ED26CE859@kymasys.com> <alpine.LFD.2.03.1305201930570.10753@linux-mips.org> <519A7249.1030302@gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36613
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

On Mon, 20 May 2013, David Daney wrote:

> >   That's rather risky as the implementation of this register (and its
> > presence in the first place) is processor-specific.  Do you maintain a
> > list of PRId values the use of this register is safe with?
> > 
> 
> FWIW:  The MIPS-VZ architecture module requires the presence of CP0 scratch
> registers that can be used for this in the exception handlers without having
> to worry about using these implementation dependent registers.  For the
> trap-and-emulate only version, there really is no choice other than to
> re-purpose some of the existing CP0 registers.

 Sure, I've just been wondering what the implementation does to make sure 
it does not go astray on a random processor out there.

 FWIW, offhand the ErrorEPC register, that's been universally present 
since MIPS III (and I doubt anyone cares of virtualising on earlier 
implementations), seems to me promising as a better choice -- of course 
that register can get clobbered if an error-class exception happens early 
on in exception processing, but in that case we're in a worse trouble than 
just clobbering one of the guest registers anyway and likely cannot 
recover at all regardless.

  Maciej
