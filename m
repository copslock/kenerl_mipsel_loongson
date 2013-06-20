Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jun 2013 13:35:37 +0200 (CEST)
Received: from mx0.aculab.com ([213.249.233.131]:49075 "HELO mx0.aculab.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6823083Ab3FTLfg2gjyp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Jun 2013 13:35:36 +0200
Received: (qmail 23910 invoked from network); 20 Jun 2013 11:35:29 -0000
Received: from localhost (127.0.0.1)
  by mx0.aculab.com with SMTP; 20 Jun 2013 11:35:29 -0000
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 23840-01 for <linux-mips@linux-mips.org>;
 Thu, 20 Jun 2013 12:35:28 +0100 (BST)
Received: (qmail 23640 invoked by uid 599); 20 Jun 2013 11:35:25 -0000
Received: from unknown (HELO saturn3.Aculab.com) (10.202.163.5)
    by mx0.aculab.com (qpsmtpd/0.28) with ESMTP; Thu, 20 Jun 2013 12:35:25 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2/2] netdev: octeon_mgmt: Fix structure layout for little-endian.
Date:   Thu, 20 Jun 2013 10:47:57 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B729B@saturn3.aculab.com>
In-Reply-To: <1371688820-4585-3-git-send-email-ddaney.cavm@gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2/2] netdev: octeon_mgmt: Fix structure layout for little-endian.
Thread-Index: Ac5tTtTVtO0JZvIHSES0j4PgHSGhEAATDZ1Q
References: <1371688820-4585-1-git-send-email-ddaney.cavm@gmail.com> <1371688820-4585-3-git-send-email-ddaney.cavm@gmail.com>
From:   "David Laight" <David.Laight@ACULAB.COM>
To:     "David Daney" <ddaney.cavm@gmail.com>, <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     <linux-mips@linux-mips.org>, "David Daney" <david.daney@cavium.com>
X-Virus-Scanned: by iCritical at mx0.aculab.com
Return-Path: <David.Laight@ACULAB.COM>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: David.Laight@ACULAB.COM
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

> The C ABI reverses the bitfield fill order when compiled as
> little-endian.

No - it is completely implementation defined.
The general concensus is not to use bitfields if you
care at all about the bit assignments.

	David
