Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Nov 2007 08:07:40 +0000 (GMT)
Received: from mail.domino-printing.com ([64.212.99.82]:1804 "EHLO
	uk-hc-ps3.domino-printing.com") by ftp.linux-mips.org with ESMTP
	id S20027284AbXKBIHb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 2 Nov 2007 08:07:31 +0000
Received: from emea-exchange3.emea.dps.local (emea-exchange3.emea.dps.local) 
    by uk-hc-ps3.domino-printing.com (Clearswift SMTPRS 5.2.9) with ESMTP 
    id <T830bdd2b1840d4635239c@uk-hc-ps3.domino-printing.com> for 
    <linux-mips@linux-mips.org>; Fri, 2 Nov 2007 08:22:39 +0000
Received: from tuxator2.emea.dps.local ([192.168.55.75]) by 
    emea-exchange3.emea.dps.local with Microsoft SMTPSVC(6.0.3790.1830); 
    Fri, 2 Nov 2007 09:06:01 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Put cast inside macro instead of all the callers
Date:	Fri, 2 Nov 2007 09:06:00 +0100
User-Agent: KMail/1.9.7
References: <20071031141124.185599da@ripper.onstor.net> 
    <200711011704.01079.eckhardt@satorlaser.com>
In-Reply-To: <200711011704.01079.eckhardt@satorlaser.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200711020906.00670.eckhardt@satorlaser.com>
X-OriginalArrivalTime: 02 Nov 2007 08:06:01.0424 (UTC) 
    FILETIME=[353DED00:01C81D27]
Return-Path: <Eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

On Thursday 01 November 2007, Ulrich Eckhardt wrote:
[...]
> - slightly puzzled -

Andrew, Ralf, thanks for the clarifications!

Uli

-- 
Sator Laser GmbH
Geschäftsführer: Michael Wöhrmann, Amtsgericht Hamburg HR B62 932

**************************************************************************************
           Visit our website at <http://www.satorlaser.de/>
**************************************************************************************
Diese E-Mail einschließlich sämtlicher Anhänge ist nur für den Adressaten bestimmt und kann vertrauliche Informationen enthalten. Bitte benachrichtigen Sie den Absender umgehend, falls Sie nicht der beabsichtigte Empfänger sein sollten. Die E-Mail ist in diesem Fall zu löschen und darf weder gelesen, weitergeleitet, veröffentlicht oder anderweitig benutzt werden.
E-Mails können durch Dritte gelesen werden und Viren sowie nichtautorisierte Änderungen enthalten. Sator Laser GmbH ist für diese Folgen nicht verantwortlich.

**************************************************************************************
