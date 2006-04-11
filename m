Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Apr 2006 22:30:49 +0100 (BST)
Received: from mms1.broadcom.com ([216.31.210.17]:8717 "EHLO mms1.broadcom.com")
	by ftp.linux-mips.org with ESMTP id S8133576AbWDKVad convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 11 Apr 2006 22:30:33 +0100
Received: from 10.10.64.154 by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Tue, 11 Apr 2006 14:42:08 -0700
X-Server-Uuid: F962EFE0-448C-40EE-8100-87DF498ED0EA
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 745402AF; Tue, 11 Apr 2006 14:42:08 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 471EE2AE; Tue, 11 Apr
 2006 14:42:08 -0700 (PDT)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5-GA) with ESMTP
 id DHC21575; Tue, 11 Apr 2006 14:42:07 -0700 (PDT)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 362B520501; Tue, 11 Apr 2006 14:42:07 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: Oprofile on sibyte 2.4.18 kernel
Date:	Tue, 11 Apr 2006 14:42:06 -0700
Message-ID: <7E000E7F06B05C49BDBB769ADAF44D07989B08@NT-SJCA-0750.brcm.ad.broadcom.com>
Thread-Topic: Oprofile on sibyte 2.4.18 kernel
Thread-Index: AcZamdRoKUMjWTsKT5ersblLdXL9owCa8JOQACmOKlA=
From:	"Mark E Mason" <mark.e.mason@broadcom.com>
To:	"Shanthi Kiran Pendyala (skiranp)" <skiranp@cisco.com>,
	"Ralf Baechle" <ralf@linux-mips.org>
cc:	"linux-mips" <linux-mips@linux-mips.org>
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006041107; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230372E34343343323138362E303036332D412D;
 ENG=IBF; TS=20060411214211; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006041107_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6822FD3A0HW6367332-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11086
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mark.e.mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello,

FYI: don't use the oprofile tools tarball - use the latest from the CVS
site on sourceforge.  The last tarball on the website is more than a bit
out of date.

I'll follow up on your other questions in a separate email (in a little
while....).

/Mark

> 
> #1: I looked at oprofile-0.9.1 and it lists this event for SB1 in the
> events/mips/sb1 directory
> --------------------------------------------------------------
> ----------
> ---
> event:10 counters:1,2,3 um:zero minimum:500 
> name:DCACHE_FILLED_SHD_NONC_EXC :Dcache is filled (shared, nonc,
> exclusive)
> ----------------------------------------------------------------
> 
> However this doesn't have an equivalent performance source 
> Listed in the sibyte manual (table 33 system performance 
> counter sources).

Are you looking in Sb1-UM100-RDS.pdf?  This is in table 95 in my copy,
on page 96/97 (section 11).  Also note that the table isn't in order --
event #10 appears on the top of the 2nd page.  It's logical grouping,
not numeric.

> #2: how does the mapping from event numbers to performance 
> sources work for sibyte ?
> 
> I looked at the op_model_mipsxx.c file in the 2.6 CVS tree 
> and the macro it uses doesn't seem to match the format 
> specified for perf_cnt_cfg register in sibyte.

Are you using the kernel from CVS instead of git?  The SB1 oprofile
support didn't turn up in the kernel until sometime mid-January, and is
only available through the git version (the CVS version of the kernel is
long out of date).

HTH,
Mark
