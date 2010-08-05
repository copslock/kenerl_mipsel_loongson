Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Aug 2010 14:28:46 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:48289 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493348Ab0HEM2n (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Aug 2010 14:28:43 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o75CSbPj025142;
        Thu, 5 Aug 2010 13:28:37 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o75CSaUM025140;
        Thu, 5 Aug 2010 13:28:36 +0100
Date:   Thu, 5 Aug 2010 13:28:35 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David VomLehn <dvomlehn@cisco.com>
Cc:     linux-mips@linux-mips.org, greg@kroah.com,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/2][MIPS] USB/PowerTV: Separate PowerTV USB support from
 non-USB code
Message-ID: <20100805122835.GA7364@linux-mips.org>
References: <20100803014058.GA31552@dvomlehn-lnx2.corp.sa.net>
 <20100805004941.GB28402@linux-mips.org>
 <20100805023244.GA6780@dvomlehn-lnx2.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100805023244.GA6780@dvomlehn-lnx2.corp.sa.net>
User-Agent: Mutt/1.5.20 (2009-12-10)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27592
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 04, 2010 at 07:32:44PM -0700, David VomLehn wrote:

> > can this patch be safely applied alone until I get an Ack for patch 1/1?
> 
> Yes. It's the first time I've submitted something that crosses maintainer
> lines, so I made sure it would work with USB disabled.

Thanks, 2/2 applied then.  I had to fix a trivial reject in
arch/mips/powertv/Makefile.

  Ralf
