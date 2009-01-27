Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jan 2009 23:00:50 +0000 (GMT)
Received: from sj-iport-2.cisco.com ([171.71.176.71]:38837 "EHLO
	sj-iport-2.cisco.com") by ftp.linux-mips.org with ESMTP
	id S21103024AbZA0XAs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Jan 2009 23:00:48 +0000
X-IronPort-AV: E=Sophos;i="4.37,335,1231113600"; 
   d="scan'208";a="126261784"
Received: from sj-dkim-1.cisco.com ([171.71.179.21])
  by sj-iport-2.cisco.com with ESMTP; 27 Jan 2009 23:00:41 +0000
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by sj-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id n0RN0fVv004098
	for <linux-mips@linux-mips.org>; Tue, 27 Jan 2009 15:00:41 -0800
Received: from sausatlsmtp2.sciatl.com (sausatlsmtp2.cisco.com [192.133.217.159])
	by sj-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id n0RN0eUj005090
	for <linux-mips@linux-mips.org>; Tue, 27 Jan 2009 23:00:41 GMT
Received: from default.com ([192.133.217.159]) by sausatlsmtp2.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 27 Jan 2009 18:00:39 -0500
Received: from sausatlbhs02.corp.sa.net ([192.133.216.42]) by sausatlsmtp2.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 27 Jan 2009 18:00:38 -0500
Received: from CUPLXSUNDISM01.corp.sa.net ([64.101.21.60]) by sausatlbhs02.corp.sa.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 27 Jan 2009 18:00:38 -0500
Message-ID: <497F9214.1000609@cisco.com>
Date:	Tue, 27 Jan 2009 15:00:36 -0800
From:	Michael Sundius <msundius@cisco.com>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org, "VomLehn, David" <dvomlehn@cisco.com>,
	msundius@sundius.com
Subject: memcpy and prefetch
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Jan 2009 23:00:38.0394 (UTC) FILETIME=[11EC8DA0:01C980D3]
X-ST-MF-Message-Resent:	1/27/2009 18:00
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=1270; t=1233097241; x=1233961241;
	c=relaxed/simple; s=sjdkim1004;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=msundius@cisco.com;
	z=From:=20Michael=20Sundius=20<msundius@cisco.com>
	|Subject:=20memcpy=20and=20prefetch
	|Sender:=20;
	bh=aL3Py1fSERdlXqIqC0rdvxeaxMBBarUg/YtcjYwGw1M=;
	b=DyhFDYJSp+lE7g/kRojI4ZJLN0nf/LiyRz49N+F2RC9/8h9/Qj8Uu5/AEA
	6AiU3oCCVZDoJLciQIe71Pfy1wCHcEkjyA8NXYkYw3evKZuLvvQkz6pR0w8p
	BtqeegbsIIBszhbiQCcKlq8l0/qIL/D30VSdf4PdP3N3uShbfOeek=;
Authentication-Results:	sj-dkim-1; header.From=msundius@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim1004 verified; ); 
Return-Path: <msundius@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: msundius@cisco.com
Precedence: bulk
X-list: linux-mips

I know this topic has been written about but so excuse me if I am 
redundant.
I saw lots of talk in the archives but I don't know if a solution was 
ever arrived
at. so:

what is the current state of the use of prefetch in memcpy()? it seems that
it is #undef-ed if CONFIG_DMA_COHERENT is not turned on.

is this still because the memcpy does not check to prevent a prefetch of
addresses beyond the end of the buffer?

If so, what was the reason a solution was abandoned....

also  has anyone out there written a memcopy that does use prefetch
intelligently (for mips32 that is)?


thanks
Mike



     - - - - -                              Cisco                            - - - - -         
This e-mail and any attachments may contain information which is confidential, 
proprietary, privileged or otherwise protected by law. The information is solely 
intended for the named addressee (or a person responsible for delivering it to 
the addressee). If you are not the intended recipient of this message, you are 
not authorized to read, print, retain, copy or disseminate this message or any 
part of it. If you have received this e-mail in error, please notify the sender 
immediately by return e-mail and delete it from your computer.
