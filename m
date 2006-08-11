Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Aug 2006 17:51:35 +0100 (BST)
Received: from mail.zeugmasystems.com ([192.139.122.66]:1393 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S20044880AbWHKQvd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Aug 2006 17:51:33 +0100
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: 2.6.17 on Broadcom BigSur (BCM91x80 A/B)
Date:	Fri, 11 Aug 2006 09:51:23 -0700
Message-ID: <66910A579C9312469A7DF9ADB54A8B7D33AF2B@exchange.ZeugmaSystems.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.17 on Broadcom BigSur (BCM91x80 A/B)
Thread-Index: Aca83+BUY44lzVI3SJuaFZU85vKM6wACzYewAB6TbjA=
From:	"Kaz Kylheku" <kaz@zeugmasystems.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <kaz@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaz@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

Manoj Ekbote wrote:
> Hi Kaz,
> 
> Kindly make sure that the below 2 patches have been applied.
>  
> http://www.linux-mips.org/archives/linux-mips/2006-07/msg00021.html
> http://www.linux-mips.org/archives/linux-mips/2006-07/msg00020.html
> 
> HTH,
> /manoj

Hi Manoj,

Thanks for the pointers to these patches. I have them in my patch
stack now. They don't solve the problem, but I'm keeping them.

I'm now going to do a binary search over the revision history to
find the very first kernel release which has the problem.  
