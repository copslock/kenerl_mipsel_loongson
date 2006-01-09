Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2006 17:40:46 +0000 (GMT)
Received: from p549F4907.dip.t-dialin.net ([84.159.73.7]:60594 "EHLO
	p549F4907.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S8133636AbWAIRkY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jan 2006 17:40:24 +0000
Received: from amdext3.amd.com ([IPv6:::ffff:139.95.251.6]:16104 "EHLO
	amdext3.amd.com") by linux-mips.net with ESMTP id <S869096AbWAIRm7>;
	Mon, 9 Jan 2006 18:42:59 +0100
Received: from SSVLGW02.amd.com (ssvlgw02.amd.com [139.95.250.170])
	by amdext3.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k09HdbeW031656;
	Mon, 9 Jan 2006 09:41:13 -0800
Received: from 139.95.250.1 by SSVLGW01.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Mon, 09 Jan 2006 09:41:01 -0800
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
Received: from ldcmail.amd.com (ldcmail.amd.com [147.5.200.40]) by
 amdint.amd.com (8.12.8/8.12.8/AMD) with ESMTP id k09Hf1VP019320; Mon, 9
 Jan 2006 09:41:01 -0800 (PST)
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id E40DB2028; Mon, 9 Jan 2006
 10:41:00 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k09Hnb4V008738; Mon, 9 Jan 2006 10:49:37
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k09HnasZ008737; Mon, 9 Jan 2006 10:49:36 -0700
Date:	Mon, 9 Jan 2006 10:49:36 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"Russell King" <rmk@arm.linux.org.uk>
cc:	linux-mips@linux-mips.org, drzeus@drzeus.cx
Subject: Re: Force MMC/SD to 512 byte block sizes
Message-ID: <20060109174936.GJ17575@cosmic.amd.com>
References: <20060106164406.GA15617@cosmic.amd.com>
 <20060106165930.GC16093@flint.arm.linux.org.uk>
MIME-Version: 1.0
In-Reply-To: <20060106165930.GC16093@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6FDC7FA72BK3549672-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9820
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

On 06/01/06 16:59 +0000, Russell King wrote:
> On Fri, Jan 06, 2006 at 09:44:06AM -0700, Jordan Crouse wrote:
> > This patch is not specific to the AU1200 SD driver, but thats what
> > we used to debug and verify this, so thats why it is applied against
> > the linux-mips tree.   Pierre, I'm sending this to you too, because I thought
> > you may be interested.
> 
> NACK.  Please wait until the next round of patches get merged and then
> revalidate this.

Ok - I saw your fixes.  Looks good to me.

I'm still sticking to the (assumption|hypothesis|foolish fantasy) that
even cards that do not support partial block writes will still support
512 byte writes - mainly because I just don't see those ASICs in the 
el-Cheapo card readers being capable of doing the advanced buffering
to convert 512 <-> 1024 or 2048, and hopefully one of these days I'll
find a card to prove that.  Until then, I don't have a leg to stand on,
so I'll quietly hang back.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>
