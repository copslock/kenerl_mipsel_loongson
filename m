Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2010 08:58:43 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:54575 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491008Ab0JTG6j (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Oct 2010 08:58:39 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o9K6wW0H013844;
        Wed, 20 Oct 2010 07:58:33 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o9K6wV7x013839;
        Wed, 20 Oct 2010 07:58:31 +0100
Date:   Wed, 20 Oct 2010 07:58:30 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        grant.likely@secretlab.ca, linux-kernel@vger.kernel.org,
        Dezhong Diao <dediao@cisco.com>
Subject: Re: [PATCH] of/mips: Cleanup some include directives/files.
Message-ID: <20101020065830.GA12565@linux-mips.org>
References: <1287528631-31797-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1287528631-31797-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 19, 2010 at 03:50:31PM -0700, David Daney wrote:

> The __init directives should go on the definitions of things, not the
> declaration, also __init is meaningless for inline functions, so
> remove it from prom.h.  This allows us to get rid of a useless
> #include, but most of the rest of them are useless too, so kill them
> as well.
> 
> If of_i2c.c needs irq definitions, it should include linux/irq.h
> directly, not assume indirect inclusion via asm/prom.h.

Grant, I assume you're going to merge this one.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
