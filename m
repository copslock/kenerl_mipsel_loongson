Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2003 17:59:26 +0100 (BST)
Received: from [IPv6:::ffff:207.16.149.110] ([IPv6:::ffff:207.16.149.110]:57308
	"EHLO mail.teralogic.tv") by linux-mips.org with ESMTP
	id <S8225202AbTDNQ7Z>; Mon, 14 Apr 2003 17:59:25 +0100
Received: from tlexmail.teralogic.tv (tlexmail [192.168.100.138])
	by mail.teralogic.tv (8.11.6/8.11.6) with ESMTP id h3EGu4O18476;
	Mon, 14 Apr 2003 09:56:04 -0700 (PDT)
Received: by TLEXMAIL with Internet Mail Service (5.5.2653.19)
	id <22AC354Y>; Mon, 14 Apr 2003 09:52:54 -0700
Message-ID: <56BEF0DBC8B9D611BFDB00508B5E2634102F07@TLEXMAIL>
From: Dennis Castleman <DennisCastleman@oaktech.com>
To: "'Ralf Baechle'" <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc: Gus Fernandez <GusFernandez@oaktech.com>
Subject: Soft floating point on 5K
Date: Mon, 14 Apr 2003 09:52:53 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C302A6.4AA10880"
Return-Path: <DennisCastleman@oaktech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2036
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: DennisCastleman@oaktech.com
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C302A6.4AA10880
Content-Type: text/plain;
	charset="ISO-8859-1"

ALL  

I'm trying to run soft-floating point functions on a r5000 core with a FPU. 
Without having to take the overhead of using a trap.  Using the files
fp-bit.c and dp-bit.c 
from the gcc source as a floating point lib.  This implementation lack in
accuracy in 
the least signeficant bit multiplication in division operations. 

Using the floating point validation test from UCB(ucbtest), which validates 
single and double precision operations for addition, subtraction, division 
and multiplication. This test tests all difficult cases and edge conditions 
(like combination of infinities, Nan etc.). 

Here is the result with our soft-float library:- 
Single precision Addition: Passed all 344 tests. 
Single precision Subtraction: Passed all 316 tests 
Single precision multiplication: Total: 334 Passed:313 Failed: 21 
Single precision division: Total: 379 Passed: 375 Failed: 4 
Double precision Addition: Passed all 352 tests. 
Double precision Subtraction: Passed all 321 tests 
Double precision multiplication: Total: 340 Passed: 319 Failed: 21 
Double precision division: Total: 383 Passed: 379 Failed: 4 

However, in all the failed cases there is only 1 bit different in the
mantissa. 
Essentially for some cases, it's less accurate by the minimum distance. 


Any ideas in how to make this work or improve soft-floating point on a mips
5Kc?


Value error: divd n eq xu
	Input:    000FFFFF FFFFFFFE 3FEFFFFF FFFFFFFE
	Computed: 000FFFFF FFFFFFFE 
	Expected: 000FFFFF FFFFFFFF xu
Value error: divd n eq xu
	Input:    000FFFFF FFFFFFF7 3FEFFFFF FFFFFFFE
	Computed: 000FFFFF FFFFFFF7 
	Expected: 000FFFFF FFFFFFF8 xu
Value error: divd n eq xu
	Input:    800FFFFF FFFFFFF8 3FEFFFFF FFFFFFFE
	Computed: 800FFFFF FFFFFFF8 
	Expected: 800FFFFF FFFFFFF9 xu
Value error: divd n eq xu
	Input:    001FFFFF FFFFFFFF 40000000 00000000
	Computed: 000FFFFF FFFFFFFF 
	Expected: 00100000 00000000 xu
Total  383 tests:  pass  379,  flags err    0,  value err   4,     divd
 ucbtest UCBFAIL in divd at line 701 for double 


Value error: divs n eq xu
	Input:    007FFFFE 3F7FFFFE
	Computed: 007FFFFE 
	Expected: 007FFFFF xu
Value error: divs n eq xu
	Input:    007FFFF7 3F7FFFFE
	Computed: 007FFFF7 
	Expected: 007FFFF8 xu
Value error: divs n eq xu
	Input:    807FFFF8 3F7FFFFE
	Computed: 807FFFF8 
	Expected: 807FFFF9 xu
Value error: divs n eq xu
	Input:    00FFFFFF 40000000
	Computed: 007FFFFF 
	Expected: 00800000 xu
Total  379 tests:  pass  375,  flags err    0,  value err   4,     divs
 ucbtest UCBFAIL in divs at line 701 for float 

