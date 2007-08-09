Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2007 13:16:02 +0100 (BST)
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:29065
	"EHLO vs166246.vserver.de") by ftp.linux-mips.org with ESMTP
	id S20022370AbXHIMPw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Aug 2007 13:15:52 +0100
Received: from t5ea7.t.pppool.de ([89.55.94.167] helo=powermac.local)
	by vs166246.vserver.de with esmtpa (Exim 4.50)
	id 1IJ6sc-0007I4-I2; Thu, 09 Aug 2007 14:12:42 +0200
From:	Michael Buesch <mb@bu3sch.de>
To:	Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: [PATCH 2/4][RFC] MIPS: BCM947xx support
Date:	Thu, 9 Aug 2007 14:12:13 +0200
User-Agent: KMail/1.9.6
Cc:	linux-mips@linux-mips.org,
	Andrew Morton <akpm@linux-foundation.org>, nbd@openwrt.org,
	jolt@tuxbox.org
References: <20070806150900.GG24308@hall.aurel32.net> <200708091251.37073.mb@bu3sch.de> <46BAF9F0.5060900@aurel32.net>
In-Reply-To: <46BAF9F0.5060900@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200708091412.13657.mb@bu3sch.de>
Return-Path: <mb@bu3sch.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mb@bu3sch.de
Precedence: bulk
X-list: linux-mips

On Thursday 09 August 2007 13:26:40 Aurelien Jarno wrote:
> Michael Buesch a écrit :
> > On Thursday 09 August 2007 12:38:43 Aurelien Jarno wrote:
> >> Michael Buesch a écrit :
> >>> On Thursday 09 August 2007 02:44:30 Aurelien Jarno wrote:
> >>>> +struct ssb_bus ssb_bcm947xx;
> >>>> +EXPORT_SYMBOL(ssb_bcm947xx);
> >>> Huh, which module does need this internal structure?
> >>>
> >> This is needed for mtd mappings. The size and the location of the flash
> >> is taken from this structure.
> >>
> > 
> > So mtd is compiled as a module? Really? From where is it loaded,
> > if not from flash?
> > 
> 
> Well you don't have to compile it as a module, but you can. Then you can
> load it from the hard drive.

Ah, ok. I see. Acked.

-- 
Greetings Michael.
