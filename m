Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jun 2005 10:15:00 +0100 (BST)
Received: from web25806.mail.ukl.yahoo.com ([IPv6:::ffff:217.12.10.191]:60004
	"HELO web25806.mail.ukl.yahoo.com") by linux-mips.org with SMTP
	id <S8224976AbVFUJOg>; Tue, 21 Jun 2005 10:14:36 +0100
Received: (qmail 55714 invoked by uid 60001); 21 Jun 2005 09:14:29 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=yibFwH+p+xnej1oYGpDT1Vek2vpRIU3Ofcsy5hd3AYwZiPn81DRdiyICyNI1ajEFNACXtZLvEH/TyIy9HQmxVAIv3hMFl8YjnchpeYdHcb8WyhPZSTqZyPZZG/FVBoIPqR24ozQLbWf3qSADvb7yUuVsR1+EJeae+QBC63C2iZo=  ;
Message-ID: <20050621091429.55712.qmail@web25806.mail.ukl.yahoo.com>
Received: from [217.167.142.149] by web25806.mail.ukl.yahoo.com via HTTP; Tue, 21 Jun 2005 11:14:28 CEST
Date:	Tue, 21 Jun 2005 11:14:28 +0200 (CEST)
From:	moreau francis <francis_moreau2000@yahoo.fr>
Subject: Using a hal lib in Linux.
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <francis_moreau2000@yahoo.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: francis_moreau2000@yahoo.fr
Precedence: bulk
X-list: linux-mips

Hi all,

I've got a mips board provided with a library that deals with hardware
management.
This library have been compiled with "sde-lite" gcc. I'm thinking of using this
lib into my linux drivers to speed up developement process. Has anyone made
kernel
modifications (specially in Makefiles) in order to link such hal lib into
kernel
code ?

Thanks

       Francis


	

	
		
___________________________________________________________________________ 
Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
Téléchargez cette version sur http://fr.messenger.yahoo.com
