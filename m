Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2007 12:38:15 +0100 (BST)
Received: from arrakis.dune.hu ([195.56.146.235]:49072 "EHLO arrakis.dune.hu")
	by ftp.linux-mips.org with ESMTP id S20022089AbXHBLiN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Aug 2007 12:38:13 +0100
Received: from localhost (localhost [127.0.0.1])
	by arrakis.dune.hu (Postfix) with ESMTP id CF5167840B5;
	Thu,  2 Aug 2007 13:38:12 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from arrakis.dune.hu ([127.0.0.1])
	by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Da+yQTbgBVfa; Thu,  2 Aug 2007 13:38:06 +0200 (CEST)
Received: from ecaz.afh.b-m.hu (firewall.ahiv.hu [195.228.168.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by arrakis.dune.hu (Postfix) with ESMTP id A1FB17840C5;
	Thu,  2 Aug 2007 13:38:06 +0200 (CEST)
Date:	Thu, 02 Aug 2007 13:38:06 +0200
To:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: Sync SiByte system code to the new DUART driver
From:	"Imre Kaloz" <kaloz@openwrt.org>
Organization: OpenWrt - Wireless Freedom
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
MIME-Version: 1.0
References: <op.twfh4cuw2s3iss@ecaz.afh.b-m.hu> <20070802111314.GA25949@linux-mips.org> <Pine.LNX.4.64N.0708021218280.22591@blysk.ds.pg.gda.pl>
Content-Transfer-Encoding: 7bit
Message-ID: <op.twfjxsl32s3iss@ecaz.afh.b-m.hu>
In-Reply-To: <Pine.LNX.4.64N.0708021218280.22591@blysk.ds.pg.gda.pl>
Return-Path: <kaloz@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16021
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaloz@openwrt.org
Precedence: bulk
X-list: linux-mips

On Thu, 02 Aug 2007 13:26:22 +0200, Maciej W. Rozycki  
<macro@linux-mips.org> wrote:

>  Most of that stuff does not work anymore anyway and now you risk link
> errors. ;-)  I do not think there is place for driver-related #ifdefs
> under arch/ anyway, the answer being platform devices.  Though chances  
> are
> nobody might be bothered to ever implement them here.
>
>  Also the #ifdefs in arch/mips/sibyte/cfe/console.c do not make sense to
> me.
>


True, but as I've said Ralf on IRC, I was fixing a bug rather then doing  
an overhaul. My TODO list for today is too long to save the world, but  
maybe I'll have time for that tomorrow ;)
I think the whole sibyte target should be cleaned up and changed to  
support runtime board detection like we do it on bcm47xx/53xx and  
ar231x/5312 in OpenWrt.


Imre
