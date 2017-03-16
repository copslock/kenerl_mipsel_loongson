Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Mar 2017 16:41:36 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:35746 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991786AbdCPPl2JMPxH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Mar 2017 16:41:28 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v2GFfQ0J028170;
        Thu, 16 Mar 2017 16:41:26 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v2GFfPLd028169;
        Thu, 16 Mar 2017 16:41:25 +0100
Date:   Thu, 16 Mar 2017 16:41:25 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <steven.hill@cavium.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Octeon: Remove unused GPIO types and macros.
Message-ID: <20170316154125.GJ5512@linux-mips.org>
References: <1489068828-9629-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489068828-9629-1-git-send-email-steven.hill@cavium.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57363
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Thu, Mar 09, 2017 at 08:13:48AM -0600, Steven J. Hill wrote:

> From: "Steven J. Hill" <Steven.Hill@cavium.com>
> 
> Remove all unused bitfields and macros. Convert the remaining
> bitfields to use __BITFIELD_FIELD instead of #ifdef.
> 
> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> Acked-by: David Daney <david.daney@cavium.com>

How about posting patches against a recent tree?  The version of 
cvmx-gpio-defs.h your patch applies to was last changed by another patch
of yours on Feb 14.

  Ralf
