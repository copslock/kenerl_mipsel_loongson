Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2005 14:49:48 +0100 (BST)
Received: from web25807.mail.ukl.yahoo.com ([IPv6:::ffff:217.12.10.192]:53636
	"HELO web25807.mail.ukl.yahoo.com") by linux-mips.org with SMTP
	id <S8225531AbVFWNt3>; Thu, 23 Jun 2005 14:49:29 +0100
Received: (qmail 73799 invoked by uid 60001); 23 Jun 2005 13:48:25 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=KpB6YPCN68QcMIZIlLs5B2Ns8tAunwiFR3OOassj/Qmu7mwgwpCoKWrndVKEyUvnFTokx4LwN1fiRRk6T8W+pvwRlJrrQtd4MnDVL+VQpETjd4uXFnKTHst4Eo8hh8RrbcK4KPdDM7JK/aewYn9MMCxo2pvuo2OsMMlQsJfhygE=  ;
Message-ID: <20050623134825.73797.qmail@web25807.mail.ukl.yahoo.com>
Received: from [217.167.142.149] by web25807.mail.ukl.yahoo.com via HTTP; Thu, 23 Jun 2005 15:48:25 CEST
Date:	Thu, 23 Jun 2005 15:48:25 +0200 (CEST)
From:	moreau francis <francis_moreau2000@yahoo.fr>
Subject: CONFIG_HZ for mips
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <francis_moreau2000@yahoo.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: francis_moreau2000@yahoo.fr
Precedence: bulk
X-list: linux-mips

Hi,

A patch is being integrated into the kernel in order to be able to tune HZ
value while configuring the kernel. The values can be 100, 250, 1000 and
default value has been moved to 250. The patch is for i386 arch.

Why not doing the same on mips arch ?
BTW why the default value on mips is 1000 ?

thanks

        Francis


	

	
		
___________________________________________________________________________ 
Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
Téléchargez cette version sur http://fr.messenger.yahoo.com
