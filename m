Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2009 11:43:50 +0100 (CET)
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:37497 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by ftp.linux-mips.org with ESMTP id S1492640AbZKCKnn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 3 Nov 2009 11:43:43 +0100
Received: by opensource2.wolfsonmicro.com (Postfix, from userid 1001)
	id 5DAB4769353; Tue,  3 Nov 2009 10:43:37 +0000 (GMT)
Date:	Tue, 3 Nov 2009 10:43:37 +0000
From:	Mark Brown <broonie@opensource.wolfsonmicro.com>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	alsa-devel@alsa-project.org
Subject: Re: [RFC PATCH 2/3] MIPS: Alchemy: DB1200 AC97+I2S audio support.
Message-ID: <20091103104337.GA26068@opensource.wolfsonmicro.com>
References: <1257193305-29996-1-git-send-email-manuel.lauss@gmail.com> <1257193305-29996-2-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1257193305-29996-2-git-send-email-manuel.lauss@gmail.com>
X-Cookie: You are always busy.
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <broonie@opensource.wolfsonmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24631
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@opensource.wolfsonmicro.com
Precedence: bulk
X-list: linux-mips

On Mon, Nov 02, 2009 at 09:21:44PM +0100, Manuel Lauss wrote:
> Machine driver for DB1200 AC97 and I2S audio systems, intended as a
> proper reference asoc machine for Alchemy-based systems.
> AC97/I2S can be selected at boot time by setting switch S6.7
> 
> Cc: alsa-devel@alsa-project.org
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>

This looks good for me.  The patch touches both ASoC and MIPS trees -
I'm happy with it being merged though either.
