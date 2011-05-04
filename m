Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 May 2011 10:07:00 +0200 (CEST)
Received: from mx0.aculab.com ([213.249.233.131]:36997 "HELO mx0.aculab.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S1490983Ab1EDIG4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 May 2011 10:06:56 +0200
Received: (qmail 2805 invoked from network); 4 May 2011 08:06:45 -0000
Received: from localhost (127.0.0.1)
  by mx0.aculab.com with SMTP; 4 May 2011 08:06:45 -0000
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 00592-02 for <linux-mips@linux-mips.org>;
 Wed,  4 May 2011 09:06:44 +0100 (BST)
Received: (qmail 2712 invoked by uid 599); 4 May 2011 08:06:43 -0000
Received: from unknown (HELO saturn3.Aculab.com) (10.202.163.5)
    by mx0.aculab.com (qpsmtpd/0.28) with ESMTP; Wed, 04 May 2011 09:06:43 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] atomic: add *_dec_not_zero
Date:   Wed, 4 May 2011 09:05:53 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AD0D@saturn3.aculab.com>
In-Reply-To: <1304458235-28473-1-git-send-email-sven@narfation.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] atomic: add *_dec_not_zero
Thread-Index: AcwJ3EAltH6AZTKdQ3qO9QnukRcgpAAVa6Mw
From:   "David Laight" <David.Laight@ACULAB.COM>
To:     "Sven Eckelmann" <sven@narfation.org>,
        <linux-kernel@vger.kernel.org>
Cc:     <linux-arch@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-m32r@ml.linux-m32r.org>, <linux-ia64@vger.kernel.org>,
        <linux-parisc@vger.kernel.org>, <linux-cris-kernel@axis.com>,
        <linux-s390@vger.kernel.org>, <linux-sh@vger.kernel.org>,
        <x86@kernel.org>, "Chris Metcalf" <cmetcalf@tilera.com>,
        "David Howells" <dhowells@redhat.com>,
        <linux-m68k@lists.linux-m68k.org>, <linux-am33-list@redhat.com>,
        <linux-alpha@vger.kernel.org>, <sparclinux@vger.kernel.org>,
        <uclinux-dist-devel@blackfin.uclinux.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>
X-Virus-Scanned: by iCritical at mx0.aculab.com
Return-Path: <David.Laight@ACULAB.COM>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: David.Laight@ACULAB.COM
Precedence: bulk
X-list: linux-mips

 
> Introduce an *_dec_not_zero operation.  Make this a special case of
> *_add_unless because batman-adv uses atomic_dec_not_zero in different
> places like re-broadcast queue or aggregation queue management. There
> are other non-final patches which may also want to use this macro.

Isn't there a place where a default definition of this can be
defined? Instead of adding it separately to every architecture.

	David
