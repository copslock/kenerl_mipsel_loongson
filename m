Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Dec 2005 23:48:43 +0000 (GMT)
Received: from amdext4.amd.com ([163.181.251.6]:64210 "EHLO amdext4.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133715AbVLNXsW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Dec 2005 23:48:22 +0000
Received: from SAUSGW01.amd.com (sausgw01.amd.com [163.181.250.21])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id jBENkfpt020118;
	Wed, 14 Dec 2005 17:48:47 -0600
Received: from 163.181.250.1 by SAUSGW01.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Wed, 14 Dec 2005 17:48:39 -0600
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Received: from ldcmail.amd.com (ldcmail.amd.com [147.5.200.40]) by
 amdint2.amd.com (8.12.8/8.12.8/AMD) with ESMTP id jBENmdh5022288; Wed,
 14 Dec 2005 17:48:39 -0600 (CST)
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id 19A47201E; Wed, 14 Dec 2005
 16:48:39 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id jBENoVf6024550; Wed, 14 Dec 2005 16:50:31
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id jBENoVNP024549; Wed, 14 Dec 2005 16:50:31
 -0700
Date:	Wed, 14 Dec 2005 16:50:31 -0700
From:	"Jordan Crouse" <jordan.crouse@AMD.com>
To:	bora.sahin@ttnet.net.tr
cc:	linux-mips@linux-mips.org
Subject: Re: Au1200 & IDE
Message-ID: <20051214235031.GD23276@cosmic.amd.com>
References: <200512142356.14417.bora.sahin@ttnet.net.tr>
MIME-Version: 1.0
In-Reply-To: <200512142356.14417.bora.sahin@ttnet.net.tr>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6FBE70DD4KG2293280-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@AMD.com
Precedence: bulk
X-list: linux-mips

> But that directory doesnt contain "ide-timing.h" so compiler complains from 
> it. ide-timing.h is in ide folder. I did a grep and saw that some other 
> dirs under ide also includes that file in the same manner as in mips but 
> doesnt contain it in its own folder. After I did a sym link, compile was 
> successfull. What's the concept behind this? Can we move it to 
> include/linux.

I'm not sure about that - thats probably more of a question for the core
folks.  For your particular error, however, it should be sufficient to add

EXTRA_CFLAGS += -Idrivers/ide

To drivers/ide/mips/Makefile.  I do believe that the most recent patches
had that fix attached.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>
