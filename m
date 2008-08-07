Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Aug 2008 03:10:19 +0100 (BST)
Received: from rtp-iport-2.cisco.com ([64.102.122.149]:8217 "EHLO
	rtp-iport-2.cisco.com") by ftp.linux-mips.org with ESMTP
	id S28578001AbYHGCKO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Aug 2008 03:10:14 +0100
X-IronPort-AV: E=Sophos;i="4.31,318,1215388800"; 
   d="scan'208";a="16723693"
Received: from rtp-dkim-2.cisco.com ([64.102.121.159])
  by rtp-iport-2.cisco.com with ESMTP; 07 Aug 2008 02:10:02 +0000
Received: from rtp-core-1.cisco.com (rtp-core-1.cisco.com [64.102.124.12])
	by rtp-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id m772A2aM000377
	for <linux-mips@linux-mips.org>; Wed, 6 Aug 2008 22:10:02 -0400
Received: from sausatlsmtp1.sciatl.com ([192.133.217.33])
	by rtp-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id m772A1db012154
	for <linux-mips@linux-mips.org>; Thu, 7 Aug 2008 02:10:01 GMT
Received: from default.com ([192.133.217.33]) by sausatlsmtp1.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 6 Aug 2008 22:10:01 -0400
Received: from sausatlbhs01.corp.sa.net ([192.133.216.76]) by sausatlsmtp1.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 6 Aug 2008 22:10:00 -0400
Received: from [127.0.0.1] ([64.101.20.200]) by sausatlbhs01.corp.sa.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 6 Aug 2008 22:09:59 -0400
Message-ID: <489A5975.1000401@cisco.com>
Date:	Wed, 06 Aug 2008 19:09:57 -0700
From:	David VomLehn <dvomlehn@cisco.com>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Anyone noticed that there are a lot of cache flushes after kunmap/kunmap_atomic
 is called?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Aug 2008 02:09:59.0606 (UTC) FILETIME=[B1DB6D60:01C8F832]
X-ST-MF-Message-Resent:	8/6/2008 22:10
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=1390; t=1218075002; x=1218939002;
	c=relaxed/simple; s=rtpdkim2001;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Anyone=20noticed=20that=20there=20are=20a=20lot
	=20of=20cache=20flushes=20after=20kunmap/kunmap_atomic=0A=20
	is=20called?
	|Sender:=20
	|To:=20=22linux-mips@linux-mips.org=22=20<linux-mips@linux-
	mips.org>;
	bh=NR4um0HgShbaVpa8cIkzGCo8j7OVzDPWzr9KJ+kmyDU=;
	b=xxn0K8LLtTip2Qpbd9QXnrum6JNI7Y1RzeGLbBfScZoyn1uzaGvBS5H9Iy
	rVR8xh+hbU5Arssh4NqqCSXMaioUMevK6ozYu7CyVMc8fbmKEMhAUXu3otvZ
	z63jSKxky9;
Authentication-Results:	rtp-dkim-2; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/rtpdkim2001 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On the MIPS processor, cache flushing is done based on virtual addresses. 
However, in the Linux kernel, there are a lot of places where memory is mapped 
with kmap or kmap_atomic, then unmapped with the corresponding kunmap or 
kunmap_atomic and only *then* is the cache flushed. In other words, we only flush 
the cache after we have dropped the mapping of memory into a virtual address. I 
think this is generally wrong.

This may really only affect those of us who have enabled high memory, but it's 
pretty prevalent in kernel code. We noted this before, but have apparently just 
been bitten by it. Is it just me or is there a fairly widespread problem for 
processors that flush the cache using virtual addresses?




     - - - - -                              Cisco                            - - - - -         
This e-mail and any attachments may contain information which is confidential, 
proprietary, privileged or otherwise protected by law. The information is solely 
intended for the named addressee (or a person responsible for delivering it to 
the addressee). If you are not the intended recipient of this message, you are 
not authorized to read, print, retain, copy or disseminate this message or any 
part of it. If you have received this e-mail in error, please notify the sender 
immediately by return e-mail and delete it from your computer.
