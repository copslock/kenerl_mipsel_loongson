Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Dec 2004 02:08:11 +0000 (GMT)
Received: from alpha.total-knowledge.com ([IPv6:::ffff:209.157.135.102]:9113
	"EHLO alpha.total-knowledge.com") by linux-mips.org with ESMTP
	id <S8224947AbULVCIG>; Wed, 22 Dec 2004 02:08:06 +0000
Received: (qmail 7644 invoked from network); 21 Dec 2004 09:13:37 -0800
Received: from c-24-6-216-150.client.comcast.net (HELO ?192.168.0.238?) (24.6.216.150)
  by alpha.total-knowledge.com with SMTP; 21 Dec 2004 09:13:37 -0800
Message-ID: <41C8D6F5.2080007@total-knowledge.com>
Date: Tue, 21 Dec 2004 18:07:49 -0800
From: "Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Organization: Total Knowledge
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040918
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: moreau francis <francis_moreau2000@yahoo.fr>
CC: linux-mips@linux-mips.org
Subject: Re: port on exotic board.
References: <20041221085307.3009.qmail@web25107.mail.ukl.yahoo.com> <20041222012715.GA13782@gw.junsun.net>
In-Reply-To: <20041222012715.GA13782@gw.junsun.net>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ilya@total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@total-knowledge.com
Precedence: bulk
X-list: linux-mips

CPHYSADDR gives you physical address from an address that lies in
one of compatibility "unmapped" spaces. "compatibility" in this case refers
to 32bit MIPS view of memory space.

As such, CPHYSADDR macro generally should not be used.

Jun Sun wrote:

>>I noticed CPHYSADDR macro. This macro only works if
>>PAGE_OFFSET is equal to 0x80000000. Why does this 
>>macro exist ? Why not using __pa macro ?
>>    
>>
>
>Don't know much about this one.
>
>BTW, once there was a board whose memory starts from 0x90000000.  It had
>similar problems as yours, but I think it ran in the end.  Try to search
>the mailing list.
>
>Jun
>
>  
>
