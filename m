Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 15:03:49 +0000 (GMT)
Received: from amdext3.amd.com ([139.95.251.6]:43734 "EHLO amdext3.amd.com")
	by ftp.linux-mips.org with ESMTP id S3458585AbWAWPC2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Jan 2006 15:02:28 +0000
Received: from SSVLGW02.amd.com (ssvlgw02.amd.com [139.95.250.170])
	by amdext3.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k0NF5kci021191;
	Mon, 23 Jan 2006 07:05:46 -0800
Received: from 139.95.250.1 by SSVLGW01.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Mon, 23 Jan 2006 07:05:20 -0800
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
Received: from ldcmail.amd.com (ldcmail.amd.com [147.5.200.40]) by
 amdint.amd.com (8.12.8/8.12.8/AMD) with ESMTP id k0NF5KVP017565; Mon,
 23 Jan 2006 07:05:20 -0800 (PST)
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id 14F472028; Mon, 23 Jan 2006
 08:05:20 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k0NF6MNf004515; Mon, 23 Jan 2006 08:06:22
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k0NF6L9R004514; Mon, 23 Jan 2006 08:06:21
 -0700
Date:	Mon, 23 Jan 2006 08:06:21 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"Dan Malek" <dan@embeddedalley.com>
cc:	"Ralf Baechle" <ralf@linux-mips.org>, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org, "Adrian Bunk" <bunk@stusta.de>,
	perex@suse.cz, linux-mips@linux-mips.org
Subject: Re: RFC: OSS driver removal, a slightly different approach
Message-ID: <20060123150621.GE4371@cosmic.amd.com>
References: <20060119174600.GT19398@stusta.de>
 <20060121210511.GD3456@linux-mips.org>
 <2edd3641fe1cb18d25e35abe40de5d4e@embeddedalley.com>
MIME-Version: 1.0
In-Reply-To: <2edd3641fe1cb18d25e35abe40de5d4e@embeddedalley.com>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6FCA2F3A1HW274478-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

On 23/01/06 09:11 -0500, Dan Malek wrote:
> 
> On Jan 21, 2006, at 4:05 PM, Ralf Baechle wrote:
> 
> >On Thu, Jan 19, 2006 at 06:46:00PM +0100, Adrian Bunk wrote:
> >
> >>3. no ALSA drivers for the same hardware
> >[...]
> >>SOUND_AU1550_AC97
> 
> The Au1550 should have an ALSA driver.  It was done
> some time ago.  Perhaps we just didn't submit it to the
> proper maintainer.  I'll track that down.

My official position is that I would prefer an ALSA driver if exists.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>