Value error: muld n eq x?u
	Input:    000FFFFF FFFFFFF8 3FF00000 00000008
	Computed: 000FFFFF FFFFFFFF 
	Expected: 00100000 00000000 x?u
Value error: muld n eq x?u
	Input:    000FFFFF FFFFFFF8 BFF00000 00000008
	Computed: 800FFFFF FFFFFFFF 
	Expected: 80100000 00000000 x?u
Value error: muld n eq x?u
	Input:    000FFFFF FFFFFFFF 3FF00000 00000001
	Computed: 000FFFFF FFFFFFFF 
	Expected: 00100000 00000000 x?u
Value error: muld n eq x?u
	Input:    00100000 00000001 3FEFFFFF FFFFFFFE
	Computed: 000FFFFF FFFFFFFF 
	Expected: 00100000 00000000 x?u
Value error: muld n eq x?u
	Input:    00100000 00000002 3FEFFFFF FFFFFFFC
	Computed: 000FFFFF FFFFFFFF 
	Expected: 00100000 00000000 x?u
Value error: muld n eq x?u
	Input:    20000000 02000000 1FFFFFFF FC000000
	Computed: 00000000 00000000 
	Expected: 00100000 00000000 x?u
Value error: muld n eq x?u
	Input:    800FFFFF FFFFFFFF 3FF00000 00000001
	Computed: 800FFFFF FFFFFFFF 
	Expected: 80100000 00000000 x?u
Value error: muld n eq xu
	Input:    00000000 00000001 3FEFFFFF FFFFFFFF
	Computed: 00000000 00000000 
	Expected: 00000000 00000001 xu
Value error: muld n eq xu
	Input:    00000000 00000001 BFEFFFFF FFFFFFFF
	Computed: 80000000 00000000 
	Expected: 80000000 00000001 xu
Value error: muld n eq xu
	Input:    000FFFFF FFFFFFF8 3FF00000 00000001
	Computed: 000FFFFF FFFFFFF8 
	Expected: 000FFFFF FFFFFFF9 xu
Value error: muld n eq xu
	Input:    000FFFFF FFFFFFF8 BFF00000 00000001
	Computed: 800FFFFF FFFFFFF8 
	Expected: 800FFFFF FFFFFFF9 xu
Value error: muld n eq xu
	Input:    000FFFFF FFFFFFFE 3FF00000 00000001
	Computed: 000FFFFF FFFFFFFE 
	Expected: 000FFFFF FFFFFFFF xu
Value error: muld n eq xu
	Input:    000FFFFF FFFFFFFE BFF00000 00000001
	Computed: 800FFFFF FFFFFFFE 
	Expected: 800FFFFF FFFFFFFF xu
Value error: muld n eq xu
	Input:    00100000 00000001 3FEFFFFF FFFFFFFA
	Computed: 000FFFFF FFFFFFFD 
	Expected: 000FFFFF FFFFFFFE xu
Value error: muld n eq xu
	Input:    001FFFFF FFFFFFFF 3FE00000 00000000
	Computed: 000FFFFF FFFFFFFF 
	Expected: 00100000 00000000 xu
Value error: muld n eq xu
	Input:    001FFFFF FFFFFFFF BFE00000 00000000
	Computed: 800FFFFF FFFFFFFF 
	Expected: 80100000 00000000 xu
Value error: muld n eq xu
	Input:    800FFFFF FFFFFFF7 3FF00000 00000001
	Computed: 800FFFFF FFFFFFF7 
	Expected: 800FFFFF FFFFFFF8 xu
Value error: muld n eq xu
	Input:    BFE00000 00000001 00000000 00000001
	Computed: 80000000 00000000 
	Expected: 80000000 00000001 xu
Value error: muld n eq xu
	Input:    BFF80000 00000000 80000000 00000001
	Computed: 00000000 00000001 
	Expected: 00000000 00000002 xu
Value error: muld n eq xu
	Input:    C0040000 00000001 00000000 00000001
	Computed: 80000000 00000002 
	Expected: 80000000 00000003 xu
Value error: muld n eq xu
	Input:    C00C0000 00000000 80000000 00000001
	Computed: 00000000 00000003 
	Expected: 00000000 00000004 xu
Total  340 tests:  pass  319,  flags err    0,  value err  21,     muld
 ucbtest UCBFAIL in muld at line 701 for double 
  

 

Dennis Castleman
Manager Systems Software Engineering 
TeraLogic Group, Inc. a division of Oak Technologies Inc. 
1-408-523-4214
_______________________________________________________________________ 
CONFIDENTIALITY NOTICE: The information contained in this message and any
attachment(s) is confidential and may be legally privileged. The message is
intended solely for the addressee(s). If you are not the intended recipient,
you are hereby notified that any use, dissemination, or reproduction is
strictly prohibited and may be unlawful. If you are not the intended
recipient, please contact the sender by return e-mail and destroy all copies
of the original message and any associated attachments. If you are the
intended recipient - this is official notification that this email or it's
attachments are confidential and covered by the agreements between the
companies.
Thank-you.__________________________________________________________________
___ 



