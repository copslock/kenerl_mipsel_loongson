Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 May 2007 11:11:47 +0100 (BST)
Received: from mail.domino-printing.com ([64.212.99.82]:9221 "EHLO
	UK-HC-PS1.domino-printing.com") by ftp.linux-mips.org with ESMTP
	id S20022384AbXEIKLp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 9 May 2007 11:11:45 +0100
Received: from emea-exchange3.emea.dps.local (emea-exchange3.emea.dps.local) 
    by UK-HC-PS1.domino-printing.com (Clearswift SMTPRS 5.2.5) with ESMTP 
    id <T7f7cf3d8fb40d46352f78@UK-HC-PS1.domino-printing.com> for 
    <linux-mips@linux-mips.org>; Wed, 9 May 2007 11:13:22 +0100
Received: from tuxator2.emea.dps.local ([192.168.55.75]) by 
    emea-exchange3.emea.dps.local with Microsoft SMTPSVC(6.0.3790.1830); 
    Wed, 9 May 2007 12:13:27 +0200
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Re: PCI video card on SGI O2
Date:	Wed, 9 May 2007 12:12:31 +0200
User-Agent: KMail/1.9.5
References: <1978.129.133.142.66.1178605460.squirrel@webmail.wesleyan.edu> 
    <876473x0jx.wl@betelheise.deep.net> 
    <Pine.LNX.4.64.0705080920150.24717@anakin>
In-Reply-To: <Pine.LNX.4.64.0705080920150.24717@anakin>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200705091212.32061.eckhardt@satorlaser.com>
X-OriginalArrivalTime: 09 May 2007 10:13:27.0778 (UTC) 
    FILETIME=[AFB53420:01C79222]
Return-Path: <Eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

On Tuesday 08 May 2007 09:22, Geert Uytterhoeven wrote:
> It's a pity the Millenium doesn't fit, as matroxfb is about the only
> frame buffer device that can initialize a graphics card from scratch,
> without help from the BIOS...

I'm not sure if this is the same thing you are referring to, but I have a G4 
Mac Mini which has a Radeon 9200 chip. The autodetection does not find a BIOS 
ROM (is that what you meant?) but it works nonetheless, both with FB and 
X.org. From reading the sources, it seems that this is even normal, in 
particular for embedded graphic chips as typically found in laptops.

Uli

-- 
Sator Laser GmbH
Geschäftsführer: Ronald Boers, Amtsgericht Hamburg HR B62 932

**************************************************************************************
           Visit our website at <http://www.satorlaser.de/>
**************************************************************************************
Diese E-Mail einschließlich sämtlicher Anhänge ist nur für den Adressaten bestimmt und kann vertrauliche Informationen enthalten. Bitte benachrichtigen Sie den Absender umgehend, falls Sie nicht der beabsichtigte Empfänger sein sollten. Die E-Mail ist in diesem Fall zu löschen und darf weder gelesen, weitergeleitet, veröffentlicht oder anderweitig benutzt werden.
E-Mails können durch Dritte gelesen werden und Viren sowie nichtautorisierte Änderungen enthalten. Sator Laser GmbH ist für diese Folgen nicht verantwortlich.

**************************************************************************************
