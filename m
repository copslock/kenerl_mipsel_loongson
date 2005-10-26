Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Oct 2005 18:26:49 +0100 (BST)
Received: from ns1.pioneer-pra.com ([65.205.244.70]:63035 "EHLO
	mail1.dmz.sj.pioneer-pra.com") by ftp.linux-mips.org with ESMTP
	id S8133563AbVJZR02 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Oct 2005 18:26:28 +0100
Received: from localhost (localhost [127.0.0.1])
	by mail1.dmz.sj.pioneer-pra.com (Postfix) with ESMTP id B6D6D39002E;
	Wed, 26 Oct 2005 10:26:23 -0700 (PDT)
Received: from mail1.dmz.sj.pioneer-pra.com ([127.0.0.1])
 by localhost (neo1 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 20336-06; Wed, 26 Oct 2005 10:26:23 -0700 (PDT)
Received: from eo (unknown [65.244.224.162])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by mail1.dmz.sj.pioneer-pra.com (Postfix) with ESMTP id 8106A39002D;
	Wed, 26 Oct 2005 10:26:22 -0700 (PDT)
From:	"Mike C. Ward" <mward@pioneer-pra.com>
To:	"'kernel coder'" <lhrkernelcoder@gmail.com>
Cc:	<linux-mips@linux-mips.org>
Subject: RE: Porting oprofile to 2.4.32 kernel
Date:	Wed, 26 Oct 2005 10:25:55 -0700
Message-ID: <013701c5da52$5399a9c0$5502020a@eo>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <20051026135414.GD3161@linux-mips.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Importance: Normal
Return-Path: <mward@pioneer-pra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mward@pioneer-pra.com
Precedence: bulk
X-list: linux-mips

But if you wanted to undertake that cause nonetheless, you
could check out the patch I did to 2.4.25 
at 
http://oss.pioneer-pra.com/oprofile/

Mike

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Ralf Baechle
> Sent: Wednesday, October 26, 2005 6:54 AM
> To: kernel coder
> Cc: linux-mips@linux-mips.org
> Subject: Re: Porting oprofile to 2.4.32 kernel
> 
> 
> On Wed, Oct 26, 2005 at 02:34:07AM -0700, kernel coder wrote:
> 
> >    i'm trying to port oprofile on 2.4.32 kernel running on MIPS 
> > board.From where can i  get the patch for other boards so 
> that i can 
> > make a head start by using that patch as a guide.
> 
> Oprofile for 2.4 is considered a lost cause on any 
> architecture and I guess I'd rather do something sensible 
> like ironing snowflakes than porting it at this stage where 
> funeral eulogies for 2.4 are already being written ;-)
> 
>   Ralf
> 
> 
