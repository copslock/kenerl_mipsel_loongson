Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jun 2010 14:14:17 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:54402 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491952Ab0FRMOO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Jun 2010 14:14:14 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o5ICE49P007884;
        Fri, 18 Jun 2010 13:14:07 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o5ICE3hq007877;
        Fri, 18 Jun 2010 13:14:03 +0100
Date:   Fri, 18 Jun 2010 13:14:03 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Gleb O. Raiko" <raiko@niisi.msk.ru>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Jesper Nilsson <jesper@jni.nu>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: MIPS: return after handling coprocessor 2 exception
Message-ID: <20100618121403.GC4466@linux-mips.org>
References: <20100617132554.GB24162@jni.nu>
 <4C1A57AE.9080706@caviumnetworks.com>
 <4C1B263E.7070906@niisi.msk.ru>
 <20100618100053.GA4466@linux-mips.org>
 <4C1B4C0A.9070506@niisi.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C1B4C0A.9070506@niisi.msk.ru>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 27171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 12815

On Fri, Jun 18, 2010 at 02:35:54PM +0400, Gleb O. Raiko wrote:

> >static int default_cu2_call(struct notifier_block *nfb, unsigned long action,
> >         void *data)
> >{
> >	...
> >
> >	return NOTIFY_OK | NOTIFY_STOP;
> NOTIFY_STOP implies NOTIFY_OK, so
> 	return NOTIFY_STOP;
> shall be enough.

Correct - I was thinking NOTIFY_STOP_MASK.

> >}
> 
> >The notifier list could also be used for example by perf
> 
> Or octeon cop2 handler that just sends NOTIFY_BAD for getting the
> same behavior.

Bad karma to return an error for where none happened.

  Ralf
