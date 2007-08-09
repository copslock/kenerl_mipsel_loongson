Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2007 11:00:47 +0100 (BST)
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:48030
	"EHLO vs166246.vserver.de") by ftp.linux-mips.org with ESMTP
	id S20021672AbXHIKAi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 9 Aug 2007 11:00:38 +0100
Received: from t5ea7.t.pppool.de ([89.55.94.167] helo=powermac.local)
	by vs166246.vserver.de with esmtpa (Exim 4.50)
	id 1IJ4on-0007Kw-IA; Thu, 09 Aug 2007 12:00:37 +0200
From:	Michael Buesch <mb@bu3sch.de>
To:	Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: [PATCH 2/4][RFC] MIPS: BCM947xx support
Date:	Thu, 9 Aug 2007 12:00:09 +0200
User-Agent: KMail/1.9.6
Cc:	linux-mips@linux-mips.org,
	Andrew Morton <akpm@linux-foundation.org>, nbd@openwrt.org,
	jolt@tuxbox.org
References: <20070806150900.GG24308@hall.aurel32.net> <20070809004156.GA4682@hall.aurel32.net> <20070809004430.GC4682@hall.aurel32.net>
In-Reply-To: <20070809004430.GC4682@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200708091200.09615.mb@bu3sch.de>
Return-Path: <mb@bu3sch.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16146
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mb@bu3sch.de
Precedence: bulk
X-list: linux-mips

On Thursday 09 August 2007 02:44:30 Aurelien Jarno wrote:
> +struct ssb_bus ssb_bcm947xx;
> +EXPORT_SYMBOL(ssb_bcm947xx);

Huh, which module does need this internal structure?

-- 
Greetings Michael.
