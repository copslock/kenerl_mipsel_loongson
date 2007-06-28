Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jun 2007 15:37:25 +0100 (BST)
Received: from gw-eur4.philips.com ([161.85.125.10]:13669 "EHLO
	gw-eur4.philips.com") by ftp.linux-mips.org with ESMTP
	id S20022640AbXF1OhT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 Jun 2007 15:37:19 +0100
Received: from smtpscan-eur8.philips.com (smtpscan-eur8.mail.philips.com [130.144.57.173])
	by gw-eur4.philips.com (Postfix) with ESMTP id 5443649704
	for <linux-mips@linux-mips.org>; Thu, 28 Jun 2007 14:37:13 +0000 (UTC)
Received: from smtpscan-eur8.philips.com (localhost [127.0.0.1])
	by localhost.philips.com (Postfix) with ESMTP id 3592D258
	for <linux-mips@linux-mips.org>; Thu, 28 Jun 2007 14:37:13 +0000 (GMT)
Received: from smtprelay-eur1.philips.com (smtprelay-eur1.philips.com [130.144.57.170])
	by smtpscan-eur8.philips.com (Postfix) with ESMTP id 18556DC
	for <linux-mips@linux-mips.org>; Thu, 28 Jun 2007 14:37:13 +0000 (GMT)
Received: from lnx32www01.soton.sc.philips.com (pww.osrp.sc.philips.com [130.141.89.1])
	by smtprelay-eur1.philips.com (Postfix) with ESMTP id C6D56C82
	for <linux-mips@linux-mips.org>; Thu, 28 Jun 2007 14:37:12 +0000 (GMT)
Received: from krate.soton.sc.philips.com (krate [130.141.7.10])
	by lnx32www01.soton.sc.philips.com (8.13.7/8.13.7) with ESMTP id l5SEbCqG004616
	for <linux-mips@linux-mips.org>; Thu, 28 Jun 2007 15:37:12 +0100
Received: from stout.soton.sc.philips.com (root@stout [130.141.7.8])
	by krate.soton.sc.philips.com (8.12.11/8.12.11) with ESMTP id l5SEb7kX003019
	for <linux-mips@linux-mips.org>; Thu, 28 Jun 2007 15:37:07 +0100 (BST)
Received: from [130.141.93.19] (host9319 [130.141.93.19])
	by stout.soton.sc.philips.com (8.11.3/8.11.3) with ESMTP id l5SEb7l22403
	for <linux-mips@linux-mips.org>; Thu, 28 Jun 2007 15:37:07 +0100 (BST)
Message-ID: <4683C792.4000100@nxp.com>
Date:	Thu, 28 Jun 2007 15:37:06 +0100
From:	Daniel Laird <daniel.j.laird@nxp.com>
User-Agent: Thunderbird 2.0.0.4 (Windows/20070604)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Generating patches and using checkpatch.pl
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <daniel.j.laird@nxp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.j.laird@nxp.com
Precedence: bulk
X-list: linux-mips

I am trying to start feeding back various patches to do with supporting 
the hardware I work on.
The company also decided upon a name change so I thought I would do this 
as well.
So I moved arch/mips/philips to arch/mips/nxp.

I generated a patch
I ran checkpatch.pl as Ralf suggested before.

I now have pages of errors in the patch

- Line over 80 chars
- printk must have KERN_ debug level
- must have a space after this (, or *)
- use tabs not spaces
- Do not use C99 comments.
To name but a few

My question is:
If you do a patch and find all these errors is it expected that I fix 
all these problems, or I just make sure my changes do not make it worse!

Dan
