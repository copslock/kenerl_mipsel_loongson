Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2010 03:30:41 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8623 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492781Ab0BCCag (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2010 03:30:36 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b68dfd20001>; Tue, 02 Feb 2010 18:30:42 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 2 Feb 2010 18:29:44 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 2 Feb 2010 18:29:44 -0800
Message-ID: <4B68DF98.4080501@caviumnetworks.com>
Date:   Tue, 02 Feb 2010 18:29:44 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Ben Dooks <ben-linux@fluff.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-i2c@vger.kernel.org, khali@linux-fr.org,
        rade.bozic.ext@nsn.com,
        Michael Lawnick <michael.lawnick.ext@nsn.com>
Subject: Re: [PATCH] I2C: Add driver for Cavium OCTEON I2C ports.
References: <1264711627-24304-1-git-send-email-ddaney@caviumnetworks.com> <20100128234113.GC13143@linux-mips.org> <20100203022404.GB24325@fluff.org.uk>
In-Reply-To: <20100203022404.GB24325@fluff.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Feb 2010 02:29:44.0858 (UTC) FILETIME=[BF7447A0:01CAA478]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25865
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Ben Dooks wrote:
> On Fri, Jan 29, 2010 at 12:41:13AM +0100, Ralf Baechle wrote:
>> On Thu, Jan 28, 2010 at 12:47:07PM -0800, David Daney wrote:
>>
>> Thanks, I've replaced the queue patch with this one.
> 
> I'd rather avoid a cross-tree merge if possible. Is there anything
> stopping it being added to my next-i2c tree?
>  

I can't speak to the logistics, but I would note that there are two 
related MIPS specific patches that add the platform device and register 
some i2c_board_info.  I don't know if it would make sense to merge them 
all via the same path.

I will let you and Ralf decide that.

In any event thanks for looking at the patches,
David Daney



>>   Ralf
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
