Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Mar 2003 00:23:32 +0000 (GMT)
Received: from real.realitydiluted.com ([IPv6:::ffff:208.242.241.164]:40932
	"EHLO real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225253AbTCDAXb>; Tue, 4 Mar 2003 00:23:31 +0000
Received: from localhost ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.36 #1 (Debian))
	id 18q0DS-0000gE-00; Mon, 03 Mar 2003 18:23:30 -0600
Message-ID: <3E63EFDC.6090605@realitydiluted.com>
Date: Mon, 03 Mar 2003 18:14:20 -0600
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: "Steven J. Hill" <sjhill@realitydiluted.com>
CC: linux-mips@linux-mips.org
Subject: Re: Improper handling of unaligned user address access?
References: <3E63B17C.8000403@realitydiluted.com>
In-Reply-To: <3E63B17C.8000403@realitydiluted.com>
Content-Type: multipart/mixed;
 boundary="------------080509080807080001030003"
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1608
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------080509080807080001030003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The first thing I tried to fix this issue was to use the
'memcpy.S' file from 2.4.7 and that actually worked, but
that was a step backwards. It was much simpler to just
add a 'nop' after the offending branch instruction. It
fixes all of my problems with 'copy_from_user'. I have
already checked these into both the 2.4 and 2.5 trees.

I do have one further question. In 'arch/mips/mm/fault.c'
when we need to do a fixup:

    fixup = search_exception_table(regs->cp0_epc);

Why do we not check to see if the EPC is a branch insn
before looking in the exception table?

-Steve

--------------080509080807080001030003
Content-Type: text/plain;
 name="memcpy-2.4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="memcpy-2.4.diff"

Index: memcpy.S
===================================================================
RCS file: /home/cvs/linux/arch/mips/lib/memcpy.S,v
retrieving revision 1.6.2.4
diff -u -r1.6.2.4 memcpy.S
--- memcpy.S	19 Sep 2002 14:01:24 -0000	1.6.2.4
+++ memcpy.S	4 Mar 2003 00:09:52 -0000
@@ -357,6 +357,7 @@
 	beqz	len, done
 	 and	rem, len, NBYTES-1  # rem = len % NBYTES
 	beq	rem, len, copy_bytes
+	nop
 1:
 EXC(	 LDFIRST t0, FIRST(0)(src),	l_exc)
 EXC(	LDREST	t0, REST(0)(src),	l_exc_copy)

--------------080509080807080001030003
Content-Type: text/plain;
 name="memcpy-2.5.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="memcpy-2.5.diff"

Index: memcpy.S
===================================================================
RCS file: /home/cvs/linux/arch/mips/lib/memcpy.S,v
retrieving revision 1.11
diff -u -r1.11 memcpy.S
--- memcpy.S	19 Sep 2002 14:01:28 -0000	1.11
+++ memcpy.S	4 Mar 2003 00:10:58 -0000
@@ -357,6 +357,7 @@
 	beqz	len, done
 	 and	rem, len, NBYTES-1  # rem = len % NBYTES
 	beq	rem, len, copy_bytes
+	nop
 1:
 EXC(	 LDFIRST t0, FIRST(0)(src),	l_exc)
 EXC(	LDREST	t0, REST(0)(src),	l_exc_copy)

--------------080509080807080001030003--
