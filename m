Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Dec 2002 22:00:55 +0100 (CET)
Received: from port48.ds1-vbr.adsl.cybercity.dk ([212.242.58.113]:3400 "EHLO
	ubik.localnet") by linux-mips.org with ESMTP id <S8225193AbSLJVAy>;
	Tue, 10 Dec 2002 22:00:54 +0100
Received: from murphy.dk (brm@brian.localnet [10.0.0.2])
	by ubik.localnet (8.12.3/8.12.3/Debian -4) with ESMTP id gBAL0lqG006133;
	Tue, 10 Dec 2002 22:00:47 +0100
Message-ID: <3DF655FF.80508@murphy.dk>
Date: Tue, 10 Dec 2002 22:00:47 +0100
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: linux-mips@linux-mips.org
CC: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: update_mmu_cache bug
References: <20021210191801.GF609@gateway.total-knowledge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <brian@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian@murphy.dk
Precedence: bulk
X-list: linux-mips

ilya@theIlya.com wrote:

>Following small patch is needed to prevent kernel from going into infinite loop
>on page_fault. Probably similar patches are needed for other CPUs as well,
>but since I don;t have any, I'll let those who do take care of that :)
>
>	Ilya.
>
>  
>
It also seems not to work for the 32 bit kernel. The macro for

pte_offset_map

is very different in pgtable.h in the 32 bit directory than the 64 bit.

(Is there a good reason for this Ralf?)

/Brian
