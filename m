Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Aug 2003 23:48:34 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:45307 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8224821AbTHTWsc>;
	Wed, 20 Aug 2003 23:48:32 +0100
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id PAA17543
	for <linux-mips@linux-mips.org>; Wed, 20 Aug 2003 15:48:28 -0700
Message-ID: <3F43FABC.20E9C11@mvista.com>
Date: Wed, 20 Aug 2003 16:48:28 -0600
From: Michael Pruznick <michael_pruznick@mvista.com>
Reply-To: michael_pruznick@mvista.com
Organization: MontaVista
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: root=nfs no longer works in 2.4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <michael_pruznick@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael_pruznick@mvista.com
Precedence: bulk
X-list: linux-mips

In the last week or so root=nfs has stopped
working.  Must now use root=/dev/nfs.

Just wondering if this is an intentional
change or a bug?
