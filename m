Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Feb 2011 15:31:28 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:47337 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491146Ab1BWObX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Feb 2011 15:31:23 +0100
Received: from duck.linux-mips.net (localhost.localdomain [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p1NEUYS5001213;
        Wed, 23 Feb 2011 15:30:34 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p1NEUSux001200;
        Wed, 23 Feb 2011 15:30:28 +0100
Date:   Wed, 23 Feb 2011 15:30:28 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Gibson <david@gibson.dropbear.id.au>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        grant.likely@secretlab.ca, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 02/10] MIPS: Octeon: Add device tree source files.
Message-ID: <20110223143028.GA11832@linux-mips.org>
References: <1298408274-20856-1-git-send-email-ddaney@caviumnetworks.com>
 <1298408274-20856-3-git-send-email-ddaney@caviumnetworks.com>
 <20110223000759.GA26300@yookeroo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110223000759.GA26300@yookeroo>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29258
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 23, 2011 at 11:07:59AM +1100, David Gibson wrote:

> Uh.. where are the CPUs?

CPUs are probed the old style way on MIPS.  There is a large number of
varieties of CPUs - things like cache size, cache line size, architectural
extension and many small details of behaviour differ.  If we'd fully
honor DT CPU configuration information a kernel would need to have fairly
full blown generic CPU support for anything under the sun.  But there
already is a scheme that allows platform support code to select permanet
enablement, disablement or runtime probe for every CPU feature under the
sun for significant code savings and performance gain.

  Ralf
