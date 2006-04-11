Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Apr 2006 23:57:55 +0100 (BST)
Received: from sj-iport-4.cisco.com ([171.68.10.86]:30590 "EHLO
	sj-iport-4.cisco.com") by ftp.linux-mips.org with ESMTP
	id S8133580AbWDKW5q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 11 Apr 2006 23:57:46 +0100
Received: from sj-core-4.cisco.com ([171.68.223.138])
  by sj-iport-4.cisco.com with ESMTP; 11 Apr 2006 16:09:30 -0700
X-IronPort-AV: i="4.04,113,1144047600"; 
   d="scan'208"; a="1794034317:sNHT30742856"
Received: from xbh-sjc-211.amer.cisco.com (xbh-sjc-211.cisco.com [171.70.151.144])
	by sj-core-4.cisco.com (8.12.10/8.12.6) with ESMTP id k3BN9RYq004906;
	Tue, 11 Apr 2006 16:09:30 -0700 (PDT)
Received: from xmb-sjc-215.amer.cisco.com ([171.70.151.169]) by xbh-sjc-211.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.211);
	 Tue, 11 Apr 2006 16:09:29 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Oprofile on sibyte 2.4.18 kernel
Date:	Tue, 11 Apr 2006 16:09:28 -0700
Message-ID: <5547014632ED654F971D7E1E0C2E0C3E0194AD2D@xmb-sjc-215.amer.cisco.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Oprofile on sibyte 2.4.18 kernel
Thread-Index: AcZamdRoKUMjWTsKT5ersblLdXL9owCa8JOQACmOKlAAA+V1oA==
From:	"Shanthi Kiran Pendyala \(skiranp\)" <skiranp@cisco.com>
To:	"Mark E Mason" <mark.e.mason@broadcom.com>
Cc:	"linux-mips" <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 11 Apr 2006 23:09:29.0241 (UTC) FILETIME=[FC28E090:01C65DBC]
Return-Path: <skiranp@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skiranp@cisco.com
Precedence: bulk
X-list: linux-mips

Hi Mark,

Thx for the info.

The doc I have has the title 1250_1125-UM100-RDS.pdf. I went back to
docsafe
And looked for the sb1-um100-rds.pdf doc that you mention. 

I thought sb1 is the core and if two of these cores are present it is
labelled 1250 and
If only one is present it is marketed as 1125 ? Is my understanding
wrong ?

Let me look at this document and see if it answers my questions.

Also, yes I was looking at 2.6 git tree, not the CVS tree as I said
below.. Sorry about
That.

Shanthi kiran 

>-----Original Message-----
>From: Mark E Mason [mailto:mark.e.mason@broadcom.com] 
>Sent: Tuesday, April 11, 2006 2:42 PM
>To: Shanthi Kiran Pendyala (skiranp); Ralf Baechle
>Cc: linux-mips
>Subject: RE: Oprofile on sibyte 2.4.18 kernel
>
>Hello,
>
>FYI: don't use the oprofile tools tarball - use the latest 
>from the CVS site on sourceforge.  The last tarball on the 
>website is more than a bit out of date.
>
>I'll follow up on your other questions in a separate email (in 
>a little while....).
>
>/Mark
>
>> 
>> #1: I looked at oprofile-0.9.1 and it lists this event for SB1 in the
>> events/mips/sb1 directory
>> --------------------------------------------------------------
>> ----------
>> ---
>> event:10 counters:1,2,3 um:zero minimum:500 
>> name:DCACHE_FILLED_SHD_NONC_EXC :Dcache is filled (shared, nonc,
>> exclusive)
>> ----------------------------------------------------------------
>> 
>> However this doesn't have an equivalent performance source Listed in 
>> the sibyte manual (table 33 system performance counter sources).
>
>Are you looking in Sb1-UM100-RDS.pdf?  This is in table 95 in 
>my copy, on page 96/97 (section 11).  Also note that the table 
>isn't in order -- event #10 appears on the top of the 2nd 
>page.  It's logical grouping, not numeric.
>
>> #2: how does the mapping from event numbers to performance sources 
>> work for sibyte ?
>> 
>> I looked at the op_model_mipsxx.c file in the 2.6 CVS tree and the 
>> macro it uses doesn't seem to match the format specified for 
>> perf_cnt_cfg register in sibyte.
>
>Are you using the kernel from CVS instead of git?  The SB1 
>oprofile support didn't turn up in the kernel until sometime 
>mid-January, and is only available through the git version 
>(the CVS version of the kernel is long out of date).
>
>HTH,
>Mark
>
