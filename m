Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2006 18:11:18 +0000 (GMT)
Received: from amdext4.amd.com ([163.181.251.6]:13699 "EHLO amdext4.amd.com")
	by ftp.linux-mips.org with ESMTP id S8134432AbWAISKu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Jan 2006 18:10:50 +0000
Received: from SAUSGW02.amd.com (sausgw02.amd.com [163.181.250.22])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k09IDe7P000365;
	Mon, 9 Jan 2006 12:13:40 -0600
Received: from 163.181.250.1 by SAUSGW01.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Mon, 09 Jan 2006 12:13:19 -0600
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Received: from ldcmail.amd.com (ldcmail.amd.com [147.5.200.40]) by
 amdint2.amd.com (8.12.8/8.12.8/AMD) with ESMTP id k09IDIh5025523; Mon,
 9 Jan 2006 12:13:18 -0600 (CST)
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id 5428D2028; Mon, 9 Jan 2006
 11:13:18 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k09ILsiN009983; Mon, 9 Jan 2006 11:21:54
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k09ILsPc009982; Mon, 9 Jan 2006 11:21:54 -0700
Date:	Mon, 9 Jan 2006 11:21:54 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	linux-usb-devel@lists.sourceforge.net
cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	info-linux@ldcmail.amd.com, thomas.dahlmann@amd.com
Subject: Re: UDC support for MIPS/AU1200 and Geode/CS5536
Message-ID: <20060109182154.GL17575@cosmic.amd.com>
References: <20060109180356.GA8855@cosmic.amd.com>
MIME-Version: 1.0
In-Reply-To: <20060109180356.GA8855@cosmic.amd.com>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6FDC78353982717051-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9824
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

On 09/01/06 11:03 -0700, Jordan Crouse wrote:

> From the "two-birds-one-stone" department, I am pleased to present USB UDC
> support for both the MIPS Au1200 SoC and the Geode CS5535 south bridge.  
                                                     ^^^^^^
Of course, I meant the CS5536 - this *won't* work for the CS5535.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>
