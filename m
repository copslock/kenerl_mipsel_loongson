Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2008 17:05:13 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:65038 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23909389AbYKYRFK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Nov 2008 17:05:10 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B492c30330002>; Tue, 25 Nov 2008 12:04:51 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 25 Nov 2008 09:04:49 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 25 Nov 2008 09:04:49 -0800
Message-ID: <492C3031.2000408@caviumnetworks.com>
Date:	Tue, 25 Nov 2008 09:04:49 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Jeff Garzik <jeff@garzik.org>
CC:	linux-ide@vger.kernel.org, linux-mips@linux-mips.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] libata: Add three more columns to the ata_timing
 table.
References: <492B56B0.9030409@caviumnetworks.com> <1227577181-30206-1-git-send-email-ddaney@caviumnetworks.com> <492C2F23.8050105@garzik.org>
In-Reply-To: <492C2F23.8050105@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Nov 2008 17:04:49.0246 (UTC) FILETIME=[ECD0D7E0:01C94F1F]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21421
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Jeff Garzik wrote:
> David Daney wrote:
>> The forthcoming OCTEON SOC Compact Flash driver needs a few more
>> timing values than were available in the ata_timing table.  I add new
>> columns for write_hold, read_hold, and read_holdz times.  The values
>> were obtained from the Compact Flash specification Rev 4.1.
>>
>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
>> ---
>>  drivers/ata/libata-core.c |   76 
>> ++++++++++++++++++++++++--------------------
>>  include/linux/libata.h    |   14 ++++++--
>>  2 files changed, 52 insertions(+), 38 deletions(-)
> 
> I would be happy to go ahead and apply this...  Alan, any last minute 
> objections?
> 

Sergei had some comments that I am trying to address.  Perhaps we should 
hold off a little, while I figure out how what to do WRT those comments.

David Daney
