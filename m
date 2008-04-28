Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Apr 2008 08:19:29 +0100 (BST)
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:29873
	"EHLO QMTA03.westchester.pa.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S20142769AbYD1HT0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 28 Apr 2008 08:19:26 +0100
Received: from OMTA05.westchester.pa.mail.comcast.net ([76.96.62.43])
	by QMTA03.westchester.pa.mail.comcast.net with comcast
	id Jv2h1Z0070vyq2s5301Z00; Mon, 28 Apr 2008 07:17:27 +0000
Received: from gateway.sf.frob.com ([76.102.158.52])
	by OMTA05.westchester.pa.mail.comcast.net with comcast
	id JvKF1Z00318718U3R00000; Mon, 28 Apr 2008 07:19:18 +0000
X-Authority-Analysis: v=1.0 c=1 a=RYFLW6ebtpNBegQnzZ7X4w==:17
 a=sFLNcNVhiJPzHL5vmp0A:9 a=XEEw1lP6X9rOa3b2BZcA:7
 a=felfMFoaT4sFoLyqm1PajlMSb5wA:4 a=oqs56FR1YJwA:10
Received: from magilla.localdomain (magilla.sf.frob.com [198.49.250.228])
	by gateway.sf.frob.com (Postfix) with ESMTP
	id 6F9BE357B; Mon, 28 Apr 2008 00:01:35 -0700 (PDT)
Received: by magilla.localdomain (Postfix, from userid 5281)
	id 3B92026F8F0; Mon, 28 Apr 2008 00:01:35 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:	Roland McGrath <roland@redhat.com>
To:	Adrian Bunk <bunk@kernel.org>
X-Fcc:	~/Mail/linus
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: mips ptrace compat build error
In-Reply-To: Adrian Bunk's message of  Wednesday, 23 April 2008 19:06:07 +0300 <20080423160607.GS28933@cs181133002.pp.htv.fi>
References: <20080423160607.GS28933@cs181133002.pp.htv.fi>
X-Shopping-List: (1) Spastic admonition pronunciations
   (2) No-Action stones
   (3) Despotic condiments
   (4) Prototypical dependent commanders
Message-Id: <20080428070135.3B92026F8F0@magilla.localdomain>
Date:	Mon, 28 Apr 2008 00:01:35 -0700 (PDT)
Return-Path: <roland@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19027
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: roland@redhat.com
Precedence: bulk
X-list: linux-mips

Sorry for the delay; I was out sick last week.

I thought I'd checked for other arch's that would be affected, but I think
I may only have noticed those that actually use compat_ptrace_request.
Every CONFIG_COMPAT arch ought to clean up to use compat_ptrace_request
anyway, replacing calls to ptrace_request or their own implementations of
things like PTRACE_GETEVENTMSG that compat_ptrace_request takes care of.

I'm not in a position to test mips, but this patch is probably what you
need to restore the build.  I'd recommend that you follow this up with a
cleanup patch to use compat_ptrace_request, and another to replace
sys32_ptrace with compat_arch_ptrace and set __ARCH_WANT_COMPAT_SYS_PTRACE.


Thanks,
Roland


diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 572c610..99372f7 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -775,14 +775,25 @@ asmlinkage int sys32_rt_sigpending(compat_sigset_t __user *uset,
 	return ret;
 }
 
+int copy_siginfo_from_user32(siginfo_t *to, compat_siginfo_t __user *from)
+{
+	memset(to, 0, sizeof *to);
+
+	if (copy_from_user(to, from, 3*sizeof(int)) ||
+	    copy_from_user(to->_sifields._pad,
+			   from->_sifields._pad, SI_PAD_SIZE))
+		return -EFAULT;
+
+	return 0;
+}
+
 asmlinkage int sys32_rt_sigqueueinfo(int pid, int sig, compat_siginfo_t __user *uinfo)
 {
 	siginfo_t info;
 	int ret;
 	mm_segment_t old_fs = get_fs();
 
-	if (copy_from_user(&info, uinfo, 3*sizeof(int)) ||
-	    copy_from_user(info._sifields._pad, uinfo->_sifields._pad, SI_PAD_SIZE))
+	if (copy_siginfo_from_user32(&info, uinfo))
 		return -EFAULT;
 	set_fs(KERNEL_DS);
 	ret = sys_rt_sigqueueinfo(pid, sig, (siginfo_t __user *)&info);
