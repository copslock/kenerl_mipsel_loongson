Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Feb 2003 14:14:27 +0000 (GMT)
Received: from [IPv6:::ffff:133.36.48.43] ([IPv6:::ffff:133.36.48.43]:26273
	"EHLO cat.os-omicron.org") by linux-mips.org with ESMTP
	id <S8225192AbTBQOO0>; Mon, 17 Feb 2003 14:14:26 +0000
Received: from wl04.sys.cs.tuat.ac.jp (pisces.sys.cs.tuat.ac.jp [165.93.162.82])
	by cat.os-omicron.org (Postfix) with SMTP id 508B8A4E3
	for <linux-mips@linux-mips.org>; Mon, 17 Feb 2003 23:16:07 +0900 (JST)
Date: Mon, 17 Feb 2003 23:13:43 +0900
From: TAKANO Ryousei <takano@os-omicron.org>
To: linux-mips@linux-mips.org
Subject: Re: [PATCH][1/2] TANBAC TB0193 (L-Card+)
Message-Id: <20030217231343.32b7aa6c.takano@os-omicron.org>
In-Reply-To: <86vfzj9u2d.fsf@trasno.mitica>
References: <20030217133213.6febe320.takano@os-omicron.org>
	<86vfzj9u2d.fsf@trasno.mitica>
Organization: OS/omicron Project
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-vine-linux)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Mon__17_Feb_2003_23:13:43_+0900_0823f5f0"
Return-Path: <takano@os-omicron.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: takano@os-omicron.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

--Multipart_Mon__17_Feb_2003_23:13:43_+0900_0823f5f0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi, Juan

On Mon, 17 Feb 2003 09:42:50 +0100
Juan Quintela <quintela@mandrakesoft.com> wrote:
> Please, use C99 initializers.
> 

I fixed C99 initializers.

Thanks,
TAKANO Ryousei

--Multipart_Mon__17_Feb_2003_23:13:43_+0900_0823f5f0
Content-Type: application/octet-stream;
 name="tanbac-tb0193-arch2.patch"
Content-Disposition: attachment;
 filename="tanbac-tb0193-arch2.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtTnJ1IC0tZXhjbHVkZT1DVlMgLS1leGNsdWRlPS5jdnNpZ25vcmUgbGludXgub3JpZy9h
cmNoL21pcHMvdnI0MTgxL3RhbmJhYy10YjAxOTMvaWRlLXRiMDE5My5jIGxpbnV4L2FyY2gvbWlw
cy92cjQxODEvdGFuYmFjLXRiMDE5My9pZGUtdGIwMTkzLmMKLS0tIGxpbnV4Lm9yaWcvYXJjaC9t
aXBzL3ZyNDE4MS90YW5iYWMtdGIwMTkzL2lkZS10YjAxOTMuYwlNb24gRmViIDE3IDIyOjQxOjQ3
IDIwMDMKKysrIGxpbnV4L2FyY2gvbWlwcy92cjQxODEvdGFuYmFjLXRiMDE5My9pZGUtdGIwMTkz
LmMJTW9uIEZlYiAxNyAxOTowNTozNyAyMDAzCkBAIC04MCwxMiArODAsMTIgQEAKIH0KIAogc3Ry
dWN0IGlkZV9vcHMgdGIwMTkzX2lkZV9vcHMgPSB7Ci0JJnRiMDE5M19pZGVfZGVmYXVsdF9pcnEs
Ci0JJnRiMDE5M19pZGVfZGVmYXVsdF9pb19iYXNlLAotCSZ0YjAxOTNfaWRlX2luaXRfaHdpZl9w
b3J0cywKLQkmdGIwMTkzX2lkZV9yZXF1ZXN0X2lycSwKLQkmdGIwMTkzX2lkZV9mcmVlX2lycSwK
LQkmdGIwMTkzX2lkZV9jaGVja19yZWdpb24sCi0JJnRiMDE5M19pZGVfcmVxdWVzdF9yZWdpb24s
Ci0JJnRiMDE5M19pZGVfcmVsZWFzZV9yZWdpb24KKwkuaWRlX2RlZmF1bHRfaXJxID0JdGIwMTkz
X2lkZV9kZWZhdWx0X2lycSwKKwkuaWRlX2RlZmF1bHRfaW9fYmFzZSA9CXRiMDE5M19pZGVfZGVm
YXVsdF9pb19iYXNlLAorCS5pZGVfaW5pdF9od2lmX3BvcnRzID0JdGIwMTkzX2lkZV9pbml0X2h3
aWZfcG9ydHMsCisJLmlkZV9yZXF1ZXN0X2lycSA9CXRiMDE5M19pZGVfcmVxdWVzdF9pcnEsCisJ
LmlkZV9mcmVlX2lycSA9CQl0YjAxOTNfaWRlX2ZyZWVfaXJxLAorCS5pZGVfY2hlY2tfcmVnaW9u
ID0JdGIwMTkzX2lkZV9jaGVja19yZWdpb24sCisJLmlkZV9yZXF1ZXN0X3JlZ2lvbiA9CXRiMDE5
M19pZGVfcmVxdWVzdF9yZWdpb24sCisJLmlkZV9yZWxlYXNlX3JlZ2lvbiA9CXRiMDE5M19pZGVf
cmVsZWFzZV9yZWdpb24KIH07Cg==

--Multipart_Mon__17_Feb_2003_23:13:43_+0900_0823f5f0--