------_=_NextPart_001_01C302A6.4AA10880
Content-Type: text/html;
	charset="ISO-8859-1"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META NAME="Generator" CONTENT="MS Exchange Server version 5.5.2653.12">
<TITLE>Soft floating point on 5K</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=2>ALL&nbsp; </FONT>
</P>

<P><FONT SIZE=2>I'm trying to run soft-floating point functions on a r5000 core with a FPU. </FONT>
<BR><FONT SIZE=2>Without having to take the overhead of using a trap.&nbsp; Using the files fp-bit.c and dp-bit.c </FONT>
<BR><FONT SIZE=2>from the gcc source as a floating point lib.&nbsp; This implementation lack in accuracy in </FONT>
<BR><FONT SIZE=2>the least signeficant bit multiplication in division operations. </FONT>
</P>

<P><FONT SIZE=2>Using the floating point validation test from UCB(ucbtest), which validates </FONT>
<BR><FONT SIZE=2>single and double precision operations for addition, subtraction, division </FONT>
<BR><FONT SIZE=2>and multiplication. This test tests all difficult cases and edge conditions </FONT>
<BR><FONT SIZE=2>(like combination of infinities, Nan etc.). </FONT>
</P>

<P><FONT SIZE=2>Here is the result with our soft-float library:- </FONT>
<BR><FONT SIZE=2>Single precision Addition: Passed all 344 tests. </FONT>
<BR><FONT SIZE=2>Single precision Subtraction: Passed all 316 tests </FONT>
<BR><FONT SIZE=2>Single precision multiplication: Total: 334 Passed:313 Failed: 21 </FONT>
<BR><FONT SIZE=2>Single precision division: Total: 379 Passed: 375 Failed: 4 </FONT>
<BR><FONT SIZE=2>Double precision Addition: Passed all 352 tests. </FONT>
<BR><FONT SIZE=2>Double precision Subtraction: Passed all 321 tests </FONT>
<BR><FONT SIZE=2>Double precision multiplication: Total: 340 Passed: 319 Failed: 21 </FONT>
<BR><FONT SIZE=2>Double precision division: Total: 383 Passed: 379 Failed: 4 </FONT>
</P>

<P><FONT SIZE=2>However, in all the failed cases there is only 1 bit different in the mantissa. </FONT>
<BR><FONT SIZE=2>Essentially for some cases, it's less accurate by the minimum distance. </FONT>
</P>
<BR>

<P><FONT SIZE=2>Any ideas in how to make this work or improve soft-floating point on a mips 5Kc?</FONT>
</P>
<BR>

<P><FONT SIZE=2>Value error: divd n eq xu</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Input:&nbsp;&nbsp;&nbsp; 000FFFFF FFFFFFFE 3FEFFFFF FFFFFFFE</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Computed: 000FFFFF FFFFFFFE </FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Expected: 000FFFFF FFFFFFFF xu</FONT>
<BR><FONT SIZE=2>Value error: divd n eq xu</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Input:&nbsp;&nbsp;&nbsp; 000FFFFF FFFFFFF7 3FEFFFFF FFFFFFFE</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Computed: 000FFFFF FFFFFFF7 </FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Expected: 000FFFFF FFFFFFF8 xu</FONT>
<BR><FONT SIZE=2>Value error: divd n eq xu</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Input:&nbsp;&nbsp;&nbsp; 800FFFFF FFFFFFF8 3FEFFFFF FFFFFFFE</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Computed: 800FFFFF FFFFFFF8 </FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Expected: 800FFFFF FFFFFFF9 xu</FONT>
<BR><FONT SIZE=2>Value error: divd n eq xu</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Input:&nbsp;&nbsp;&nbsp; 001FFFFF FFFFFFFF 40000000 00000000</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Computed: 000FFFFF FFFFFFFF </FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Expected: 00100000 00000000 xu</FONT>
<BR><FONT SIZE=2>Total&nbsp; 383 tests:&nbsp; pass&nbsp; 379,&nbsp; flags err&nbsp;&nbsp;&nbsp; 0,&nbsp; value err&nbsp;&nbsp; 4,&nbsp;&nbsp;&nbsp;&nbsp; divd</FONT>
<BR><FONT SIZE=2>&nbsp;ucbtest UCBFAIL in divd at line 701 for double </FONT>
</P>
<BR>

