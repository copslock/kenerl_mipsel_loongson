Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jun 2005 08:23:32 +0100 (BST)
Received: from web25802.mail.ukl.yahoo.com ([IPv6:::ffff:217.12.10.187]:43644
	"HELO web25802.mail.ukl.yahoo.com") by linux-mips.org with SMTP
	id <S8225507AbVFXHXO>; Fri, 24 Jun 2005 08:23:14 +0100
Received: (qmail 42177 invoked by uid 60001); 24 Jun 2005 07:22:14 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Nt1DRHqN8ZfPBkGyWCc7XfSdwNikgagbxglXn1hyEvrZ1iymzui//ZBxTTfXfCjx1wx51TpnpsMZ2/NeJZ1z48xZbDjqUGljkC6mZrwcTp+ju4PmRhnLCpB7cPni200Yd9NGW336992JluROBD12vcAIWP/M1sajXBNjQTsePQM=  ;
Message-ID: <20050624072214.42175.qmail@web25802.mail.ukl.yahoo.com>
Received: from [217.167.142.149] by web25802.mail.ukl.yahoo.com via HTTP; Fri, 24 Jun 2005 09:22:14 CEST
Date:	Fri, 24 Jun 2005 09:22:14 +0200 (CEST)
From:	moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: CONFIG_HZ for mips
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <Pine.LNX.4.61L.0506231457200.17155@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <francis_moreau2000@yahoo.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: francis_moreau2000@yahoo.fr
Precedence: bulk
X-list: linux-mips

Hi,

--- "Maciej W. Rozycki" <macro@linux-mips.org> a écrit :

>  Well, you are welcomed to submit a patch.  Except our situation a bit 
> more complicated as some platforms these values and may need something 
> like 128, 256 or 1024 instead.  This should be properly taken care of.
> 

hmm, each time I sent a patch, it goes into /dev/null. So I believe that is
because of my poor programming skills, I prefer the job done by someone
skiller than me ;)

I grep for HZ in mips arch and can find only 100, 128 and 1000 values.
What is the difference between 100 and 128 ?

thanks,

            Francis


	

	
		
___________________________________________________________________________ 
Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
Téléchargez cette version sur http://fr.messenger.yahoo.com
