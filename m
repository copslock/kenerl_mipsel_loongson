Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9TDYCs03122
	for linux-mips-outgoing; Mon, 29 Oct 2001 05:34:12 -0800
Received: from firewall.i-data.com (firewall.i-data.com [195.24.22.194])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9TDY5003115
	for <linux-mips@oss.sgi.com>; Mon, 29 Oct 2001 05:34:05 -0800
From: tommy.christensen@eicon.com
Received: (qmail 3009 invoked from network); 29 Oct 2001 13:34:02 -0000
Received: from idahub2000.i-data.com (HELO idanshub.i-data.com) (172.16.1.8)
  by firewall.i-data.com with SMTP; 29 Oct 2001 13:34:02 -0000
Received: from eicon.com ([172.17.159.1])          by idanshub.i-data.com (Lotus
 Domino Release 5.0.8)          with ESMTP id 2001102914361998:11913
 ;          Mon, 29 Oct 2001 14:36:19 +0100
Message-ID: <3BDD5B31.E12DE812@eicon.com>
Date: Mon, 29 Oct 2001 14:35:45 +0100
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Fixup in unaligned.c
X-MIMETrack: Itemize by SMTP Server on idaHUB2000/INT(Release 5.0.8 |June 18, 2001) at
 29-10-2001 14:36:20,
	MIME-CD by Notes Server on idaHUB2000/INT(Release 5.0.8 |June 18, 2001) at
 29-10-2001 14:36:20,
	MIME-CD complete at 29-10-2001 14:36:20,
	Serialize by Router on idaHUB2000/INT(Release 5.0.8 |June 18, 2001) at 29-10-2001
 14:36:20
Content-type: multipart/mixed; 
	Boundary="0__=C1256AF4004ABCDC8f9e8a93df938690918cC1256AF4004ABCDC"
Content-Disposition: inline
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

--0__=C1256AF4004ABCDC8f9e8a93df938690918cC1256AF4004ABCDC
Content-type: text/plain; charset=us-ascii


It seems we don't always handle bad user-mode pointers correctly.
If put_user is called with an unmapped AND unaligned address it
kills the current process instead of returning EFAULT.

The reason for this is that we do compute_return_epc() in do_ade()
before the exception table is searched, so we never get a match.

Below is a simple patch to fix it (attached as well).
The second part is not related, but it makes sense to only consult
the MF_FIXADE flag on exceptions originating from user-mode, right?

-Tommy


--- arch/mips/kernel/unaligned.c        2001/10/05 15:13:25     1.14
+++ arch/mips/kernel/unaligned.c        2001/10/29 12:39:56
@@ -353,12 +353,12 @@

 fault:
        /* Did we have an exception handler installed? */
-       fixup = search_exception_table(regs->cp0_epc);
+       fixup = search_exception_table(pc);
        if (fixup) {
                long new_epc;
-               new_epc = fixup_exception(dpf_reg, fixup, regs->cp0_epc);
+               new_epc = fixup_exception(dpf_reg, fixup, pc);
                printk(KERN_DEBUG "%s: Forwarding exception at [<%lx>]
(%lx)\n",
-                      current->comm, regs->cp0_epc, new_epc);
+                      current->comm, pc, new_epc);
                regs->cp0_epc = new_epc;
                return;
        }
@@ -408,7 +408,7 @@
        pc = regs->cp0_epc + ((regs->cp0_cause & CAUSEF_BD) ? 4 : 0);
        if (compute_return_epc(regs))
                return;
-       if ((current->thread.mflags & MF_FIXADE) == 0)
+       if (user_mode(regs) && (current->thread.mflags & MF_FIXADE) == 0)
                goto sigbus;

        emulate_load_store_insn(regs, regs->cp0_badvaddr, pc);
(See attached file: unaligned.c.patch.gz)
--0__=C1256AF4004ABCDC8f9e8a93df938690918cC1256AF4004ABCDC
Content-type: application/octet-stream; 
	name="unaligned.c.patch.gz"
Content-Disposition: attachment; filename="unaligned.c.patch.gz"
Content-transfer-encoding: base64

H4sICJBO3TsAA3VuYWxpZ25lZC5jLnBhdGNoAKVSW2/TMBR+Tn7F0aRVyZI0SS/AUrp1W1s0IXjY
NAkJUOTGJ6k114kcp62E+O84SelaQIMJvxxbPt/lXG4FxW0ERCZLf8WK0n9EKZD7lSCcZQJpNzHH
/3/Mu5t7SBnHCPxkXfqciWrrP6fqrk2JSjJcM5GB1KFkuYCwGw5MytIUvAo8WT/h0Kvnec8WY/SC
IPTDwA+GEA6jsB/1hkZD6jjOvyF75xD2ov55NHxlTibg9Yd9N+yBs4uTiQkmpKTiKjLB8M9gyihs
EJZkjUAE4DbBQtXFLImgHCUwUSrCOdJLOPNNz0jZtipgDCXWhuI9IFZkwdGSmJXeRVIEMRaJPTKd
vwGaLDBYClaTacM3/TR4rjsrcFPTjLSssbtroibticeiRRprWbf9cOF3Cy8A7+wYhWRCPVrvZ3cf
4+ns+uEdnJyWEcxzuSGS1mN/ahVR8PntKd9efAVLB/uLOHFry9CepJIShdKW8tXqF3vuzxpbn39G
HKdpc0cUuqh9n5o/VUlRX783GzAI3rivwWlDPX+jgRxTOGAdTC4hVYnQgZurh/vZPL6e2nAJA4gg
2I9KGysqhXGrVnM0eNs+tOA1qda+GrWUSGh3lXKSlZr/wzye3366ms5sGI81ue5ADdDiMl7ltF0m
GzodeAGH1s9ylUPJskVVjup9N3BVcaLd8pzQuFS5xFivtWj4DweyIHRNKJW7NfgBiEKUKoAEAAA=

--0__=C1256AF4004ABCDC8f9e8a93df938690918cC1256AF4004ABCDC--
