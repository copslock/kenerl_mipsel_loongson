Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2011 00:52:11 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:43078 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491116Ab1EKWwF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 May 2011 00:52:05 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p4BMrVbW023810;
        Wed, 11 May 2011 23:53:31 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p4BMrVoo023808;
        Wed, 11 May 2011 23:53:31 +0100
Date:   Wed, 11 May 2011 23:53:31 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH 3/3] MIPS: lantiq: Check return value from
 strict_strtoul().
Message-ID: <20110511225331.GD17315@linux-mips.org>
References: <1305145347-32605-1-git-send-email-ddaney@caviumnetworks.com>
 <1305145347-32605-4-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1305145347-32605-4-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 11, 2011 at 01:22:27PM -0700, David Daney wrote:

> Subject: [PATCH 3/3] MIPS: lantiq: Check return value from strict_strtoul().

Thanks, folded into "MIPS: Lantiq: Add initial support for Lantiq SoCs".

  Ralf
