Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 May 2015 01:20:30 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:57292 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006688AbbEVXU0sDQhH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 May 2015 01:20:26 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t4MNKN58018152;
        Sat, 23 May 2015 01:20:23 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t4MNKJje018150;
        Sat, 23 May 2015 01:20:19 +0200
Date:   Sat, 23 May 2015 01:20:19 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     linux-mips@linux-mips.org, rusty@rustcorp.com.au,
        alexinbeijing@gmail.com, paul.burton@imgtec.com,
        david.daney@cavium.com, alex@alex-smith.me.uk,
        linux-kernel@vger.kernel.org, james.hogan@imgtec.com,
        markos.chandras@imgtec.com, macro@linux-mips.org,
        eunb.song@samsung.com, manuel.lauss@gmail.com,
        andreas.herrmann@caviumnetworks.com
Subject: Re: [PATCH 1/2] MIPS: MSA: bugfix - disable MSA during thread switch
 correctly
Message-ID: <20150522232019.GA10556@linux-mips.org>
References: <20150519211222.35859.52798.stgit@ubuntu-yegoshin>
 <20150519211351.35859.80332.stgit@ubuntu-yegoshin>
 <20150522093812.GH6941@linux-mips.org>
 <555F776E.3070904@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <555F776E.3070904@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47591
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

On Fri, May 22, 2015 at 11:37:34AM -0700, Leonid Yegoshin wrote:

> On 05/22/2015 02:38 AM, Ralf Baechle wrote:
> >Just move the call to finish_arch_switch().
> 
> It might be a problem later, then a correct MSA partiton starts working. It
> should be tight to saving MSA registers in that case.
> 
> >Your rewrite also dropped the if (cpu_has_msa) condition from
> >disable_msa() probably causing havoc on lots of CPUs which will likely not
> >decode the set bits of the MFC0/MTC0 instructions thus end up accessing
> >Config0. Ralf
> 
> Right before this chunk of code there is a saving MSA registers. Does it
> causing a havoc or else?
> 
> May I ask you to look into switch_to macro to figure out how "if
> (cpu_has_msa)" check works in this case?

Ah sorry I now see that your added code is not executed for all CPUs but
only those having MSA.  So then it's safe.

Still I don't stylistically like defining the register t4 in the middle
of the code.

Below my suggested patch.  It's advantage is that for non-MSA platforms
the call to disable_msa() will be removed entirely.

Something like Paul's http://patchwork.linux-mips.org/patch/10111/ (assuming
it's correct and tested) seems like a full cleanup but it's way too
complex for 4.1 or the stable kernels.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/include/asm/switch_to.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/switch_to.h b/arch/mips/include/asm/switch_to.h
index e92d6c4b..7163cd7 100644
--- a/arch/mips/include/asm/switch_to.h
+++ b/arch/mips/include/asm/switch_to.h
@@ -104,7 +104,6 @@ do {									\
 	if (test_and_clear_tsk_thread_flag(prev, TIF_USEDMSA))		\
 		__fpsave = FP_SAVE_VECTOR;				\
 	(last) = resume(prev, next, task_thread_info(next), __fpsave);	\
-	disable_msa();							\
 } while (0)
 
 #define finish_arch_switch(prev)					\
@@ -122,6 +121,7 @@ do {									\
 	if (cpu_has_userlocal)						\
 		write_c0_userlocal(current_thread_info()->tp_value);	\
 	__restore_watch();						\
+	disable_msa();							\
 } while (0)
 
 #endif /* _ASM_SWITCH_TO_H */
