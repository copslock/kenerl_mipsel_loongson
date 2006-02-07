Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2006 12:51:05 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:24587 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133369AbWBGMuw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 7 Feb 2006 12:50:52 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k17CuetQ005427;
	Tue, 7 Feb 2006 12:56:40 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k17B9xkm004138;
	Tue, 7 Feb 2006 11:09:59 GMT
Date:	Tue, 7 Feb 2006 11:09:59 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kurt Schwemmer <kurts@vitesse.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: oprofile gets only kernel samples?
Message-ID: <20060207110959.GA3383@linux-mips.org>
References: <389E6A416914954182ECDFCD844D8269434D89@MX-COS.vsc.vitesse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <389E6A416914954182ECDFCD844D8269434D89@MX-COS.vsc.vitesse.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 06, 2006 at 02:54:00PM -0700, Kurt Schwemmer wrote:

> I've got oprofile working sort of with 2.6.15 kernel on a 24Kc processor
> using just timer interrupts. I only get samples within vmlinux.out
> though. When I look at top output during the period of time there is
> definitely some significant user mode time. Before digging too deep into
> the problem I thought I'd ask to see if this is a known limitation and
> if everyone is seeing this.

That's the symptom of running too old oprofile tools; you need to use a
cvs; the release tarballs are too old.

  Ralf
