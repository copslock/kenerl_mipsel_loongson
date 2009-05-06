Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2009 19:28:00 +0100 (BST)
Received: from mms2.broadcom.com ([216.31.210.18]:2975 "EHLO mms2.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20022123AbZEFS1w (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 May 2009 19:27:52 +0100
Received: from [10.9.200.131] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Wed, 06 May 2009 11:27:38 -0700
X-Server-Uuid: D3C04415-6FA8-4F2C-93C1-920E106A2031
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.1.358.0; Wed, 6 May 2009 11:27:37 -0700
Received: from [10.28.6.13] (lab-mhtb-013.ne.broadcom.com [10.28.6.13])
 by mail-irva-13.broadcom.com (Postfix) with ESMTP id 1A92474D05; Wed, 6
 May 2009 11:27:36 -0700 (PDT)
Subject: Re: [PATCH 2/3] mips:powertv: Make kernel command line size
 configurable (resend)
From:	"Jon Fraser" <jfraser@broadcom.com>
Reply-to: jfraser@broadcom.com
To:	"David Daney" <ddaney@caviumnetworks.com>
cc:	jfraser@broadcom.com, "David VomLehn" <dvomlehn@cisco.com>,
	"Ralf Baechle" <ralf@linux-mips.org>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <4A01D5C7.4090900@caviumnetworks.com>
References: <20090504225719.GA22417@cuplxvomd02.corp.sa.net>
 <20090506163518.GA19624@linux-mips.org>
 <20090506181931.GA14025@cuplxvomd02.corp.sa.net>
 <4A01D5C7.4090900@caviumnetworks.com>
Organization: Broadcom
Date:	Wed, 6 May 2009 14:27:36 -0400
Message-ID: <1241634456.10498.11.camel@chaos.ne.broadcom.com>
MIME-Version: 1.0
X-Mailer: Evolution 2.12.3 (2.12.3-5.fc8)
X-WSS-ID: 661F09103BO12416686-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jfraser@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22643
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jfraser@broadcom.com
Precedence: bulk
X-list: linux-mips



On Wed, 2009-05-06 at 11:24 -0700, David Daney wrote:
> David VomLehn wrote:
> > On Wed, May 06, 2009 at 05:35:18PM +0100, Ralf Baechle wrote:
> >> On Mon, May 04, 2009 at 03:57:19PM -0700, David VomLehn wrote:
> >>
> >>> Most platforms can get by perfectly well with the default command line size,
> >>> but some platforms need more. This patch allows the command line size to
> >>> be configured for those platforms that need it. The default remains 256
> >>> characters.
> >>>
> >>> Signed-off-by: David VomLehn <dvomlehn@cisco.com>
> >> How big of a command line do you need?  For no scientific reason other
> >> than there not being any obvious need for a larger size MIPS is using 256
> >> and I think unless you're asking for a huge number it will be better to
> >> just raise that constant.
> > 
> > The answer depends on the platform, but it's at 438 characters on a typical
> > platform. If I *had* to pick a number, I'd probably go for 512 characters; I
> > just hate to force others to use memory they aren't going to use.
> > 
> 
> I wonder if the memory could be dynamically allocated.  It would of 
> course be a much larger patch.
> 
> David Daney
> 



A bit of a chicken and egg problem if your command line arguments
set the memory configuration.


Jon Fraser
Broadcom
