Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Nov 2006 06:47:37 +0000 (GMT)
Received: from ams-iport-1.cisco.com ([144.254.224.140]:47400 "EHLO
	ams-iport-1.cisco.com") by ftp.linux-mips.org with ESMTP
	id S20037586AbWKLGrc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 12 Nov 2006 06:47:32 +0000
Received: from ams-dkim-2.cisco.com ([144.254.224.139])
  by ams-iport-1.cisco.com with ESMTP; 12 Nov 2006 07:46:47 +0100
X-IronPort-AV: i="4.09,414,1157320800"; 
   d="scan'208"; a="119401187:sNHT53480120"
Received: from ams-core-1.cisco.com (ams-core-1.cisco.com [144.254.224.150])
	by ams-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id kAC6kkoX028070;
	Sun, 12 Nov 2006 07:46:46 +0100
Received: from xbh-ams-331.emea.cisco.com (xbh-ams-331.cisco.com [144.254.231.71])
	by ams-core-1.cisco.com (8.12.10/8.12.6) with ESMTP id kAC6kf4Z024956;
	Sun, 12 Nov 2006 07:46:42 +0100 (MET)
Received: from xmb-ams-33b.cisco.com ([144.254.231.86]) by xbh-ams-331.emea.cisco.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 12 Nov 2006 07:46:41 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Sync operation in atomic_add_return()
Date:	Sun, 12 Nov 2006 07:46:39 +0100
Message-ID: <E98CBCB9ACC07244969BE4541EC0A7830317CEE5@xmb-ams-33b.emea.cisco.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Sync operation in atomic_add_return()
Thread-Index: AccBscqczM/yLc/WQ56lzFz+PK98AwAHKqogARW5gcA=
From:	"Gideon Stupp \(gstupp\)" <gstupp@cisco.com>
To:	"Kaz Kylheku" <kaz@zeugmasystems.com>
Cc:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 12 Nov 2006 06:46:41.0400 (UTC) FILETIME=[4F66A780:01C70626]
DKIM-Signature:	v=0.5; a=rsa-sha256; q=dns/txt; l=2477; t=1163314006; x=1164178006;
	c=relaxed/simple; s=amsdkim2001;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=gstupp@cisco.com;
	z=From:=20=22Gideon=20Stupp=20\(gstupp\)=22=20<gstupp@cisco.com>
	|Subject:=20RE=3A=20Sync=20operation=20in=20atomic_add_return()
	|Sender:=20;
	bh=raNmksd1EaNylGSTfql4VzTlIp0fCc9Pp4PMg8aQVF0=;
	b=NnYbUoSayt8Qa0Zv18ENFNGp4nUtykXwtpiRIDSn5pXNHcDlT08em/rCUyCGUdISBeCHdnyX
	Dq/aa/c967kwroIRIJYY9loeW/uP4otcJq+RitbUKQcplOy6tvBJOov6;
Authentication-Results:	ams-dkim-2; header.From=gstupp@cisco.com; dkim=pass (
	sig from cisco.com/amsdkim2001 verified; ); 
Return-Path: <gstupp@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gstupp@cisco.com
Precedence: bulk
X-list: linux-mips

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Kaz Kylheku
> Sent: Monday, November 06, 2006 8:18 PM
> To: linux-mips@linux-mips.org
> Subject: RE: Sync operation in atomic_add_return()
> 
> Gideon Stupp wrote:
> > Hi,
> > I am trying to figure out why there is a sync operation in 
> > linux/include/asm-mips/atomic.h:atomic_add_return().
> > I believe it was added in the linux-2.4.19 patch, but can't 
> trace the 
> > reason. Can anyone help?
> 
> Is it just unwarranted paranoia? There does not appear to be 
> a need for the sync within the atomic_add_return code itself.
> 
> But it might be that the code which calls this function needs 
> the sync.
> 
> Without looking at any code whatsoever, here is a general hypothesis.
> 
> In what situation might you /care/ about the return value of 
> an atomic add?
> 
> Suppose atomic increments and decrements are being used for 
> reference counting. If you know that you hold the reference 
> to an object, you can call atomic_add to increase the 
> reference count without caring about the return value, and no 
> sync is needed in that situation.
> 
> Suppose, however, that atomic_add is used to pick up a reference.
> Suppose you have a pool of ``dead'' objects with reference 
> counts of zero, and want to recycle an object from such a 
> pool. You might use atomic_add_return to examine the 
> reference counts of the objects in this pool one by one until 
> you get a 1 return. You might get something other than a 1 
> return if racing against another processor which is tryiing 
> to pick up the same object.
> 
> In this situation, if you successfully get the object, you do 
> want to do a sync, since the object is being handed off 
> between two processors.
> Before the object was put into the pool, its fields were 
> updated, since it was being cleaned up. You would not want 
> the new owner, by chance, to observe stale values of those fields.
> 
> I.e., to put it briefly, atomic_add_return can have "acquire" 
> semantics.
> 

Thanks for the reply.  I also checked the Alpha implementation ( the
only other architecture I know of with non serializing atomic operations
) and indeed there is an explicit smp_mb() in atomic_add_return() and
nowhere else.  So I guess this is the convention.

Gideon.
