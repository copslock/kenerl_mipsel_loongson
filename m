Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2009 13:40:11 +0000 (GMT)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:19436 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21366314AbZA1NkJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Jan 2009 13:40:09 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n0SDe8KQ002541;
	Wed, 28 Jan 2009 13:40:08 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n0SDe7iP002540;
	Wed, 28 Jan 2009 13:40:07 GMT
Date:	Wed, 28 Jan 2009 13:40:07 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] add return value check to
	user_termio_to_kernel_termios()
Message-ID: <20090128134007.GA29709@linux-mips.org>
References: <20090125224557.8582051b.yoichi_yuasa@tripeaks.co.jp> <20090128124047.GA25706@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090128124047.GA25706@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21857
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 28, 2009 at 12:40:47PM +0000, Ralf Baechle wrote:

> Duh...  That sort of trivial thing is not fatal but just shouldn't
> happen.  And other architectures have the same bug even.  Your patch
> leaves the last get_user and the copy_from_user return values unchecked.
> I'll sort that out.

How about this patch which also gets rid of the rest of the macro soup
by replacing them with inline functions.

How about this?

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

commit 848091da998d2f0d5fe70c6bcd34a0cdf5c7f2b2
Author: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Date:   Sun Jan 25 22:45:57 2009 +0900

    MIPS: Add return value checks to user_termio_to_kernel_termios()
    
    Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/include/asm/termios.h b/arch/mips/include/asm/termios.h
index a275661..8f77f77 100644
--- a/arch/mips/include/asm/termios.h
+++ b/arch/mips/include/asm/termios.h
@@ -9,6 +9,7 @@
 #ifndef _ASM_TERMIOS_H
 #define _ASM_TERMIOS_H
 
+#include <linux/errno.h>
 #include <asm/termbits.h>
 #include <asm/ioctls.h>
 
@@ -94,38 +95,81 @@ struct termio {
 /*
  * Translate a "termio" structure into a "termios". Ugh.
  */
-#define user_termio_to_kernel_termios(termios, termio) \
-({ \
-	unsigned short tmp; \
-	get_user(tmp, &(termio)->c_iflag); \
-	(termios)->c_iflag = (0xffff0000 & ((termios)->c_iflag)) | tmp; \
-	get_user(tmp, &(termio)->c_oflag); \
-	(termios)->c_oflag = (0xffff0000 & ((termios)->c_oflag)) | tmp; \
-	get_user(tmp, &(termio)->c_cflag); \
-	(termios)->c_cflag = (0xffff0000 & ((termios)->c_cflag)) | tmp; \
-	get_user(tmp, &(termio)->c_lflag); \
-	(termios)->c_lflag = (0xffff0000 & ((termios)->c_lflag)) | tmp; \
-	get_user((termios)->c_line, &(termio)->c_line); \
-	copy_from_user((termios)->c_cc, (termio)->c_cc, NCC); \
-})
+static inline int user_termio_to_kernel_termios(struct ktermios *termios,
+	struct termio __user *termio)
+{
+	unsigned short iflag, oflag, cflag, lflag;
+	unsigned int err;
+
+	if (!access_ok(VERIFY_READ, termio, sizeof(struct termio)))
+		return -EFAULT;
+
+	err = __get_user(iflag, &termio->c_iflag);
+	termios->c_iflag = (termios->c_iflag & 0xffff0000) | iflag;
+	err |=__get_user(oflag, &termio->c_oflag);
+	termios->c_oflag = (termios->c_oflag & 0xffff0000) | oflag;
+	err |=__get_user(cflag, &termio->c_cflag);
+	termios->c_cflag = (termios->c_cflag & 0xffff0000) | cflag;
+	err |=__get_user(lflag, &termio->c_lflag);
+	termios->c_lflag = (termios->c_lflag & 0xffff0000) | lflag;
+	err |=__get_user(termios->c_line, &termio->c_line);
+	if (err)
+		return -EFAULT;
+
+	if (__copy_from_user(termios->c_cc, termio->c_cc, NCC))
+		return -EFAULT;
+
+	return 0;
+}
 
 /*
  * Translate a "termios" structure into a "termio". Ugh.
  */
-#define kernel_termios_to_user_termio(termio, termios) \
-({ \
-	put_user((termios)->c_iflag, &(termio)->c_iflag); \
-	put_user((termios)->c_oflag, &(termio)->c_oflag); \
-	put_user((termios)->c_cflag, &(termio)->c_cflag); \
-	put_user((termios)->c_lflag, &(termio)->c_lflag); \
-	put_user((termios)->c_line, &(termio)->c_line); \
-	copy_to_user((termio)->c_cc, (termios)->c_cc, NCC); \
-})
-
-#define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios2))
-#define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios2))
-#define user_termios_to_kernel_termios_1(k, u) copy_from_user(k, u, sizeof(struct termios))
-#define kernel_termios_to_user_termios_1(u, k) copy_to_user(u, k, sizeof(struct termios))
+static inline int kernel_termios_to_user_termio(struct termio __user *termio,
+	struct ktermios *termios)
+{
+	int err;
+
+	if (!access_ok(VERIFY_WRITE, termio, sizeof(struct termio)))
+		return -EFAULT;
+
+	err = __put_user(termios->c_iflag, &termio->c_iflag);
+	err |= __put_user(termios->c_oflag, &termio->c_oflag);
+	err |= __put_user(termios->c_cflag, &termio->c_cflag);
+	err |= __put_user(termios->c_lflag, &termio->c_lflag);
+	err |= __put_user(termios->c_line, &termio->c_line);
+	if (err)
+		return -EFAULT;
+
+	if (__copy_to_user(termio->c_cc, termios->c_cc, NCC))
+		return -EFAULT;
+
+	return 0;
+}
+
+static inline int user_termios_to_kernel_termios(struct ktermios __user *k,
+	struct termios2 *u)
+{
+	return copy_from_user(k, u, sizeof(struct termios2)) ? -EFAULT : 0;
+}
+
+static inline int kernel_termios_to_user_termios(struct termios2 __user *u,
+	struct ktermios *k)
+{
+	return copy_to_user(u, k, sizeof(struct termios2)) ? -EFAULT : 0;
+}
+
+static inline int user_termios_to_kernel_termios_1(struct ktermios *k,
+	struct termios __user *u)
+{
+	return copy_from_user(k, u, sizeof(struct termios)) ? -EFAULT : 0;
+}
+
+static inline int kernel_termios_to_user_termios_1(struct termios __user *u,
+	struct ktermios *k)
+{
+	return copy_to_user(u, k, sizeof(struct termios)) ? -EFAULT : 0;
+}
 
 #endif /* defined(__KERNEL__) */
 
