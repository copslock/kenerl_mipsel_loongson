Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3UI8wI19074
	for linux-mips-outgoing; Mon, 30 Apr 2001 11:08:58 -0700
Received: from pobox.sibyte.com (pobox.sibyte.com [208.12.96.20])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3UI8vM19071
	for <linux-mips@oss.sgi.com>; Mon, 30 Apr 2001 11:08:57 -0700
Received: from postal.sibyte.com (moat.sibyte.com [208.12.96.21])
	by pobox.sibyte.com (Postfix) with SMTP id 99590205FB
	for <linux-mips@oss.sgi.com>; Mon, 30 Apr 2001 11:08:51 -0700 (PDT)
Received: from SMTP agent by mail gateway 
 Mon, 30 Apr 2001 11:00:54 -0800
Received: from plugh.sibyte.com (plugh.sibyte.com [10.21.64.158])
	by postal.sibyte.com (Postfix) with ESMTP id 5F40615961
	for <linux-mips@oss.sgi.com>; Mon, 30 Apr 2001 11:08:52 -0700 (PDT)
Received: by plugh.sibyte.com (Postfix, from userid 61017)
	id 7FD22686D; Mon, 30 Apr 2001 11:08:41 -0700 (PDT)
From: Justin Carlson <carlson@sibyte.com>
Reply-To: carlson@sibyte.com
Organization: Sibyte
To: linux-mips@oss.sgi.com
Subject: mips64 linux glibc compilation broken?
Date: Mon, 30 Apr 2001 11:07:33 -0700
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <0104301108411I.31854@plugh.sibyte.com>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


I could swear I saw this topic go by before, but searching my archives,
I don't see it.

glibc fresh out of redhat cvs doesn't compile for mips64-linux; it fails
with quite a bit of stuff like this:

---
In file included from dynamic-link.h:21,
from dl-load.c:32:
../sysdeps/mips/mips64/dl-machine.h: In function `elf_machine_got_rel':
../sysdeps/mips/mips64/dl-machine.h:178: warning: passing arg 2 of `_dl_lookup_symbol' from incompatible pointer type
../sysdeps/mips/mips64/dl-machine.h:178: warning: passing arg 3 of `_dl_lookup_symbol' from incompatible pointer type
../sysdeps/mips/mips64/dl-machine.h:178: warning: passing arg 4 of `_dl_lookup_symbol' from incompatible pointer type
../sysdeps/mips/mips64/dl-machine.h:178: too few arguments to function `_dl_lookup_symbol'
../sysdeps/mips/mips64/dl-machine.h:181: warning: passing arg 2 of `_dl_lookup_symbol' from incompatible pointer type
../sysdeps/mips/mips64/dl-machine.h:181: warning: passing arg 3 of `_dl_lookup_symbol' from incompatible pointer type
../sysdeps/mips/mips64/dl-machine.h:181: warning: passing arg 4 of `_dl_lookup_symbol' from incompatible pointer type
---

It looks like this is something that has been fixed for mips, but not mips64. 
I'm sure I can fix the immediate compile problems, but am not familiar enough
with glibc to be confident of doing the Right Thing overall.

Are there any patches for mips64 linux that haven't made it into the mainline
cvs yet?

Thanks,
Justin
