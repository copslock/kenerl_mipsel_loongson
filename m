Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 May 2010 01:06:20 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:57953 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492097Ab0EKXGR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 12 May 2010 01:06:17 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o4BN6BOn017047;
        Wed, 12 May 2010 00:06:12 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o4BN6Agc017045;
        Wed, 12 May 2010 00:06:10 +0100
Date:   Wed, 12 May 2010 00:06:09 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Dezhong Diao (dediao)" <dediao@cisco.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] Apply kmap_high_get with MIPS
Message-ID: <20100511230609.GB13271@linux-mips.org>
References: <7A9214B0DEB2074FBCA688B30B04400DBBA5E5@XMB-RCD-208.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7A9214B0DEB2074FBCA688B30B04400DBBA5E5@XMB-RCD-208.cisco.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 03, 2010 at 06:40:04PM -0500, Dezhong Diao (dediao) wrote:

At a glance this looks sane.  The patch got linewrapped however so you'd
need to re-send it, please.

I noticed that in http://patchwork.linux-mips.org/patch/1170/ the patch
got truncated after the first segment for highmem.c but wasn't on the
list.  Hm...

  Ralf
