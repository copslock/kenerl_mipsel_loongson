Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jul 2004 12:41:09 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:55057
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8226066AbUGFLlF>; Tue, 6 Jul 2004 12:41:05 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1BhoJr-0005EP-00; Tue, 06 Jul 2004 13:41:03 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1BhoJq-0003QU-00; Tue, 06 Jul 2004 13:41:02 +0200
Date: Tue, 6 Jul 2004 13:41:02 +0200
To: Thomas Kunze <thomas.kunze@xmail.net>
Cc: linux-mips@linux-mips.org
Subject: Re: Linux on SNI RM300E ?
Message-ID: <20040706114102.GC21982@rembrandt.csv.ica.uni-stuttgart.de>
References: <038c01c46334$38621de0$0200000a@ALEC> <1089105260.40ea6d6cf2f9c@www.x-mail.net> <20040706100647.GB21982@rembrandt.csv.ica.uni-stuttgart.de> <1089110887.40ea8367df720@www.x-mail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089110887.40ea8367df720@www.x-mail.net>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5408
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Thomas Kunze wrote:
> Quoting Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>:
> 
> > It is, AFAIK. But the woody kernel is for a SGI Indy/Indigo2, not for
> > RM300E. The linux-mips.org tree has only support for RM200C, adding
> > support for RM300E is probably not that complicated if it is similiar
> > enough.
> 
> OK. what are the next steps to get a bigendian bootimage for the RM300E? 
> are there any sources available to compile for the RM300? 
> is there a bootimage for the RM200C that i can give a try?

I would try current CVS HEAD, compile the RM200C configuration and
see where it dies. No need to bother about a complete boot image
at this stage. Welcome to the world of kernel porting. :-)

(You need a kernel converted to ECOFF for this, like it is done
for some other machines via elf2ecoff.)


Thiemo