<P><FONT SIZE=2>Value error: divs n eq xu</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Input:&nbsp;&nbsp;&nbsp; 007FFFFE 3F7FFFFE</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Computed: 007FFFFE </FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Expected: 007FFFFF xu</FONT>
<BR><FONT SIZE=2>Value error: divs n eq xu</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Input:&nbsp;&nbsp;&nbsp; 007FFFF7 3F7FFFFE</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Computed: 007FFFF7 </FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Expected: 007FFFF8 xu</FONT>
<BR><FONT SIZE=2>Value error: divs n eq xu</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Input:&nbsp;&nbsp;&nbsp; 807FFFF8 3F7FFFFE</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Computed: 807FFFF8 </FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Expected: 807FFFF9 xu</FONT>
<BR><FONT SIZE=2>Value error: divs n eq xu</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Input:&nbsp;&nbsp;&nbsp; 00FFFFFF 40000000</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Computed: 007FFFFF </FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Expected: 00800000 xu</FONT>
<BR><FONT SIZE=2>Total&nbsp; 379 tests:&nbsp; pass&nbsp; 375,&nbsp; flags err&nbsp;&nbsp;&nbsp; 0,&nbsp; value err&nbsp;&nbsp; 4,&nbsp;&nbsp;&nbsp;&nbsp; divs</FONT>
<BR><FONT SIZE=2>&nbsp;ucbtest UCBFAIL in divs at line 701 for float </FONT>
</P>

