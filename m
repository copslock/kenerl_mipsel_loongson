Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2006 13:25:35 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:27304 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20038415AbWLHNZa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 8 Dec 2006 13:25:30 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 615113EC9; Fri,  8 Dec 2006 05:25:26 -0800 (PST)
Message-ID: <45796826.4060209@ru.mvista.com>
Date:	Fri, 08 Dec 2006 16:27:02 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Vitaly Wool <vitalywool@gmail.com>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH][respin] add STB810 support (Philips PNX8550-based)
References: <20061208114035.000049c4.vitalywool@gmail.com> <45796661.7070600@ru.mvista.com>
In-Reply-To: <45796661.7070600@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, I wrote:

>> +#
>> +# Partition Types
>> +#
>> +# CONFIG_PARTITION_ADVANCED is not set
>> +CONFIG_MSDOS_PARTITION=y

>    I doubt this kernel needs iSCSI crap even as modules but well...

    Oh, sorry, cut-n-paste issue. I meant to also complain about [V]FAT 
support in-kernel...

WBR, Sergei
