Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 May 2004 22:44:22 +0100 (BST)
Received: from rwcrmhc13.comcast.net ([IPv6:::ffff:204.127.198.39]:11452 "EHLO
	rwcrmhc13.comcast.net") by linux-mips.org with ESMTP
	id <S8225790AbUERVoV>; Tue, 18 May 2004 22:44:21 +0100
Received: from gentoo.org (pcp04939029pcs.waldrf01.md.comcast.net[68.48.72.58])
          by comcast.net (rwcrmhc13) with ESMTP
          id <20040518214412015008jegte>
          (Authid: kumba12345);
          Tue, 18 May 2004 21:44:13 +0000
Message-ID: <40AA842D.9080603@gentoo.org>
Date: Tue, 18 May 2004 17:46:21 -0400
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: IRQ problem on cobalt / 2.6.6
References: <20040513183059.GA25743@getyour.pawsoff.org> <20040518073439.GA6818@skeleton-jack> <20040518205914.GA29574@getyour.pawsoff.org> <20040518211246.GA11722@skeleton-jack> <20040518211810.GA29636@getyour.pawsoff.org> <20040518211932.GB29636@getyour.pawsoff.org>
In-Reply-To: <20040518211932.GB29636@getyour.pawsoff.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Kieran Fulke wrote:

> yeah. cleared out /usr/src and re-emerged mips-sources-2.6.6, then made 
> the change to include/asm/cobalt/cobalt.h you suggested. kernel 
> .config attached ..
> 
> Kieran.

Just to rule out a few things, try disabling the following options in 
your .config:

CONFIG_IDE_TASK_IOCTL (IDE Taskfile Access)
CONFIG_IDE_TASKFILE_IO (IDE Taskfile IO)

CONFIG_TULIP_MWI (New bus configuration)
CONFIG_TULIP_MMIO (Use PCI shared mem for NIC registers)
CONFIG_TULIP_NAPI (Use NAPI RX polling)
CONFIG_TULIP_NAPI_HW_MITIGATION (Use Interrupt Mitigation)


Taskfile access is, afaict, needed only if you're doing disk forensics 
or such.  The new taskfile IO code hung up on me a few times on Cobalt 
when I was initially testing some of Peter's 2.6.x patches, and as such, 
I haven't cut it on since then.

Tulip, I don't recall which, but I *think* one of them also caused me 
some kind of an issue, I'm unsure if it was a hang or something else. In 
either case, I left them as is.

See if turning those off does anything different.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
