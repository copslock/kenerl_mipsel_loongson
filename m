Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 10:36:29 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:20666 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S22568038AbYJ1KgU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Oct 2008 10:36:20 +0000
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 4C32F3ECB; Tue, 28 Oct 2008 03:36:14 -0700 (PDT)
Message-ID: <4906EB1A.8050006@ru.mvista.com>
Date:	Tue, 28 Oct 2008 13:36:10 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: Re: [PATCH 02/36] Add Cavium OCTEON files to	arch/mips/include/asm/mach-cavium-octeon
References: <490655B6.4030406@caviumnetworks.com> <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com> <20081028075733.GB20858@linux-mips.org>
In-Reply-To: <20081028075733.GB20858@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ralf Baechle wrote:

>> +/**
>> + * Write a 32bit value to the Octeon NPI register space
>> + *
>> + * @param address Address to write to
>> + * @param val     Value to write
>> + */
>>     
>
> Linux coding style - comments are:
>
> /*
>  * blah frobnicate zumbitso
>  */
>
> sed is your friend to fix this.
>   

   This is kernel-doc style but looking wrong anyway. It should be:

/**
 * octeon_npi_write32 - write a 32bit value to the Octeon NPI register space
 *
 * @address:    address to write to
 * @val :         value to write
 */

WBR, Sergei
