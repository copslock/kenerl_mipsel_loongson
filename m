Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2009 13:38:57 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:52978 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492597AbZLBMiy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Dec 2009 13:38:54 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nB2CcqAp019436;
        Wed, 2 Dec 2009 12:38:53 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nB2CcpiK019434;
        Wed, 2 Dec 2009 12:38:51 GMT
Date:   Wed, 2 Dec 2009 12:38:50 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] rb532: fix devices.c compilation
Message-ID: <20091202123850.GA19401@linux-mips.org>
References: <200912021307.02014.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200912021307.02014.florian@openwrt.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25271
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 02, 2009 at 01:07:01PM +0100, Florian Fainelli wrote:

> We should now use dev_set_drvdata to set the driver
> driver_data field.

Thanks, applied.

  Ralf
