Received:  by oss.sgi.com id <S305157AbQDTKgI>;
	Thu, 20 Apr 2000 03:36:08 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:34581 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305154AbQDTKfx>; Thu, 20 Apr 2000 03:35:53 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id DAA07171; Thu, 20 Apr 2000 03:39:55 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id DAA14170; Thu, 20 Apr 2000 03:35:22 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA59141
	for linux-list;
	Thu, 20 Apr 2000 03:21:36 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA45503
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 20 Apr 2000 03:21:34 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA01539
	for <linux@cthulhu.engr.sgi.com>; Thu, 20 Apr 2000 03:21:33 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id A44B687D; Thu, 20 Apr 2000 12:21:31 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id EA2188FC4; Thu, 20 Apr 2000 12:16:10 +0200 (CEST)
Date:   Thu, 20 Apr 2000 12:16:10 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Hiroyuki Machida <machida@sm.sony.co.jp>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: MIPS gas problem
Message-ID: <20000420121610.B1247@paradigm.rfc822.org>
References: <20000420111320Z.machida@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20000420111320Z.machida@sm.sony.co.jp>; from Hiroyuki Machida on Thu, Apr 20, 2000 at 11:13:20AM +0900
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, Apr 20, 2000 at 11:13:20AM +0900, Hiroyuki Machida wrote:
> 
> I found the problem  "__attribute__ ((aligned(xx))" doesn't work
> properly on MIPS/Linux. Please try to execute the attached test. 
> I think this problem can be reproduced on any ELF/MIPS box except
> EMBEDED system which has OS name "elf". 
> 
> I tracked down and finaly found gas/config/t-mips.c:s_change_sec(sec) 
> sets  always ".rodata" section-alignment to 2**4. This should be set 
> to the maximum rodata object's alignment value.

Hmm,
if i understand that correctly i am seeing a different behaviour:
(egcs 1.0.3a + binutils 2.8.1)

[flo@repeat flo]$ gcc -save-temps -o rotest rotest.c
rotest.c:8: warning: alignment of `global1' is greater than maximum object file alignment
rotest.c:9: warning: alignment of `global2' is greater than maximum object file alignment
rotest.c:11: warning: alignment of `local1' is greater than maximum object file alignment
rotest.c:12: warning: alignment of `local2' is greater than maximum object file alignment

And i see only a max alignment 3 in the rotest.s, and as expected
the test fails:

[flo@repeat flo]$ ./rotest 
* readonly local/gloabl
chcking align:400
err:4007a8 expected:400400
err:400798 expected:400400
4007a8:400798
chcking align:1000
err:400798 expected:400000
err:4007a0 expected:400000
400798:4007a0

NG:4

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
