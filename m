Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2010 00:20:47 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:45491 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1493482Ab0AZXUn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Jan 2010 00:20:43 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0QNKojv023908;
        Wed, 27 Jan 2010 00:20:51 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0QNKoGJ023906;
        Wed, 27 Jan 2010 00:20:50 +0100
Date:   Wed, 27 Jan 2010 00:20:50 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David VomLehn <dvomlehn@cisco.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] powertv: Fix support for timer interrupts when using >64
 external IRQs
Message-ID: <20100126232050.GA13539@linux-mips.org>
References: <20091222014922.GA30164@dvomlehn-lnx2.corp.sa.net>
 <20100126142614.GC17849@linux-mips.org>
 <20100126183606.GA9784@dvomlehn-lnx2.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100126183606.GA9784@dvomlehn-lnx2.corp.sa.net>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 17042

On Tue, Jan 26, 2010 at 10:36:06AM -0800, David VomLehn wrote:

> > I think this isn't relevant for any currently in-tree supported platforms (?)
> > so I've queued this for 2.6.34.
> > 
> > Thanks,
> > 
> >   Ralf
> 
> It's required for the PowerTV platform, but the release that includes it
> is at your discretion.

Should have guessed so.  Will pull it into 2.6.33 then.

  Ralf
