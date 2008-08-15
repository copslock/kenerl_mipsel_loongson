Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Aug 2008 01:02:57 +0100 (BST)
Received: from e33.co.us.ibm.com ([32.97.110.151]:9608 "EHLO e33.co.us.ibm.com")
	by ftp.linux-mips.org with ESMTP id S28597183AbYHOACs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 Aug 2008 01:02:48 +0100
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7F02cak020891
	for <linux-mips@linux-mips.org>; Thu, 14 Aug 2008 20:02:38 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m7F02b7I184736
	for <linux-mips@linux-mips.org>; Thu, 14 Aug 2008 18:02:37 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m7F02bLT025803
	for <linux-mips@linux-mips.org>; Thu, 14 Aug 2008 18:02:37 -0600
Received: from [9.48.113.232] (sig-9-48-113-232.mts.ibm.com [9.48.113.232])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id m7F02asD025708;
	Thu, 14 Aug 2008 18:02:36 -0600
Subject: Re: sparsemem support for mips with highmem
From:	Dave Hansen <dave@linux.vnet.ibm.com>
To:	C Michael Sundius <Michael.sundius@sciatl.com>
Cc:	linux-mm@kvack.org, linux-mips@linux-mips.org,
	jfraser@broadcom.com, Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <48A4C542.5000308@sciatl.com>
References: <48A4AC39.7020707@sciatl.com> <1218753308.23641.56.camel@nimitz>
	 <48A4C542.5000308@sciatl.com>
Content-Type: text/plain
Date:	Thu, 14 Aug 2008 17:02:35 -0700
Message-Id: <1218758555.23641.69.camel@nimitz>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.2 
Content-Transfer-Encoding: 7bit
Return-Path: <dave@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dave@linux.vnet.ibm.com
Precedence: bulk
X-list: linux-mips

Looks great to me.  I can't test it, of course, but I don't see any
problems with it.

Signed-off-by: Dave Hansen <dave@linux.vnet.ibm.com>

-- Dave
