Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 May 2011 13:48:42 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:56814 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491055Ab1ESLsk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 May 2011 13:48:40 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p4JBmfwr018053;
        Thu, 19 May 2011 12:48:41 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p4JBmfij018051;
        Thu, 19 May 2011 12:48:41 +0100
Date:   Thu, 19 May 2011 12:48:41 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MIPS: pfn_valid() is broken on low memory HIGHMEM
 systems
Message-ID: <20110519114841.GA17284@linux-mips.org>
References: <1b31306f28573a4bee56f164b1f74962fced9bc5@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b31306f28573a4bee56f164b1f74962fced9bc5@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30079
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Queued for 2.6.41 with David Daney's suggested change to avoid GNU C
extensions but I'm probably going to change my mind and will push this
earlier.

Thanks!

  Ralf
