Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2007 14:57:55 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.170]:26118 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20022622AbXJYN5r (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Oct 2007 14:57:47 +0100
Received: by ug-out-1314.google.com with SMTP id u2so583965uge
        for <linux-mips@linux-mips.org>; Thu, 25 Oct 2007 06:57:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type;
        bh=Mv0iQ8FSmP/fzXb4aq1OJi4xcD5fO7bofDxc87qNkH4=;
        b=exuJZwHufgh6o33YOr6eYvJKrYADOs+uNTngtHlA0EQNttW6zYMWaSjDpRS3hLT3c1mkWMRNmBOWjJ3/iXnZPgTtiMFBYCCt1wf2YwezW40F9xeoVsv2MCitkCDgybg5vDCWcpNaPvzDYWA5F6V50dWoqdbQH2NmAIRDdluJH4c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type;
        b=QafqU9Hldkmo8POeCtMCflTDeK+L6wI+TVI3puxCTkdNuVeSayvbXJzNJv1X1aMvfEuJokei+IV0pzF3og7C8qI8llSz/LTNRwLudKyhREhOflhY42/vfFczqy2p7SvZcgwSDGZwq9UUP0Y/n8ecm9ZRBA6uQGmr+5d0NtgpHqg=
Received: by 10.67.19.13 with SMTP id w13mr3316061ugi.1193320648417;
        Thu, 25 Oct 2007 06:57:28 -0700 (PDT)
Received: from ?194.132.8.27? ( [85.70.229.122])
        by mx.google.com with ESMTPS id z40sm2618661ikz.2007.10.25.06.57.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Oct 2007 06:57:28 -0700 (PDT)
Message-ID: <4720A11E.5060101@gmail.com>
Date:	Thu, 25 Oct 2007 15:58:54 +0200
From:	Jan Nikitenko <jan.nikitenko@gmail.com>
User-Agent: Thunderbird 2.0.0.6 (X11/20070917)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org, linux-serial@vger.kernel.org
Subject: [PATCH] serial: fix au1xxx UART0 irq setup
Content-Type: multipart/mixed;
 boundary="------------060501070907010108080001"
Return-Path: <jan.nikitenko@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17209
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jan.nikitenko@gmail.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------060501070907010108080001
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

UART0 on Alchemy mips platforms (au1xxx) does not use real uart's hw
irq, causing 'ttyS0: 1 input overrun(s)' kernel message with data loss,
when more characters than uart's fifo size were to be received by the uart.

This problem can be experienced for example when uart0 is used as a
serial console on au1550 and more than 16 characters are pasted from
clipboard to the console.

The is_real_interrupt(irq) macro is defined in drivers/serial/8250.c as
a check, if the irq number is other than zero.
Because UART0 on au1xxx platforms uses irq number 0, the
is_real_interrupt() check fails and serial8250_backup_timeout() is used
instead of uart's hw irq.

The patch redefines the is_real_interrupt(irq) macro, as suggested in
the comment above the macro definition in 8250.c, in the
asm-mips/serial.h to be always true for CONFIG_SERIAL_8250_AU1X00.
This allows the irq number 0 to be used as hw irq for the alchemy uart0
and fixes the overrun problem.

Signed-off-by: Jan Nikitenko <jan.nikitenko@gmail.com>

---

 include/asm-mips/serial.h |    5 +++++
 1 file changed, 5 insertions(+)

--------------060501070907010108080001
Content-Type: text/plain;
 name="serial-fix-au1xxx-uart0-irq-setup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="serial-fix-au1xxx-uart0-irq-setup.patch"

diff --git a/include/asm-mips/serial.h b/include/asm-mips/serial.h
index c07ebd8..526bd2e 100644
--- a/include/asm-mips/serial.h
+++ b/include/asm-mips/serial.h
@@ -19,4 +19,9 @@
  */
 #define BASE_BAUD (1843200 / 16)
 
+#ifdef CONFIG_SERIAL_8250_AU1X00
+#undef is_real_interrupt
+#define is_real_interrupt(irq)  (1)
+#endif
+
 #endif /* _ASM_SERIAL_H */

--------------060501070907010108080001--
