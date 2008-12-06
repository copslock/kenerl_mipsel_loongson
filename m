Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Dec 2008 10:31:24 +0000 (GMT)
Received: from sj-iport-1.cisco.com ([171.71.176.70]:32967 "EHLO
	sj-iport-1.cisco.com") by ftp.linux-mips.org with ESMTP
	id S24163331AbYLFKbR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 6 Dec 2008 10:31:17 +0000
X-IronPort-AV: E=Sophos;i="4.33,724,1220227200"; 
   d="scan'208";a="114477216"
Received: from sj-dkim-1.cisco.com ([171.71.179.21])
  by sj-iport-1.cisco.com with ESMTP; 06 Dec 2008 10:31:10 +0000
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by sj-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id mB6AVAHd002674
	for <linux-mips@linux-mips.org>; Sat, 6 Dec 2008 02:31:10 -0800
Received: from sausatlsmtp1.sciatl.com (sausatlsmtp1.cisco.com [192.133.217.33])
	by sj-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id mB6AV6jx010146
	for <linux-mips@linux-mips.org>; Sat, 6 Dec 2008 10:31:07 GMT
Received: from default.com ([192.133.217.33]) by sausatlsmtp1.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 6 Dec 2008 05:27:50 -0500
Received: from sausatlbhs02.corp.sa.net ([192.133.216.42]) by sausatlsmtp1.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 5 Dec 2008 21:46:14 -0500
Received: from sausatlexch4.corp.sa.net ([192.133.216.28]) by sausatlbhs02.corp.sa.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 5 Dec 2008 21:46:13 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: question regarding system memory whatever
Date:	Fri, 5 Dec 2008 21:46:12 -0500
Message-ID: <1C18506EA6ACF94097F87E8D358338F501F558@sausatlexch4.corp.sa.net>
In-Reply-To: <20081205181737.2fc890bc@ripper.onstor.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: question regarding system memory whatever
Thread-Index: AclXSQvmR4JUstECSeW0/by8VP5gegAA4sFw
References: <20081205181737.2fc890bc@ripper.onstor.net>
From:	"VomLehn, David" <dvomlehn@cisco.com>
To:	"Andrew Sharp" <andy.sharp@onstor.com>, <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 06 Dec 2008 02:46:13.0964 (UTC) FILETIME=[CDDBE0C0:01C9574C]
X-ST-MF-Message-Resent:	12/6/2008 05:27
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=2581; t=1228559470; x=1229423470;
	c=relaxed/simple; s=sjdkim1004;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20=22VomLehn,=20David=22=20<dvomlehn@cisco.com>
	|Subject:=20RE=3A=20question=20regarding=20system=20memory=
	20whatever
	|Sender:=20;
	bh=IGcTZVBgeXnWsvpwyIDrnC7z7Va04PoFCdZTdVldZuQ=;
	b=sxlH/sLwCiPdyZjzskhtnVp6on/k8sZDq7KVhP8lCR4L4j/wVB2wYQbqlR
	F+ByXKBQ7JMXi+qLQ7mGMz8mDmi/Zn2xD/lFIz0Rr0vwzIn7VqOsQzdD1vK0
	MrkrX5oyYiS9A5NE4h0GsgQLDyqE2U1SGFGDuwtwErn4EBHfUr/6o=;
Authentication-Results:	sj-dkim-1; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim1004 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21543
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

(Resend, the linux-mips email address was mangled the first time)
 
Er, it's kind of a good news/bad news joke...

The bad news is that MIPS Linux isn't smart enough, at least as of
2.6.24, to use memory that precedes the kernel.

The good news is that we've got changes that will handle this.

The bad news is that I'm so backed up even getting a basic patchset to
add our platform to the kernel mainline that I don't know how long it
will take until I'm be able to get these additional patches out.

I'll cc the guy who did the changes to see if he can extract a patch for
this.
> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Andrew Sharp
> Sent: Friday, December 05, 2008 6:18 PM
> To: linux-mips@
> Subject: question regarding system memory whatever
> 
> I recently changed plat_mem_setup() or equivalent in my platform code
> to not mark the first 32M of memory as BOOT_MEM_ROM_DATA and instead
> have the first BOOT_MEM_RAM memory region start at 0.  Here is the two
> lines of output from mem_init() for the two different versions:
> 
> Memory: 433408k/475136k available (2202k kernel code, 41556k 
> reserved, 690k data, 112k init, 0k highmem)
> 
> Memory: 433408k/507904k available (2202k kernel code, 74324k 
> reserved, 689k data, 112k init, 0k highmem)
> 
> As you can see, the 32M got added to "reserved" memory (?) and only
> added to the right hand number of the "available".  OK, so what does
> that mean?  I promised our monkey userspace programmers that they
> would have another 32M of memory to slosh around in, but before I
> release this change on them I'd like to know what these numbers are
> telling me.
> 
> This is on 2.6.22 from l.m.o on a Sibyte 1125 in 64bit LE.
> CONFIG_FLATMEM=y which was the fashion at the time.
> 
> Cheers,
> 
> a
> 
> 



     - - - - -                              Cisco                            - - - - -         
This e-mail and any attachments may contain information which is confidential, 
proprietary, privileged or otherwise protected by law. The information is solely 
intended for the named addressee (or a person responsible for delivering it to 
the addressee). If you are not the intended recipient of this message, you are 
not authorized to read, print, retain, copy or disseminate this message or any 
part of it. If you have received this e-mail in error, please notify the sender 
immediately by return e-mail and delete it from your computer.