<P><FONT SIZE=2>Value error: muld n eq x?u</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Input:&nbsp;&nbsp;&nbsp; 000FFFFF FFFFFFF8 3FF00000 00000008</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Computed: 000FFFFF FFFFFFFF </FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Expected: 00100000 00000000 x?u</FONT>
<BR><FONT SIZE=2>Value error: muld n eq x?u</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Input:&nbsp;&nbsp;&nbsp; 000FFFFF FFFFFFF8 BFF00000 00000008</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Computed: 800FFFFF FFFFFFFF </FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Expected: 80100000 00000000 x?u</FONT>
<BR><FONT SIZE=2>Value error: muld n eq x?u</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Input:&nbsp;&nbsp;&nbsp; 000FFFFF FFFFFFFF 3FF00000 00000001</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Computed: 000FFFFF FFFFFFFF </FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Expected: 00100000 00000000 x?u</FONT>
<BR><FONT SIZE=2>Value error: muld n eq x?u</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Input:&nbsp;&nbsp;&nbsp; 00100000 00000001 3FEFFFFF FFFFFFFE</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Computed: 000FFFFF FFFFFFFF </FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Expected: 00100000 00000000 x?u</FONT>
<BR><FONT SIZE=2>Value error: muld n eq x?u</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Input:&nbsp;&nbsp;&nbsp; 00100000 00000002 3FEFFFFF FFFFFFFC</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Computed: 000FFFFF FFFFFFFF </FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Expected: 00100000 00000000 x?u</FONT>
<BR><FONT SIZE=2>Value error: muld n eq x?u</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Input:&nbsp;&nbsp;&nbsp; 20000000 02000000 1FFFFFFF FC000000</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Computed: 00000000 00000000 </FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Expected: 00100000 00000000 x?u</FONT>
<BR><FONT SIZE=2>Value error: muld n eq x?u</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Input:&nbsp;&nbsp;&nbsp; 800FFFFF FFFFFFFF 3FF00000 00000001</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Computed: 800FFFFF FFFFFFFF </FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Expected: 80100000 00000000 x?u</FONT>
<BR><FONT SIZE=2>Value error: muld n eq xu</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Input:&nbsp;&nbsp;&nbsp; 00000000 00000001 3FEFFFFF FFFFFFFF</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Computed: 00000000 00000000 </FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Expected: 00000000 00000001 xu</FONT>
<BR><FONT SIZE=2>Value error: muld n eq xu</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Input:&nbsp;&nbsp;&nbsp; 00000000 00000001 BFEFFFFF FFFFFFFF</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Computed: 80000000 00000000 </FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Expected: 80000000 00000001 xu</FONT>
<BR><FONT SIZE=2>Value error: muld n eq xu</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Input:&nbsp;&nbsp;&nbsp; 000FFFFF FFFFFFF8 3FF00000 00000001</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Computed: 000FFFFF FFFFFFF8 </FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Expected: 000FFFFF FFFFFFF9 xu</FONT>
<BR><FONT SIZE=2>Value error: muld n eq xu</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Input:&nbsp;&nbsp;&nbsp; 000FFFFF FFFFFFF8 BFF00000 00000001</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Computed: 800FFFFF FFFFFFF8 </FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Expected: 800FFFFF FFFFFFF9 xu</FONT>
<BR><FONT SIZE=2>Value error: muld n eq xu</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Input:&nbsp;&nbsp;&nbsp; 000FFFFF FFFFFFFE 3FF00000 00000001</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Computed: 000FFFFF FFFFFFFE </FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Expected: 000FFFFF FFFFFFFF xu</FONT>
<BR><FONT SIZE=2>Value error: muld n eq xu</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Input:&nbsp;&nbsp;&nbsp; 000FFFFF FFFFFFFE BFF00000 00000001</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Computed: 800FFFFF FFFFFFFE </FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Expected: 800FFFFF FFFFFFFF xu</FONT>
<BR><FONT SIZE=2>Value error: muld n eq xu</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Input:&nbsp;&nbsp;&nbsp; 00100000 00000001 3FEFFFFF FFFFFFFA</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Computed: 000FFFFF FFFFFFFD </FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Expected: 000FFFFF FFFFFFFE xu</FONT>
<BR><FONT SIZE=2>Value error: muld n eq xu</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Input:&nbsp;&nbsp;&nbsp; 001FFFFF FFFFFFFF 3FE00000 00000000</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Computed: 000FFFFF FFFFFFFF </FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Expected: 00100000 00000000 xu</FONT>
<BR><FONT SIZE=2>Value error: muld n eq xu</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Input:&nbsp;&nbsp;&nbsp; 001FFFFF FFFFFFFF BFE00000 00000000</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Computed: 800FFFFF FFFFFFFF </FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Expected: 80100000 00000000 xu</FONT>
<BR><FONT SIZE=2>Value error: muld n eq xu</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Input:&nbsp;&nbsp;&nbsp; 800FFFFF FFFFFFF7 3FF00000 00000001</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Computed: 800FFFFF FFFFFFF7 </FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Expected: 800FFFFF FFFFFFF8 xu</FONT>
<BR><FONT SIZE=2>Value error: muld n eq xu</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Input:&nbsp;&nbsp;&nbsp; BFE00000 00000001 00000000 00000001</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Computed: 80000000 00000000 </FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Expected: 80000000 00000001 xu</FONT>
<BR><FONT SIZE=2>Value error: muld n eq xu</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Input:&nbsp;&nbsp;&nbsp; BFF80000 00000000 80000000 00000001</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Computed: 00000000 00000001 </FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Expected: 00000000 00000002 xu</FONT>
<BR><FONT SIZE=2>Value error: muld n eq xu</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Input:&nbsp;&nbsp;&nbsp; C0040000 00000001 00000000 00000001</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Computed: 80000000 00000002 </FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Expected: 80000000 00000003 xu</FONT>
<BR><FONT SIZE=2>Value error: muld n eq xu</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Input:&nbsp;&nbsp;&nbsp; C00C0000 00000000 80000000 00000001</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Computed: 00000000 00000003 </FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=2>Expected: 00000000 00000004 xu</FONT>
<BR><FONT SIZE=2>Total&nbsp; 340 tests:&nbsp; pass&nbsp; 319,&nbsp; flags err&nbsp;&nbsp;&nbsp; 0,&nbsp; value err&nbsp; 21,&nbsp;&nbsp;&nbsp;&nbsp; muld</FONT>
<BR><FONT SIZE=2>&nbsp;ucbtest UCBFAIL in muld at line 701 for double </FONT>
<BR><FONT SIZE=2>&nbsp; </FONT>
</P>

<P><FONT SIZE=2>&nbsp;</FONT>
</P>

<P><FONT SIZE=2>Dennis Castleman</FONT>
<BR><FONT SIZE=2>Manager Systems Software Engineering </FONT>
<BR><FONT SIZE=2>TeraLogic Group, Inc. a division of Oak Technologies Inc. </FONT>
<BR><FONT SIZE=2>1-408-523-4214</FONT>
<BR><FONT SIZE=2>_______________________________________________________________________ </FONT>
<BR><FONT SIZE=2>CONFIDENTIALITY NOTICE: The information contained in this message and any attachment(s) is confidential and may be legally privileged. The message is intended solely for the addressee(s). If you are not the intended recipient, you are hereby notified that any use, dissemination, or reproduction is strictly prohibited and may be unlawful. If you are not the intended recipient, please contact the sender by return e-mail and destroy all copies of the original message and any associated attachments. If you are the intended recipient - this is official notification that this email or it's attachments are confidential and covered by the agreements between the companies. Thank-you._____________________________________________________________________ </FONT></P>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C302A6.4AA10880--
