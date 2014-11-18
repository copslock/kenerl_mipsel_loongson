Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2014 18:19:52 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:55896 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013907AbaKRRTtXjcKf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Nov 2014 18:19:49 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sAIHJmPt023062;
        Tue, 18 Nov 2014 18:19:48 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sAIHJmnD023061;
        Tue, 18 Nov 2014 18:19:48 +0100
Date:   Tue, 18 Nov 2014 18:19:48 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     bin.jiang@windriver.com
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: get_user: set the parameter @x to zero on error
Message-ID: <20141118171947.GA22757@linux-mips.org>
References: <1416292496-6149-1-git-send-email-bin.jiang@windriver.com>
 <20141118112258.GQ24983@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141118112258.GQ24983@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44272
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

On Tue, Nov 18, 2014 at 12:22:59PM +0100, Ralf Baechle wrote:

> On Tue, Nov 18, 2014 at 02:34:56PM +0800, bin.jiang@windriver.com wrote:
> 
> > From: Bin Jiang <bin.jiang@windriver.com>
> > 
> > The following compile warning is caused to use uninitialized variables:
> > 
> > fs/compat_ioctl.c: In function 'compat_SyS_ioctl':
> > arch/mips/include/asm/uaccess.h:451:2: warning: 'length' may be used \
> >                 uninitialized in this function [-Wmaybe-uninitialized]
> >   __asm__ __volatile__(      \
> >   ^
> > fs/compat_ioctl.c:208:6: note: 'length' was declared here
> >   int length, err;
> >       ^
> > 
> > In get_user function, the parameter @x is used to store result. If the
> > function return error, the @x won't be set and cause above warning.
> > 
> > According to the description of get_user function, the parameter @x should
> > be set to zero on error.
> 
> You're not the first to send such a patch, see
> 
>   http://patchwork.linux-mips.org/patch/1307/
> 
> However I've hesistated to apply the previous patch which only claimed to
> resolve a warning because __get_user and get_user get expanded very often
> in the kernel so a small innocent looking change like this results in a
> surprisingly large bloat.
> 
> A smart compiler will reorder this:
> 
> 	int x;
> 
> 	if (...) {
> 		...
> 	} else
> 		x = 0;
> 
> into:
> 
> 	int x = 0;
> 
> 	if (...) {
> 		...
> 	}
> 
> Which avoids the branches otherwise necessary for the else construct.  However
> both the original and your patch fail to take care of the case where the
> if is taken but __get_user_asm aborts due to an inaccessible fault.
> 
> That case is only fixed by manually doing above reordering - a compiler can't
> know that the inline assembler won't assign anything in that case.
> 
> The comment btw was cut and paste and - blame me - it seems I failed to read
> what it promises about @x for the error case; I had implemented get_user under
> the assumption that the returned value was undefined in case of an -EFAULT
> error.
> 
> Thanks for reporting this!

On a closer look my proposed solution has issues if the expression to be
assigned to has side effects, say for something like

  get_user(array[index++], ptr);

so I came back to the solution you had proposed initially.  Still as mentioned
in my previous email that leaves the case unsolved where access_ok() succeeds
but the load from userland then causes a fault.  So combining the two things
I ended up with below patch.

The 64 bit loads from user space for 32 bit kernel were already zeroing the
register in the fixup code.  For these loads there was the interesting
special case were one of the loads might succeed, the other one fault.  This
behavious was obviously least useful, hence the clearing of the destination
register.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/include/asm/uaccess.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index 826329f..c034ce3 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -301,7 +301,8 @@ do {									\
 			__get_kernel_common((x), size, __gu_ptr);	\
 		else							\
 			__get_user_common((x), size, __gu_ptr);		\
-	}								\
+	} else								\
+		(x) = 0;						\
 									\
 	__gu_err;							\
 })
@@ -316,6 +317,7 @@ do {									\
 	"	.insn						\n"	\
 	"	.section .fixup,\"ax\"				\n"	\
 	"3:	li	%0, %4					\n"	\
+	"	move	%0, $0					\n"	\
 	"	j	2b					\n"	\
 	"	.previous					\n"	\
 	"	.section __ex_table,\"a\"			\n"	\
@@ -630,6 +632,7 @@ do {									\
 	"	.insn						\n"	\
 	"	.section .fixup,\"ax\"				\n"	\
 	"3:	li	%0, %4					\n"	\
+	"	move	%1, $zero				\n"	\
 	"	j	2b					\n"	\
 	"	.previous					\n"	\
 	"	.section __ex_table,\"a\"			\n"	\
