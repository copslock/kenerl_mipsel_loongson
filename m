Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jan 2005 17:30:36 +0000 (GMT)
Received: from web25110.mail.ukl.yahoo.com ([IPv6:::ffff:217.12.10.58]:46452
	"HELO web25110.mail.ukl.yahoo.com") by linux-mips.org with SMTP
	id <S8225399AbVANRac>; Fri, 14 Jan 2005 17:30:32 +0000
Received: (qmail 95444 invoked by uid 60001); 14 Jan 2005 17:30:25 -0000
Message-ID: <20050114173025.95442.qmail@web25110.mail.ukl.yahoo.com>
Received: from [80.14.198.143] by web25110.mail.ukl.yahoo.com via HTTP; Fri, 14 Jan 2005 18:30:25 CET
Date: Fri, 14 Jan 2005 18:30:25 +0100 (CET)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: initrd support.
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: linux-mips@linux-mips.org
In-Reply-To: <20050114154147.GM31149@rembrandt.csv.ica.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <francis_moreau2000@yahoo.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: francis_moreau2000@yahoo.fr
Precedence: bulk
X-list: linux-mips

 --- Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
a écrit : 
> Actually, there are three:
> - the generic initramfs method for compiled in
> initrds
what's the difference with the rd_start/rd_size method
?

> - the addinitrd method to attach a initrd to a
> precompiled kernel
>   image (which is old, and essentially unmaintained)
why is it still in kernel's tree ? Is it going to be
removed ?

> - the rd_start/rd_size method, which allows a
> bootloader to load both
>   kernel and initrd images into memory and then
> tells the kernel via
>   the rd_start/rd_size parameters where the initrd
> is located
Why do I need to provide rd_start/ rd_size setup
parameters ? It's already provided by vmlinux.lds.S.

thanks,

Francis.



	

	
		
Découvrez le nouveau Yahoo! Mail : 250 Mo d'espace de stockage pour vos mails ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com/
