Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2003 02:10:04 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:57071 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225232AbTEUBDv>;
	Wed, 21 May 2003 02:03:51 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id SAA02426;
	Tue, 20 May 2003 18:03:49 -0700
Subject: Re: patch: change config options for au1x00 usb device
From: Pete Popov <ppopov@mvista.com>
To: Steve Longerbeam <stevel@mvista.com>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>,
	Jun Sun <jsun@mvista.com>
In-Reply-To: <3EAF17A8.8050805@mvista.com>
References: <3EAF17A8.8050805@mvista.com>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1053479105.1247.18.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 20 May 2003 18:05:05 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips


On Tue, 2003-04-29 at 17:24, Steve Longerbeam wrote:
> Attached patch fixes CONFIG_AU1000_USB_DEVICE, which
> had to be defined manually for each au1x00-based board in
> arch/mips/config.in. The patch defines it automatically if one of
> the au1x00 usb function drivers have been enabled.

I finally got to this patch but it doesn't look like the patch was
against the linux-mips tree, so I manually patched it.

Pete
