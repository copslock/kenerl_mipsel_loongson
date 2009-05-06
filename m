Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2009 17:44:29 +0100 (BST)
Received: from mms3.broadcom.com ([216.31.210.19]:4264 "EHLO MMS3.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20024435AbZEFQoX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 May 2009 17:44:23 +0100
Received: from [10.9.200.131] by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Wed, 06 May 2009 09:44:02 -0700
X-Server-Uuid: B55A25B1-5D7D-41F8-BC53-C57E7AD3C201
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.1.358.0; Wed, 6 May 2009 09:44:02 -0700
Received: from [10.28.6.13] (lab-mhtb-013.ne.broadcom.com [10.28.6.13])
 by mail-irva-13.broadcom.com (Postfix) with ESMTP id 62D1B74D09; Wed, 6
 May 2009 09:44:01 -0700 (PDT)
Subject: Re: [PATCH 2/3] mips:powertv: Make kernel command line size
 configurable (resend)
From:	"Jon Fraser" <jfraser@broadcom.com>
Reply-to: jfraser@broadcom.com
cc:	jfraser@broadcom.com, "David VomLehn" <dvomlehn@cisco.com>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <20090506163518.GA19624@linux-mips.org>
References: <20090504225719.GA22417@cuplxvomd02.corp.sa.net>
 <20090506163518.GA19624@linux-mips.org>
Organization: Broadcom
Date:	Wed, 6 May 2009 12:44:00 -0400
Message-ID: <1241628240.10498.4.camel@chaos.ne.broadcom.com>
MIME-Version: 1.0
X-Mailer: Evolution 2.12.3 (2.12.3-5.fc8)
X-WSS-ID: 661F61D838S12249587-02-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To:	unlisted-recipients:; (no To-header on input)
Return-Path: <jfraser@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22639
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jfraser@broadcom.com
Precedence: bulk
X-list: linux-mips



David,

We found huge command lines to be awkward.  In our platform support
code, we can pass environment variables from our bootstrap (CFE) to the
kernel.  Would something like this work for you?

I have no objection to making the command line buffer size bigger.

Jon



On Wed, 2009-05-06 at 09:35 -0700, Ralf Baechle wrote:
> On Mon, May 04, 2009 at 03:57:19PM -0700, David VomLehn wrote:
> 
> > Most platforms can get by perfectly well with the default command line size,
> > but some platforms need more. This patch allows the command line size to
> > be configured for those platforms that need it. The default remains 256
> > characters.
> > 
> > Signed-off-by: David VomLehn <dvomlehn@cisco.com>
> 
> How big of a command line do you need?  For no scientific reason other
> than there not being any obvious need for a larger size MIPS is using 256
> and I think unless you're asking for a huge number it will be better to
> just raise that constant.
> 
>   Ralf
> 
> 
