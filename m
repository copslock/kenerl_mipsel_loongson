Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Feb 2005 09:03:19 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.184]:14833
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225334AbVBBJDD>; Wed, 2 Feb 2005 09:03:03 +0000
Received: from [212.227.126.160] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1CwGPe-0003FD-00; Wed, 02 Feb 2005 10:03:02 +0100
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1CwGPc-0007Mn-00; Wed, 02 Feb 2005 10:03:01 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH] au1100fb.c ported from 2.4 to 2.6
Date:	Wed, 2 Feb 2005 10:05:18 +0100
User-Agent: KMail/1.7.1
Cc:	Christian <c.pellegrin@exadron.com>
References: <1105523407.5654.18.camel@absolute.ascensit.com>
In-Reply-To: <1105523407.5654.18.camel@absolute.ascensit.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502021005.18589.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Christian wrote:
> works in 16bpp, anyone with a system that works in 8bbp can give me a
> hand to test this mode?

I have a system that has a 4bpp monochrome display and the driver doesn't 
work. After initializing, it turns on the display[1] but I fail to get any 
content onto it. I extended the array with the display characteristics 
according to an existing driver, but to no avail.

I'm pretty lost there, since I have zero prior experience with framebuffers or 
video drivers, so I'd appreciate any hint that might get me towards debugging 
this.

Uli

[1] p_lcd_reg->lcd_control |= LCD_CONTROL_GO;
