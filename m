Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jun 2008 15:51:11 +0100 (BST)
Received: from wr-out-0506.google.com ([64.233.184.230]:13272 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20039282AbYFPOvG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Jun 2008 15:51:06 +0100
Received: by wr-out-0506.google.com with SMTP id 58so2985464wri.8
        for <linux-mips@linux-mips.org>; Mon, 16 Jun 2008 07:51:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:mime-version:content-type:x-google-sender-auth;
        bh=8dxpQIuZ4jU+mZ2vgSHWfR2jytPFc9vJWjuCdohK8R8=;
        b=kARwayJyVqhnp2hUB0/oYVfgLCwTuDyE+1r7TQ8xTaybdmX57j0726T6quk2cjRQTa
         rJioCG3U6Liyeu5eBrr6PjzVmFa3lEiy7tyUkwG9zDeZ5zJfZrzImoayllazIbChMDYu
         7WVLEnlQvkUQMGZtaNN52+Z+tZ9rrzYbxdeQk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:mime-version:content-type
         :x-google-sender-auth;
        b=S5uKwvEgz5m+znlmZH0whU55uHasTH6IZiYANmeMdrCaiXICrK/nqrc9f7QPf+yq4M
         rdd7N/kAWfalVXN4D2+Z/O7sxtapzB50JCNqC0TW0nU+4KPQbYiKW73WauYW7kyU2Y7B
         ZS/oZ6rrxiMleNV+NklGB3zyyC7VzSRM/s0o0=
Received: by 10.90.102.15 with SMTP id z15mr7088647agb.114.1213627865094;
        Mon, 16 Jun 2008 07:51:05 -0700 (PDT)
Received: by 10.90.70.11 with HTTP; Mon, 16 Jun 2008 07:51:05 -0700 (PDT)
Message-ID: <64660ef00806160751m723ee4ddjf4f9226aa08aabf9@mail.gmail.com>
Date:	Mon, 16 Jun 2008 15:51:05 +0100
From:	"Daniel Laird" <daniel.j.laird@nxp.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: [PATCH 2/2] : Patch to fix stubborn timers on PNX833x/(Others?)
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_8356_29964952.1213627865097"
X-Google-Sender-Auth: 79f770fd0d512b7e
Return-Path: <daniel.j.laird@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19572
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.j.laird@nxp.com
Precedence: bulk
X-list: linux-mips

------=_Part_8356_29964952.1213627865097
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The mips processor on PNX833x is a stubborn mips chip and takes a few
attempts to
hit the timer ack.  Introduce a loop of 10 attempts to ack the timer.

 cevt-r4k.c |   33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

Signed-off-by: daniel.j.laird <daniel.j.laird@nxp.com>

diff -urN --exclude=.svn
linux-2.6.26-rc4.orig/arch/mips/kernel/cevt-r4k.c
linux-2.6.26-rc4/arch/mips/kernel/cevt-r4k.c
--- linux-2.6.26-rc4.orig/arch/mips/kernel/cevt-r4k.c	2008-06-03
10:56:51.000000000 +0100
+++ linux-2.6.26-rc4/arch/mips/kernel/cevt-r4k.c	2008-06-16
14:12:18.000000000 +0100
@@ -47,11 +47,25 @@
 static int cp0_timer_irq_installed;

 /*
+ * FIXME: This doesn't hold for the relocated E9000 compare interrupt.
+ */
+static inline int c0_compare_int_pending(void)
+{
+	return (read_c0_cause() >> cp0_compare_irq) & 0x100;
+}
+
+/*
  * Timer ack for an R4k-compatible timer of a known frequency.
  */
-static void c0_timer_ack(void)
+static inline void c0_timer_ack(bool timeout)
 {
-	write_c0_compare(read_c0_compare());
+	int attempts_remaining = 10;
+	do {
+		write_c0_compare(read_c0_compare());
+		irq_disable_hazard();
+		if (timeout)
+			attempts_remaining--;
+	} while (c0_compare_int_pending() && attempts_remaining);
 }

 /*
@@ -93,7 +107,7 @@
 	 * interrupt.  Being the paranoiacs we are we check anyway.
 	 */
 	if (!r2 || (read_c0_cause() & (1 << 30))) {
-		c0_timer_ack();
+		c0_timer_ack(false);
 #ifdef CONFIG_MIPS_MT_SMTC
 		if (cpu_data[cpu].vpe_id)
 			goto out;
@@ -169,13 +183,6 @@
 {
 }

-/*
- * FIXME: This doesn't hold for the relocated E9000 compare interrupt.
- */
-static int c0_compare_int_pending(void)
-{
-	return (read_c0_cause() >> cp0_compare_irq) & 0x100;
-}

 static int c0_compare_int_usable(void)
 {
@@ -186,8 +193,7 @@
 	 * IP7 already pending?  Try to clear it by acking the timer.
 	 */
 	if (c0_compare_int_pending()) {
-		write_c0_compare(read_c0_count());
-		irq_disable_hazard();
+		c0_timer_ack(true);
 		if (c0_compare_int_pending())
 			return 0;
 	}
@@ -208,8 +214,7 @@
 	if (!c0_compare_int_pending())
 		return 0;

-	write_c0_compare(read_c0_count());
-	irq_disable_hazard();
+	c0_timer_ack(true);
 	if (c0_compare_int_pending())
 		return 0;

------=_Part_8356_29964952.1213627865097
Content-Type: text/x-patch; name=arch_mips_kernel_stubborn_timers.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fhj6one70
Content-Disposition: attachment;
 filename=arch_mips_kernel_stubborn_timers.patch

VGhlIG1pcHMgcHJvY2Vzc29yIG9uIFBOWDgzM3ggaXMgYSBzdHViYm9ybiBtaXBzIGNoaXAgYW5k
IHRha2VzIGEgZmV3IGF0dGVtcHRzIHRvIApoaXQgdGhlIHRpbWVyIGFjay4gIEludHJvZHVjZSBh
IGxvb3Agb2YgMTAgYXR0ZW1wdHMgdG8gYWNrIHRoZSB0aW1lci4KCiBjZXZ0LXI0ay5jIHwgICAz
MyArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxOSBp
bnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkKClNpZ25lZC1vZmYtYnk6IGRhbmllbC5qLmxh
aXJkIDxkYW5pZWwuai5sYWlyZEBueHAuY29tPgoKZGlmZiAtdXJOIC0tZXhjbHVkZT0uc3ZuIGxp
bnV4LTIuNi4yNi1yYzQub3JpZy9hcmNoL21pcHMva2VybmVsL2NldnQtcjRrLmMgbGludXgtMi42
LjI2LXJjNC9hcmNoL21pcHMva2VybmVsL2NldnQtcjRrLmMKLS0tIGxpbnV4LTIuNi4yNi1yYzQu
b3JpZy9hcmNoL21pcHMva2VybmVsL2NldnQtcjRrLmMJMjAwOC0wNi0wMyAxMDo1Njo1MS4wMDAw
MDAwMDAgKzAxMDAKKysrIGxpbnV4LTIuNi4yNi1yYzQvYXJjaC9taXBzL2tlcm5lbC9jZXZ0LXI0
ay5jCTIwMDgtMDYtMTYgMTQ6MTI6MTguMDAwMDAwMDAwICswMTAwCkBAIC00NywxMSArNDcsMjUg
QEAKIHN0YXRpYyBpbnQgY3AwX3RpbWVyX2lycV9pbnN0YWxsZWQ7CiAKIC8qCisgKiBGSVhNRTog
VGhpcyBkb2Vzbid0IGhvbGQgZm9yIHRoZSByZWxvY2F0ZWQgRTkwMDAgY29tcGFyZSBpbnRlcnJ1
cHQuCisgKi8KK3N0YXRpYyBpbmxpbmUgaW50IGMwX2NvbXBhcmVfaW50X3BlbmRpbmcodm9pZCkK
K3sKKwlyZXR1cm4gKHJlYWRfYzBfY2F1c2UoKSA+PiBjcDBfY29tcGFyZV9pcnEpICYgMHgxMDA7
Cit9CisKKy8qCiAgKiBUaW1lciBhY2sgZm9yIGFuIFI0ay1jb21wYXRpYmxlIHRpbWVyIG9mIGEg
a25vd24gZnJlcXVlbmN5LgogICovCi1zdGF0aWMgdm9pZCBjMF90aW1lcl9hY2sodm9pZCkKK3N0
YXRpYyBpbmxpbmUgdm9pZCBjMF90aW1lcl9hY2soYm9vbCB0aW1lb3V0KQogewotCXdyaXRlX2Mw
X2NvbXBhcmUocmVhZF9jMF9jb21wYXJlKCkpOworCWludCBhdHRlbXB0c19yZW1haW5pbmcgPSAx
MDsKKwlkbyB7CisJCXdyaXRlX2MwX2NvbXBhcmUocmVhZF9jMF9jb21wYXJlKCkpOworCQlpcnFf
ZGlzYWJsZV9oYXphcmQoKTsKKwkJaWYgKHRpbWVvdXQpCisJCQlhdHRlbXB0c19yZW1haW5pbmct
LTsKKwl9IHdoaWxlIChjMF9jb21wYXJlX2ludF9wZW5kaW5nKCkgJiYgYXR0ZW1wdHNfcmVtYWlu
aW5nKTsKIH0KIAogLyoKQEAgLTkzLDcgKzEwNyw3IEBACiAJICogaW50ZXJydXB0LiAgQmVpbmcg
dGhlIHBhcmFub2lhY3Mgd2UgYXJlIHdlIGNoZWNrIGFueXdheS4KIAkgKi8KIAlpZiAoIXIyIHx8
IChyZWFkX2MwX2NhdXNlKCkgJiAoMSA8PCAzMCkpKSB7Ci0JCWMwX3RpbWVyX2FjaygpOworCQlj
MF90aW1lcl9hY2soZmFsc2UpOwogI2lmZGVmIENPTkZJR19NSVBTX01UX1NNVEMKIAkJaWYgKGNw
dV9kYXRhW2NwdV0udnBlX2lkKQogCQkJZ290byBvdXQ7CkBAIC0xNjksMTMgKzE4Myw2IEBACiB7
CiB9CiAKLS8qCi0gKiBGSVhNRTogVGhpcyBkb2Vzbid0IGhvbGQgZm9yIHRoZSByZWxvY2F0ZWQg
RTkwMDAgY29tcGFyZSBpbnRlcnJ1cHQuCi0gKi8KLXN0YXRpYyBpbnQgYzBfY29tcGFyZV9pbnRf
cGVuZGluZyh2b2lkKQotewotCXJldHVybiAocmVhZF9jMF9jYXVzZSgpID4+IGNwMF9jb21wYXJl
X2lycSkgJiAweDEwMDsKLX0KIAogc3RhdGljIGludCBjMF9jb21wYXJlX2ludF91c2FibGUodm9p
ZCkKIHsKQEAgLTE4Niw4ICsxOTMsNyBAQAogCSAqIElQNyBhbHJlYWR5IHBlbmRpbmc/ICBUcnkg
dG8gY2xlYXIgaXQgYnkgYWNraW5nIHRoZSB0aW1lci4KIAkgKi8KIAlpZiAoYzBfY29tcGFyZV9p
bnRfcGVuZGluZygpKSB7Ci0JCXdyaXRlX2MwX2NvbXBhcmUocmVhZF9jMF9jb3VudCgpKTsKLQkJ
aXJxX2Rpc2FibGVfaGF6YXJkKCk7CisJCWMwX3RpbWVyX2Fjayh0cnVlKTsKIAkJaWYgKGMwX2Nv
bXBhcmVfaW50X3BlbmRpbmcoKSkKIAkJCXJldHVybiAwOwogCX0KQEAgLTIwOCw4ICsyMTQsNyBA
QAogCWlmICghYzBfY29tcGFyZV9pbnRfcGVuZGluZygpKQogCQlyZXR1cm4gMDsKIAotCXdyaXRl
X2MwX2NvbXBhcmUocmVhZF9jMF9jb3VudCgpKTsKLQlpcnFfZGlzYWJsZV9oYXphcmQoKTsKKwlj
MF90aW1lcl9hY2sodHJ1ZSk7CiAJaWYgKGMwX2NvbXBhcmVfaW50X3BlbmRpbmcoKSkKIAkJcmV0
dXJuIDA7CiAK
------=_Part_8356_29964952.1213627865097--
