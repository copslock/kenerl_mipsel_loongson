Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Apr 2006 02:44:22 +0100 (BST)
Received: from test-iport-3.cisco.com ([171.71.176.78]:33390 "EHLO
	test-iport-3.cisco.com") by ftp.linux-mips.org with ESMTP
	id S8133642AbWDKBoN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 11 Apr 2006 02:44:13 +0100
Received: from sj-core-2.cisco.com ([171.71.177.254])
  by test-iport-3.cisco.com with ESMTP; 10 Apr 2006 18:55:51 -0700
Received: from xbh-sjc-211.amer.cisco.com (xbh-sjc-211.cisco.com [171.70.151.144])
	by sj-core-2.cisco.com (8.12.10/8.12.6) with ESMTP id k3B1toGv029388;
	Mon, 10 Apr 2006 18:55:51 -0700 (PDT)
Received: from xmb-sjc-215.amer.cisco.com ([171.70.151.169]) by xbh-sjc-211.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.211);
	 Mon, 10 Apr 2006 18:55:47 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Oprofile on sibyte 2.4.18 kernel
Date:	Mon, 10 Apr 2006 18:55:46 -0700
Message-ID: <5547014632ED654F971D7E1E0C2E0C3E018DB5D0@xmb-sjc-215.amer.cisco.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Oprofile on sibyte 2.4.18 kernel
Thread-Index: AcZamdRoKUMjWTsKT5ersblLdXL9owCa8JOQ
From:	"Shanthi Kiran Pendyala \(skiranp\)" <skiranp@cisco.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	"linux-mips" <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 11 Apr 2006 01:55:47.0356 (UTC) FILETIME=[0D2AA5C0:01C65D0B]
Return-Path: <skiranp@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skiranp@cisco.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

Thanks for the reply.

>Correct.  So if at all you would have to rip oprofile from the 
>2.6 kernel and bolt that code back into the old kernel which 
>would seem doable.  The MIPS bits certainly don't rely on much 
>2.6 infrastructure.

#1: I looked at oprofile-0.9.1 and it lists this event for SB1 in the
events/mips/sb1 directory
------------------------------------------------------------------------
---
event:10 counters:1,2,3 um:zero minimum:500
name:DCACHE_FILLED_SHD_NONC_EXC :Dcache is filled (shared, nonc,
exclusive)
----------------------------------------------------------------

However this doesn't have an equivalent performance source
Listed in the sibyte manual (table 33 system performance counter
sources). 


#2: how does the mapping from event numbers to performance sources work
for sibyte ?

I looked at the op_model_mipsxx.c file in the 2.6 CVS tree and the macro
it uses doesn't seem to match the
format specified for perf_cnt_cfg register in sibyte. 

What am I missing ? 

Thx
Kiran 
