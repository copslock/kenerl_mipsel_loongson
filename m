Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2016 14:53:47 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:58644 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27028189AbcELMxnAKrU4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 May 2016 14:53:43 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u4CCrg3J012913;
        Thu, 12 May 2016 14:53:42 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u4CCrgnq012912;
        Thu, 12 May 2016 14:53:42 +0200
Date:   Thu, 12 May 2016 14:53:42 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: Endless loop on execution attempt on non-executable page
Message-ID: <20160512125342.GS16402@linux-mips.org>
References: <57345F0D.9070503@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57345F0D.9070503@redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53407
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Thu, May 12, 2016 at 12:46:37PM +0200, Florian Weimer wrote:

> The GCC compile farm has a big-endian 64-bit MIPS box.  The kernel is:
> 
> Linux erpro8-fsf1 3.14.10-er8mod-00013-ge0fe977 #1 SMP PREEMPT Wed Jan
> 14 12:33:22 PST 2015 mips64 GNU/Linux
> 
> Which is a vendor kernel for the EdgeRouter Pro-8.
> 
> /proc/cpuinfo reports:
> 
> system type             : UBNT_E200 (CN6120p1.1-1000-NSP)
> machine                 : Unknown
> processor               : 0
> cpu model               : Cavium Octeon II V0.1
> 
> While testing W^X (execmod, DEP, NX) stack enforcement, I noticed that once
> I try to execute code off a non-executable page, I do not get a signal, but
> the code appears to enter an infinite loop.  The generated function starts
> with a jump instruction to return to the caller, but instead, the program
> counter does not seem to change at all.
> 
> “si” in GDB also hangs (but can be interrupted with ^C).
> 
> My test code is here:
> 
>   https://pagure.io/execmod-tests
> 
> Is this a kernel bug or an issue with the silicon?

I see the test case uses mprotect to add PROT_EXEC after writing the code
to memory.  I don't think mprotect however gives any guarantee that this
will make the I-cache coherent with the D-cache, that is that the CPU will
actually fetch and execute the instruction that were just written to memory.
For that you have to do something architecture specific such as dancing
around a fire waving a dead chicken.  Or on MIPS call cacheflush(), see
the man page for details.

For portability sake to some broken processors you should also ensure
that a 32 byte cache line is entirely filled with valid instructions by
padding the two test instructions with another six no-op (opcode 0).
The test case as it is guarantees this implicitly by using a freshly
allocated page but I thought I should mention it.

  Ralf
