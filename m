Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Mar 2006 16:18:19 +0000 (GMT)
Received: from amdext4.amd.com ([163.181.251.6]:19408 "EHLO amdext4.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133525AbWCQQSH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 17 Mar 2006 16:18:07 +0000
Received: from SAUSGW02.amd.com (sausgw02.amd.com [163.181.250.22])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k2HGPpeT015693;
	Fri, 17 Mar 2006 10:27:23 -0600
Received: from 163.181.22.101 by SAUSGW02.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Fri, 17 Mar 2006 10:27:15 -0600
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Received: from ldcmail.amd.com ([147.5.200.40]) by sausexbh1.amd.com
 with Microsoft SMTPSVC(6.0.3790.0); Fri, 17 Mar 2006 08:27:13 -0800
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id 8F9732028; Fri, 17 Mar 2006
 09:27:13 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k2HGc7jW003893; Fri, 17 Mar 2006 09:38:07
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k2HGc6Wc003892; Fri, 17 Mar 2006 09:38:06
 -0700
Date:	Fri, 17 Mar 2006 09:38:06 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"elmar gerdes" <elmar.gerdes@engel-kg.com>
cc:	linux-mips@linux-mips.org
Subject: Re: au1000_tx_timeout and promiscuous mode
Message-ID: <20060317163806.GA3679@cosmic.amd.com>
References: <20060317010227.GA16575@engel-kg.com>
MIME-Version: 1.0
In-Reply-To: <20060317010227.GA16575@engel-kg.com>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 17 Mar 2006 16:27:14.0083 (UTC)
 FILETIME=[A6284730:01C649DF]
X-WSS-ID: 68043CE81VK9489160-03-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10835
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

On 17/03/06 02:02 +0100, elmar gerdes wrote:
> 
> hi folks,

Greetings Elmar.

> @@ -2070,6 +2070,7 @@
>  	printk(KERN_ERR "%s: au1000_tx_timeout: dev=%p\n", dev->name, dev);
>  	reset_mac(dev);
>  	au1000_init(dev);
> +	set_rx_mode(dev);	// EG 2006-03-15: set promiscuous mode
>  	dev->trans_start = jiffies;
>  	netif_wake_queue(dev);

I would move the comment to the previous line, use standard /* */ notation,
and your name and the date isn't really needed, as that information will
be stored in the GIT log.

Also, don't forget your Signed-off-by line and a short description of the
patch for posterity.

Other then that, I have no problems with the bug - unless Pete wants to
object, I think you should send the fixed-up patch to netdev@vger.kernel.org 
and CC this list. 

Regards,
Jordan

--
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>
