Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f49Cc9k23069
	for linux-mips-outgoing; Wed, 9 May 2001 05:38:09 -0700
Received: from cvsftp.cotw.com (cvsftp.cotw.com [208.242.241.39])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f49CbrF23061;
	Wed, 9 May 2001 05:37:53 -0700
Received: from cotw.com (dhcp-050.inter.net [192.168.10.50])
	by cvsftp.cotw.com (8.9.3/8.9.3) with ESMTP id HAA25247;
	Wed, 9 May 2001 07:37:38 -0500
Message-ID: <3AF93D3F.5E57070@cotw.com>
Date: Wed, 09 May 2001 07:51:11 -0500
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre17-idepci i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Jaeger <aj@suse.de>
CC: Florian Lohoff <flo@rfc822.org>, Tom Appermont <tea@sonycom.com>,
   Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: Binary compatibility break understood ?
References: <20010505144708.A12575@paradigm.rfc822.org>
		<20010507163210.B2381@bacchus.dhis.org>
		<20010508202518.A13476@paradigm.rfc822.org>
		<20010508214313.A12528@bacchus.dhis.org>
		<20010509095955.A8392@sonycom.com>
		<20010509104635.D12267@paradigm.rfc822.org>
		<3AF934AE.38AB0089@cotw.com> <hoeltyemh0.fsf@gee.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Andreas Jaeger wrote:
> 
> Ok, I finally understand.  Can you send a new patch for glibc with an
> update for the FAQ?  I'll add it this time.
> 
diff -urN glibc-2.2.3/sysdeps/mips/rtld-ldscript.in glibc-2.2.3-patched/sysdeps/
mips/rtld-ldscript.in
--- glibc-2.2.3/sysdeps/mips/rtld-ldscript.in   Sat Jul 12 18:23:14 1997
+++ glibc-2.2.3-patched/sysdeps/mips/rtld-ldscript.in   Sun Apr 29 22:32:35 2001
@@ -1,4 +1,3 @@
-OUTPUT_FORMAT("@@rtld-oformat@@")
 OUTPUT_ARCH(@@rtld-arch@@)
 ENTRY(@@rtld-entry@@)
 SECTIONS


There's the patch. It's not much but it is correct. I have built multiple
toolchains and such using this patch. GCC out of CVS both the 3.0 and
cutting edge branch work without patches for Linux. And as mentioned
earlier, binutils is already fixed. As far as FAQ update...what do you
want?

-Steve

-- 
 Steven J. Hill - Embedded SW Engineer
 Public Key: 'http://www.cotw.com/pubkey.txt'
 FPR1: E124 6E1C AF8E 7802 A815
 FPR2: 7D72 829C 3386 4C4A E17D
