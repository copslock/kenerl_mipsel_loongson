Received:  by oss.sgi.com id <S305185AbQDXDbO>;
	Sun, 23 Apr 2000 20:31:14 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:59502 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305161AbQDXDay>; Sun, 23 Apr 2000 20:30:54 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id UAA01164; Sun, 23 Apr 2000 20:35:00 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA83420
	for linux-list;
	Sun, 23 Apr 2000 20:17:32 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA03570
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 23 Apr 2000 20:17:31 -0700 (PDT)
	mail_from (machida@sm.sony.co.jp)
Received: from ns4.sony.co.jp (ns4.Sony.CO.JP [202.238.80.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id UAA07255
	for <linux@cthulhu.engr.sgi.com>; Sun, 23 Apr 2000 20:17:25 -0700 (PDT)
	mail_from (machida@sm.sony.co.jp)
Received: from mail3.sony.co.jp (gatekeeper7.Sony.CO.JP [202.238.80.21])
	by ns4.sony.co.jp (04/18/00) with ESMTP id MAA47600;
	Mon, 24 Apr 2000 12:17:23 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
	by mail3.sony.co.jp (3.7W99051310c) with ESMTP id MAA24951;
	Mon, 24 Apr 2000 12:17:23 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.27.209.5]) by smail1.sm.sony.co.jp (8.8.8/3.6W) with ESMTP id MAA29716; Mon, 24 Apr 2000 12:16:39 +0900 (JST)
Received: from mach0.sm.sony.co.jp (mach0.sm.sony.co.jp [43.27.210.135]) by imail.sm.sony.co.jp (8.8.8/3.7W) with ESMTP id MAA00528; Mon, 24 Apr 2000 12:16:52 +0900 (JST)
Received: from localhost by mach0.sm.sony.co.jp (8.8.8/FreeBSD) with ESMTP id MAA04425; Mon, 24 Apr 2000 12:16:52 +0900 (JST)
xTo:    binutils@sourceware.cygnus.com
Cc:     linux@cthulhu.engr.sgi.com, debian-mips@lists.debian.org
Subject: Re: MIPS gas problem
In-Reply-To: <20000421154859.3820.qmail@daffy.airs.com>
References: <20000420164812.17210.qmail@daffy.airs.com>
	<20000421123014J.machida@sm.sony.co.jp>
	<20000421154859.3820.qmail@daffy.airs.com>
X-Mailer: Mew version 1.94.1 on Emacs 19.34 / Mule 2.3 (SUETSUMUHANA)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20000424121651S.machida@sm.sony.co.jp>
Date:   Mon, 24 Apr 2000 12:16:51 +0900
From:   Hiroyuki Machida <machida@sm.sony.co.jp>
X-Dispatcher: imput version 990905(IM130)
To:     unlisted-recipients:; (no To-header on input)
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Thank you Ian and Alan.

From: Ian Lance Taylor <ian@zembu.com>
Subject: Re: MIPS gas problem
Date: 21 Apr 2000 08:48:59 -0700

>    Date: Fri, 21 Apr 2000 12:30:14 +0900
>    From: Hiroyuki Machida <machida@sm.sony.co.jp>
> 
>    This message is a gcc issue, as you said. 
> 
>    But, my reported plobelm is really binutils issue.
> 
> I know.  I didn't mean to imply otherwise.  Alan Modra's suggested
> patch was the right one.
> 
> Ian

I summarize the problem and attach patch. Please install it, if you
can. I don't know what procedure is required to install the patch to
CVS tree. 

*Problem Description:
Current tc-mips.c:s_change_sec() always sets '.rdata' and '.sdata'
section alignments to 2**4, even if those contain over 2**4 aligned 
objects.


*Solution:
Tc-mips.c:s_change_sec() should use record_alignment(), not
bfd_set_section_alignment(), for preventing  reset section
alignments.


*Patch:

2000-04-24	Machida Hiroyuki <machida@sm.sony.co.jp>

tc-mips.c (s_change_sec): Use record_alignment(), not 
  bfd_set_section_alignment() to preserve section aligenments. 


--- tc-mips.c.ORG	Mon Apr 24 11:22:39 2000
+++ tc-mips.c	Mon Apr 24 11:24:48 2000
@@ -10045,7 +10045,7 @@ s_change_sec (sec)
 				      | SEC_RELOC
 				      | SEC_DATA));
 	      if (strcmp (TARGET_OS, "elf") != 0)
-		bfd_set_section_alignment (stdoutput, seg, 4);
+		record_alignment (stdoutput, seg, 4);
 	    }
 	  demand_empty_rest_of_line ();
 	}
@@ -10067,7 +10067,7 @@ s_change_sec (sec)
 				     SEC_ALLOC | SEC_LOAD | SEC_RELOC
 				     | SEC_DATA);
 	      if (strcmp (TARGET_OS, "elf") != 0)
-		bfd_set_section_alignment (stdoutput, seg, 4);
+		record_alignment (stdoutput, seg, 4);
 	    }
 	  demand_empty_rest_of_line ();
 	  break;
