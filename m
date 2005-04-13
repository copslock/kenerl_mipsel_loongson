Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Apr 2005 13:47:34 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:21258 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225800AbVDMMrT>; Wed, 13 Apr 2005 13:47:19 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j3DClEXu011665;
	Wed, 13 Apr 2005 13:47:14 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j3DClC7F011664;
	Wed, 13 Apr 2005 13:47:12 +0100
Date:	Wed, 13 Apr 2005 13:47:12 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Stuart Longland <stuartl@longlandclan.hopto.org>
Cc:	Greg Weeks <greg.weeks@timesys.com>, linux-mips@linux-mips.org
Subject: Re: BogoMIPS
Message-ID: <20050413124712.GF5253@linux-mips.org>
References: <425BDCE4.6070708@timesys.com> <425C9DBF.6090807@longlandclan.hopto.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425C9DBF.6090807@longlandclan.hopto.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7716
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 13, 2005 at 02:19:11PM +1000, Stuart Longland wrote:

> Probably, because it's no longer relevant these days.  It doesn't say
> anything special.

Nonsense.  It's just not printed to the screen by default.

> Interestingly, my IP28 still shows the BogoMIPS reading in /proc/cpuinfo:
> >stuartl@indigo ~ $ uname -a
> >Linux indigo 2.6.10-mipscvs-20050115-ip28 #2 Sun Apr 3 08:24:18 EST 2005 

Because you're running a vintage kernel.  The 0 BogoMIPS bug was
introduced by this CVS change:

  revision 1.54
  date: 2005/02/21 21:34:24;  author: ralf;  state: Exp;  lines: +2 -2
  On multiprocessor systems the BogoMIPS for each CPU was reported was
  the value for the last CPU having calibrated it's delay loop.

Only the value shown in /proc/cpuinfo on UP kernel was affected, so the
effect should be purely psychologic - I know what negative impact low
BogoMIPS may have on some people ;-)

  Ralf
