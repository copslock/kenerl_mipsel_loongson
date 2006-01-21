Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 12:25:59 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:50196 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133518AbWAWMYU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jan 2006 12:24:20 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0NCRK0h005416;
	Mon, 23 Jan 2006 12:28:05 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0LL5BB7007331;
	Sat, 21 Jan 2006 21:05:11 GMT
Date:	Sat, 21 Jan 2006 21:05:11 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Adrian Bunk <bunk@stusta.de>
Cc:	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
	perex@suse.cz, linux-mips@linux-mips.org
Subject: Re: RFC: OSS driver removal, a slightly different approach
Message-ID: <20060121210511.GD3456@linux-mips.org>
References: <20060119174600.GT19398@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119174600.GT19398@stusta.de>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10053
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 19, 2006 at 06:46:00PM +0100, Adrian Bunk wrote:

> 3. no ALSA drivers for the same hardware
[...]
> SOUND_AU1550_AC97
[...]
> SOUND_IT8172
[...]
> SOUND_VRC5477

I'm already hammering the responsible people to rewrite the drivers for
ALSA since a while but slow progress.  The latter two platforms have no
active maintainers so I don't expect to see ALSA drivers.

  Ralf
