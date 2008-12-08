Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Dec 2008 20:46:21 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:36550 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24207505AbYLHUqR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 Dec 2008 20:46:17 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B493d876e0002>; Mon, 08 Dec 2008 15:45:39 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 8 Dec 2008 12:44:44 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 8 Dec 2008 12:44:44 -0800
Message-ID: <493D873C.3020202@caviumnetworks.com>
Date:	Mon, 08 Dec 2008 12:44:44 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.18 (X11/20081119)
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
CC:	linux-ide@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] libata: Add two more columns to the ata_timing table.
References: <4939B402.9010004@caviumnetworks.com> <1228518561-16242-1-git-send-email-ddaney@caviumnetworks.com> <493ADE48.6050709@ru.mvista.com> <493D65C8.2060808@caviumnetworks.com> <493D6C0F.7070809@ru.mvista.com> <493D6DA1.3090801@ru.mvista.com>
In-Reply-To: <493D6DA1.3090801@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Dec 2008 20:44:44.0505 (UTC) FILETIME=[CD2C5490:01C95975]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Sergei Shtylyov wrote:

>    OK, t6z is yet longer than t9 but putting it into the table seems 
> pointless anyway as it's fixed at 30 ns, at least for the standard 5 PIO 
> modes (and for other two modes 30 ns would be good anyway).
>    Though frankly speaking I don't quite understand your care for this 
> timing, if the ATA standard permits -CE deasserted and data bus being 
> driven to overlap.

It doesn't matter what the ATA standard permits in this case.  We need 
to assure that the OCTEON Boot Bus standard is respected.  There are 
several timing parameters that we have to set based on the documented 
properties of the device.  Ideally if we try to run bus cycles for 
non-ATA/CF devices that share the signal lines of the Boot Bus, they 
should  not interfere with the CF interface.

David Daney
