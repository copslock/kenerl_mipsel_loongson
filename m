Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Oct 2009 01:53:54 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16129 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493807AbZJAXxr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 2 Oct 2009 01:53:47 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4ac540f90006>; Thu, 01 Oct 2009 16:53:29 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 1 Oct 2009 16:47:03 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 1 Oct 2009 16:47:03 -0700
Message-ID: <4AC53F75.4090902@caviumnetworks.com>
Date:	Thu, 01 Oct 2009 16:47:01 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 0/2] Two Octeon compile errors with 2.6.32-rc1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Oct 2009 23:47:03.0310 (UTC) FILETIME=[79E542E0:01CA42F1]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Ralf,

There are a couple of problems I found with 2.6.32-rc1.

Two trivial patches to follow.

David Daney
