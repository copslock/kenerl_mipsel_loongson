Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2007 14:17:34 +0100 (BST)
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:30647
	"EHLO vs166246.vserver.de") by ftp.linux-mips.org with ESMTP
	id S20022117AbXHGNR0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 7 Aug 2007 14:17:26 +0100
Received: from t4268.t.pppool.de ([89.55.66.104] helo=powermac.local)
	by vs166246.vserver.de with esmtpa (Exim 4.50)
	id 1IIOt6-000259-6I; Tue, 07 Aug 2007 15:14:16 +0200
From:	Michael Buesch <mb@bu3sch.de>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH -mm 0/4] MIPS BCM947xx CPUs support
Date:	Tue, 7 Aug 2007 15:13:23 +0200
User-Agent: KMail/1.9.6
Cc:	Aurelien Jarno <aurelien@aurel32.net>,
	Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	Waldemar Brodkorb <wbx@openwrt.org>,
	Felix Fietkau <nbd@openwrt.org>,
	Florian Schirmer <jolt@tuxbox.org>
References: <20070806150701.GE24308@hall.aurel32.net> <20070807125521.GA23739@linux-mips.org>
In-Reply-To: <20070807125521.GA23739@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200708071513.23793.mb@bu3sch.de>
Return-Path: <mb@bu3sch.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16109
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mb@bu3sch.de
Precedence: bulk
X-list: linux-mips

On Tuesday 07 August 2007 14:55:21 Ralf Baechle wrote:
> > I am submitting those patches for inclusion into -mm as they depend
> > on features that are not present in the linux-mips git tree, but are
> > present in the -mm series, namely Sonic Silicon Backplane bus support.
> 
> That won't fly as akpm is pulling from the MIPS tree also, so there
> will be conflicts really soon.

?
I don't see why this should conflict.
The patches are in mm currently.

-- 
Greetings Michael.
