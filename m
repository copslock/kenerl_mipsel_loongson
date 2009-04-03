Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Apr 2009 01:31:11 +0100 (BST)
Received: from mms2.broadcom.com ([216.31.210.18]:42250 "EHLO
	mms2.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S20021796AbZDCAbD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 3 Apr 2009 01:31:03 +0100
Received: from [10.11.16.99] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Thu, 02 Apr 2009 17:30:49 -0700
X-Server-Uuid: D3C04415-6FA8-4F2C-93C1-920E106A2031
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 D97F02C1; Thu, 2 Apr 2009 17:30:48 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.11.18.52]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id C60ED2B0 for
 <linux-mips@linux-mips.org>; Thu, 2 Apr 2009 17:30:48 -0700 (PDT)
Received: from mail-irva-13.broadcom.com (mail-irva-13.broadcom.com
 [10.11.16.103]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id HOY18582; Thu, 2 Apr 2009 17:30:48 -0700 (PDT)
Received: from [10.28.6.13] (lab-mhtb-013.ne.broadcom.com [10.28.6.13])
 by mail-irva-13.broadcom.com (Postfix) with ESMTP id D877774D03 for
 <linux-mips@linux-mips.org>; Thu, 2 Apr 2009 17:30:47 -0700 (PDT)
Subject: HIGHMEM and 2.6.28
From:	"Jon Fraser" <jfraser@broadcom.com>
Reply-to: jfraser@broadcom.com
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Organization: Broadcom
Date:	Thu, 02 Apr 2009 20:30:46 -0400
Message-ID: <1238718646.3175.45.camel@chaos.ne.broadcom.com>
MIME-Version: 1.0
X-Mailer: Evolution 2.12.3 (2.12.3-5.fc8)
X-WSS-ID: 65CB87333D414281851-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jfraser@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jfraser@broadcom.com
Precedence: bulk
X-list: linux-mips

Has anybody been able to get HIGHMEM to work on 2.6.28
with an r4k style processor?

We have it working on 2.6.24 on a mips r24k.  We even have it working
with discontiguous memory and cache aliasing.  I ported our changes
to 2.6.28, but no joy.  I switched to a smaller cache to avoid cache
aliasing, and changed to a flat memory model to eliminate the
discontiguous memory code, but still no joy.  

We're using 2.6.28.9

Thanks,
Jon Fraser
Broadcom
