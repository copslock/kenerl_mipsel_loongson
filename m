Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2006 21:16:12 +0000 (GMT)
Received: from sardaukar.technologeek.org ([213.41.134.240]:17024 "EHLO
	frigate.technologeek.org") by ftp.linux-mips.org with ESMTP
	id S8133815AbWCBVP5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Mar 2006 21:15:57 +0000
Received: by frigate.technologeek.org (Postfix, from userid 1000)
	id 86B011474E17; Thu,  2 Mar 2006 22:23:39 +0100 (CET)
From:	Julien BLACHE <jb@jblache.org>
To:	Michael Dosser <mic@nethack.at>
Cc:	linux-mips@linux-mips.org
Subject: Re: MIPS kernel status as of 2.6.16-rc5
References: <20060228214144.GA6615@deprecation.cyrius.com>
	<20060301100817.GB928@nethack.at>
Date:	Thu, 02 Mar 2006 22:23:39 +0100
In-Reply-To: <20060301100817.GB928@nethack.at> (Michael Dosser's message of
	"Wed, 1 Mar 2006 11:08:18 +0100")
Message-ID: <87d5h4wnfo.fsf@frigate.technologeek.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.17 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <jb@jblache.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jb@jblache.org
Precedence: bulk
X-list: linux-mips

Michael Dosser <mic@nethack.at> wrote:

Hi,

>>  - IP22: Indigo2 with > 256 MB fails to boot (regression from 2.4;
>>    while 2.4 would only see 256 MB, it would at least boot)
>
> Is there a chance, that even if it would boot with > 256 MB linux could
> actually use all 384 MB of RAM? If not, does anybody know why and can
> explain it (I am no kernel developer and know only very little about the
> I2 hardware)?

IIRC, a discontig memory implementation is needed for the I2 to use
more than 256 MB, due to the memory layout on this machine (with
aliased memory etc -- see the R3000 MC spec).

I kind of lost track of this issue recently, so I may have forgotten
some details and got part of the above totally wrong :)

JB.

-- 
Julien BLACHE                                   <http://www.jblache.org> 
<jb@jblache.org>                                  GPG KeyID 0xF5D65169
