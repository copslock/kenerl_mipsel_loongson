Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Sep 2006 19:06:54 +0100 (BST)
Received: from web31501.mail.mud.yahoo.com ([68.142.198.130]:13156 "HELO
	web31501.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20038661AbWISSGw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 Sep 2006 19:06:52 +0100
Received: (qmail 8124 invoked by uid 60001); 19 Sep 2006 18:06:45 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=xcfkaUsYIKR7Z6UVAjPlrxV67sLnuQNOkq1CEWlMTb8KjJT2CnqQFBWPl3OtO0o8+pcTNTEiGCd943UNH/iJGvG7hJhyKTDY0X7oFxhcad163u6OOsqhBONQkrNEDInECJKlgXEVwrcvC0y0Mnnvw6l4gnT5b69aSD+l2lgfGvQ=  ;
Message-ID: <20060919180645.8122.qmail@web31501.mail.mud.yahoo.com>
Received: from [70.103.67.194] by web31501.mail.mud.yahoo.com via HTTP; Tue, 19 Sep 2006 11:06:45 PDT
Date:	Tue, 19 Sep 2006 11:06:45 -0700 (PDT)
From:	Jonathan Day <imipak@yahoo.com>
Subject: RE: Kernel debugging contd.
To:	Mark E Mason <mark.e.mason@broadcom.com>, linux-mips@linux-mips.org
In-Reply-To: <7E000E7F06B05C49BDBB769ADAF44D070111E24B@NT-SJCA-0750.brcm.ad.broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12599
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips

I would guess I can fix the problem by simply
cutting-and-pasting the SB1 codes back in and then
changing the calls. (If there's a patch for this out
there, that would be even easier...! :)

Out of curiosity, any idea why the code was switched
to a generic implementation?

--- Mark E Mason <mark.e.mason@broadcom.com> wrote:

> Hello,
> 
> FWIW - this is the same place my boards are hanging
> (right after freeing
> kernel memory).  I'd tracked it down to the commit
> that changed the
> cache/page handling for the sibyte parts from the
> sb1 specific to the
> generic codes -- but haven't found time to look into
> it further as yet.
> 
> /Mark 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
