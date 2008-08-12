Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2008 01:49:36 +0100 (BST)
Received: from mms3.broadcom.com ([216.31.210.19]:2057 "EHLO MMS3.broadcom.com")
	by ftp.linux-mips.org with ESMTP id S28591285AbYHLAt3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 12 Aug 2008 01:49:29 +0100
Received: from [10.11.16.99] by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Mon, 11 Aug 2008 17:49:11 -0700
X-Server-Uuid: B55A25B1-5D7D-41F8-BC53-C57E7AD3C201
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 DC32A2B1; Mon, 11 Aug 2008 17:49:11 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.11.18.52]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id C6E4E2B0; Mon, 11 Aug
 2008 17:49:11 -0700 (PDT)
Received: from mail-irva-13.broadcom.com (mail-irva-13.broadcom.com
 [10.11.16.103]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id HBM54968; Mon, 11 Aug 2008 17:49:11 -0700 (PDT)
Received: from [10.28.6.13] (lab-mhtb-013.ne.broadcom.com [10.28.6.13])
 by mail-irva-13.broadcom.com (Postfix) with ESMTP id 235B774CFE; Mon,
 11 Aug 2008 17:49:10 -0700 (PDT)
Subject: Re: Anyone noticed that there are a lot of cache flushes after
 kunmap/kunmap_atomic is called?
From:	"Jon Fraser" <jfraser@broadcom.com>
Reply-to: jfraser@broadcom.com
To:	"David VomLehn" <dvomlehn@cisco.com>
cc:	"Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	michael.sundius@sciatl.com
In-Reply-To: <48A0C8E7.6080506@cisco.com>
References: <489A5975.1000401@cisco.com>
 <20080808082404.GA27519@linux-mips.org>
 <1218206499.20791.152.camel@chaos.ne.broadcom.com>
 <48A0C8E7.6080506@cisco.com>
Organization: Broadcom
Date:	Mon, 11 Aug 2008 20:49:08 -0400
Message-ID: <1218502148.20791.250.camel@chaos.ne.broadcom.com>
MIME-Version: 1.0
X-Mailer: Evolution 2.12.3 (2.12.3-3.fc8)
X-WSS-ID: 64BE018D4YK52586-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jfraser@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jfraser@broadcom.com
Precedence: bulk
X-list: linux-mips

David,

I agree.  It's my number one work item this week.  Well,
so far, anyway :-)

Jon


On Mon, 2008-08-11 at 16:19 -0700, David VomLehn wrote:
> Jon Fraser wrote:
> > David,
> > 
> >   I'm battling this now.  Our mips 24k has a virtually indexed cache.
> > We're definitely seeing issues where the cache hasn't been flushed
> > for highmem pages.  I thought I had this fixed, but I'm still seeing
> > some problems.
> 
> As I understand it, you have the most difficult combination of things:
> o You are using high memory
> o You have a virtually indexed cache
> o You have data cache aliases
> 
> Fortunately, we have only the first two of those in our system. We should 
> probably put together a coherent set of patches for people who want high memory. 
> So far as I can tell, the 32-bit MIPS architecture has a long way to go before it 
> runs out of steam in the embedded world. I expect more people will need MIPS 
> highmem support in the next few years.
> 
> David
> 
> 
