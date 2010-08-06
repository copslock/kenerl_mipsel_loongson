Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Aug 2010 11:22:40 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:52490 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492069Ab0HFJWc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 6 Aug 2010 11:22:32 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o769MTpA027589;
        Fri, 6 Aug 2010 10:22:29 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o769MSMQ027587;
        Fri, 6 Aug 2010 10:22:28 +0100
Date:   Fri, 6 Aug 2010 10:22:28 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Remove unused task_struct.trap_no field.
Message-ID: <20100806092227.GA27524@linux-mips.org>
References: <1280872659-27372-1-git-send-email-ddaney@caviumnetworks.com>
 <20100804233013.GA28115@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100804233013.GA28115@linux-mips.org>
User-Agent: Mutt/1.5.20 (2009-12-10)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27599
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Aug 05, 2010 at 12:30:13AM +0100, Ralf Baechle wrote:

> Thanks, applied.

Btw, this field was unused since at least Linux 1.1.68, that is late 1994 :-)

  Ralf
