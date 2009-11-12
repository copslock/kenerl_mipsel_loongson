Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Nov 2009 18:02:22 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:43422 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493171AbZKLRCT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Nov 2009 18:02:19 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nACH2MwN011025;
	Thu, 12 Nov 2009 18:02:22 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nACH2KqE011021;
	Thu, 12 Nov 2009 18:02:20 +0100
Date:	Thu, 12 Nov 2009 18:02:20 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@paralogos.com>
Cc:	Mikael Starvik <mikael.starvik@axis.com>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	Jesper Nilsson <Jesper.Nilsson@axis.com>
Subject: Re: SMTC lookup in smtc_distribute_timer
Message-ID: <20091112170220.GC10372@linux-mips.org>
References: <4BEA3FF3CAA35E408EA55C7BE2E61D0546A586E7EA@xmail3.se.axis.com> <4AF9C2EA.3090205@paralogos.com> <4BEA3FF3CAA35E408EA55C7BE2E61D0546A586E886@xmail3.se.axis.com> <4AFB0F30.7090209@paralogos.com> <4BEA3FF3CAA35E408EA55C7BE2E61D0546A586EA36@xmail3.se.axis.com> <4AFBD7D5.2090304@paralogos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AFBD7D5.2090304@paralogos.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 12, 2009 at 10:39:33AM +0100, Kevin D. Kissell wrote:

> OK, thanks.  Ralf, can we consider this one queued?  It does seem to  
> have been captured correctly by Patchwork.

Just applied it to master; this should go into 2.6.32 and the -stable
branches.

Patchwork only tracks patches so people know the status of their patches and
I don't drop it by accident.  A patch just showing up in patchwork doesn't
yet mean it has been accepted.

Thanks everybody!

  Ralf
