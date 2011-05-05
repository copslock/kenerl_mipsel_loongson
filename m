Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 May 2011 13:32:10 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:54174 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1490982Ab1EELcI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 May 2011 13:32:08 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p45BXAkK031737;
        Thu, 5 May 2011 12:33:10 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p45BX998031735;
        Thu, 5 May 2011 12:33:09 +0100
Date:   Thu, 5 May 2011 12:33:09 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Invalidate old TLB mappings when updating huge
 page PTEs.
Message-ID: <20110505113309.GA30067@linux-mips.org>
References: <1303947568-29874-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1303947568-29874-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29820
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Thanks, applied.

  Ralf
