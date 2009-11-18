Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Nov 2009 02:04:05 +0100 (CET)
Received: from sj-iport-4.cisco.com ([171.68.10.86]:47045 "EHLO
	sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493929AbZKRBD6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 18 Nov 2009 02:03:58 +0100
Authentication-Results:	sj-iport-4.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAM/WAkurRN+J/2dsb2JhbAC9f5hJhDsE
X-IronPort-AV: E=Sophos;i="4.44,761,1249257600"; 
   d="scan'208";a="50764018"
Received: from sj-core-3.cisco.com ([171.68.223.137])
  by sj-iport-4.cisco.com with ESMTP; 18 Nov 2009 01:03:51 +0000
Received: from dvomlehn-lnx2.corp.sa.net ([64.101.20.155])
	by sj-core-3.cisco.com (8.13.8/8.14.3) with ESMTP id nAI13pWx020816;
	Wed, 18 Nov 2009 01:03:51 GMT
Date:	Tue, 17 Nov 2009 20:03:51 -0500
From:	David VomLehn <dvomlehn@cisco.com>
To:	myuboot@fastmail.fm
Cc:	Florian Fainelli <florian@openwrt.org>,
	Chris Dearman <chris@mips.com>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: problem bring up initramfs and busybox
Message-ID: <20091118010351.GA21728@dvomlehn-lnx2.corp.sa.net>
References: <1255735395.30097.1340523469@webmail.messagingengine.com> <4B031B78.5030204@mips.com> <1258504293.3627.1345755107@webmail.messagingengine.com> <200911180139.29283.florian@openwrt.org> <1258505915.7077.1345760963@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1258505915.7077.1345760963@webmail.messagingengine.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Tue, Nov 17, 2009 at 06:58:35PM -0600, myuboot@fastmail.fm wrote:
> 
> On Wed, 18 Nov 2009 01:39 +0100, "Florian Fainelli"
> <florian@openwrt.org> wrote:
> > -------------------------------
> Actually I already got this patch for the board in little endian mode,
> and it is still there for the big endian mode. And this is one of the
> place I have been wondering if that needs to be changed for big endian. 

It sounds like you've done a good job getting the bootloader and kernel
to work, so this may be a silly suggestion, but are you sure your root
filesystem and busybox are little-endian? It would be an easy mistake to
make...

> thanks. Andrew

David VL
