Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Dec 2008 20:19:35 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:19484 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S24177068AbYLFUT0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 6 Dec 2008 20:19:26 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id B11B73ECB; Sat,  6 Dec 2008 12:19:20 -0800 (PST)
Message-ID: <493ADE48.6050709@ru.mvista.com>
Date:	Sat, 06 Dec 2008 23:19:20 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-ide@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] libata: Add two more columns to the ata_timing table.
References: <4939B402.9010004@caviumnetworks.com> <1228518561-16242-1-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1228518561-16242-1-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21545
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

David Daney wrote:

> The forthcoming OCTEON SOC Compact Flash driver needs a few more
> timing values than were available in the ata_timing table.  I add new
> columns for write_hold and read_holdz times.  The values were obtained
> from the Compact Flash specification Rev 4.1.

> Signed-off-by: David Daney <ddaney@caviumnetworks.com>

NAK.

> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index ed3f26e..95fa9f6 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
[...]
>  enum ata_xfer_mask {
> @@ -864,6 +868,8 @@ struct ata_timing {
>  	unsigned short cyc8b;		/* t0 for 8-bit I/O */
>  	unsigned short active;		/* t2 or tD */
>  	unsigned short recover;		/* t2i or tK */
> +	unsigned short write_hold;	/* t4 */
> +	unsigned short read_holdz;	/* t6z */

    Sorry for failing to notice this before but t6z is again the timing that 
the host can't control. Therefore I'm seeig no sense in its addition. I don't 
know how your driver is going to use it -- but most probably incorrectly...

MBR, Sergei
