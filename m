Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Apr 2005 18:59:48 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.171]:32752
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8224923AbVDFR7e>; Wed, 6 Apr 2005 18:59:34 +0100
Received: from c155208.adsl.hansenet.de[213.39.155.208] (helo=c155208.adsl.hansenet.de)
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0MKwtQ-1DJEoM3qpU-0005IE; Wed, 06 Apr 2005 19:59:30 +0200
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Re: Au1100 FB driver uplift for 2.6
Date:	Wed, 6 Apr 2005 19:58:17 +0200
User-Agent: KMail/1.7.1
References: <200504041717.29098.eckhardt@satorlaser.com> <200504061131.38457.eckhardt@satorlaser.com> <425405E7.5060003@embeddedalley.com>
In-Reply-To: <425405E7.5060003@embeddedalley.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504061958.18023.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7614
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

On Wednesday 06 April 2005 17:53, Pete Popov wrote:
> I checked in a patch that was an uplift for 2.6 a couple of days ago. I'm
> sorry, I didn't catch your email in time to let you know that someone else
> is working on a patch. 

Pete, nothing to be sorry for, I wasn't working on anything. Point is that I 
grabbed a patch from someone else here (around 3 months ago) that updated the 
bitrotted 2.6 code to a usable state. Your version now is in some aspects 
even cleaner that that code and I'm in fact referring to the changes you 
committed a few days ago.

> If you're willing to pull the latest code and see 
> what it makes sense to merge from your code, including the new panel
> support, and send me that patch, I'll apply it.

I continuously track the latest changes, and merging the panel is perfectly 
painless, apart from this one thing with the clock setup.

thanks for your work

Uli
