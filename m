Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Mar 2003 08:20:59 +0000 (GMT)
Received: from [IPv6:::ffff:203.197.124.190] ([IPv6:::ffff:203.197.124.190]:5134
	"EHLO alumnux.com") by linux-mips.org with ESMTP
	id <S8225218AbTCSIU6>; Wed, 19 Mar 2003 08:20:58 +0000
Received: from alumnux.com (mamata.alumnus.co.in [192.168.10.121])
	by alumnux.com (8.9.3/8.9.3) with ESMTP id TAA10147
	for <linux-mips@linux-mips.org>; Wed, 19 Mar 2003 19:28:50 +0530
Message-ID: <3E78284D.9BE358B2@alumnux.com>
Date: Wed, 19 Mar 2003 13:50:29 +0530
From: debashis <debashis@alumnux.com>
Organization: Alumnus Software Ltd
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: compressed image for mips:malta
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <debashis@alumnux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1775
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: debashis@alumnux.com
Precedence: bulk
X-list: linux-mips

Hi,
I am working with a mips malta 4KC box. It supports vmlinux. The linux
kernel version that I am using is 2.4.18

However the size of the vmlinux image looks high (more than 1M).  I am
trying to get a smaller image (with neworking). Need some help :

Is their any compressed image is supported for this particular board?

Does the loader need some change to support compressed image?

In case I need to provide support for the compressed image, is there any
similar board on which the compressed image support is present?

Any suggession is welcome.

Thanks in advance.

Regards,
debashis
