Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Feb 2007 08:20:45 +0000 (GMT)
Received: from mail.domino-uk.com ([193.131.116.193]:44561 "EHLO
	UK-HC-PS1.domino-printing.com") by ftp.linux-mips.org with ESMTP
	id S20037844AbXBHIUl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Feb 2007 08:20:41 +0000
Received: from emea-exchange3.emea.dps.local (EMEA-EXCHANGE3) by 
    UK-HC-PS1.domino-printing.com (Clearswift SMTPRS 5.2.5) with ESMTP id 
    <T7dacdab1bcc18374c1ce0@UK-HC-PS1.domino-printing.com> for 
    <linux-mips@linux-mips.org>; Thu, 8 Feb 2007 08:22:05 +0000
Received: from tuxator2.emea.dps.local ([192.168.55.75]) by 
    emea-exchange3.emea.dps.local with Microsoft SMTPSVC(6.0.3790.1830); 
    Thu, 8 Feb 2007 09:22:04 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH] eXcite nand flash driver
Date:	Thu, 8 Feb 2007 09:20:12 +0100
User-Agent: KMail/1.9.5
References: <200702080157.25432.thomas.koeller@baslerweb.com>
In-Reply-To: <200702080157.25432.thomas.koeller@baslerweb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200702080920.12723.eckhardt@satorlaser.com>
X-OriginalArrivalTime: 08 Feb 2007 08:22:04.0500 (UTC) 
    FILETIME=[36FC6940:01C74B5A]
Return-Path: <Eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Just some cosmetic notes ...

On Thursday 08 February 2007 01:57, Thomas Koeller wrote:
> @@ -216,10 +216,26 @@ config MTD_NAND_DISKONCHIP_BBTWRITE
>  	  Even if you leave this disabled, you can enable BBT writes at module
>  	  load time (assuming you build diskonchip as a module) with the module
>  	  parameter "inftl_bbt_write=1".
> -
> +

This just inserts whitespace.

>         tristate "NAND support for OLPC CAFÉ chip"

The accent on the E might cause problems, but I'm not sure.

> +#define io_readb(__a__)		__raw_readb((__a__))
> +#define io_writeb(__v__, __a__)	__raw_writeb((__v__), (__a__))

I would have used an inline function. Also, aren't there functions to use IOs 
already? What's the reason here?

> +/* prefix for debug output */
> +static const char module_id[] = "excite_nandflash";

I'd have used

  static const char* module_id = "excite_nandflash";

except if you need the sizeof it to capture the length.

> +static inline const struct resource *excite_nand_get_resource
> +    (struct platform_device *d, unsigned long flags, const char *basename){
> +	const char fmt[] = "%s_%u";

Here, too, is no need for a local buffer, just use a pointer.

> +/* excite_nand_probe
> + *
> + * called by device layer when it finds a device matching
> + * one our driver can handled. [...]

"... when it finds a device our driver can handle."

Otherwise I'd say it looks very clean, better than quite some other stuff I 
have seen.

Uli

**************************************************************************************
           Visit our website at <http://www.satorlaser.de/>
**************************************************************************************
Diese E-Mail einschließlich sämtlicher Anhänge ist nur für den Adressaten bestimmt und kann vertrauliche Informationen enthalten. Bitte benachrichtigen Sie den Absender umgehend, falls Sie nicht der beabsichtigte Empfänger sein sollten. Die E-Mail ist in diesem Fall zu löschen und darf weder gelesen, weitergeleitet, veröffentlicht oder anderweitig benutzt werden.
E-Mails können durch Dritte gelesen werden und Viren sowie nichtautorisierte Änderungen enthalten. Sator Laser GmbH ist für diese Folgen nicht verantwortlich.

**************************************************************************************
